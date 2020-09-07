package ${packageName}.${projectName}.dao.impl;

import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Map;

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
			   .addOrder("${tableAlias}.${conditionIn.code}", Order.ASC)
					</#if>
					<#if conditionIn.sort == 1>
			   .addOrder("${tableAlias}.${conditionIn.code}", Order.DESC)
					</#if>
				</#list>
				;
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
	
	@Override
	public List<Map<String, Object>> getTreeList() {
		String sql = "SELECT ID, NAME, PARENT_ID, PARENT_SUB FROM ${tableCode} WHERE STATE = 1 ORDER BY NO ASC";
		return getMapList(sql);
	}
	
	@Override
	public List<${entityNameFU}> getList() {
		String sql = "SELECT * FROM ${tableCode} WHERE STATE = 1 ";
		return getList(sql);
	}
	
	@Override
	public List<${entityNameFU}> getList(Integer parentId) {
		String sql = "SELECT * FROM ${tableCode} WHERE PARENT_ID = ? AND STATE = 1 ";
		return getList(sql, new Object[] { parentId });
	}
	
	@Override
	public boolean existName(String name, Integer excludeId) {
		if (excludeId == null) {
			String sql = "SELECT COUNT(*) AS NUM FROM ${tableCode} WHERE NAME = ? AND STATE = 1";
			return getCount(sql, new Object[] { name }) > 0;
		}

		String sql = "SELECT COUNT(*) AS NUM FROM ${tableCode} WHERE NAME = ? AND STATE = 1 AND ID != ?";
		return getCount(sql, new Object[] { name, excludeId }) > 0;
	}
}