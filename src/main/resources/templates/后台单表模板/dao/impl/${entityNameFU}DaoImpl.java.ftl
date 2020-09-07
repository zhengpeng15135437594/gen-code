package ${packageName}.${projectName}.dao.impl;

import org.springframework.stereotype.Repository;

import ${packageName}.core.dao.impl.RBaseDaoImpl;
import ${packageName}.core.entity.PageIn;
import ${packageName}.core.entity.PageOut;
import ${packageName}.core.util.SqlUtil;
import ${packageName}.core.util.SqlUtil.Order;
import ${packageName}.core.util.ValidateUtil;
import ${packageName}.core.util.HibernateUtil;
import ${packageName}.core.util.DateUtil;
import ${packageName}.sys.cache.DictCache;
import ${packageName}.${projectName}.dao.${entityNameFU}Dao;
import ${packageName}.${projectName}.entity.${entityNameFU};

/**
 * ${tableName}数据访问层实现
 * 
 * v1.0 ${author} ${updateTime}
 */
@Repository
public class ${entityNameFU}DaoImpl extends RBaseDaoImpl<${entityNameFU}> implements ${entityNameFU}Dao {

	@Override
	public PageOut getListpage(PageIn pageIn) {
		<#assign tableAlias=tableCode?substring(tableCode?index_of('_') + 1)>
		String sql = "SELECT * "
				+ "FROM ${tableCode} ${tableAlias} ";
		SqlUtil sqlUtil = new SqlUtil(sql);
		sqlUtil.addWhere(ValidateUtil.isValid(pageIn.getTwo()), "${tableAlias}.ID = ?", pageIn.getTwo())
				<#list conditionInfoList as condition>
					<#if condition.search == 1>
						.addWhere(ValidateUtil.isValid(${condition.pageIn}), "${tableAlias}.${condition.code} = ?", ${condition.pageIn})
					</#if>
					<#if condition.search == 2>
						.addWhere(ValidateUtil.isValid(${condition.pageIn}), "${tableAlias}.${condition.code} LIKE ?", String.format("%%%s%%", ${condition.pageIn}))
					</#if>
				</#list>
				<#list conditionInfoList as conditionIn> 
					<#if conditionIn.sort == 2>
						.addOrder("${tableAlias}.${conditionIn.code}", Order.ASC)<#sep>;</#sep>
					</#if>
					<#if conditionIn.sort == 1>
						.addOrder("${tableAlias}.${conditionIn.code}", Order.DESC)<#sep>;</#sep>
					</#if>
				</#list>
		PageOut pageOut = getListpage(sqlUtil, pageIn);
				<#list conditionInfoList as condition>
					<#if condition.type == 6>
				HibernateUtil.formatDate(pageOut.getRows(), "${condition.code}", DateUtil.FORMAT_DATE_TIME);
					</#if>
					<#if condition.type == 7>
				HibernateUtil.formatDict(pageOut.getRows(), DictCache.getIndexkeyValueMap(), "${tableAlias}_${condition.code}", "${condition.code}");
					</#if>
				</#list>
		return pageOut;
	}
}