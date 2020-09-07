package com.jingmax.entity;

/**
 * 查询信息
 * 
 * v1.0 peng_zheng 2020-8-28下午05:27:17
 */
public class ConditionInfo {
	// 数据库字段
	private String code;
	// 实体字段
	private String entityCode;
	// 实体字段
	private String codeToHump;
	// 字段名称
	private String name;
	// 字段页面显示类型
	private Integer type;
	// 页面是否展示
	private Integer web;
	// 是否必填
	private Integer required;
	// 查询（模糊/精确）
	private Integer search;
	// 排序
	private Integer sort;
	// 查询条件（pageIn.getThree()）
	private String pageIn;
	// 查询条件（three）
	private String pageInName;

	public ConditionInfo() {
		super();
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getEntityCode() {
		return entityCode;
	}

	public void setEntityCode(String entityCode) {
		this.entityCode = entityCode;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCodeToHump() {
		return codeToHump;
	}

	public void setCodeToHump(String codeToHump) {
		this.codeToHump = codeToHump;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getWeb() {
		return web;
	}

	public void setWeb(Integer web) {
		this.web = web;
	}

	public Integer getRequired() {
		return required;
	}

	public void setRequired(Integer required) {
		this.required = required;
	}

	public Integer getSearch() {
		return search;
	}

	public void setSearch(Integer search) {
		this.search = search;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	public String getPageIn() {
		return pageIn;
	}

	public void setPageIn(String pageIn) {
		this.pageIn = pageIn;
	}

	public String getPageInName() {
		return pageInName;
	}

	public void setPageInName(String pageInName) {
		this.pageInName = pageInName;
	}
}
