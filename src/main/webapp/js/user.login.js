

//判断页面是否加载了Jquery
if(typeof jQuery == 'undefined'){
	console.log('当前页面没有引入jquery加载中。。。');
	var script = document.createElement("script");
	script.src = "http://open.sojson.com/common/jquery/jquery1.8.3.min.js" ;
	document.getElementsByTagName("head")[0].appendChild(script);
	
	// IE和opera支持onreadystatechange
    // safari、chrome、opera支持onload
	script.onload = script.onreadystatechange = function () {
		login_init();
	}
}else{
	login_init();
}


function  login_init(){
	//换种方式获取，之前的方式在不同的环境下，有问题
	var baseUrl = $("script[baseUrl]").attr('baseUrl');

	/**退出*/
	window.logout = function(){
		var load = layer.load();
		$.getJSON(baseUrl + '/u/logout.shtml',{},function(result){
			layer.close(load);
			if(result && result.status == 200){
				$(".qqlogin").html('').next('ul').remove();
				layer.msg('退出成功');
				window.location.reload(true);
				return !1;
			}else{
				layer.msg('退出失败，重试！');
			}
		});
	}
	
}
