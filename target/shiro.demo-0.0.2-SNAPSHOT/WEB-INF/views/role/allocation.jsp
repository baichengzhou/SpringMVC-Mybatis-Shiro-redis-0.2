<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%> 
<%--shiro 标签 --%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>  
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>

<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<meta charset="utf-8" />
		<%--不知道这里的basePath 设置没用 --%>
		<base href="<%=basePath%>"/>
		<title>用户角色分配 - 权限管理</title>
    	<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
		<link   rel="shortcut icon" href="<%=basePath%>/favicon.ico" />
		<link href="<%=basePath%>/js/common/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet"/>
		<link href="<%=basePath%>/css/common/base.css" rel="stylesheet"/>
		<script  src="<%=basePath%>/js/common/jquery/jquery1.8.3.min.js"></script>
		<script  src="<%=basePath%>/js/common/layer/layer.js"></script>
		<script  src="<%=basePath%>/js/common/bootstrap/3.3.5/js/bootstrap.min.js"></script>
		<script  src="<%=basePath%>/js/shiro.demo.js"></script>
		<script >
		so.init(function(){
				//初始化全选。
				so.checkBoxInit('#checkAll','[check=box]');
				<shiro:hasPermission name="/role/clearRoleByUserIds.shtml">
				//全选
				so.id('deleteAll').on('click',function(){
					var checkeds = $('[check=box]:checked');
					if(!checkeds.length){
						return layer.msg('请选择要清除的用户。',so.default),!0;
					}
					var array = [];
					checkeds.each(function(){
						array.push(this.value);
					});
					return deleteById(array);
				});
				</shiro:hasPermission>
			});
			<shiro:hasPermission name="/role/clearRoleByUserIds.shtml">
			<%--根据ID数组清空用户的角色--%>
			function deleteById(ids){
				var index = layer.confirm("确定清除这"+ ids.length +"个用户的角色？",function(){
					var load = layer.load();
					$.post('<%=basePath%>/role/clearRoleByUserIds.shtml',{userIds:ids.join(',')},function(result){
						layer.close(load);
						if(result && result.status != 200){
							return layer.msg(result.message,so.default),!0;
						}else{
							layer.msg(result.message);
							setTimeout(function(){
								$('#formId').submit();
							},1000);
						}
					},'json');
					layer.close(index);
				});
			}
			</shiro:hasPermission>
			<shiro:hasPermission name="/role/addRole2User.shtml">
			<%--选择角色后保存--%>
			function selectRole(){
				var checked = $("#boxRoleForm  :checked");
				var ids=[],names=[];
				$.each(checked,function(){
					ids.push(this.id);
					names.push($.trim($(this).attr('name')));
				});
				var index = layer.confirm("确定操作？",function(){
					<%--loding--%>
					var load = layer.load();
					$.post('<%=basePath%>/role/addRole2User.shtml',{ids:ids.join(','),userId:$('#selectUserId').val()},function(result){
						layer.close(load);
						if(result && result.status != 200){
							return layer.msg(result.message,so.default),!1;
						}
						layer.msg('添加成功。');
						setTimeout(function(){
							$('#formId').submit();
						},1000);
					},'json');
				});
			}
			/*
			*根据角色ID选择权限，分配权限操作。
			*/
			function selectRoleById(id){
				var load = layer.load();
				$.post("<%=basePath%>/role/selectRoleByUserId.shtml",{id:id},function(result){
					layer.close(load);
					if(result && result.length){
						var html =[];
						$.each(result,function(){
							html.push("<div class='checkbox'><label>");
							html.push("<input type='checkbox' id='");
							html.push(this.id);
							html.push("'");
							if(this.check){
								html.push(" checked='checked'");
							}
							html.push("name='");
							html.push(this.name);
							html.push("'/>");
							html.push(this.name);
							html.push('</label></div>');
						});
						return so.id('boxRoleForm').html(html.join('')) & $('#selectRole').modal(),$('#selectUserId').val(id),!1;
					}else{
						return layer.msg(result.message,so.default);
					}
				},'json');
			}
			</shiro:hasPermission>
		</script>
	</head>
	<body data-target="#one" data-spy="scroll">
		<%--引入头部<@_top.top 3/>--%>
		<jsp:include page="../common/config/top.jsp"></jsp:include>
		<div class="container" style="padding-bottom: 15px;min-height: 300px; margin-top: 40px;">
			<div class="row">
				<%--引入左侧菜单--%>
				<shiro:hasAnyRoles name='888888,100003'>  
					<div id="one" class="col-md-2">
						<ul data-spy="affix" class="nav nav-list nav-tabs nav-stacked bs-docs-sidenav dropdown affix" style="top: 100px; z-index: 100;">
						 <shiro:hasPermission name="/role/index.shtml">
						  <li class="">
						      <a href="<%=basePath%>/role/index.shtml">
						    	 <i class="glyphicon glyphicon-chevron-right"></i>角色列表
						      </a>
						  </li>
						  </shiro:hasPermission>
						 <shiro:hasPermission name="/role/allocation.shtml">
						  <li class="active dropdown">
						      <a href="<%=basePath%>/role/allocation.shtml" title="角色分配（这是个JSP页面）">
						    	 <i class="glyphicon glyphicon-chevron-right"></i>角色分配（这是个JSP页面）
						      </a>
						  </li>
						  </shiro:hasPermission>
						  <shiro:hasPermission name="/permission/index.shtml">
						  <li class=" dropdown">
						      <a href="<%=basePath%>/permission/index.shtml">
						    	 <i class="glyphicon glyphicon-chevron-right"></i>权限列表
						      </a>
						  </li>
						  </shiro:hasPermission>
						  <shiro:hasPermission name="/permission/allocation.shtml">
						  <li class="  dropdown">
						      <a href="<%=basePath%>/permission/allocation.shtml">
						    	 <i class="glyphicon glyphicon-chevron-right"></i>权限分配
						      </a>
						  </li>
						  </shiro:hasPermission>
						</ul>
					</div>
				</shiro:hasAnyRoles>  
				<div class="col-md-10">
					<h2>用户角色分配（这是个JSP页面）</h2>
					<hr>
					<form method="post" action="" id="formId" class="form-inline">
						<div clss="well">
					      <div class="form-group">
					        <input type="text" class="form-control" style="width: 300px;" value="${findContent}" 
					        			name="findContent" id="findContent" placeholder="输入用户昵称 / 用户帐号">
					      </div>
					     <span class=""> <%--pull-right --%>
				         	<button type="submit" class="btn btn-primary">查询</button>
				         	<shiro:hasPermission name="/role/clearRoleByUserIds.shtml">
				         		<button type="button" id="deleteAll" class="btn  btn-danger">清空用户角色</button>
			         		</shiro:hasPermission>
				         </span>    
				        </div>
					<hr>
					<table class="table table-bordered">
						<input type="hidden" id="selectUserId">
						<tr>
							<th width="5%"><input type="checkbox" id="checkAll"/></th>
							<th width="10%">用户昵称</th>
							<th width="10%">Email/帐号</th>
							<th width="10%">状态</th>
							<th width="55%">拥有的角色</th>
							<th width="10%">操作</th>
						</tr>
						<c:choose>
							<c:when test="${page != null && fn:length(page.list) gt 0}">
								<c:forEach items="${page.list}" var="it">
									<tr>
										<td><input value="${it.id}" check='box' type="checkbox" /></td>
										<td>${it.nickname}</td>
										<td>${it.email}</td>
										<td>${it.status==1?'有效':'禁止'}</td>
										<td roleIds="${it.roleIds}">${it.roleNames}</td>
										<td>
											<shiro:hasPermission name="/role/addRole2User.shtml">
												<i class="glyphicon glyphicon-share-alt"></i><a href="javascript:selectRoleById(${it.id});">选择角色</a>
											</shiro:hasPermission>
										</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td class="text-center danger" colspan="6">没有找到用户</td>
								</tr>
							</c:otherwise>
						</c:choose>
						
					</table>
					<c:if test="${page != null && fn:length(page.list) gt 0}">
						<div class="pagination pull-right">
							${page.pageHtml}
						</div>
					</c:if>
					</form>
				</div>
			</div><%--/row--%>
			
			<%--弹框--%>
			<div class="modal fade bs-example-modal-sm"  id="selectRole" tabindex="-1" role="dialog" aria-labelledby="selectRoleLabel">
			  <div class="modal-dialog modal-sm" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="selectRoleLabel">添加角色</h4>
			      </div>
			      <div class="modal-body">
			        <form id="boxRoleForm">
			          loading...
			        </form>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			        <button type="button" onclick="selectRole();" class="btn btn-primary">Save</button>
			      </div>
			    </div>
			  </div>
			</div>
			<%----/弹框--%>
			
		</div>
			
	</body>
</html>