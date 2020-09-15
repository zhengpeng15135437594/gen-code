package ${packageName}.${projectName}.service.impl;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Map;
import java.util.Date;

import ${packageName}.core.exception.MyException;
import ${packageName}.core.util.ValidateUtil;
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
	public void addAndUpdate(${entityNameFU} ${entityName}) {
		// 校验数据有效性
		if (!ValidateUtil.isValid(${entityName}.getName())) {
			throw new MyException("参数错误：name");
		}
		if (${entityName}.getParentId() == null || ${entityName}.getParentId() == 0) {
			throw new MyException("参数错误：parentId");
		}
		
		if (existName(${entityName})) {
			throw new MyException("名称已存在！");
		}
		
		// 添加${tableName}
		${entityName}.setUpdateUserId(getCurUser().getId());
		${entityName}.setUpdateTime(new Date());
		${entityName}.setState(1);
		add(${entityName});
		
		// 更新父子关系
		${entityNameFU} parent${entityNameFU} = ${entityName}Dao.getEntity(${entityName}.getParentId());
		${entityName}.setParentSub(parent${entityNameFU}.getParentSub() + ${entityName}.getId() + "_");
		${entityName}.setLevel(${entityName}.getParentSub().split("_").length - 1);
		update(${entityName});
	}

	@Override
	public void delAndUpdate(Integer id) {
		// 校验数据有效性
		if (id == 1) { //不包括根${tableName}
			return;
		}
		${entityNameFU} ${entityName} = ${entityName}Dao.getEntity(id);
		List<${entityNameFU}> ${entityName}List = ${entityName}Dao.getList(${entityName}.getParentId());
		if (ValidateUtil.isValid(${entityName}List)) {
			throw new MyException("请先删除子${tableName}！");
		}
		
		// 删除${tableName}
		${entityName}.setState(0);
		${entityName}.setUpdateTime(new Date());
		${entityName}.setUpdateUserId(getCurUser().getId());
		update(${entityName});
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
		source.setParentId(target.getId());
		source.setParentSub(String.format("%s%s_", target.getParentSub(), source.getId()));
		source.setLevel(source.getParentSub().split("_").length - 1);
		update(source);
		
		List<${entityNameFU}> subSourceList = ${entityName}Dao.getList(source.getId());
		doMove(source, subSourceList);
	}
		
	private void doMove(${entityNameFU} target, List<${entityNameFU}> subTargetList) {
		for (${entityNameFU} subTarget : subTargetList) {
			subTarget.setParentId(target.getId());
			subTarget.setParentSub(String.format("%s%s_", target.getParentSub(), subTarget.getId()));
			subTarget.setLevel(subTarget.getParentSub().split("_").length - 1);
			update(subTarget);
			
			List<${entityNameFU}> subSubTargetList = ${entityName}Dao.getList(subTarget.getId());
			if (ValidateUtil.isValid(subSubTargetList)) {
				doMove(subTarget, subSubTargetList);
			}
		}
	}
	
	@Override
	public boolean existName(${entityNameFU} ${entityName}) {
		return ${entityName}Dao.existName(${entityName}.getName(), ${entityName}.getId());
	}
}
