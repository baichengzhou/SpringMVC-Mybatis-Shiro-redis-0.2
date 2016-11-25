
<#--JSON相关-->
<#macro json index>
 <div class="toolsTab clearfix"  style="padding-bottom: 15px; margin-top: 40px;">
    <ul class="nav nav-tabs _load">
        <li class="${(index==1)?string('active',' ')}"><a href="http://www.sojson.com/">JSON格式化</a></li>
        <li load="no" open="new_json" class=""><a  class="red" href="http://www.sojson.com/simple_json.html"target="_blank" >JSON格式化（加强版）</a></li>
        <li class="${(index==2)?string('active',' ')}"><a href="http://www.sojson.com/yasuo.html">JSON转义压缩 / 中文Unicode互转</a></li>
        <li class="${(index==3)?string('active',' ')}"><a href="http://www.sojson.com/editor.html">JSON在线示图</a></li>
		<li class="${(index==4)?string('active',' ')}"><a href="http://www.sojson.com/jsonfmt.html">JSON着色</a></li>
		<li class="${(index==5)?string('active',' ')}"><a href="http://www.sojson.com/json2xml/">JSON | XML互转</a></li>
		<li class="${(index==6)?string('active',' ')}"><a  class="red" href="http://www.sojson.com/json2entity.html" >JSON生成实体</a></li>
		<li class=""><a href="http://www.sojson.com/contrastjson.html" >JSON 数据对比</a></li>
		<li class=""><a href="http://www.sojson.com/json/"  class="red">JSON 教程</a></li>
		<#--
		<li load="no" class=""><a href="http://www.sojson.com/simple_json_beta.html" target="_blank" style="color:#c7254e">JSON 简版(Beta)</a></li>
		-->
    </ul>
    <div class="clear"></div>
</div>
</#macro>
<#--web相关-->
<#macro web index>
 <div class="toolsTab clearfix"  style="padding-bottom: 15px; margin-top: 40px;">
    <ul class="nav nav-tabs _load">
        <li class="${(index==1)?string('active',' ')}"><a href="http://www.sojson.com/web/online/">在线调色板</a></li>
        <li class="${(index==2)?string('active',' ')}"><a href="http://www.sojson.com/web/use/">网页常用色彩</a></li>
        <li class="${(index==3)?string('active',' ')}"><a href="http://www.sojson.com/web/cj/">中日传统色彩</a></li>
		<li class="${(index==4)?string('active',' ')}"><a href="http://www.sojson.com/web/img/">传图识色</a></li>
		<li class="${(index==5)?string('active',' ')}"><a href="http://www.sojson.com/web/web/">WEB安全色</a></li>
		<li class="${(index==6)?string('active',' ')}"><a href="http://www.sojson.com/web/page/">网页颜色选择器</a></li>
		<li class="${(index==7)?string('active',' ')}"><a href="http://www.sojson.com/web/select/">RGB颜色值查询</a></li>
		<li class="${(index==8)?string('active',' ')}"><a href="http://www.sojson.com/web/yasuo/">图片大小修改</a></li>
		<li load="no"><a href="javascript:;" for="https://tinypng.com/" _target="_blank" rel="nofollow external" >图片批量压缩</a></li>
    <div class="clear"></div>                          
</div>
</#macro>
<#--正则相关-->
<#macro regex index>
 <div class="toolsTab clearfix"  style="padding-bottom: 15px; margin-top: 40px;">
    <ul class="nav nav-tabs _load">
        <li class="${(index==1)?string('active',' ')}"><a href="http://www.sojson.com/regex/generate">正则生成</a></li>
        <li class="${(index==2)?string('active',' ')}"><a href="http://www.sojson.com/regex/">正则测试</a></li>
    <div class="clear"></div>                          
</div>
</#macro>

