 
/**
 * @author sojson.com
 * @ps 你可以当作是一个闭包 | 封装的Demo
 */
(function(o,w){
	if(!w.so)w.so = {};
	return (function(so){
		so.$1 = !0,//true
		so.$0 = !1;//false
		/**
		 * 全选
		 */
		so.checkBoxInit = function(prentCheckbox,childCheckbox){
			childCheckbox = o(childCheckbox),prentCheckbox = o(prentCheckbox);
			//先取消全选。
			//childCheckbox.add(prentCheckbox).attr('checked',!1);
			//全选
			prentCheckbox.on('click',function(){
				childCheckbox.attr('checked',this.checked);
			});
			//子选择
			childCheckbox.on('click',function(){
				prentCheckbox.attr('checked',childCheckbox.length === childCheckbox.end().find(':checked').not(prentCheckbox).length);
			});
		},
		//初始化
		so.init = function(fn){
			o(function(){fn()});
		}
		so.id = function(id){
			return o('#' + id);
		}
		so.default = function(){}
		
	})(so);
})($,window);
