package com.jingmax.entity;

import java.util.ArrayList;
import java.util.List;

/**
 * 数据库表信息
 * 
 * v1.0 zhanghc 2015-5-6下午05:27:17
 */
public class DBTableInfo {
	private String code;
	private String name;
	private List<DBColInfo> colInfoList = new ArrayList<>();

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

	public List<DBColInfo> getColInfoList() {
		return colInfoList;
	}

	public void setColInfoList(List<DBColInfo> colInfoList) {
		this.colInfoList = colInfoList;
	}
}
