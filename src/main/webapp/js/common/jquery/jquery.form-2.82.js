;(function($){$.fn.ajaxSubmit=function(options){if(!this.length){log('ajaxSubmit: skipping submit process - no element selected');return this;}
var method,action,url,$form=this;;if(typeof options=='function'){options={success:options};}
method=this.attr('method');action=this.attr('action');url=(typeof action==='string')?$.trim(action):'';url=url||window.location.href||'';if(url){url=(url.match(/^([^#]+)/)||[])[1];}
options=$.extend(true,{url:url,success:$.ajaxSettings.success,type:method||'GET',iframeSrc:/^https/i.test(window.location.href||'')?'javascript:false':'about:blank'},options);var veto={};this.trigger('form-pre-serialize',[this,options,veto]);if(veto.veto){log('ajaxSubmit: submit vetoed via form-pre-serialize trigger');return this;}
if(options.beforeSerialize&&options.beforeSerialize(this,options)===false){log('ajaxSubmit: submit aborted via beforeSerialize callback');return this;}
var n,v,a=this.formToArray(options.semantic);if(options.data){options.extraData=options.data;for(n in options.data){if(options.data[n]instanceof Array){for(var k in options.data[n]){a.push({name:n,value:options.data[n][k]});}}
else{v=options.data[n];v=$.isFunction(v)?v():v;a.push({name:n,value:v});}}}
if(options.beforeSubmit&&options.beforeSubmit(a,this,options)===false){log('ajaxSubmit: submit aborted via beforeSubmit callback');return this;}
this.trigger('form-submit-validate',[a,this,options,veto]);if(veto.veto){log('ajaxSubmit: submit vetoed via form-submit-validate trigger');return this;}
var q=$.param(a);if(options.type.toUpperCase()=='GET'){options.url+=(options.url.indexOf('?')>=0?'&':'?')+q;options.data=null;}
else{options.data=q;}
var callbacks=[];if(options.resetForm){callbacks.push(function(){$form.resetForm();});}
if(options.clearForm){callbacks.push(function(){$form.clearForm();});}
if(!options.dataType&&options.target){var oldSuccess=options.success||function(){};callbacks.push(function(data){var fn=options.replaceTarget?'replaceWith':'html';$(options.target)[fn](data).each(oldSuccess,arguments);});}
else if(options.success){callbacks.push(options.success);}
options.success=function(data,status,xhr){var context=options.context||options;for(var i=0,max=callbacks.length;i<max;i++){callbacks[i].apply(context,[data,status,xhr||$form,$form]);}};var fileInputs=$('input:file',this).length>0;var mp='multipart/form-data';var multipart=($form.attr('enctype')==mp||$form.attr('encoding')==mp);if(options.iframe!==false&&(fileInputs||options.iframe||multipart)){if(options.closeKeepAlive){$.get(options.closeKeepAlive,function(){fileUpload(a);});}
else{fileUpload(a);}}
else{if($.browser.msie&&method=='get'){var ieMeth=$form[0].getAttribute('method');if(typeof ieMeth==='string')
options.type=ieMeth;}
$.ajax(options);}
this.trigger('form-submit-notify',[this,options]);return this;function fileUpload(a){var form=$form[0],i,s,g,id,$io,io,xhr,sub,n,timedOut,timeoutHandle;if(a){for(i=0;i<a.length;i++){$(form[a[i].name]).attr('disabled',false);}}
if($(':input[name=submit],:input[id=submit]',form).length){alert('Error: Form elements must not have name or id of "submit".');return;}
s=$.extend(true,{},$.ajaxSettings,options);s.context=s.context||s;id='jqFormIO'+(new Date().getTime());if(s.iframeTarget){$io=$(s.iframeTarget);n=$io.attr('name');if(n==null)
$io.attr('name',id);else
id=n;}
else{$io=$('<iframe name="'+id+'" src="'+s.iframeSrc+'" />');$io.css({position:'absolute',top:'-1000px',left:'-1000px'});}
io=$io[0];xhr={aborted:0,responseText:null,responseXML:null,status:0,statusText:'n/a',getAllResponseHeaders:function(){},getResponseHeader:function(){},setRequestHeader:function(){},abort:function(status){var e=(status==='timeout'?'timeout':'aborted');log('aborting upload... '+e);this.aborted=1;$io.attr('src',s.iframeSrc);xhr.error=e;s.error&&s.error.call(s.context,xhr,e,status);g&&$.event.trigger("ajaxError",[xhr,s,e]);s.complete&&s.complete.call(s.context,xhr,e);}};g=s.global;if(g&&!$.active++){$.event.trigger("ajaxStart");}
if(g){$.event.trigger("ajaxSend",[xhr,s]);}
if(s.beforeSend&&s.beforeSend.call(s.context,xhr,s)===false){if(s.global){$.active--;}
return;}
if(xhr.aborted){return;}
sub=form.clk;if(sub){n=sub.name;if(n&&!sub.disabled){s.extraData=s.extraData||{};s.extraData[n]=sub.value;if(sub.type=="image"){s.extraData[n+'.x']=form.clk_x;s.extraData[n+'.y']=form.clk_y;}}}
var CLIENT_TIMEOUT_ABORT=1;var SERVER_ABORT=2;function getDoc(frame){var doc=frame.contentWindow?frame.contentWindow.document:frame.contentDocument?frame.contentDocument:frame.document;return doc;}
function doSubmit(){var t=$form.attr('target'),a=$form.attr('action');form.setAttribute('target',id);if(!method){form.setAttribute('method','POST');}
if(a!=s.url){form.setAttribute('action',s.url);}
if(!s.skipEncodingOverride&&(!method||/post/i.test(method))){$form.attr({encoding:'multipart/form-data',enctype:'multipart/form-data'});}
if(s.timeout){timeoutHandle=setTimeout(function(){timedOut=true;cb(CLIENT_TIMEOUT_ABORT);},s.timeout);}
function checkState(){try{var state=getDoc(io).readyState;log('state = '+state);if(state.toLowerCase()=='uninitialized')
setTimeout(checkState,50);}
catch(e){log('Server abort: ',e,' (',e.name,')');cb(SERVER_ABORT);timeoutHandle&&clearTimeout(timeoutHandle);timeoutHandle=undefined;}}
var extraInputs=[];try{if(s.extraData){for(var n in s.extraData){extraInputs.push($('<input type="hidden" name="'+n+'" />').attr('value',s.extraData[n]).appendTo(form)[0]);}}
if(!s.iframeTarget){$io.appendTo('body');io.attachEvent?io.attachEvent('onload',cb):io.addEventListener('load',cb,false);}
setTimeout(checkState,15);form.submit();}
finally{form.setAttribute('action',a);if(t){form.setAttribute('target',t);}else{$form.removeAttr('target');}
$(extraInputs).remove();}}
if(s.forceSync){doSubmit();}
else{setTimeout(doSubmit,10);}
var data,doc,domCheckCount=50,callbackProcessed;function cb(e){if(xhr.aborted||callbackProcessed){return;}
try{doc=getDoc(io);}
catch(ex){log('cannot access response document: ',ex);e=SERVER_ABORT;}
if(e===CLIENT_TIMEOUT_ABORT&&xhr){xhr.abort('timeout');return;}
else if(e==SERVER_ABORT&&xhr){xhr.abort('server abort');return;}
if(!doc||doc.location.href==s.iframeSrc){if(!timedOut)
return;}
io.detachEvent?io.detachEvent('onload',cb):io.removeEventListener('load',cb,false);var status='success',errMsg;try{if(timedOut){throw'timeout';}
var isXml=s.dataType=='xml'||doc.XMLDocument||$.isXMLDoc(doc);log('isXml='+isXml);if(!isXml&&window.opera&&(doc.body==null||doc.body.innerHTML=='')){if(--domCheckCount){log('requeing onLoad callback, DOM not available');setTimeout(cb,250);return;}}
var docRoot=doc.body?doc.body:doc.documentElement;xhr.responseText=docRoot?docRoot.innerHTML:null;xhr.responseXML=doc.XMLDocument?doc.XMLDocument:doc;if(isXml)
s.dataType='xml';xhr.getResponseHeader=function(header){var headers={'content-type':s.dataType};return headers[header];};if(docRoot){xhr.status=Number(docRoot.getAttribute('status'))||xhr.status;xhr.statusText=docRoot.getAttribute('statusText')||xhr.statusText;}
var dt=s.dataType||'';var scr=/(json|script|text)/.test(dt.toLowerCase());if(scr||s.textarea){var ta=doc.getElementsByTagName('textarea')[0];if(ta){xhr.responseText=ta.value;xhr.status=Number(ta.getAttribute('status'))||xhr.status;xhr.statusText=ta.getAttribute('statusText')||xhr.statusText;}
else if(scr){var pre=doc.getElementsByTagName('pre')[0];var b=doc.getElementsByTagName('body')[0];if(pre){xhr.responseText=pre.textContent?pre.textContent:pre.innerHTML;}
else if(b){xhr.responseText=b.innerHTML;}}}
else if(s.dataType=='xml'&&!xhr.responseXML&&xhr.responseText!=null){xhr.responseXML=toXml(xhr.responseText);}
try{data=httpData(xhr,s.dataType,s);}
catch(e){status='parsererror';xhr.error=errMsg=(e||status);}}
catch(e){log('error caught: ',e);status='error';xhr.error=errMsg=(e||status);}
if(xhr.aborted){log('upload aborted');status=null;}
if(xhr.status){status=(xhr.status>=200&&xhr.status<300||xhr.status===304)?'success':'error';}
if(status==='success'){s.success&&s.success.call(s.context,data,'success',xhr);g&&$.event.trigger("ajaxSuccess",[xhr,s]);}
else if(status){if(errMsg==undefined)
errMsg=xhr.statusText;s.error&&s.error.call(s.context,xhr,status,errMsg);g&&$.event.trigger("ajaxError",[xhr,s,errMsg]);}
g&&$.event.trigger("ajaxComplete",[xhr,s]);if(g&&!--$.active){$.event.trigger("ajaxStop");}
s.complete&&s.complete.call(s.context,xhr,status);callbackProcessed=true;if(s.timeout)
clearTimeout(timeoutHandle);setTimeout(function(){if(!s.iframeTarget)
$io.remove();xhr.responseXML=null;},100);}
var toXml=$.parseXML||function(s,doc){if(window.ActiveXObject){doc=new ActiveXObject('Microsoft.XMLDOM');doc.async='false';doc.loadXML(s);}
else{doc=(new DOMParser()).parseFromString(s,'text/xml');}
return(doc&&doc.documentElement&&doc.documentElement.nodeName!='parsererror')?doc:null;};var parseJSON=$.parseJSON||function(s){return window['eval']('('+s+')');};var httpData=function(xhr,type,s){var ct=xhr.getResponseHeader('content-type')||'',xml=type==='xml'||!type&&ct.indexOf('xml')>=0,data=xml?xhr.responseXML:xhr.responseText;if(xml&&data.documentElement.nodeName==='parsererror'){$.error&&$.error('parsererror');}
if(s&&s.dataFilter){data=s.dataFilter(data,type);}
if(typeof data==='string'){if(type==='json'||!type&&ct.indexOf('json')>=0){data=parseJSON(data);}else if(type==="script"||!type&&ct.indexOf("javascript")>=0){$.globalEval(data);}}
return data;};}};$.fn.ajaxForm=function(options){if(this.length===0){var o={s:this.selector,c:this.context};if(!$.isReady&&o.s){log('DOM not ready, queuing ajaxForm');$(function(){$(o.s,o.c).ajaxForm(options);});return this;}
log('terminating; zero elements found by selector'+($.isReady?'':' (DOM not ready)'));return this;}
return this.ajaxFormUnbind().bind('submit.form-plugin',function(e){if(!e.isDefaultPrevented()){e.preventDefault();$(this).ajaxSubmit(options);}}).bind('click.form-plugin',function(e){var target=e.target;var $el=$(target);if(!($el.is(":submit,input:image"))){var t=$el.closest(':submit');if(t.length==0){return;}
target=t[0];}
var form=this;form.clk=target;if(target.type=='image'){if(e.offsetX!=undefined){form.clk_x=e.offsetX;form.clk_y=e.offsetY;}else if(typeof $.fn.offset=='function'){var offset=$el.offset();form.clk_x=e.pageX-offset.left;form.clk_y=e.pageY-offset.top;}else{form.clk_x=e.pageX-target.offsetLeft;form.clk_y=e.pageY-target.offsetTop;}}
setTimeout(function(){form.clk=form.clk_x=form.clk_y=null;},100);});};$.fn.ajaxFormUnbind=function(){return this.unbind('submit.form-plugin click.form-plugin');};$.fn.formToArray=function(semantic){var a=[];if(this.length===0){return a;}
var form=this[0];var els=semantic?form.getElementsByTagName('*'):form.elements;if(!els){return a;}
var i,j,n,v,el,max,jmax;for(i=0,max=els.length;i<max;i++){el=els[i];n=el.name;if(!n){continue;}
if(semantic&&form.clk&&el.type=="image"){if(!el.disabled&&form.clk==el){a.push({name:n,value:$(el).val()});a.push({name:n+'.x',value:form.clk_x},{name:n+'.y',value:form.clk_y});}
continue;}
v=$.fieldValue(el,true);if(v&&v.constructor==Array){for(j=0,jmax=v.length;j<jmax;j++){a.push({name:n,value:v[j]});}}
else if(v!==null&&typeof v!='undefined'){a.push({name:n,value:v});}}
if(!semantic&&form.clk){var $input=$(form.clk),input=$input[0];n=input.name;if(n&&!input.disabled&&input.type=='image'){a.push({name:n,value:$input.val()});a.push({name:n+'.x',value:form.clk_x},{name:n+'.y',value:form.clk_y});}}
return a;};$.fn.formSerialize=function(semantic){return $.param(this.formToArray(semantic));};$.fn.fieldSerialize=function(successful){var a=[];this.each(function(){var n=this.name;if(!n){return;}
var v=$.fieldValue(this,successful);if(v&&v.constructor==Array){for(var i=0,max=v.length;i<max;i++){a.push({name:n,value:v[i]});}}
else if(v!==null&&typeof v!='undefined'){a.push({name:this.name,value:v});}});return $.param(a);};$.fn.fieldValue=function(successful){for(var val=[],i=0,max=this.length;i<max;i++){var el=this[i];var v=$.fieldValue(el,successful);if(v===null||typeof v=='undefined'||(v.constructor==Array&&!v.length)){continue;}
v.constructor==Array?$.merge(val,v):val.push(v);}
return val;};$.fieldValue=function(el,successful){var n=el.name,t=el.type,tag=el.tagName.toLowerCase();if(successful===undefined){successful=true;}
if(successful&&(!n||el.disabled||t=='reset'||t=='button'||(t=='checkbox'||t=='radio')&&!el.checked||(t=='submit'||t=='image')&&el.form&&el.form.clk!=el||tag=='select'&&el.selectedIndex==-1)){return null;}
if(tag=='select'){var index=el.selectedIndex;if(index<0){return null;}
var a=[],ops=el.options;var one=(t=='select-one');var max=(one?index+1:ops.length);for(var i=(one?index:0);i<max;i++){var op=ops[i];if(op.selected){var v=op.value;if(!v){v=(op.attributes&&op.attributes['value']&&!(op.attributes['value'].specified))?op.text:op.value;}
if(one){return v;}
a.push(v);}}
return a;}
return $(el).val();};$.fn.clearForm=function(){return this.each(function(){$('input,select,textarea',this).clearFields();});};$.fn.clearFields=$.fn.clearInputs=function(){var re=/^(?:color|date|datetime|email|month|number|password|range|search|tel|text|time|url|week)$/i;return this.each(function(){var t=this.type,tag=this.tagName.toLowerCase();if(re.test(t)||tag=='textarea'){this.value='';}
else if(t=='checkbox'||t=='radio'){this.checked=false;}
else if(tag=='select'){this.selectedIndex=-1;}});};$.fn.resetForm=function(){return this.each(function(){if(typeof this.reset=='function'||(typeof this.reset=='object'&&!this.reset.nodeType)){this.reset();}});};$.fn.enable=function(b){if(b===undefined){b=true;}
return this.each(function(){this.disabled=!b;});};$.fn.selected=function(select){if(select===undefined){select=true;}
return this.each(function(){var t=this.type;if(t=='checkbox'||t=='radio'){this.checked=select;}
else if(this.tagName.toLowerCase()=='option'){var $sel=$(this).parent('select');if(select&&$sel[0]&&$sel[0].type=='select-one'){$sel.find('option').selected(false);}
this.selected=select;}});};function log(){var msg='[jquery.form] '+Array.prototype.join.call(arguments,'');if(window.console&&window.console.log){window.console.log(msg);}
else if(window.opera&&window.opera.postError){window.opera.postError(msg);}};})(jQuery);