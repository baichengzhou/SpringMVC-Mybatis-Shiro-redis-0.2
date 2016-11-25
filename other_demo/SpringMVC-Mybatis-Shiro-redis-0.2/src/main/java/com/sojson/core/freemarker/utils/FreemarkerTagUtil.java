package com.sojson.core.freemarker.utils;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import freemarker.core.Environment;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;
import freemarker.template.TemplateModelException;




/**
 * 
 * 开发公司：SOJSON在线工具 <p>
 * 版权所有：© www.sojson.com<p>
 * 博客地址：http://www.sojson.com/blog/  <p>
 * <p>
 * 
 * Freemarker Tag Utils
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
public class FreemarkerTagUtil {

	public static final String OUT_TAG_NAME = "outTagName" ;
	
	
	/**
	 * 统一转换模型
	 * @param env
	 * @param maps
	 * @return
	 * @throws TemplateException
	 */
	public static Map<String, TemplateModel> convertToTemplateModel(
			Environment env, Map<String, TemplateModel> maps)
			throws TemplateException {
		Map<String, TemplateModel> origMap = new HashMap<String, TemplateModel>();
		if (maps.size() <= 0) {
			return origMap;
		}
		Set<Map.Entry<String, TemplateModel>> entrySet = maps.entrySet();
		String key;
		TemplateModel value;
		for (Map.Entry<String, TemplateModel> entry : entrySet) {
			key = entry.getKey();
			value = env.getVariable(key);
			if (null != value) {
				origMap.put(key, value);
			}
			env.setVariable(key, entry.getValue());
		}
		return setTemplateModel(env, maps, origMap);
	}
	/**
	 * 复制到新的Object
	 * @param env
	 * @param maps
	 * @param origMap
	 * @return
	 * @throws TemplateModelException
	 */
	public static Map<String, TemplateModel> setTemplateModel(Environment env, Map<String, TemplateModel> maps,Map<String, TemplateModel> origMap) throws TemplateModelException{
		Set<Map.Entry<String, TemplateModel>> entrySet = maps.entrySet();
		String key;
		TemplateModel value;
		for (Map.Entry<String, TemplateModel> entry : entrySet) {
			key = entry.getKey();
			value = env.getVariable(key);
			if (null != value  ) {
				origMap.put(key, value);
			}
			env.setVariable(key, entry.getValue());
		}
		return origMap;
		
	}
	/**
	 * 清除变量值
	 * 
	 * @param env
	 * @param params
	 * @param origMap
	 * @throws TemplateException
	 */
	public static void clearTempleModel(Environment env,
			Map<String, TemplateModel> params,
			Map<String, TemplateModel> origMap) throws TemplateException {
		if (params.size() <= 0) {
			return;
		}
		for (String key : params.keySet()) {
			env.setVariable(key, origMap.get(key));
		}
	}
	
}
