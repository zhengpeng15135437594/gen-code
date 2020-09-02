package ${packageName}.${projectName}.service.impl;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Map;

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
	public List<Map<String, Object>> getTreeList() {
		return ${entityName}Dao.getTreeList();
	}

	@Override
	public void doMove(Integer sourceId, Integer targetId) {
		// 校验数据有效性
		if (sourceId == null) {
			throw new RuntimeException("无法获取参数：sourceId");
		}
		if (targetId == null) {
			throw new RuntimeException("无法获取参数：targetId");
		}
		if (sourceId == targetId) {
			throw new RuntimeException("源${tableName}和目标${tableName}一致！");
		}

		${entityNameFU} source = getEntity(sourceId);
		${entityNameFU} target = getEntity(targetId);
		if (target.getParentSub().contains(source.getParentSub())) {
			throw new RuntimeException("父${tableName}不能移动到子${tableName}下！");
		}

		// 移动${tableName}
		${entityName}Dao.doMove(sourceId, targetId);
	}
}
