<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<meta charset="utf-8" />
		<title>当前在线Session — SSM + Shiro Demo</title>
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
			<@shiro.hasPermission name="/member/changeSessionStatus.shtml">
			$(function(){
				$("a[v=onlineDetails]").on('click',function(){
					var self = $(this);
					var text = $.trim(self.text());
					var index = layer.confirm("确定"+ text +"？",function(){
						changeSessionStatus(self.attr('sessionId'),self.attr('status'),self);
						layer.close(index);
					});
				});
			});
			//改变状态
			function changeSessionStatus(sessionIds,status,self){
				status = !parseInt(status);
				//loading
				var load = layer.load();
				$.post("${basePath}/member/changeSessionStatus.shtml",{status:status,sessionIds:sessionIds},function(result){
					layer.close(load);
					if(result && result.status == 200){
						return self.text(result.sessionStatusText),
									self.attr('status',result.sessionStatus),
										self.parent().prev().text(result.sessionStatusTextTd);
										layer.msg('操作成功'),!1;
					}else{
						return layer.msg(result.message,function(){}),!1;
					}		
				},'json');
			}
			</@shiro.hasPermission>
			
		</script>
	</head>
	<body data-target="#one" data-spy="scroll">
		
		<@_top.top 2/>
		<div class="container" style="padding-bottom: 15px;min-height: 300px; margin-top: 40px;">
			<div class="row">
				<@_left.member 2/>
				<div class="col-md-10">
					<h2>当前在线用户</h2>
					<hr>
					<form method="post" action="" id="formId" class="form-inline">
						<div clss="well">
					     	<p>这里是在线已经登录的<code>有效</code>Session，不能等同于当前在线用户，来源于Redis。</p>
					     	<p>再者，说明一个问题，老有同学纠结怎么删除无效的Session，也就是删除用户直接关闭浏览器，导致无法继续使用的Session，我再次严正声明，这个Session不需要你删除，别纠结了，这个Session是有TTL，有效期是30分钟，30分钟这个Session没有更新就会剔除，故你不用纠结。</p>
					     	<p>老有同学纠结这个，美其名曰为了更好的效率，为了效率你去干干其他的事情。</p>
				        </div>
					<hr>
					<table class="table table-bordered">
						<tr>
							<th>SessionID</th>
							<th>昵称</th>
							<th>Email/帐号</th>
							<th>创建回话</th>
							<th>回话最后活动</th>
							<th>状态</th>
							<th>操作</th>
						</tr>
						<#if list?exists && list?size gt 0 >
							<#list list as it>
								<tr>
									<td>${it.sessionId?default('未设置')}</td>
									<td>${it.nickname?default('未设置')}</td>
									<td>${it.email?default('未设置')}</td>
									<td>${it.startTime?string('HH:mm:ss yy-MM-dd')}</td>
									<td>${it.lastAccess?string('HH:mm:ss yy-MM-dd')}</td>
									<td>${(it.sessionStatus)?string('有效','已踢出')}</td>
									<td>
										<a href="${basePath}/member/onlineDetails/${it.sessionId}.shtml">详情</a>
										<@shiro.hasPermission name="/member/changeSessionStatus.shtml">
											<a v="onlineDetails"href="javascript:void(0);" sessionId="${it.sessionId}" status="${(it.sessionStatus)?string(1,0)}">${(it.sessionStatus)?string('踢出','激活')}</a>
										</@shiro.hasPermission>
									</td>
								</tr>
							</#list>
						<#else>
							<tr>
								<td class="center-block" callspan="4">没有用户</td>
							</tr>
						</#if>
						
					</table>
				</div>
			</div><#--/row-->
		</div>
			
	</body>
</html>