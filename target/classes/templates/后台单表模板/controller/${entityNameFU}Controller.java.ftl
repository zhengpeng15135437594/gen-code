package ${packageName}.${projectName}.controller;

import javax.annotation.Resource;

import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import ${packageName}.core.controller.BaseController;
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
			return "/sys/${entityName}/${entityName}List";
		} catch (Exception e) {
			log.error("到达${tableName}列表页面错误：", e);
			return "/sys/${entityName}/${entityName}List";
		}
	}
	
	/**
	 * ${tableName}列表
	 * 
	 * v1.0 ${author} ${updateTime}
	 * @return pageOut
	 */
	@RequestMapping("/list")
	@ResponseBody
	public PageOut list(PageIn pageIn) {
		try {
			return ${entityName}Service.getListpage(pageIn);
		} catch (Exception e) {
			log.error("${tableName}列表错误：", e);
			return new PageOut();
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
			return "/sys/${entityName}/${entityName}Edit";
		} catch (Exception e) {
			log.error("到达添加${tableName}页面错误：", e);
			return "/sys/${entityName}/${entityName}Edit";
		}
	}
	
	/**
	 * 完成添加${tableName}
	 * 
	 * v1.0 ${author} ${updateTime}
	 * @return pageOut
	 */
	@RequestMapping("/doAdd")
	@ResponseBody
	public PageResult doAdd(${entityNameFU} ${entityName}) {
		try {
			<#list conditionInfoList as condition>
				<#if condition.entityCode == "updateTime">
			${entityName}.setUpdateTime(new Date());
				</#if>
				<#if condition.entityCode == "updateUserId">
			${entityName}.setUpdateUserId(getCurUser().getId());
				</#if>
				<#if condition.entityCode == "saasId">
			${entityName}.setSaasId(getCurUser().getSaasId());
				</#if>
			</#list>
			${entityName}Service.add(${entityName});
			return new PageResult(true, "添加成功");
		} catch (MyException e) {
			log.error("完成添加${tableName}错误：{}", e.getMessage());
			return new PageResult(false, "添加失败：" + e.getMessage());
		} catch (Exception e) {
			log.error("完成添加${tableName}错误：", e);
			return new PageResult(false, "添加失败：" + e.getMessage());
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
			<#list conditionInfoList as condition>
				<#if condition.type == 7>
			model.addAttribute("${condition.entityCode}List", DictCache.getIndexDictlistMap().get("${tableAlias}_${condition.code}"));
				</#if>
			</#list>
			return "/sys/${entityName}/${entityName}Edit";
		} catch (Exception e) {
			log.error("到达修改${tableName}页面错误：", e);
			return "/sys/${entityName}/${entityName}Edit";
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
			${entityNameFU} entity = ${entityName}Service.getEntity(${entityName}.id);
			<#list conditionInfoList as condition>
				<#if condition.required == 1>
					<#if condition.entityCode != "saasId" && condition.entityCode != "updateUserId" && condition.entityCode != "updateTime">
			entity.set${condition.codeToHump}(${entityName}.get${condition.codeToHump});
					</#if>
				</#if>
				<#if condition.entityCode == "updateTime">
			entity.setUpdateTime(new Date());
				</#if>
				<#if condition.entityCode == "updateUserId">
			entity.setUpdateUserId(getCurUser().getId());
				</#if>
				<#if condition.entityCode == "saasId">
			entity.setSaasId(getCurUser().getSaasId());
				</#if>
			</#list>
			${entityName}Service.update(entity);
			return new PageResult(true, "修改成功");
		} catch (MyException e) {
			log.error("完成修改${tableName}错误：{}", e.getMessage());
			return new PageResult(false, "修改失败：" + e.getMessage());
		} catch (Exception e) {
			log.error("完成修改${tableName}错误：", e);
			return new PageResult(false, "修改失败：" + e.getMessage());
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
			${entityName}Service.del(id);
			return new PageResult(true, "删除成功");
		} catch (MyException e) {
			log.error("完成删除${tableName}错误：{}", e.getMessage());
			return new PageResult(false, "删除失败：" + e.getMessage());
		} catch (Exception e) {
			log.error("完成删除${tableName}错误：", e);
			return new PageResult(false, "删除失败：" + e.getMessage());
		}
	}

}
