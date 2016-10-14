package com.sojson.permission.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sojson.common.dao.UPermissionMapper;
import com.sojson.common.dao.URolePermissionMapper;
import com.sojson.common.dao.UUserMapper;
import com.sojson.common.dao.UUserRoleMapper;
import com.sojson.common.model.UPermission;
import com.sojson.common.model.URolePermission;
import com.sojson.common.utils.LoggerUtils;
import com.sojson.common.utils.StringUtils;
import com.sojson.core.mybatis.BaseMybatisDao;
import com.sojson.core.mybatis.page.Pagination;
import com.sojson.core.shiro.token.manager.TokenManager;
import com.sojson.permission.bo.UPermissionBo;
import com.sojson.permission.service.PermissionService;
@Service
public class PermissionServiceImpl extends BaseMybatisDao<UPermissionMapper> implements PermissionService {

	@Autowired
	UPermissionMapper permissionMapper;
	@Autowired
	UUserMapper userMapper;
	@Autowired
	URolePermissionMapper rolePermissionMapper;
	@Autowired
	UUserRoleMapper userRoleMapper;
	
	@Override
	public int deleteByPrimaryKey(Long id) {
		return permissionMapper.deleteByPrimaryKey(id);
	}

	@Override
	public UPermission insert(UPermission record) {
		permissionMapper.insert(record);
		return record;
	}

	@Override
	public UPermission insertSelective(UPermission record) {
		//添加权限
		permissionMapper.insertSelective(record);
		//每添加一个权限，都往【系统管理员 	888888】里添加一次。保证系统管理员有最大的权限
		executePermission(new Long(1), String.valueOf(record.getId()));
		return record;
	}

	@Override
	public UPermission selectByPrimaryKey(Long id) {
		return permissionMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKey(UPermission record) {
		return permissionMapper.updateByPrimaryKey(record);
	}

	@Override
	public int updateByPrimaryKeySelective(UPermission record) {
		return permissionMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public Map<String, Object> deletePermissionById(String ids) {
		Map<String,Object> resultMap = new HashMap<String,Object>();
		try {
			int successCount=0,errorCount=0;
			String resultMsg ="删除%s条，失败%s条";
			String[] idArray = new String[]{};
			if(StringUtils.contains(ids, ",")){
				idArray = ids.split(",");
			}else{
				idArray = new String[]{ids};
			}
			
			for (String idx : idArray) {
				Long id = new Long(idx);
				
				List<URolePermission> rolePermissions= rolePermissionMapper.findRolePermissionByPid(id);
				if(null != rolePermissions && rolePermissions.size() > 0){
					errorCount += rolePermissions.size();
				}else{
					successCount+=this.deleteByPrimaryKey(id);
				}
			}
			resultMap.put("status", 200);
			//如果有成功的，也有失败的，提示清楚。
			if(errorCount > 0){
				resultMsg = String.format(resultMsg, successCount,errorCount);
			}else{
				resultMsg = "操作成功";
			}
			resultMap.put("resultMsg", resultMsg);
		} catch (Exception e) {
			LoggerUtils.fmtError(getClass(), e, "根据IDS删除用户出现错误，ids[%s]", ids);
			resultMap.put("status", 500);
			resultMap.put("message", "删除出现错误，请刷新后再试！");
		}
		return resultMap;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Pagination<UPermission> findPage(Map<String,Object> resultMap, Integer pageNo,
			Integer pageSize) {
		return super.findPage(resultMap, pageNo, pageSize);
	}

	@Override
	public List<UPermissionBo> selectPermissionById(Long id) {
		return permissionMapper.selectPermissionById(id);
	}

	@Override
	public Map<String, Object> addPermission2Role(Long roleId, String ids) {
		//先删除原有的。
		rolePermissionMapper.deleteByRid(roleId);
		return executePermission(roleId, ids);
	}
	/**
	 * 处理权限 
	 * @param roleId
	 * @param ids
	 * @return
	 */
	private Map<String, Object> executePermission(Long roleId, String ids){
		Map<String,Object> resultMap = new HashMap<String, Object>();
		int count = 0;
		try {
			//如果ids,permission 的id 有值，那么就添加。没值象征着：把这个角色（roleId）所有权限取消。
			if(StringUtils.isNotBlank(ids)){
				String[] idArray = null;
				
				//这里有的人习惯，直接ids.split(",") 都可以，我习惯这么写。清楚明了。
				if(StringUtils.contains(ids, ",")){
					idArray = ids.split(",");
				}else{
					idArray = new String[]{ids};
				}
				//添加新的。
				for (String pid : idArray) {
					//这里严谨点可以判断，也可以不判断。这个{@link StringUtils 我是重写了的} 
					if(StringUtils.isNotBlank(pid)){
						URolePermission entity = new URolePermission(roleId,new Long(pid));
						count += rolePermissionMapper.insertSelective(entity);
					}
				}
			}
			resultMap.put("status", 200);
			resultMap.put("message", "操作成功");
		} catch (Exception e) {
			resultMap.put("status", 200);
			resultMap.put("message", "操作失败，请重试！");
		}
		//清空拥有角色Id为：roleId 的用户权限已加载数据，让权限数据重新加载
		List<Long> userIds = userRoleMapper.findUserIdByRoleId(roleId);
		
		TokenManager.clearUserAuthByUserId(userIds);
		resultMap.put("count", count);
		return resultMap;
		
	}

	@Override
	public Map<String, Object> deleteByRids(String roleIds) {
		Map<String,Object> resultMap = new HashMap<String, Object>();
		try {
			resultMap.put("roleIds", roleIds);
			rolePermissionMapper.deleteByRids(resultMap);
			resultMap.put("status", 200);
			resultMap.put("message", "操作成功");
		} catch (Exception e) {
			resultMap.put("status", 200);
			resultMap.put("message", "操作失败，请重试！");
		}
		return resultMap;
	}

	@Override
	public Set<String> findPermissionByUserId(Long userId) {
		return permissionMapper.findPermissionByUserId(userId);
	}

	
}
