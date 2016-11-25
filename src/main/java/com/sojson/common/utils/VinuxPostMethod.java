package com.sojson.common.utils;

import java.io.IOException;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.PropertyFilter;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;

/**
 * 
 * 开发公司：SOJSON在线工具 <p>
 * 版权所有：© www.sojson.com<p>
 * 博客地址：http://www.sojson.com/blog/  <p>
 * <p>
 * 
 * 封装PostMethod
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
public class VinuxPostMethod extends PostMethod {

	public final static String JSONObject = "JSONObject";
	public final static String JSONArray = "JSONArray";
	
	//自定义请求头信息
	private Map<String,String> head = new LinkedHashMap<String, String>();
	private int timeOut = 60000 ;//默认超时时间

	/**
	 * 直接返回对应类型
	 * @param <T>
	 * @param requiredType  支持[net.sf.json.JSONArray,net.sf.json.JSONObject,String]
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public <T> T executeMethod(Class<T> requiredType) {
		if (null == requiredType) {
			return null;
		}
		if ("net.sf.json.JSONArray".equals(requiredType
				.getCanonicalName())) {
			return (T) executeMethod(JSONArray);
		}
		if ("net.sf.json.JSONObject".equals(requiredType
				.getCanonicalName())) {
			return (T) executeMethod(JSONObject);
		}else{
			return (T) executeMethod();
		}
	}

	/***
	 * 执行方法 type 可以不传，默认返回String
	 * 
	 * @param type
	 *            [JSONObject,JSONArray]
	 * @return
	 */
	public Object executeMethod(String... type) {
		try {
			HttpClient client = new HttpClient();
			//取到当前系统域名，方便被请求方统计来源
			client.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET,
					"UTF-8");
			client.getParams().setParameter("Connection","close");
			/**
			 * 请求超时时间
			 * 如果需要调整，请setTimeOut(自定义时间(单位毫秒))
			 */
			//加入额外的请求头信息
			for (String key : head.keySet()) {
				if(StringUtils.isNotBlank(key,head.get(key))){
					this.setRequestHeader(key,head.get(key));
				}
			}
			
			client.getHttpConnectionManager().getParams().setConnectionTimeout(getTimeOut());
			int status = 0;
			String result = null;
			String url = getPath();
			try {
				status = client.executeMethod(this);
			} catch (Exception e) {
				LoggerUtils.error(getClass(),
						"请求[" + url + "]超时或错误,message : " + e.getMessage(), e);
				RuntimeException ve = new RuntimeException("请求[" + url + "]超时或错误,message : "
						+ e.getMessage(),e);
				throw ve;
			}
	
			if (status == HttpStatus.SC_OK) {
				try {
					result = this.getResponseBodyAsString();
				} catch (IOException e) {
					LoggerUtils.error(getClass(),
							"Abnormal request returns! Exception information as follows: "
									+ e.getMessage(), e);
					RuntimeException ve = new RuntimeException( "请求[" + url + "]超时或错误,message : "
							+ e.getMessage(),e);
					throw ve;
				}
			} else {
				LoggerUtils.error(getClass(), "HTTP请求错误，请求地址为：[" + url + "],状态为：["
						+ status + "]");
				throw new RuntimeException( "HTTP请求错误，请求地址为：[" + url
						+ "],状态为：[" + status + "]");
			}
			if (StringUtils.indexOf(JSONObject, type) > 0) {
				return net.sf.json.JSONObject.fromObject(result);
			}
	
			if (StringUtils.indexOf(JSONArray, type) > 0) {
				return net.sf.json.JSONArray.fromObject(result);
			}
			return result;
		}finally{
			this.releaseConnection();
		}
	}

	/**
	 * 设置参数List<Map<String, Object>>
	 * 
	 * @param parameter
	 */
	public void setParameter(List<Map<String, Object>> parameter) {
		for (Map<String, Object> map : parameter) {
			setParameter(map);
		}
	}

	/**
	 * 设置参数JSONObject
	 * 
	 * @param parameter
	 */
	public void setJSONParameter(JSONObject parameter) {
		for (Iterator<?> iter = parameter.keys(); iter.hasNext();) {
			String key = (String) iter.next();
			Object str = parameter.get(key);
			String value = null == str ? "" : StringUtils.trimToEmpty(str
					.toString());
			this.addParameter(key, value);
		}
	}

	/**
	 * 设置参数JSONArray
	 * 
	 * @param parameter
	 */
	public void setJSONArrayParameter(JSONArray parameter) {
		for (Object object : parameter) {
			JSONObject jsonObject = (JSONObject) object;
			this.setJSONParameter(jsonObject);
		}
	}

	/**
	 * 设置参数Map<String, Object>
	 * 
	 * @param parameter
	 */
	public void setParameter(Map<String, Object> parameter) {
		for (String key : parameter.keySet()) {
			Object str = parameter.get(key);
			String value = null == str ? "" : StringUtils.trimToEmpty(str.toString());
			this.addParameter(key, value);
		}
	}

	/**
	 * 构造方法begin
	 */
	 public VinuxPostMethod() {
		 super();
	 }
	public VinuxPostMethod(String url) {
		super(url);
	}

	public VinuxPostMethod(List<Map<String, Object>> parameter) {
		super();
		this.setParameter(parameter);
	}

	public VinuxPostMethod(String url, List<Map<String, Object>> parameter) {
		super(url);
		this.setParameter(parameter);
	}

	public VinuxPostMethod(JSONObject parameter) {
		super();
		this.setJSONParameter(parameter);
	}

	public VinuxPostMethod(Map<String, Object> parameter) {
		super();
		this.setParameter(parameter);
	}

	public VinuxPostMethod(String url, Map<String, Object> parameter) {
		super(url);
		this.setParameter(parameter);
	}

	public VinuxPostMethod(String url, JSONObject parameter) {
		super(url);
		this.setJSONParameter(parameter);
	}

	public VinuxPostMethod(JSONArray parameter) {
		super();
		this.setJSONArrayParameter(parameter);
	}

	public VinuxPostMethod(String url, JSONArray parameter) {
		super(url);
		this.setJSONArrayParameter(parameter);
	}
	
	
	/**
	 * 构造方法end
	 */
	

	public Map<String, String> getHead() {
		return head;
	}

	public void setHead(Map<String, String> head) {
		this.head = head;
	}

	public int getTimeOut() {
		return timeOut;
	}

	public void setTimeOut(int timeOut) {
		this.timeOut = timeOut;
	}
	
	
	public JsonConfig getConfig(){
		JsonConfig config = new JsonConfig();
		// 实现属性过滤器接口并重写apply()方法
		PropertyFilter pf = new PropertyFilter() {
			@Override
			// 返回true则跳过此属性，返回false则正常转换
			public boolean apply(Object source, String name, Object value) {
				if (StringUtils.isBlank(value)) {
					return true;
				}
				return false;
			}
		};
		// 将过滤器放入json-config中
		config.setJsonPropertyFilter(pf);
		
		return config;
	}
}
