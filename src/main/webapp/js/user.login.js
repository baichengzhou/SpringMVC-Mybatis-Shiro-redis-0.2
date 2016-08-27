/**退出*/
function logout(){
	var load = layer.load();
	$.getJSON('/u/logout.shtml',{},function(result){
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