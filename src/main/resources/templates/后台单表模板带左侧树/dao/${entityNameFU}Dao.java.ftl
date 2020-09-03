package ${packageName}.${projectName}.dao;

import java.util.List;
import java.util.Map;
import ${packageName}.core.dao.RBaseDao;
import ${packageName}.${projectName}.entity.${entityNameFU};

/**
 * ${tableName}数据访问层接口
 * 
 * v1.0 ${author} ${updateTime}
 */
public interface ${entityNameFU}Dao extends RBaseDao<${entityNameFU}> {
	
	/**
	 * 获取${tableName}树 
	 * 
	 * v1.0 ${author} ${updateTime}
	 * 
	 * @return List<Map<String,Object>>
	 */
	List<Map<String, Object>> getTreeList();
	
	/**
	 * 获取${tableName}列表
	 * 
	 * v1.0 ${author} ${updateTime}
	 * 
	 * @return List<${entityNameFU}>
	 */
	List<${entityNameFU}> getList();
	
	/**
	 * 获取${tableName}列表
	 * 
	 * v1.0 ${author} ${updateTime}
	 * 
	 * @param parentId
	 * @return List<${entityNameFU}>
	 */
	List<${entityNameFU}> getList(Integer parentId);
	
	/**
	 * 名称是否存在
	 * 
	 * v1.0 ${author} ${updateTime}
	 * 
	 * @param name
	 * @param excludeId
	 * @return boolean
	 */
	boolean existName(String name, Integer excludeId);
}
