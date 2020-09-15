package ${packageName}.${projectName}.controller;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Date;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import ${packageName}.core.controller.BaseController;
import ${packageName}.core.entity.PageIn;
import ${packageName}.core.entity.PageResult;
import ${packageName}.core.entity.PageResultEx;
import ${packageName}.core.entity.PageIn;
import ${packageName}.core.entity.PageOut;
import ${packageName}.core.entity.PageResult;
import ${packageName}.${projectName}.entity.${entityNameFU};
import ${packageName}.${projectName}.service.${entityNameFU}Service;
import ${packageName}.sys.cache.DictCache;
import ${packageName}.core.exception.MyException;

/**
 * ${tableName}控制层
 * 
 * v1.0 ${author} ${updateTime}
 */
@Controller
@RequestMapping("/${entityName}")
public class ${entityNameFU}Controller extends BaseController {
	private static final Logger log = LoggerFactory.getLogger(${entityNameFU}Controller.class);
	
	@Resource
	private ${entityNameFU}Service ${entityName}Service;
	
	<#assign tableAlias=tableCode?substring(tableCode?index_of('_') + 1)  >
	/**
	 * 到达${tableName}列表页面
	 * 
	 * v1.0 ${author} ${updateTime}
	 * @return String
	 */
	@RequestMapping("/toList")
	public String toList() {
		try {
			return "${projectName}/${entityName}/${entityName}List";
		} catch (Exception e) {
			log.error("到达${tableName}列表页面错误：", e);
			return "${projectName}/${entityName}/${entityName}List";
		}
	}
	
	/**
	 * ${tableName}树
	 * 
	 * v1.0 ${author} ${updateTime}
	 * 
	 * @return PageResult
	 */
	@RequestMapping("/treeList")
	@ResponseBody
	public PageResult treeList() {
		try {
			return new PageResultEx(true, "查询成功", ${entityName}Service.getTreeList());
		} catch (Exception e) {
			log.error("${tableName}树错误：", e);
			return new PageResult(false, "查询失败");
		}
	}
	
	/**
	 * ${tableName}列表
	 * 
	 * v1.0 ${author} ${updateTime}
	 * @return PageResult
	 */
	@RequestMapping("/list")
	@ResponseBody
	public PageResult list(PageIn pageIn) {
		try {
			return new PageResultEx(true, "查询成功", ${entityName}Service.getListpage(pageIn));
		} catch (Exception e) {
			log.error("${tableName}列表错误：", e);
			return new PageResult(false, "查询失败");
		}
	}
	
	/**
	 * 到达添加${tableName}页面
	 * 
	 * v1.0 ${author} ${updateTime}
	 * @return String
	 */
	@RequestMapping("/toAdd")
	public String toAdd(Model model) {
		try {
			<#list conditionInfoList as condition>
				<#if condition.type == 7>
			model.addAttribute("${condition.entityCode}List", DictCache.getIndexDictlistMap().get("${tableAlias}_${condition.code}"));
				</#if>
			</#list>
			return "${projectName}/${entityName}/${entityName}Edit";
		} catch (Exception e) {
			log.error("到达添加${tableName}页面错误：", e);
			return "${projectName}/${entityName}/${entityName}Edit";
		}
	}
	
	/**
	 * 完成添加${tableName}
	 * 
	 * v1.0 ${author} ${updateTime}
	 * @return PageResult
	 */
	@RequestMapping("/doAdd")
	@ResponseBody
	public PageResult doAdd(${entityNameFU} ${entityName}) {
		try {
			${entityName}Service.addAndUpdate(${entityName});
			return new PageResult(true, "添加成功");
		} catch (MyException e) {
			log.error("完成添加${tableName}错误：{}", e.getMessage());
			return new PageResult(false, e.getMessage());
		} catch (Exception e) {
			log.error("完成添加${tableName}错误：", e);
			return new PageResult(false, "未知异常");
		}
	}
	
	/**
	 * 到达修改${tableName}页面
	 * 
	 * v1.0 ${author} ${updateTime}
	 * @return String
	 */
	@RequestMapping("/toEdit")
	public String toEdit(Model model, Integer id) {
		try {
			${entityNameFU} ${entityName} = ${entityName}Service.getEntity(id);
			model.addAttribute("${entityName}", ${entityName});
			if(${entityName}.getParentId() != null){
				model.addAttribute("parent${entityNameFU}", ${entityName}Service.getEntity(${entityName}.getParentId()));
			}
			<#list conditionInfoList as condition>
				<#if condition.type == 7>
			model.addAttribute("${condition.entityCode}List", DictCache.getIndexDictlistMap().get("${tableAlias}_${condition.code}"));
				</#if>
			</#list>
			return "${projectName}/${entityName}/${entityName}Edit";
		} catch (Exception e) {
			log.error("到达修改${tableName}页面错误：", e);
			return "${projectName}/${entityName}/${entityName}Edit";
		}
	}
	
	/**
	 * 完成修改${tableName}
	 * 
	 * v1.0 ${author} ${updateTime}
	 * @return pageOut
	 */
	@RequestMapping("/doEdit")
	@ResponseBody
	public PageResult doEdit(${entityNameFU} ${entityName}) {
		try {
			${entityName}Service.update(entity);
			return new PageResult(true, "修改成功");
		} catch (MyException e) {
			log.error("完成修改${tableName}错误：{}", e.getMessage());
			return new PageResult(false, e.getMessage());
		} catch (Exception e) {
			log.error("完成修改${tableName}错误：", e);
			return new PageResult(false, "未知异常");
		}
	}
	
	/**
	 * 完成删除${tableName}
	 * 
	 * v1.0 ${author} ${updateTime}
	 * @return pageOut
	 */
	@RequestMapping("/doDel")
	@ResponseBody
	public PageResult doDel(Integer id) {
		try {
			${entityName}Service.delAndUpdate(id);
			return new PageResult(true, "删除成功");
		} catch (MyException e) {
			log.error("完成删除${tableName}错误：{}", e.getMessage());
			return new PageResult(false, e.getMessage());
		} catch (Exception e) {
			log.error("完成删除${tableName}错误：", e);
			return new PageResult(false, "未知异常");
		}
	}
	
	/**
	 * 到达移动${tableName}页面
	 * 
	 * v1.0 ${author} ${updateTime}
	 * 
	 * @return String
	 */
	@RequestMapping("/toMove")
	public String toMove() {
		try {
			return "${projectName}/${entityName}/${entityName}Move";
		} catch (Exception e) {
			log.error("到达移动${tableName}页面错误", e);
			return "${projectName}/${entityName}/${entityName}Move";
		}
	}

	/**
	 * 完成移动${tableName}
	 * 
	 * v1.0 ${author} ${updateTime}
	 * 
	 * @param sourceId
	 * @param targetId
	 * @return PageResult
	 */
	@RequestMapping("/doMove")
	@ResponseBody
	public PageResult doMove(Integer sourceId, Integer targetId) {
		try {
			${entityName}Service.doMove(sourceId, targetId);
			return new PageResult(true, "移动成功");
		} catch (MyException e) {
			log.error("完成移动${tableName}错误：{}", e.getMessage());
			return new PageResult(false, e.getMessage());
		} catch (Exception e) {
			log.error("完成移动${tableName}错误：", e);
			return new PageResult(false, "未知异常");
		}
	}

}
