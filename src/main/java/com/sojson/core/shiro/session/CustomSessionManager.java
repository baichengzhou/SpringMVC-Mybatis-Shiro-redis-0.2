package com.sojson.core.shiro.session;


import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.shiro.session.Session;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.apache.shiro.subject.support.DefaultSubjectContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.sojson.common.model.UUser;
import com.sojson.common.utils.LoggerUtils;
import com.sojson.common.utils.StringUtils;
import com.sojson.core.shiro.CustomShiroSessionDAO;
import com.sojson.user.bo.UserOnlineBo;
/**
 * 
 * 开发公司：SOJSON在线工具 <p>
 * 版权所有：© www.sojson.com<p>
 * 博客地址：http://www.sojson.com/blog/  <p>
 * <p>
 * 
 * 用户Session 手动管理
 * 
 * <p>
 * 
 * 区分　责任人　日期　　　　说明<br/>
 * 创建　周柏成　2016年6月2日 　<br/>
 *
 * @author zhou-baicheng
 * @email  so@sojson.com
 * @version 1.0,2016年6月2日 <br/>
 * 
 */

public class CustomSessionManager {

	/**
	 * session status 
	 */
	public static final String SESSION_STATUS ="sojson-online-status";
	ShiroSessionRepository shiroSessionRepository;
	
	CustomShiroSessionDAO customShiroSessionDAO;
	
	/**
	 * 获取所有的有效Session用户
	 * @return
	 */
	public  List<UserOnlineBo> getAllUser() {
		//获取所有session
		Collection<Session> sessions = customShiroSessionDAO.getActiveSessions();
		List<UserOnlineBo> list = new ArrayList<UserOnlineBo>();
		
		for (Session session : sessions) {
			UserOnlineBo bo = getSessionBo(session);
			if(null != bo){
				list.add(bo);
			}
		}
		return list;
	}
	/**
	 * 根据ID查询 SimplePrincipalCollection
	 * @param userIds	用户ID
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<SimplePrincipalCollection> getSimplePrincipalCollectionByUserId(Long...userIds){
		//把userIds 转成Set，好判断
		Set<Long> idset = (Set<Long>) StringUtils.array2Set(userIds);
		//获取所有session
		Collection<Session> sessions = customShiroSessionDAO.getActiveSessions();
		//定义返回
		List<SimplePrincipalCollection> list = new ArrayList<SimplePrincipalCollection>();
		for (Session session : sessions) {
			//获取SimplePrincipalCollection
			Object obj = session.getAttribute(DefaultSubjectContext.PRINCIPALS_SESSION_KEY);
			if(null != obj && obj instanceof SimplePrincipalCollection){
				//强转
				SimplePrincipalCollection spc = (SimplePrincipalCollection)obj;
				//判断用户，匹配用户ID。
				obj = spc.getPrimaryPrincipal();
				if(null != obj && obj instanceof UUser){
					UUser user = (UUser)obj;
					//比较用户ID，符合即加入集合
					if(null != user && idset.contains(user.getId())){
						list.add(spc);
					}
				}
			}
		}
		return list;
	}
	
	
	
	/**
	 * 获取单个Session
	 * @param sessionId
	 * @return
	 */
	public UserOnlineBo getSession(String sessionId) {
		Session session = shiroSessionRepository.getSession(sessionId);
		UserOnlineBo bo = getSessionBo(session);
		return bo;
	}
	private UserOnlineBo getSessionBo(Session session){
		//获取session登录信息。
		Object obj = session.getAttribute(DefaultSubjectContext.PRINCIPALS_SESSION_KEY);
		if(null == obj){
			return null;
		}
		//确保是 SimplePrincipalCollection对象。
		if(obj instanceof SimplePrincipalCollection){
			SimplePrincipalCollection spc = (SimplePrincipalCollection)obj;
			/**
			 * 获取用户登录的，@link SampleRealm.doGetAuthenticationInfo(...)方法中
			 * return new SimpleAuthenticationInfo(user,user.getPswd(), getName());的user 对象。
			 */
			obj = spc.getPrimaryPrincipal();
			if(null != obj && obj instanceof UUser){
				//存储session + user 综合信息
				UserOnlineBo userBo = new UserOnlineBo((UUser)obj);
				//最后一次和系统交互的时间
				userBo.setLastAccess(session.getLastAccessTime());
				//主机的ip地址
				userBo.setHost(session.getHost());
				//session ID
				userBo.setSessionId(session.getId().toString());
				//session最后一次与系统交互的时间
				userBo.setLastLoginTime(session.getLastAccessTime());
				//回话到期 ttl(ms)
				userBo.setTimeout(session.getTimeout());
				//session创建时间
				userBo.setStartTime(session.getStartTimestamp());
				//是否踢出
				SessionStatus sessionStatus = (SessionStatus)session.getAttribute(SESSION_STATUS);
				boolean status = Boolean.TRUE;
				if(null != sessionStatus){
					status = sessionStatus.getOnlineStatus();
				}
				userBo.setSessionStatus(status);
				return userBo;
			}
		}
		return null;
	}
	/**
	 * 改变Session状态
	 * @param status {true:踢出,false:激活}
	 * @param sessionId
	 * @return
	 */
	public Map<String, Object> changeSessionStatus(Boolean status,
			String sessionIds) {
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			String[] sessionIdArray = null;
			if(sessionIds.indexOf(",") ==-1){
				sessionIdArray = new String[]{sessionIds};
			}else{
				sessionIdArray = sessionIds.split(",");
			}
			for (String id : sessionIdArray) {
				Session session = shiroSessionRepository.getSession(id);
				SessionStatus sessionStatus = new SessionStatus();
				sessionStatus.setOnlineStatus(status);
				session.setAttribute(SESSION_STATUS, sessionStatus);
				customShiroSessionDAO.update(session);
			}
			map.put("status", 200);
			map.put("sessionStatus", status?1:0);
			map.put("sessionStatusText", status?"踢出":"激活");
			map.put("sessionStatusTextTd", status?"有效":"已踢出");
		} catch (Exception e) {
			LoggerUtils.fmtError(getClass(), e, "改变Session状态错误，sessionId[%s]", sessionIds);
			map.put("status", 500);
			map.put("message", "改变失败，有可能Session不存在，请刷新再试！");
		}
		return map;
	}
	/**
	 * 查询要禁用的用户是否在线。
	 * @param id		用户ID
	 * @param status	用户状态
	 */
	public void forbidUserById(Long id, Long status) {
		//获取所有在线用户
		for(UserOnlineBo bo : getAllUser()){
			Long userId = bo.getId();
			//匹配用户ID
			if(userId.equals(id)){
				//获取用户Session
				Session session = shiroSessionRepository.getSession(bo.getSessionId());
				//标记用户Session
				SessionStatus sessionStatus = (SessionStatus) session.getAttribute(SESSION_STATUS);
				//是否踢出 true:有效，false：踢出。
				sessionStatus.setOnlineStatus(status.intValue() == 1);
				//更新Session
				customShiroSessionDAO.update(session);
			}
		}
	}
	public void setShiroSessionRepository(
			ShiroSessionRepository shiroSessionRepository) {
		this.shiroSessionRepository = shiroSessionRepository;
	}

	public void setCustomShiroSessionDAO(CustomShiroSessionDAO customShiroSessionDAO) {
		this.customShiroSessionDAO = customShiroSessionDAO;
	}
}
