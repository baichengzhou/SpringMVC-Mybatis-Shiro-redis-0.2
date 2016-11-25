package com.sojson.core.mybatis;

import java.lang.reflect.ParameterizedType;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.ParameterMapping;
import org.apache.ibatis.session.Configuration;
import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.sojson.common.utils.LoggerUtils;
import com.sojson.common.utils.StringUtils;
import com.sojson.core.mybatis.page.MysqlDialect;
import com.sojson.core.mybatis.page.Pagination;

@SuppressWarnings( { "unchecked" })
public class BaseMybatisDao<T> extends SqlSessionDaoSupport {

	private String NAMESPACE;
	final static  Class<? extends Object> SELF = BaseMybatisDao.class;
	protected final Log logger = LogFactory.getLog(BaseMybatisDao.class);
	/**默认的查询Sql id*/
	final static String DEFAULT_SQL_ID = "findAll";
	/**默认的查询Count sql id**/
	final static String DEFAULT_COUNT_SQL_ID = "findCount";
	public BaseMybatisDao() {
		try {
			Object genericClz = getClass().getGenericSuperclass();
			if (genericClz instanceof ParameterizedType) {
				Class<T> entityClass = (Class<T>) ((ParameterizedType) genericClz)
						.getActualTypeArguments()[0];
				NAMESPACE = entityClass.getPackage().getName() + "."
						+ entityClass.getSimpleName();
			}
		} catch (RuntimeException e) {
			LoggerUtils.error(SELF, "初始化失败，继承BaseMybatisDao，没有泛型！");
		}
	}
	/**
	 * 根据Sql id 去查询 分页对象
	 * @param sqlId			对应mapper.xml 里的Sql Id
	 * @param params		参数<String,Object>
	 * @param pageNo		number
	 * @param pageSize		size
	 * @return
	 */
	public Pagination findByPageBySqlId(String sqlId,
			Map<String, Object> params, Integer pageNo, Integer pageSize) {

		pageNo = null == pageNo ? 1 : pageNo;
		pageSize = null == pageSize ? 10 : pageSize;

		sqlId = String.format("%s.%s", NAMESPACE,sqlId) ;

		Pagination page = new Pagination();
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);
		Configuration c = this.getSqlSession().getConfiguration();
		int offset = (page.getPageNo() - 1) * page.getPageSize();
		String page_sql = String.format(" limit %s , %s", offset,pageSize);
		params.put("page_sql", page_sql);
		
		
		BoundSql boundSql = c.getMappedStatement(sqlId).getBoundSql(params);
		String sqlcode = boundSql.getSql();
		
