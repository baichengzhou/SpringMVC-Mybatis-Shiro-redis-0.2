<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<meta charset="utf-8" />
		<title>这个页面没有用，是个测试页面。安全提交Demo  —个人中心</title>
		<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
		<link   rel="icon" href="${basePath}/favicon.ico" type="image/x-icon" />
		<link   rel="shortcut icon" href="${basePath}/favicon.ico" />
		<link href="${basePath}/js/common/bootstrap/3.3.5/css/bootstrap.min.css?${_v}" rel="stylesheet"/>
		<link href="${basePath}/css/common/base.css?${_v}" rel="stylesheet"/>
	</head>
	<body data-target="#one" data-spy="scroll">
		
		<@_top.top 1/>
		<div class="container" style="padding-bottom: 15px;min-height: 300px; margin-top: 40px;">
			<#--row-->
			<div class="row">
				<@_left.user 2/>
				<div class="col-md-10">
					<h2>安全提交测试</h2>
					<hr>
					<div id="getPermissionTree" >
						<form class=" col-md-8" method="post" action="${basePath}/demo/submit/${urlPart}.shtml" enctype="multipart/form-data" id="formId">
						  <input type="hidden" name="id" value="1">
						  <div class="form-group">
						     <div class="input-group">
							     <span class="input-group-btn">
						            <button class="btn btn-default" type="button">Phone</button>
						          </span>
						          <input type="text" class="form-control" name="${phone}" >
						          <div class="input-group-btn">
						            <button type="button" class="btn btn-success">发送验证码</button>
						          </div>
				        	  </div>
						  </div>
						  <div class="form-group">
						     <div class="input-group">
							     <span class="input-group-btn">
						            <button class="btn btn-default" type="button">LoginName</button>
						          </span>
						          <input type="text" class="form-control" name="${loginName}" >
				        	  </div>
						  </div>
						  <div class="form-group">
						     <div class="input-group">
							     <span class="input-group-btn">
						            <button class="btn btn-default" type="button">Password</button>
						          </span>
						          <input type="text" class="form-control" name="${password}">
				        	  </div>
						  </div>
						  <div class="form-group">
							  <button class="btn btn-success pull-right" type="submit">提交信息</button>
						  </div>
					    	<p class="help-block"></p>
						</form>
					
					</div>
				</div>
			</div>
			<#--/row-->
		</div>
		<script  src="${basePath}/js/common/jquery/jquery1.8.3.min.js"></script>
		<script  src="${basePath}/js/common/layer/layer.js"></script>
		<script  src="${basePath}/js/common/bootstrap/3.3.5/js/bootstrap.min.js"></script>
		<script  src="${basePath}/js/common/bootstrap/bootstrap-treeview.js"></script>
		<script  src="${basePath}/js/shiro.demo.js"></script>
	</body>
</html>