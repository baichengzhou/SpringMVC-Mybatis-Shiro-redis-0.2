package com.sojson.core.mybatis.page;

/**
 * 
 * 开发公司：SOJSON在线工具 <p>
 * 版权所有：© www.sojson.com<p>
 * 博客地址：http://www.sojson.com/blog/  <p>
 * <p>
 * 
 * 分页实体
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
public interface Paginable {


		/**
		 * 总记录数
		 * 
		 * @return
		 */
		public int getTotalCount();

		/**
		 * 总页数
		 * 
		 * @return
		 */
		public int getTotalPage();

		/**
		 * 每页记录数
		 * 
		 * @return
		 */
		public int getPageSize();

		/**
		 * 当前页号
		 * 
		 * @return
		 */
		public int getPageNo();

		/**
		 * 是否第一页
		 *
		 * @return
		 */
		public boolean isFirstPage();

		/**
		 * 是否最后一页
		 * 
		 * @return
		 */
		public boolean isLastPage();

		/**
		 * 返回下页的页号
		 */
		public int getNextPage();

		/**
		 * 返回上页的页号
		 */
		public int getPrePage();
	}
