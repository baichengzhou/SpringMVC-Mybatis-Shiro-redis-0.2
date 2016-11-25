package com.sojson.user.bo;

import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.codec.binary.StringUtils;



/**
 * 模拟的数据对象
 * @author Administrator
 *
 */
public class SubmitDto {

	private String phone;
	
	private String loginName;
	
	private transient String password;

	public SubmitDto() {
		
	}
	/**
	 * 从Request里取到信息，和outMap匹配
	 * @param outMap
	 * @param request
	 */
	public SubmitDto(Map<String, String> outMap, HttpServletRequest request) {
		Map<String,String> requestMap = request.getParameterMap();
		
		for (String key : requestMap.keySet()) {
			if(outMap.containsValue(key)){
				try {
					BeanUtils.setProperty(this, getKeyByValue(outMap, key), requestMap.get(key));
				} catch (Exception e) {
					e.printStackTrace();
				}
				
			}
		}
	}
	/**
	 * 根据value 找 Key ，这里的前提是生成的value不重复
	 * @param outMap
	 * @param value
	 * @return
	 */
	public String getKeyByValue(Map<String,String> outMap,String value){
		for (String key : outMap.keySet()) {
			String v = outMap.get(key);
			if(StringUtils.equals(v, value)){
				return key;
			}
		}
		return null;
	}
	
	/**
	 * 把字段用随机字母替代
	 * @return
	 */
	public Map<String,Object> securitySelf(){
		Map<String,Object> map = new LinkedHashMap<String, Object>();
		map.put("phone", getRandom());
		map.put("loginName", getRandom());
		map.put("password", getRandom());
		return map;
	}
	
	/**
	 * 随机字母作为字段替代的name
	 * @return
	 */
	public static String getRandom(){
		String az = "abcdefghijklmnopqrstuvwxyz";
		return String.valueOf(az.charAt((int)(Math.random() * 26)));
	}
	
	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
}
