<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<meta charset="utf-8" />
		<title>权限列表 - 权限管理</title>
		<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
		<link   rel="icon" href="${basePath}/favicon.ico" type="image/x-icon" />
		<link   rel="shortcut icon" href="${basePath}/favicon.ico" />
		<link href="${basePath}/js/common/bootstrap/3.3.5/css/bootstrap.min.css?${_v}" rel="stylesheet"/>
		<link href="${basePath}/css/common/base.css?${_v}" rel="stylesheet"/>
		<script  src="${basePath}/js/common/jquery/jquery1.8.3.min.js"></script>
		<script  src="${basePath}/js/common/layer/layer.js"></script>
		<script  src="${basePath}/js/common/bootstrap/3.3.5/js/bootstrap.min.js"></script>
		<script  src="${basePath}/js/shiro.demo.js"></script>
		<script >
			so.init(function(){
				//初始化全选。
				so.checkBoxInit('#checkAll','[check=box]');
				<@shiro.hasPermission name="/permission/deletePermissionById.shtml">
				//全选
				so.id('deleteAll').on('click',function(){
					var checkeds = $('[check=box]:checked');
					if(!checkeds.length){
						return layer.msg('请选择要删除的选项。',so.default),!0;
					}
					var array = [];
					checkeds.each(function(){
						array.push(this.value);
					});
					return deleteById(array);
				});
				</@shiro.hasPermission>
			});
			<@shiro.hasPermission name="/permission/deletePermissionById.shtml">
			<#--根据ID数组删除角色-->
			function deleteById(ids){
				var index = layer.confirm("确定这"+ ids.length +"个权限？",function(){
					var load = layer.load();
					$.post('${basePath}/permission/deletePermissionById.shtml',{ids:ids.join(',')},function(result){
						layer.close(load);
						if(result && result.status != 200){
							return layer.msg(result.message,so.default),!0;
						}else{
							layer.msg(result.resultMsg);
							setTimeout(function(){
								$('#formId').submit();
							},1000);
						}
					},'json');
					layer.close(index);
				});
			}
			</@shiro.hasPermission>
			<@shiro.hasPermission name="/permission/addPermission.shtml">
			<#--添加权限-->
			function addPermission(){
				var name = $('#name').val(),
					url  = $('#url').val();
				if($.trim(name) == ''){
					return layer.msg('权限名称不能为空。',so.default),!1;
				}
				if($.trim(url) == ''){
					return layer.msg('权限Url不能为空。',so.default),!1;
				}
				<#--loding-->
				var load = layer.load();
				$.post('${basePath}/permission/addPermission.shtml',{name:name,url:url},function(result){
					layer.close(load);
					if(result && result.status != 200){
						return layer.msg(result.message,so.default),!1;
					}
					layer.msg('添加成功。');
					setTimeout(function(){
						$('#formId').submit();
					},1000);
				},'json');
			}
			</@shiro.hasPermission>
		</script>
	</head>
	<body data-target="#one" data-spy="scroll">
		<#--引入头部-->
		<@_top.top 3/>
		<div class="container" style="padding-bottom: 15px;min-height: 300px; margin-top: 40px;">
			<div class="row">
				<#--引入左侧菜单-->
				<@_left.role 3/>
				<div class="col-md-10">
					<h2>权限列表</h2>
					<hr>
					<form method="post" action="" id="formId" class="form-inline">
						<div clss="well">
					      <div class="form-group">
					        <input type="text" class="form-control" style="width: 300px;" value="${findContent?default('')}" 
					        			name="findContent" id="findContent" placeholder="输入权限名称">
					      </div>
					     <span class=""> <#--pull-right -->
				         	<button type="submit" class="btn btn-primary">查询</button>
				         	<@shiro.hasPermission name="/permission/addPermission.shtml">
				         		<a class="btn btn-success" onclick="$('#addPermission').modal();">增加权限</a>
				         	</@shiro.hasPermission>
				         	<@shiro.hasPermission name="/permission/deletePermissionById.shtml">
				         		<button type="button" id="deleteAll" class="btn  btn-danger">Delete</button>
				         	</@shiro.hasPermission>
				         </span>    
				        </div>
					<hr>
					<table class="table table-bordered">
						<tr>
							<th><input type="checkbox" id="checkAll"/></th>
							<th>权限名称</th>
							<th>角色类型</th>
							<th>操作</th>
						</tr>
						<#if page?exists && page.list?size gt 0 >
							<#list page.list as it>
								<tr>
									<td><input value="${it.id}" check='box' type="checkbox" /></td>
									<td>${it.name?default('-')}</td>
									<td>${it.url?default('-')}</td>
									<td>
										<@shiro.hasPermission name="/permission/deletePermissionById.shtml">
											<i class="glyphicon glyphicon-remove"></i><a href="javascript:deleteById([${it.id}]);">删除</a>
										</@shiro.hasPermission>
									</td>
								</tr>
							</#list>
						<#else>
							<tr>
								<td class="text-center danger" colspan="4">没有找到角色</td>
							</tr>
						</#if>
					</table>
					<#if page?exists>
						<div class="pagination pull-right">
							${page.pageHtml}
						</div>
					</#if>
					</form>
				</div>
			</div><#--/row-->
			<@shiro.hasPermission name="/permission/addPermission.shtml">
			<#--弹框-->
			<div class="modal fade" id="addPermission" tabindex="-1" role="dialog" aria-labelledby="addPermissionLabel">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="addPermissionLabel">添加权限</h4>
			      </div>
			      <div class="modal-body">
			        <form id="boxRoleForm">
			          <div class="form-group">
			            <label for="recipient-name" class="control-label">权限名称:</label>
			            <input type="text" class="form-control" name="name" id="name" placeholder="请输入权限名称"/>
			          </div>
			          <div class="form-group">
			            <label for="recipient-name" class="control-label">权限URL地址:</label>
			            <input type="text" class="form-control" id="url" name="url"  placeholder="请输入权限URL地址">
			          </div>
			        </form>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			        <button type="button" onclick="addPermission();" class="btn btn-primary">Save</button>
			      </div>
			    </div>
			  </div>
			</div>
			<#--/弹框-->
			</@shiro.hasPermission>
		</div>
			
	</body>
</html>