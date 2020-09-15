package ${packageName}.${projectName}.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ${packageName}.core.dao.BaseDao;
import ${packageName}.core.service.impl.BaseServiceImp;
import ${packageName}.${projectName}.dao.${entityNameFU}Dao;
import ${packageName}.${projectName}.entity.${entityNameFU};
import ${packageName}.${projectName}.service.${entityNameFU}Service;

/**
 * ${tableName}服务层实现
 * 
 * v1.0 ${author} ${updateTime}
 */
@Service
public class ${entityNameFU}ServiceImpl extends BaseServiceImp<${entityNameFU}> implements ${entityNameFU}Service {
	@Resource
	private ${entityNameFU}Dao ${entityName}Dao;

	@Override
	@Resource(name = "${entityName}DaoImpl")
	public void setDao(BaseDao<${entityNameFU}> dao) {
		super.dao = dao;
	}
	
	@Override
	public void delAndUpdate(Integer id) {
		// 校验数据有效性
		${entityNameFU} entity = getEntity(id);
		entity.setState(0);
		update(entity);
	}
}
