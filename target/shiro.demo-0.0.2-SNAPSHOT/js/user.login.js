
//换种方式获取，之前的方式在不同的环境下，有问题
var baseUrl = $("script[baseUrl]").attr('baseUrl');
/**退出*/
function logout(){
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
