package com.jingmax.entity;

import java.util.List;

/**
 * 模板信息
 * 
 * @author zhanghc 2015-5-1下午09:29:51
 */
public class FtlInfo {
	/** 表编码 */
	private String tableCode;
	/** 表名称 */
	private String tableName;
	/** 基础包名 */
	private String packageName;
	/** 项目名 */
	private String projectName;
	/** 实体名称 */
	private String entityName;
	/** 实体名称（首字母大写） */
	private String entityNameFU;
	/** 作者 */
	private String author;
	/** 更新时间 */
	private String updateTime;
	/** 生成文件路径 */
	private String filePath;
	/** 模板详细信息 */
	private List<FtlDetail> ftlDetailList;
	/** 模板查询信息 */
	private List<ConditionInfo> conditionInfoList;

	public String getTableCode() {
		return tableCode;
	}

	public void setTableCode(String tableCode) {
		this.tableCode = tableCode;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String getPackageName() {
		return packageName;
	}

	public void setPackageName(String packageName) {
		this.packageName = packageName;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getEntityName() {
		return entityName;
	}

	public void setEntityName(String entityName) {
		this.entityName = entityName;
	}

	public String getEntityNameFU() {
		return entityNameFU;
	}

	public void setEntityNameFU(String entityNameFU) {
		this.entityNameFU = entityNameFU;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public List<FtlDetail> getFtlDetailList() {
		return ftlDetailList;
	}

	public void setFtlDetailList(List<FtlDetail> ftlDetailList) {
		this.ftlDetailList = ftlDetailList;
	}

	public List<ConditionInfo> getConditionInfoList() {
		return conditionInfoList;
	}

	public void setConditionInfoList(List<ConditionInfo> conditionInfoList) {
		this.conditionInfoList = conditionInfoList;
	}
}