<#--convert相关-->
<#macro convert1 index>
 <div class="toolsTab clearfix"  style="padding-bottom: 15px; margin-top: 40px;">
    <ul class="nav nav-tabs _load">
        <li class="${(index==1)?string('active',' ')}"><a href="http://www.sojson.com/convert/word2spell/">汉字转拼音</a></li>
        <li class="${(index==2)?string('active',' ')}"><a href="http://www.sojson.com/convert/cn2spark/">简繁体|火星文转换</a></li>
        <li class="${(index==3)?string('active',' ')}"><a href="http://www.sojson.com/convert/pingindic/">拼音字典</a></li>
		<li class="${(index==4)?string('active',' ')}"><a href="http://www.sojson.com/convert/low2up/">大小写转换</a></li>
		<li class="${(index==5)?string('active',' ')}"><a href="http://www.sojson.com/convert/fullhalf/">全角半角转换</a></li>
		<li class="${(index==6)?string('active',' ')}"><a href="http://www.sojson.com/unixtime">Unix时间戳转换</a></li>
		<li class="${(index==7)?string('active',' ')}"><a href="http://www.sojson.com/rehtml">HTML在线转义</a></li>
		<li class="${(index==8)?string('active',' ')}"><a href="http://www.sojson.com/analyzer">IK在线分词</a></li>
    <div class="clear"></div>                          
</div>
</#macro>
<#--convert相关-->
<#macro convert2 index>
 <div class="toolsTab clearfix"  style="padding-bottom: 15px; margin-top: 40px;">
    <ul class="nav nav-tabs _load">
        <li class="${(index==1)?string('active',' ')}"> <a href="http://www.sojson.com/convert/angle/">角度换算</a></li>
        <li class="${(index==2)?string('active',' ')}"> <a href="http://www.sojson.com/convert/time/">时间换算</a></li>
        <li class="${(index==3)?string('active',' ')}"> <a href="http://www.sojson.com/convert/heat/">热量换算</a></li>
		<li class="${(index==4)?string('active',' ')}"> <a href="http://www.sojson.com/convert/length/">长度换算</a></li>
		<li class="${(index==5)?string('active',' ')}"> <a href="http://www.sojson.com/convert/area/">面积换算</a></li>
		<li class="${(index==6)?string('active',' ')}"> <a href="http://www.sojson.com/convert/speed/">速度换算</a></li>
		<li class="${(index==7)?string('active',' ')}"> <a href="http://www.sojson.com/convert/datastore/">数据存储换算</a></li>
		<li class="${(index==8)?string('active',' ')}"> <a href="http://www.sojson.com/convert/subnetmask/">子网掩码换算</a></li>
		<li class="${(index==9)?string('active',' ')}"> <a href="http://www.sojson.com/convert/power/">功率换算</a></li>
		<li class="${(index==10)?string('active',' ')}"><a href="http://www.sojson.com/convert/pressure/">压力换算</a></li>
		<li class="${(index==11)?string('active',' ')}"><a href="http://www.sojson.com/convert/temperature/">温度换算</a></li>
		<li class="${(index==12)?string('active',' ')}"><a href="http://www.sojson.com/convert/density/">密度换算</a></li>
		<li class="${(index==13)?string('active',' ')}"><a href="http://www.sojson.com/convert/force/">力换算</a></li>
		<li class="${(index==14)?string('active',' ')}"><a href="http://www.sojson.com/convert/volume/">体积换算</a></li>
    <div class="clear"></div>                          
</div>
</#macro>
<#--生活工具-->
<#macro life index>
 <div class="toolsTab clearfix"  style="padding-bottom: 15px; margin-top: 40px;">
    <ul class="nav nav-tabs _load">
        <li class="${(index==1)?string('active',' ')}"><a href="http://www.sojson.com/life/calculator/">计算器</a></li>
        <li class="${(index==2)?string('active',' ')}"><a href="http://www.sojson.com/life/rmbup/">人民币大小写转换</a></li>
        <li><a href="http://air.sojson.com/">PM2.5实时查询</a>
    <div class="clear"></div>                          
</div>
</#macro>
<#--HTTP工具-->
<#macro http index>
 <div class="toolsTab clearfix"  style="padding-bottom: 15px; margin-top: 40px;">
    <ul class="nav nav-tabs _load">
        <li class="${(index==1)?string('active',' ')}"><a href="http://www.sojson.com/httpRequest/">HTTP模拟请求</a></li>
        <li class="${(index==2)?string('active',' ')}"><a href="http://www.sojson.com/httpRequest/status/">HTTP状态查询</a></li>
    <div class="clear"></div>                          
