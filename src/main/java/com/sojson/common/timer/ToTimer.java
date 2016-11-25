package com.sojson.common.timer;

import java.util.Date;

import javax.annotation.Resource;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.sojson.common.utils.DateUtil;
import com.sojson.common.utils.LoggerUtils;
import com.sojson.permission.service.RoleService;


/**
 * 定时任务恢复数据
 *
 */
@Component
public class ToTimer{
	
	@Resource
	RoleService roleService;
	
	/**
	 * 20分钟一次轮回执行
	 */
	@Scheduled(cron = "0 0/20 * * * ?")
	public void run() {
		LoggerUtils.fmtDebug(getClass(), "执行初始化数据开始：[%s]", DateUtil.dateToString(new Date(), DateUtil.DATETIME_PATTERN));
		/**
		 * 调用存储过程，重新创建表，插入初始化数据。
		 */
		roleService.initData();
		LoggerUtils.fmtDebug(getClass(), "执行初始化数据结束：[%s]", DateUtil.dateToString(new Date(), DateUtil.DATETIME_PATTERN));
	}

	
	
	
	
	
	
}
