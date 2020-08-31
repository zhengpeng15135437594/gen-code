package com.jingmax.entity;

/**
 * 数据库列信息
 * 
 * v1.0 zhanghc 2015-5-6下午05:26:27
 */
public class DBColInfo {
	private String code;
	private String name;
	private String type;
	private int len;

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getLen() {
		return len;
	}

	public void setLen(int len) {
		this.len = len;
	}
}
