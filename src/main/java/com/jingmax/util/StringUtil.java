package com.jingmax.util;

import org.apache.commons.lang3.StringUtils;

/**
 * 字符串工具类
 * 
 * @author zhanghc 2015-4-30下午02:58:01
 */
public class StringUtil {

	/**
	 * 转换成驼峰式字符串。</br> 
	 * 如：转换前：UseR_name_NamE；转换后：userNameName。</br> 
	 * 
	 * v1.0 zhanghc 2015-4-30下午03:08:31</br>
	 * @param str 需要格式化的字符串
	 * @param splitStr 分割字符串
	 * @param firstLower 首字母小写
	 * @return String
	 */
	public static String toHumpStr(String str, String splitStr, boolean firstLower) {
		if(str == null || str.isEmpty()){
			return str;
		}
		
		String[] strArr = str.toLowerCase().split(splitStr);
		for(int i = 0; i < strArr.length; i++){
			if(i == 0){
				strArr[i] = firstLower ? StringUtils.uncapitalize(strArr[i])
						: StringUtils.capitalize(strArr[i]);
				continue;
			}
			
			strArr[i] = StringUtils.capitalize(strArr[i]);
		}

		return StringUtils.join(strArr);
	}
	
	/**
	 * 首字母大写
	 * 
	 * v1.0 zhanghc 2019年6月24日上午11:56:53
	 * @param str
	 * @return String
	 */
	public static String capitalize(String str) {
		return StringUtils.capitalize(str);
	}
	
	/**
	 * 首字母小写
	 * 
	 * v1.0 zhanghc 2019年6月24日上午11:56:53
	 * @param str
	 * @return String
	 */
	public static String uncapitalize(String str) {
		return StringUtils.uncapitalize(str);
	}
	
	public static void main(String[] args) {
		String humpStr = toHumpStr("aaa_bbb_CCC_dDd", "_", true);
		System.err.println(humpStr);
		humpStr = toHumpStr("aaa_bbb_CCC_dDd", "_", false);
		System.err.println(humpStr);
	}
}