</div>
</#macro>
<#--站长工具-->
<#macro zhanzhang index,host>
 <div class="toolsTab clearfix"  style="padding-bottom: 15px; margin-top: 20px;">
    <ul class="nav nav-tabs _load" >
        <li class="${(index==1)?string('active',' ')}"><a href="http://www.sojson.com/beian/${host}">备案查询</a></li>
        <li load="no"><a target="_blank" href="https://www.xbeian.com/beian/${host}">备案高级查询</a></li>
    	<li class="${(index==3)?string('active',' ')}"><a href="http://www.sojson.com/ip/">IP地址查询</a></li>
    	<li class="${(index==4)?string('active',' ')}"><a href="http://www.sojson.com/whois/">WHOIS查询</a></li>
    	<li class="${(index==5)?string('active',' ')}"><a href="http://www.sojson.com/seocheck/">SEO优化建议</a></li>
    	<li class="${(index==6)?string('active',' ')}"><a href="http://ping.sojson.com/">Ping检测</a></li>
    	<li class="${(index==7)?string('active',' ')}"><a href="http://www.sojson.com/robots/">robots文件生成</a></li>
    	<li class="${(index==8)?string('active',' ')}"><a href="http://www.sojson.com/nslookup/">nslookup查询</a></li>
	</ul>
    <div class="clear"></div>
</div>
</#macro>
<#--JSON弹窗相关-->
<#macro openjson index>
 <div class="toolsTab clearfix"  style="padding-bottom: 15px; margin-top: 20px;">
    <ul class="nav nav-tabs _load" >
        <li class="${(index==1)?string('active',' ')}"><a href="http://www.sojson.com/openjson/index.html">JSON格式化</a></li>
        <li class="${(index==2)?string('active',' ')}"><a href="http://www.sojson.com/openjson/yasuo.html">JSON转义压缩 / 中文Unicode互转</a></li>
		<li class="${(index==4)?string('active',' ')}"><a href="http://www.sojson.com/openjson/jsonfmt.html">JSON层级编辑</a></li>
    </ul>
    <div class="clear"></div>
</div>
<div class="modal fade" id="myModal">
  <div class="modal-dialog" style="width:850px">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><code>支付宝</code>   && <code>微信付款</code> 二维码</h4>
      </div>
      <div class="modal-body">
        <img src="http://cdn.sojson.com/system/pay.png">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">好了，扫完了</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<#--保存云端--->
	<div class="modal fade" id="saveCloudWindow" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="exampleModalLabel">保存文档到云端</h4>
	      </div>
	      <div class="modal-body">
	        <form>
	          <div class="form-group">
	            <label for="recipient-name" class="control-label">名称（必须输入）:</label>
	            <input type="text" class="form-control"   AUTOCOMPLETE="off"  placeholder="输入一个名称，下次你自己能认识即可！" maxlength="64" id="title" name="title">
	          </div>
	          <div class="form-group">
	            <label for="recipient-name" class="control-label">标签（以“,”间隔，至少给一个）:</label>
	            <input type="text" class="form-control"   AUTOCOMPLETE="off"  placeholder="标签以“,”间隔，至少给一个" maxlength="64" id="tagNames" name="tagNames">
	          </div>
	          <div class="form-group">
	            <label for="message-text" class="control-label">描述（你最好是输入一下，字数限制：140字）:</label>
	            <textarea class="form-control"   AUTOCOMPLETE="off"  placeholder="简单给个描述，将要保存的信息它是干哈的！" maxlength="140"  id="description" name="description"></textarea>
	          </div>
	        </form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="saveCloudExe">保存云端</button>
	      </div>
	    </div>
	  </div>
	</div>
<#--/保存云端--->



</#macro>

