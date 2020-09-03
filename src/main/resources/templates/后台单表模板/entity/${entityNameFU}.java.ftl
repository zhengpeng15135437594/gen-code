package ${packageName}.${projectName}.entity;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * ${tableName}实体
 * 
 * v1.0 ${author} ${updateTime}
 */
@Entity
@Table(name = "${tableCode}")
public class ${entityNameFU} {
	<#list ftlDetailList as ftlDetail>
	<#if ftlDetail.fieldName == "id">
	@Id
	<#if ftlDetail.colType == "INT">
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	<#elseif ftlDetail.colType == "BIGINT">
	@GeneratedValue(generator = "snowFlake")
	@GenericGenerator(name = "snowFlake", strategy = "com.jingmax.core.hibernate.SnowFlakeGenerator")
	</#if>
	</#if>
	<#if ftlDetail.colType == "DATETIME">
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
	</#if>
	@Column(name = "${ftlDetail.colCode}")
	<#if ftlDetail.colType == "VARCHAR" || ftlDetail.colType == "TEXT">
	private String ${ftlDetail.fieldName};
	<#elseif ftlDetail.colType == "INT">
	private Integer ${ftlDetail.fieldName};
	<#elseif ftlDetail.colType == "DOUBLE">
	private Double ${ftlDetail.fieldName};
	<#elseif ftlDetail.colType == "DATETIME">
	private Date ${ftlDetail.fieldName};
	<#elseif ftlDetail.colType == "DECIMAL">
	private BigDecimal ${ftlDetail.fieldName};
	<#elseif ftlDetail.colType == "BIGINT">
	private Long ${ftlDetail.fieldName};
	</#if>
	</#list>
	<#list ftlDetailList as ftlDetail>
	<#if ftlDetail.colType == "VARCHAR" || ftlDetail.colType == "TEXT">
	
	public String get${ftlDetail.fieldNameFU}() {
		return ${ftlDetail.fieldName};
	}
 
	public void set${ftlDetail.fieldNameFU}(String ${ftlDetail.fieldName}) {
		this.${ftlDetail.fieldName} = ${ftlDetail.fieldName};
	}
	<#elseif ftlDetail.colType == "INT">
	
	public Integer get${ftlDetail.fieldNameFU}() {
		return ${ftlDetail.fieldName};
	}

	public void set${ftlDetail.fieldNameFU}(Integer ${ftlDetail.fieldName}) {
		this.${ftlDetail.fieldName} = ${ftlDetail.fieldName};
	}
	<#elseif ftlDetail.colType == "DOUBLE">
	
	public Double get${ftlDetail.fieldNameFU}() {
		return ${ftlDetail.fieldName};
	}

	public void set${ftlDetail.fieldNameFU}(Double ${ftlDetail.fieldName}) {
		this.${ftlDetail.fieldName} = ${ftlDetail.fieldName};
	}
	<#elseif ftlDetail.colType == "DATETIME">
	
	public Date get${ftlDetail.fieldNameFU}() {
		return ${ftlDetail.fieldName};
	}

	public void set${ftlDetail.fieldNameFU}(Date ${ftlDetail.fieldName}) {
		this.${ftlDetail.fieldName} = ${ftlDetail.fieldName};
	}
	<#elseif ftlDetail.colType == "DECIMAL">
	
	public BigDecimal get${ftlDetail.fieldNameFU}() {
		return ${ftlDetail.fieldName};
	}

	public void set${ftlDetail.fieldNameFU}(BigDecimal ${ftlDetail.fieldName}) {
		this.${ftlDetail.fieldName} = ${ftlDetail.fieldName};
	}
	<#elseif ftlDetail.colType == "BIGINT">
	
	public Long get${ftlDetail.fieldNameFU}() {
		return ${ftlDetail.fieldName};
	}

	public void set${ftlDetail.fieldNameFU}(Long ${ftlDetail.fieldName}) {
		this.${ftlDetail.fieldName} = ${ftlDetail.fieldName};
	}
	</#if>
	</#list>
}