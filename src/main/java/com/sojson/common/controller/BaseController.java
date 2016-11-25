package com.sojson.common.controller;

import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.sojson.common.utils.StringUtils;

/**
 * 
 * 开发公司：itboy.net<br/>
 * 版权：itboy.net<br/>
 * <p>
 * 
 * 
 * 
 * <p>
 * 
 * 区分　责任人　日期　　　　说明<br/>
 * 创建　周柏成　2016年5月3日 　<br/>
 * <p>
 * *******
 * <p>
 * @author zhou-baicheng
 * @email  i@itboy.net
 * @version 1.0,2016年5月3日 <br/>
 * 
 */
public class BaseController {

	
	protected int pageNo =1;
	public static  int pageSize = 10;
	protected final static Logger logger = Logger.getLogger(BaseController.class);
	protected Map<String, Object> resultMap = new LinkedHashMap<String, Object>();
	public static String URL404 =  "/404.html";
	
	private final static String PARAM_PAGE_NO = "pageNo";
	
	protected String pageSizeName = "pageSize";
	
	/**
	 * 往Request里带值
	 * @param request
	 * @param key
	 * @param value
	 */
	protected static void setValue2Request(HttpServletRequest request,String key,Object value){
		request.setAttribute(key, value);
	}
	
	/**
	 * [获取session]
	 * @param request
	 * @return
	 */
	public static HttpSession getSession(HttpServletRequest request){
		return request.getSession();
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		BaseController.pageSize = pageSize;
	}
	
	public ModelAndView redirect(String redirectUrl,Map<String,Object>...parament){
		ModelAndView view = new ModelAndView(new RedirectView(redirectUrl));
		if(null != parament && parament.length > 0){
			view.addAllObjects(parament[0]);
		}
		return view;
	}
	public ModelAndView redirect404(){
		return new ModelAndView(new RedirectView(URL404));
	}
	
	@SuppressWarnings("unchecked")
	protected Map<String, Object> prepareParams(Object obj, HttpServletRequest request) throws Exception {
		if (request != null) {
			String pageNoStr   = (String)request.getParameter(PARAM_PAGE_NO),
				   pageSizeStr = (String)request.getParameter(pageSizeName);
			if (StringUtils.isNotBlank(pageNoStr)) {
				pageNo = Integer.parseInt(pageNoStr);
			}
			if (StringUtils.isNotBlank(pageSizeStr)) {
				pageSize = Integer.parseInt(pageSizeStr);
			}
		}
		
		Map<String, Object> params = new HashMap<String, Object>();
		params = BeanUtils.describe(obj);
		params = handleParams(params);
		// 回填值项
		//BeanUtils.populate(obj, params);
		return params;
	}
	private Map<String, Object> handleParams(Map<String, Object> params) {
		Map<String, Object> result = new HashMap<String, Object>();
		if (null != params) {
			Set<Entry<String, Object>> entrySet = params.entrySet();
			
			for (Iterator<Entry<String, Object>> it = entrySet.iterator(); it.hasNext(); ) {
				Entry<String, Object> entry = it.next();
				if (entry.getValue() != null) {
					result.put(entry.getKey(), StringUtils.trimToEmpty((String)entry.getValue()));
				}				
			}
		}
		return result;
	}
	
}