		LoggerUtils.fmtDebug(SELF, "findByPageBySqlId sql : %s",sqlcode );
		String countCode = "",countId = "";
		BoundSql countSql = null;
		/**
		 * sql id 和 count id 用同一个
		 */
		if (StringUtils.isBlank(sqlId)) {
			countCode = sqlcode;
			countSql = boundSql;
		} else {
			countId = sqlId;
			
			Map<String,Object> countMap = new HashMap<String,Object>();
			countMap.putAll(params);
			countMap.remove("page_sql");//去掉，分页的参数。
			countSql = c.getMappedStatement(countId).getBoundSql(countMap);
			countCode = countSql.getSql();
		}
		try {
			Connection conn = this.getSqlSession().getConnection();

			List<?> resultList = this.getSqlSession().selectList(sqlId, params);
			page.setList(resultList);
			PreparedStatement ps = getPreparedStatement(countCode, countSql
					.getParameterMappings(), params, conn);
			ps.execute();
			ResultSet set = ps.getResultSet();

			while (set.next()) {
				page.setTotalCount(set.getInt(1));
			}
		} catch (Exception e) {
			LoggerUtils.error(SELF, "jdbc.error.code.findByPageBySqlId",e);
		}
		return page;
	}

	/**
	 * 根据Sql ID 查询List，而不要查询分页的页码
	 * @param sqlId			对应mapper.xml 里的Sql Id[主语句]
	 * @param params		参数<String,Object>
	 * @param pageNo		number
	 * @param pageSize		size
	 * @return
	 */
	public List findList(String sqlId, Map<String, Object> params,
			Integer pageNo, Integer pageSize) {
		pageNo = null == pageNo ? 1 : pageNo;
		pageSize = null == pageSize ? 10 : pageSize;

		int offset = (pageNo - 1) * pageSize;
		String page_sql = String.format(" limit %s , %s", offset,pageSize);
		params.put("page_sql", page_sql);
		sqlId = String.format("%s.%s", NAMESPACE,sqlId) ;

		List resultList = this.getSqlSession().selectList(sqlId, params);
		return resultList;
	}

	/**
	 * 当Sql ID 是 default findAll的情况下。
	 * 
	 * @param params
	 * @param pageNo
	 * @param pageSize
	 * @param requiredType	返回的类型[可以不传参]
	 * @return
	 */
	public List findList(Map<String, Object> params, Integer pageNo,
			Integer pageSize) {
		return findList(DEFAULT_SQL_ID, params, pageNo, pageSize);
	}

	/**
	 * 分页
	 * 
	 * @param sqlId
	 *            主语句
	 * @param countId
	 *            Count 语句
	 * @param params
	 *            参数
	 * @param pageNo
	 *            第几页
	 * @param pageSize每页显示多少条
	 * @param requiredType	返回的类型[可以不传参]
	 * @return
	 */
	public Pagination findPage(String sqlId, String countId,
			Map<String, Object> params, Integer pageNo, Integer pageSize) {
		pageNo = null == pageNo ? 1 : pageNo;
		pageSize = null == pageSize ? 10 : pageSize;
		Pagination page = new Pagination();
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);
		Configuration c = this.getSqlSession().getConfiguration();
		int offset = (page.getPageNo() - 1) * page.getPageSize();
		String page_sql = String.format(" limit  %s , %s ", offset,pageSize);
		params.put("page_sql", page_sql);

		sqlId =  String.format("%s.%s", NAMESPACE,sqlId) ;

		BoundSql boundSql = c.getMappedStatement(sqlId).getBoundSql(params);
		String sqlcode = boundSql.getSql();
		LoggerUtils.fmtDebug(SELF, "findPage sql : %s",sqlcode );
		String countCode = "";
		BoundSql countSql = null;
		if (StringUtils.isBlank(countId)) {
			countCode = sqlcode;
			countSql = boundSql;
		} else {
			countId = String.format("%s.%s", NAMESPACE,countId) ;
			countSql = c.getMappedStatement(countId).getBoundSql(params);
			countCode = countSql.getSql();
		}
		try {
			Connection conn = this.getSqlSession().getConnection();

			List resultList = this.getSqlSession().selectList(sqlId, params); 

			page.setList(resultList);
			
			/**
			 * 处理Count
			 */
			PreparedStatement ps = getPreparedStatement4Count(countCode, countSql
					.getParameterMappings(), params, conn);
			ps.execute();
			ResultSet set = ps.getResultSet();

			while (set.next()) {
				page.setTotalCount(set.getInt(1));
			}
		} catch (Exception e) {
			LoggerUtils.error(SELF, "jdbc.error.code.findByPageBySqlId",e);
		}
		return page;

	}
	/**
	 * 重载减少参数DEFAULT_SQL_ID, "findCount"
	 * 
	 * @param params
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public Pagination findPage(Map<String, Object> params, Integer pageNo,
			Integer pageSize) {

		return findPage(DEFAULT_SQL_ID, DEFAULT_COUNT_SQL_ID, params, pageNo, pageSize);
	}
	/**
	 * 组装
	 * @param sql
	 * @param parameterMappingList
	 * @param params
	 * @param conn
	 * @return
	 * @throws SQLException
	 */
	private PreparedStatement getPreparedStatement(String sql,
			List<ParameterMapping> parameterMappingList,
			Map<String, Object> params, Connection conn) throws SQLException {
		/**
		 * 分页根据数据库分页
		 */
		MysqlDialect o = new MysqlDialect();

		PreparedStatement ps = conn.prepareStatement(o.getCountSqlString(sql));
		int index = 1;
		for (int i = 0; i < parameterMappingList.size(); i++) {
			ps.setObject(index++, params.get(parameterMappingList.get(i)
					.getProperty()));
		}
		return ps;
	}
	/**
	 * 分页查询Count 直接用用户自己写的Count sql
	 * @param sql
	 * @param parameterMappingList
	 * @param params
	 * @param conn
	 * @return
	 * @throws SQLException
	 */
	private PreparedStatement getPreparedStatement4Count(String sql,
			List<ParameterMapping> parameterMappingList,
			Map<String, Object> params, Connection conn) throws SQLException {
		PreparedStatement ps = conn.prepareStatement(StringUtils.trim(sql));
		int index = 1;
		for (int i = 0; i < parameterMappingList.size(); i++) {
			ps.setObject(index++, params.get(parameterMappingList.get(i)
					.getProperty()));
		}
		return ps;
	}
	

}
