package com.jingmax.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * 日期工具类
 * 
 * v1.0 zhanghc 2015-7-21下午10:20:39
 */
public class DateUtil {
	/** yyyy-MM-dd */
	public static final String FORMAT_DATE = "yyyy-MM-dd";
	/** yyyy-MM-dd HH:mm:ss */
	public static final String FORMAT_DATE_TIME = "yyyy-MM-dd HH:mm:ss";

	/**
	 * *
	 * 获取格式化时间
	 * 
	 * v1.0 zhanghc 2015-7-21下午10:20:39
	 * @param date
	 * @param pattern
	 * @return String
	 */
	public static String getFormatDate(Date date, String pattern){
		SimpleDateFormat format = new SimpleDateFormat(pattern);
		return format.format(date);
	}
	
	/**
	 * 获取格式化时间
	 * 
	 * v1.0 zhanghc 2015-7-21下午10:20:39
	 * @return String
	 */
	public static String getFormatDateTime(){
		return getFormatDate(new Date(), DateUtil.FORMAT_DATE_TIME);
	}
	
	/**
	 * 获取格式化时间
	 * 
	 * v1.0 zhanghc 2015-7-21下午10:20:39
	 * @param date
	 * @return String yyyy-MM-dd HH:mm:ss
	 */
	public static String getFormatDateTime(Date date){
		return getFormatDate(date, DateUtil.FORMAT_DATE_TIME);
	}
	
	/**
	 * 获取下一天时间
	 * 
	 * v1.0 zhanghc 2017年4月23日下午6:04:23
	 * @param date
	 * @param dayNum
	 * @return
	 * Date
	 */
	public static Date getNextDay(Date date, int dayNum){
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.DAY_OF_MONTH, dayNum);
		return calendar.getTime();
	}
	
	/**
	 * 获取下一小时时间
	 * 
	 * v1.0 zhanghc 2019年4月24日上午11:06:53
	 * @param date
	 * @param hourNum
	 * @return Date
	 */
	public static Date getNextHour(Date date, int hourNum) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.HOUR_OF_DAY, hourNum);
		return calendar.getTime();
	}
	
	/**
	 * 获取下一分钟时间
	 * 
	 * v1.0 zhanghc 2019年4月24日上午11:06:53
	 * @param date
	 * @param minuteNum
	 * @return Date
	 */
	public static Date getNextMinute(Date date, int minuteNum) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.MINUTE, minuteNum);
		return calendar.getTime();
	}
	
	/**
	 * 获取下一秒时间
	 * 
	 * v1.0 zhanghc 2019年4月24日上午11:06:53
	 * @param date
	 * @param secondNum
	 * @return Date
	 */
	public static Date getNextSecond(Date date, int secondNum) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.SECOND, secondNum);
		return calendar.getTime();
	}
	
	/**
	 * 
	 * 获取解析后的时间
	 * 
	 * v1.0 zhanghc 2017年4月23日下午6:05:19
	 * @param dateStr
	 * @param pattern
	 * @return
	 * Date
	 */
	public static Date getDate(String dateStr, String pattern){
		SimpleDateFormat format = new SimpleDateFormat(pattern);
		try {
			return format.parse(dateStr);
		} catch (ParseException e) {
			throw new RuntimeException("解析时间异常：", e);
		}
	}
	
	/**
	 * 获取解析后的时间
	 * 
	 * v1.0 zhanghc 2017年4月23日下午6:08:48
	 * @param dateStr yyyy-MM-dd HH:mm:ss 
	 * @return Date
	 */
	public static Date getDate(String dateStr){
		return getDate(dateStr, DateUtil.FORMAT_DATE_TIME);
	}
}
