package com.sojson.core.statics;

import java.util.Calendar;

import com.sojson.core.config.IConfig;

/**
 * 
 * 开发公司：SOJSON在线工具 <p>
 * 版权所有：© www.sojson.com<p>
 * 博客地址：http://www.sojson.com/blog/  <p>
 * <p>
 * 
 * 静态变量
 * 
 * <p>
 * 
 * 区分　责任人　日期　　　　说明<br/>
 * 创建　周柏成　2016年6月2日 　<br/>
 *
 * @author zhou-baicheng
 * @email  so@sojson.com
 * @version 1.0,2016年6月2日 <br/>
 * 
 */
public interface Constant {
	
	static final String CONTEXT_PATH = "contextPath";/***项目根路径*/
	
	/***Freemarker 使用的变量 begin**/
	
	static final String TARGET = "target";//标签使用目标
	
	static final String OUT_TAG_NAME = "outTagName";//输出标签Name
	
	/***Freemarker 使用的变量 end**/
	
	
	/**其他常用变量 begin**/
	static final String NAME = "name" ;
	static final String ID = "id" ;
	static final String TOKEN = "token" ;
	static final String LOING_USER  = "loing_user" ;
	/**Long */
	static final Long ZERO = new Long(0);
	static final Long ONE = new Long(1);
	static final Long TWO = new Long(2);
	static final Long THREE = new Long(3);
	static final Long EIGHT = new Long(8);
	
	/**String */
	static final String S_ZERO = "0";
	static final String S_ONE = "1";
	static final String S_TOW = "2";
	static final String S_THREE = "3";
	
	/**Integer */
	static final Integer I_ZERO = 0;
	static final Integer I_ONE = 1;
	static final Integer I_TOW = 2;
	static final Integer I_THREE = 3;
	/**其他常用变量 end**/
	
	/**cache常用变量 begin**/
	static final String CACHE_NAME = "shiro_cache";
	static final String CACHE_MANAGER = "cacheManager" ;//cacheManager bean name
	/**cache常用变量 end**/
	
	/**当前年份**/
	static final int NOW_YEAY = Calendar.getInstance().get(Calendar.YEAR);
	
	
	/**地址**/
	static final String DOMAIN_WWW = IConfig.get("domain.www");//前端域名
	static final String DOMAIN_CDN = IConfig.get("domain.cdn");//静态资源域名
	static String VERSION = String.valueOf(System.currentTimeMillis());//版本号，重启的时间
	
	
	//存储到缓存，标识用户的禁止状态，解决在线用户踢出的问题
	final static String  EXECUTE_CHANGE_USER = "SOJSON_EXECUTE_CHANGE_USER";
}
