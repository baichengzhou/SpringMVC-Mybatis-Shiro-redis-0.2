<#macro user index>
<div id="one" class="col-md-2">
	<ul data-spy="affix" class="nav nav-list nav-tabs nav-stacked bs-docs-sidenav dropdown affix" style="top: 100px; z-index: 100;">
	  <li class="${(index==1)?string('active',' ')}">
	      <a href="${basePath}/user/index.shtml">
	    	 <i class="glyphicon glyphicon-chevron-right"></i>个人资料
	      </a>
	       <ul class="dropdown-menu" aria-labelledby="dLabel" style="margin-left: 160px; margin-top: -40px;">
              <li><a href="${basePath}/user/updateSelf.shtml">资料修改</a></li>
              <li><a href="${basePath}/user/updatePswd.shtml">密码修改</a></li>
          </ul>
	  </li>
	  <li class="${(index==2)?string('active',' ')} dropdown">
	      <a href="${basePath}/role/mypermission.shtml">
	    	 <i class="glyphicon glyphicon-chevron-right"></i>我的权限
	      </a>
	  </li>
	</ul>
</div>
</#macro>
<#macro member index>
	<@shiro.hasAnyRoles name='888888,100002'>          
		<div  id="one" class="col-md-2">
			<ul data-spy="affix" class="nav nav-list nav-tabs nav-stacked bs-docs-sidenav dropdown affix" style="top: 100px; z-index: 100;">
			  <li class="${(index==1)?string('active',' ')}">
			      <a href="${basePath}/member/list.shtml">
			    	 <i class="glyphicon glyphicon-chevron-right"></i>用户列表
			      </a>
			  </li>
			  <li class="${(index==2)?string('active',' ')} dropdown">
			      <a href="${basePath}/member/online.shtml">
			    	 <i class="glyphicon glyphicon-chevron-right"></i>在线用户
			      </a>
			  </li>
			</ul>
		</div>
	</@shiro.hasAnyRoles>         
</#macro>
<#macro role index>
	<@shiro.hasAnyRoles name='888888,100003'>  
		<div id="one" class="col-md-2">
			<ul data-spy="affix" class="nav nav-list nav-tabs nav-stacked bs-docs-sidenav dropdown affix" style="top: 100px; z-index: 100;">
			 
			 <@shiro.hasPermission name="/role/index.shtml">
			  <li class="${(index==1)?string('active',' ')}">
			      <a href="${basePath}/role/index.shtml">
			    	 <i class="glyphicon glyphicon-chevron-right"></i>角色列表
			      </a>
			  </li>
			  </@shiro.hasPermission>
			 <@shiro.hasPermission name="/role/allocation.shtml">
			  <li class="${(index==2)?string('active',' ')} dropdown">
			      <a href="${basePath}/role/allocation.shtml">
			    	 <i class="glyphicon glyphicon-chevron-right"></i>角色分配（这是个JSP页面）
			      </a>
			  </li>
			  </@shiro.hasPermission>
			  <@shiro.hasPermission name="/permission/index.shtml">
			  <li class="${(index==3)?string('active',' ')} dropdown">
			      <a href="${basePath}/permission/index.shtml">
			    	 <i class="glyphicon glyphicon-chevron-right"></i>权限列表
			      </a>
			  </li>
			  </@shiro.hasPermission>
			  <@shiro.hasPermission name="/permission/allocation.shtml">
			  <li class="${(index==4)?string('active',' ')} dropdown">
			      <a href="${basePath}/permission/allocation.shtml">
			    	 <i class="glyphicon glyphicon-chevron-right"></i>权限分配
			      </a>
			  </li>
			  </@shiro.hasPermission>
			</ul>
		</div>
	</@shiro.hasAnyRoles>   
</#macro>