<#--解码/加密-->
<#macro encrypt index>
<div class="toolsTab  clearfix"  style="padding-bottom: 15px; margin-top: 40px;">
    <ul class="nav nav-tabs _load">
    	<li class="${(index==1)?string('active',' ')}"><a href="http://www.sojson.com/encrypt.html">加密/解密</a></li>
    	<li class="${(index==2)?string('active',' ')}"><a href="http://www.sojson.com/hash.html">散列/哈希</a></li>
		<li class="${(index==3)?string('active',' ')}"><a href="http://www.sojson.com/base64.html">BASE64</a></li>
		<li class="${(index==4)?string('active',' ')}"><a href="http://www.sojson.com/image2base64.html">图片转 BASE64</a></li>
		<li class="${(index==5)?string('active',' ')}"><a href="http://www.sojson.com/hexconvert.html">进制转换</a></li>
		<li class="${(index==6)?string('active',' ')}"><a href="http://www.sojson.com/encodeurl.html">URL转码</a></li>
		<li class="${(index==7)?string('active',' ')}"><a href="http://www.sojson.com/ascii.html">ASCII转换</a></li>
		<li class="${(index==8)?string('active',' ')}"><a href="http://www.sojson.com/utf8.html">UTF-8编码</a></li>
		<li class="${(index==9)?string('active',' ')}"><a href="http://www.sojson.com/htpasswd.html">htpasswd生成器</a></li>
		<li class="${(index==11)?string('active',' ')}"><a href="http://www.sojson.com/thunder/">迅雷|快车|旋风URL加解密</a></li>
		<li class="${(index==10)?string('active',' ')}"><a href="http://www.sojson.com/md5/">MD5加密</a></li>
		<li class="${(index==12)?string('active',' ')}"><a href="http://www.sojson.com/unicode.html">Unicode</a></li>
    </ul>
    <div class='clear'></div>
</div>
</#macro>
<#--压缩/解压-->
<#macro fmt index>
<div class="toolsTab clearfix"  style="padding-bottom: 15px; margin-top: 40px;">
    <ul class="nav nav-tabs _load">
        <li class="${(index==1)?string('active',' ')}"><a href="http://www.sojson.com/fmt/jshtml">JS/HTML格式化、压缩</a></li>
        <li class="${(index==2)?string('active',' ')}"><a href="http://www.sojson.com/fmt/css">CSS格式化、压缩</a></li>
        <li class="${(index==3)?string('active',' ')}"><a href="http://www.sojson.com/fmt/xml">XML格式化、压缩</a></li>
		<li class="${(index==4)?string('active',' ')}" ><a href="http://www.sojson.com/fmt/sql">SQL格式化、压缩</a></li>
		<li class="${(index==5)?string('active',' ')}" ><a href="http://www.sojson.com/fmt/jscodeconfusion">JS代码混淆</a></li>
		<li class="${(index==6)?string('active',' ')}" ><a href="http://www.sojson.com/fmt/js">JS混淆加密、压缩</a></li>
    </ul>
    <div class="clear"></div>
</div>
</#macro>
<#--常用对照表-->
<#macro table index>
	<div class="toolsTab clearfix"  style="padding-bottom: 15px; margin-top: 40px;">
	    <ul class="nav nav-tabs _load">
            <li class="${(index==1)?string('active',' ')}"><a href="http://www.sojson.com/httpcontent.html">HTTP Content-type</a></li>
	    	<li class="${(index==2)?string('active',' ')}"><a href="http://www.sojson.com/htmlmark.html">HTML转义字符</a></li>
			<li class="${(index==3)?string('active',' ')}"><a href="http://www.sojson.com/rgb.html">RGB颜色参考</a></li>
			<li class="${(index==4)?string('active',' ')}"><a href="http://www.sojson.com/asciitable.html">ASCII对照表</a></li>
			<li class="${(index==5)?string('active',' ')}"><a href="http://www.sojson.com/http.html">HTTP状态码详解</a></li>
			<li class="${(index==6)?string('active',' ')}"><a href="http://www.sojson.com/operation.html">各语言运算符优先级</a></li>
			<li class="${(index==7)?string('active',' ')}"><a href="http://www.sojson.com/port.html">TCP/UDP端口参考</a></li>
			<li class="${(index==8)?string('active',' ')}"><a href="http://www.sojson.com/font.html">网页字体参考</a></li>
	    </ul>
	    <div class="clear"></div>
	</div>
</#macro>