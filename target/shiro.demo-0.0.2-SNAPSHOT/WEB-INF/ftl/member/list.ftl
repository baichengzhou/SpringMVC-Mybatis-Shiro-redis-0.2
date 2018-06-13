<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<meta charset="utf-8" />
		<title>用户列表 —个人中心</title>
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
				<@shiro.hasPermission name="/member/deleteUserById.shtml">
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
					return _delete(array);
				});
				</@shiro.hasPermission>
			});
			<@shiro.hasPermission name="/member/deleteUserById.shtml">
			//根据ID数组，删除
			function _delete(ids){
				var index = layer.confirm("确定这"+ ids.length +"个用户？",function(){
					var load = layer.load();
					$.post('${basePath}/member/deleteUserById.shtml',{ids:ids.join(',')},function(result){
						layer.close(load);
						if(result && result.status != 200){
							return layer.msg(result.message,so.default),!0;
						}else{
							layer.msg('删除成功');
							setTimeout(function(){
								$('#formId').submit();
							},1000);
						}
					},'json');
					layer.close(index);
				});
			}
			</@shiro.hasPermission>
			<@shiro.hasPermission name="/member/forbidUserById.shtml">
			/*
			*激活 | 禁止用户登录
			*/
			function forbidUserById(status,id){
				var text = status?'激活':'禁止';
				var index = layer.confirm("确定"+text+"这个用户？",function(){
					var load = layer.load();
					$.post('${basePath}/member/forbidUserById.shtml',{status:status,id:id},function(result){
						layer.close(load);
						if(result && result.status != 200){
							return layer.msg(result.message,so.default),!0;
						}else{
							layer.msg(text +'成功');
							setTimeout(function(){
								$('#formId').submit();
							},1000);
						}
					},'json');
					layer.close(index);
				});
			}
			</@shiro.hasPermission>
		</script>
	</head>
	<body data-target="#one" data-spy="scroll">
		
		<@_top.top 2/>
		<div class="container" style="padding-bottom: 15px;min-height: 300px; margin-top: 40px;">
			<div class="row">
				<@_left.member 1/>
				<div class="col-md-10">
					<h2>用户列表</h2>
					<hr>
					<form method="post" action="" id="formId" class="form-inline">
						<div clss="well">
					      <div class="form-group">
					        <input type="text" class="form-control" style="width: 300px;" value="${findContent?default('')}" 
					        			name="findContent" id="findContent" placeholder="输入昵称 / 帐号">
					      </div>
					     <span class=""> <#--pull-right -->
				         	<button type="submit" class="btn btn-primary">查询</button>
				         	<@shiro.hasPermission name="/member/deleteUserById.shtml">
				         		<button type="button" id="deleteAll" class="btn  btn-danger">Delete</button>
				         	</@shiro.hasPermission>
				         </span>    
				        </div>
					<hr>
					<table class="table table-bordered">
						<tr>
							<th><input type="checkbox" id="checkAll"/></th>
							<th>昵称</th>
							<th>Email/帐号</th>
							<th>登录状态</th>
							<th>创建时间</th>
							<th>最后登录时间</th>
							<th>操作</th>
						</tr>
						<#if page?exists && page.list?size gt 0 >
							<#list page.list as it>
								<tr>
									<td><input value="${it.id}" check='box' type="checkbox" /></td>
									<td>${it.nickname?default('未设置')}</td>
									<td>${it.email?default('未设置')}</td>
									<td>${(it.status==1)?string('有效','禁止')}</td>
									<td>${it.createTime?string('yyyy-MM-dd HH:mm')}</td>
									<td>${it.lastLoginTime?string('yyyy-MM-dd HH:mm')}</td>
									<td>
										<@shiro.hasPermission name="/member/forbidUserById.shtml">
										${(it.status==1)?string('<i class="glyphicon glyphicon-eye-close"></i>&nbsp;','<i class="glyphicon glyphicon-eye-open"></i>&nbsp;')}
										<a href="javascript:forbidUserById(${(it.status==1)?string(0,1)},${it.id})">
											${(it.status==1)?string('禁止登录','激活登录')}
										</a>
										</@shiro.hasPermission>
										<@shiro.hasPermission name="/member/deleteUserById.shtml">
										<a href="javascript:_delete([${it.id}]);">删除</a>
										</@shiro.hasPermission>
									</td>
								</tr>
							</#list>
						<#else>
							<tr>
								<td class="text-center danger" colspan="6">没有找到用户</td>
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
		</div>
			
	</body>
</html>