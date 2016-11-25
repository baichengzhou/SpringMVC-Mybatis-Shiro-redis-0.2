package com.sojson.permission.bo;

import java.io.Serializable;

import com.sojson.common.model.UUser;
/**
 * 用户角色分配 查询列表BO
 * @author zhou-baicheng
 *
 */
public class UserRoleAllocationBo extends UUser implements Serializable {
	private static final long serialVersionUID = 1L;
	
	//Role Name列转行，以,分割
	private String roleNames;
	//Role Id列转行，以‘,’分割
	private String roleIds;
	public String getRoleNames() {
		return roleNames;
	}
	public void setRoleNames(String roleNames) {
		this.roleNames = roleNames;
	}
	public String getRoleIds() {
		return roleIds;
	}
	public void setRoleIds(String roleIds) {
		this.roleIds = roleIds;
	}
	
}
