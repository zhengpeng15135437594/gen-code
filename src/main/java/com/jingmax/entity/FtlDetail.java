package com.jingmax.entity;

/**
 * 模板详细信息
 * 
 * @author zhanghc 2015-5-1下午09:29:51
 */
public class FtlDetail {
	/** 列编码 */
	private String colCode;
	/** 列名称 */
	private String colName;
	/** 列类型 */
	private String colType;
	/** 列长度 */
	private int colLen;
	/** 字段名称 */
	private String fieldName;
	/** 字段名称（首字母大写） */
	private String fieldNameFU;

	public String getColCode() {
		return colCode;
	}

	public void setColCode(String colCode) {
		this.colCode = colCode;
	}

	public String getColName() {
		return colName;
	}

	public void setColName(String colName) {
		this.colName = colName;
	}

	public String getColType() {
		return colType;
	}

	public void setColType(String colType) {
		this.colType = colType;
	}

	public int getColLen() {
		return colLen;
	}

	public void setColLen(int colLen) {
		this.colLen = colLen;
	}

	public String getFieldName() {
		return fieldName;
	}

	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}

	public String getFieldNameFU() {
		return fieldNameFU;
	}

	public void setFieldNameFU(String fieldNameFU) {
		this.fieldNameFU = fieldNameFU;
	}
}
