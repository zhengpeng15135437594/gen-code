package ${packageName}.${projectName}.controller;

import javax.annotation.Resource;

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
	public String toAdd() {
		try {
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
			${entityName}Service.add(${entityName});
			return new PageResult(true, "添加成功");
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
			${entityName}Service.update(${entityName});
			return new PageResult(true, "修改成功");
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
	public PageResult doDel(Integer[] ids) {
		try {
			${entityName}Service.del(ids);
			return new PageResult(true, "删除成功");
		} catch (Exception e) {
			log.error("完成删除${tableName}错误：", e);
			return new PageResult(false, "删除失败：" + e.getMessage());
		}
	}

}
