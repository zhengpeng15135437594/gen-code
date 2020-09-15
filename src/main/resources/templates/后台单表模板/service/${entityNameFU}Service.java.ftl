package ${packageName}.${projectName}.service;

import ${packageName}.core.service.BaseService;
import ${packageName}.${projectName}.entity.${entityNameFU};

/**
 * ${tableName}服务层接口
 * 
 * v1.0 ${author} ${updateTime}
 */
public interface ${entityNameFU}Service extends BaseService<${entityNameFU}> {

	/**
	 * 修改${tableName}
	 * 
	 * v1.0 ${author} ${updateTime}
	 * 
	 * @param ${entityName}
	 * void
	 */
	void editAndUpdate(${entityNameFU} ${entityName});
}
