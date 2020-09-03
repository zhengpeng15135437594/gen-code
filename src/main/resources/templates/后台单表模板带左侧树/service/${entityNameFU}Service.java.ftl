package ${packageName}.${projectName}.service;

import java.util.List;
import java.util.Map;
import ${packageName}.core.service.BaseService;
import ${packageName}.${projectName}.entity.${entityNameFU};

/**
 * ${tableName}服务层接口
 * 
 * v1.0 ${author} ${updateTime}
 */
public interface ${entityNameFU}Service extends BaseService<${entityNameFU}> {

	/**
	 * 添加${tableName}
	 * 
	 * v1.0 ${author} ${updateTime}
	 * 
	 * @param org
	 * void
	 */
	void addAndUpdate(${entityNameFU} ${entityName});

	/**
	 * 删除${tableName}
	 * 
	 * v1.0 ${author} ${updateTime}
	 * 
	 * @param id
	 * void
	 */
	void delAndUpdate(Integer id);

	/**
	 * 获取${tableName}树 
	 * 
	 * v1.0 ${author} ${updateTime}
	 * 
	 * @return List<Map<String,Object>>
	 */
	List<Map<String, Object>> getTreeList();

	/**
	 * 移动${tableName}
	 * 
	 * v1.0 ${author} ${updateTime}
	 * 
	 * @param sourceId
	 * @param targetId
	 * void
	 */
	void doMove(Integer sourceId, Integer targetId);
	
	/**
	 * 名称是否重复
	 * 
	 * v1.0 ${author} ${updateTime}
	 * @param ${entityName}
	 * @return boolean
	 */
	boolean existName(${entityNameFU} ${entityName});
}
