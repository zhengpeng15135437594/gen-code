package com.jingmax.web.controller;

import java.io.File;
import java.io.FileWriter;
import java.io.OutputStream;
import java.io.StringWriter;
import java.io.Writer;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jingmax.entity.ConditionInfo;
import com.jingmax.entity.DBColInfo;
import com.jingmax.entity.DBTableInfo;
import com.jingmax.entity.FtlDetail;
import com.jingmax.entity.FtlInfo;
import com.jingmax.entity.PageResult;
import com.jingmax.entity.PageResultEx;
import com.jingmax.util.DBUtil;
import com.jingmax.util.DateUtil;
import com.jingmax.util.JsonUtil;
import com.jingmax.util.StringUtil;
import com.jingmax.util.TemplateUtil;
import com.jingmax.util.ValidateUtil;
import com.jingmax.util.ZipUtil;

import freemarker.template.Template;

/**
 * 首页控制层
 * 
 * v1.0 zhanghc 2019年4月20日下午4:08:45
 */
@Controller
@RequestMapping("/home")
public class HomeController {
	private static final Logger log = LoggerFactory.getLogger(HomeController.class);

	private static final String sysLoginName = "admin";
	private static final String sysPassword = "admin";
	
	/**
	  * 登录页面
	  * 
	  * v1.0 zhengpeng 2020年8月28日下午4:08:45
	  * @return String
	  */
	 @RequestMapping("/login")
	 public String login() {
	  try {
	   return "/login";
	  } catch (Exception e) {
	   log.error("登录页错误：", e);
	   return "/login";
	  }
	 }
	 
	 /**
	  * 登录
	  * 
	  * v1.0 zhengpeng 2020年8月28日下午4:08:45
	  * @return String
	  */
	 @RequestMapping("/doLogin")
	 public String doLogin(String loginName, String password) {
	  try {
	   if(sysLoginName.equals(loginName) && sysPassword.equals(password)){
	    return "/index";
	   }else{
	    return "/login";
	   }
	  } catch (Exception e) {
	   log.error("登录页错误：", e);
	   return "/login";
	  }
	 }
	
	/**
	 * 默认首页
	 * 
	 * v1.0 zhanghc 2019年4月20日下午4:08:45
	 * @return String
	 */
	@RequestMapping("/index")
	public String home() {
		try {
			return "/index";
		} catch (Exception e) {
			log.error("默认首页错误：", e);
			return "/index";
		}
	}
	
	/**
	 * 到达列表页面
	 * 
	 * v1.0 zhanghc 2019年4月20日下午4:08:45
	 * @return String
	 */
	@RequestMapping("/toList")
	public String toList(Model model) {
		try {
			String baseDir = TemplateUtil.getBaseDir();
			File file = new File(baseDir);
			File[] files = file.listFiles();
			List<Object> list = new ArrayList<Object>();
			if (files != null && files.length > 0) {
				for (int i = 1; files.length >= i; i++) {
					Map<String , Object> map = new HashMap<String , Object>();
					map.put("id", i);
					map.put("path", files[i-1].getPath());
					map.put("text", files[i-1].getName());
					list.add(map);
				}
			}
			model.addAttribute("files", list);
			return "/list";
		} catch (Exception e) {
			log.error("默认首页错误：", e);
			return "/list";
		}
	}
	
	/**
	 * 模板列表
	 * 
	 * v1.0 zhanghc 2019年6月27日上午8:35:50
	 * @return String
	 */
	@RequestMapping("/templateList")
	@ResponseBody
	public List<Map<String, Object>> templateList() {
		try {
			String dir = HomeController.class.getResource("/").toURI().getPath() + "/templates/";
			File file = new File(dir);
			List<Map<String, Object>> list = new ArrayList<>();
			for(File file2 : file.listFiles()){
				if(file2.isDirectory()){
					Map<String, Object> map = new HashMap<>();
					map.put("id", file2.getName());
					map.put("text", file2.getName());
					list.add(map);
				}
			}
			return list;
		} catch (Exception e) {
			log.error("模板错误：", e);
			return new ArrayList<>();
		}
	}
	
	/**
	 * 数据库列表
	 * 
	 * v1.0 zhanghc 2019年6月27日上午8:35:50
	 * @return String
	 */
	@RequestMapping("/dbList")
	@ResponseBody
	public PageResult dbList(String dbAddr, String dbUserName, String dbPwd) {
		try {
			if(!ValidateUtil.isValid(dbAddr)){
				throw new RuntimeException("参数无效：addr");
			}
			if(!ValidateUtil.isValid(dbUserName)){
				throw new RuntimeException("参数无效：dbUserName");
			}
			if(!ValidateUtil.isValid(dbPwd)){
				throw new RuntimeException("参数无效：dbPwd");
			}
			dbAddr = dbAddr.contains(":") ? dbAddr : dbAddr + ":3306"; 
			
			String driverName = "com.mysql.cj.jdbc.Driver";
			String jdbcUrl = "jdbc:mysql://"+dbAddr+"?useUnicode=true&characterEncoding=utf-8&serverTimezone=GMT%2B8&useInformationSchema=true";
			Connection connection = DBUtil.getConnection(driverName, jdbcUrl, dbUserName, dbPwd);
			DatabaseMetaData metaData = connection.getMetaData();
			ResultSet resultSet = metaData.getCatalogs();
			List<Map<String, Object>> list = new ArrayList<>();
			while (resultSet.next()) {
				Map<String, Object> map = new HashMap<>();
				map.put("id", resultSet.getString("TABLE_CAT"));
				map.put("text", resultSet.getString("TABLE_CAT"));
				list.add(map);
			}
			DBUtil.close(connection);
			return new PageResultEx(true, "查询成功", list);
		} catch (Exception e) {
			log.error("列表错误：", e);
			return new PageResult(false, e.getMessage());
		}
	}
	
	/**
	 * 列表
	 * 
	 * v1.0 zhanghc 2019年6月27日上午8:35:50
	 * @return String
	 */
	@RequestMapping("/dbTableList")
	@ResponseBody
	public PageResult dbTableList(String dbAddr, String dbUserName, String dbPwd, String dbInstanceName) {
		try {
			if(!ValidateUtil.isValid(dbAddr)){
				throw new RuntimeException("参数无效：ip");
			}
			if(!ValidateUtil.isValid(dbUserName)){
				throw new RuntimeException("参数无效：userName");
			}
			if(!ValidateUtil.isValid(dbPwd)){
				throw new RuntimeException("参数无效：password");
			}
			if(!ValidateUtil.isValid(dbInstanceName)){
				throw new RuntimeException("参数无效：instanceName");
			}
			dbAddr = dbAddr.contains(":") ? dbAddr : dbAddr + ":3306"; 
			
			String driverName = "com.mysql.cj.jdbc.Driver";
			String jdbcUrl = "jdbc:mysql://"+dbAddr+"?useUnicode=true&characterEncoding=utf-8&serverTimezone=GMT%2B8&useInformationSchema=true";
			Connection connection = DBUtil.getConnection(driverName, jdbcUrl, dbUserName, dbPwd);
			DatabaseMetaData metaData = connection.getMetaData();
			ResultSet resultSet = metaData.getTables(dbInstanceName, null, null, new String[] { "TABLE" });
			
			List<Map<String, Object>> list = new ArrayList<>();
			while (resultSet.next()) {
				Map<String, Object> map = new HashMap<>();
				map.put("id", resultSet.getString("TABLE_NAME"));
				map.put("text", resultSet.getString("TABLE_NAME"));
				list.add(map);
			}
			DBUtil.close(connection);
			return new PageResultEx(true, "查询成功", list);
		} catch (Exception e) {
			log.error("列表错误：", e);
			return new PageResult(false, e.getMessage());
		}
	}
	
	/**
	 * 实体类名称
	 * 
	 * v1.0 zhanghc 2019年6月27日上午8:35:50
	 * @return String
	 */
	@RequestMapping("/dbTableEntity")
	@ResponseBody
	public PageResult dbTableEntity(String dbTableEntity) {
		try {
			if(!ValidateUtil.isValid(dbTableEntity)){
				throw new RuntimeException("参数无效：dbTableEntity");
			}
			String humpStr = StringUtil.toHumpStr(dbTableEntity.substring(dbTableEntity.indexOf("_") + 1), "_", false);
			//String humpStr2 = StringUtil.toHumpStr(dbTableEntity.substring(dbTableEntity.indexOf("_") + 1), "_", true);
			return new PageResultEx(true, "查询成功", humpStr);
		} catch (Exception e) {
			log.error("列表错误：", e);
			return new PageResult(false, e.getMessage());
		}
	}
	
	/**
	 * 生成表单
	 * 
	 * v1.0 zhanghc 2019年6月27日上午8:35:50
	 * @return String
	 */
	@RequestMapping("/createFrom")
	@ResponseBody
	public PageResult createFrom(String dbAddr, String dbUserName, String dbPwd, String dbName, String dbTableName) {
		try {
			if(!ValidateUtil.isValid(dbTableName)){
				throw new RuntimeException("参数无效：dbTableName");
			}
			
			String driverName = "com.mysql.cj.jdbc.Driver";
			String jdbcUrl = "jdbc:mysql://"+dbAddr+"?useUnicode=true&characterEncoding=utf-8&serverTimezone=GMT%2B8&useInformationSchema=true";
			Connection connection = DBUtil.getConnection(driverName, jdbcUrl, dbUserName, dbPwd);			
			DBTableInfo tableInfo = DBUtil.parseMetaData(connection, dbName, dbTableName);
			
	    	Iterator<DBColInfo> iterator = tableInfo.getColInfoList().iterator();
	    	while (iterator.hasNext()) {
	    		DBColInfo dBColInfo = iterator.next();
				if(dBColInfo.getCode().equals("ID")){
					iterator.remove();
					continue;
				}
				/*String humpStr = StringUtil.toHumpStr(dBColInfo.getCode(), "_", true);
				dBColInfo.setCode(humpStr);*/
			}
			return new PageResultEx(true, "查询成功", tableInfo.getColInfoList());
		} catch (Exception e) {
			log.error("列表错误：", e);
			return new PageResult(false, e.getMessage());
		}
	}
	
	/**
	 * 下载文件
	 * 
	 * v1.0 zhanghc 2019年6月27日上午8:35:50
	 * @return String
	 */
	@RequestMapping("/downLoad")
	public void downLoad(String path, HttpServletResponse response) {
		
		File file = new File("d:/6d2798e2d86f426b834703be1bc2e859/yasuo/" + path);
		System.out.println("d:/6d2798e2d86f426b834703be1bc2e859/yasuo/" + path);
		if(!file.getParentFile().exists()){
			file.getParentFile().mkdirs();
		}
		OutputStream output = null;
		try {
			path = new String(path.getBytes("UTF-8"), "ISO-8859-1");
			response.addHeader("Content-Disposition", "attachment;filename=" + path);
			response.setContentType("application/force-download");
			output = response.getOutputStream();
			FileUtils.copyFile(file, output);
			} catch (Exception e) {
				log.error("完成下载附件失败：", e);
			} finally {
				IOUtils.closeQuietly(output);
			}
	}
	
	/**
	 * 生产文件
	 * 
	 * @param projectName
	 * @return
	 */
	@RequestMapping("/createFile")
	@ResponseBody
	public Map<String,String> createFile(String dbAddr, String dbUserName, String dbPwd, String instanceName, 
			String tableName, String realmName, String projectName, String author, String entityName, String searchJson, String templateName, HttpServletResponse response) { // realmName  企业域名    author  作者   projectName 子模块
		Connection connection = null;
		Map<String,String> map = new HashMap<>();
		try {
			if(!ValidateUtil.isValid(dbAddr)){
				throw new RuntimeException("参数无效：dbAddr");
			}
			if(!ValidateUtil.isValid(dbUserName)){
				throw new RuntimeException("参数无效：dbUserName");
			}
			if(!ValidateUtil.isValid(dbPwd)){
				throw new RuntimeException("参数无效：dbPwd");
			}
			if(!ValidateUtil.isValid(instanceName)){
				throw new RuntimeException("参数无效：instanceName");
			}
			dbAddr = dbAddr.contains(":") ? dbAddr : dbAddr + ":3306"; 
			List<ConditionInfo> list = JsonUtil.stringToJson(searchJson);//将json转换为list
			List<ConditionInfo> conditionInfoList = setPageIn(list);
			
			String driverName = "com.mysql.cj.jdbc.Driver";
			String jdbcUrl = "jdbc:mysql://"+dbAddr+"?useUnicode=true&characterEncoding=utf-8&serverTimezone=GMT%2B8&useInformationSchema=true";
			connection = DBUtil.getConnection(driverName, jdbcUrl, dbUserName, dbPwd);
			DBTableInfo tableInfo = DBUtil.parseMetaData(connection, instanceName, tableName);
			
			String packageName = parseRealmName(realmName);
			FtlInfo ftlInfo = parseDBTableInfo(tableInfo, packageName, projectName, entityName, author, conditionInfoList);
			
			TemplateUtil.setDir(templateName);
			File templatePath = new File(TemplateUtil.getBaseDir() + templateName);
			
			Collection<File> listFiles = FileUtils.listFiles(templatePath, null, true);
			File delFile = new File("d:/6d2798e2d86f426b834703be1bc2e859/");
			FileUtils.deleteDirectory(delFile);
			
			for (File file : listFiles) {
				String templatePathStr = file.getAbsolutePath();
				templatePathStr = templatePathStr.endsWith(".ftl") ? templatePathStr.substring(0, templatePathStr.length() - 4) : templatePathStr; 
				Template stringTemplate = TemplateUtil.getStringTemplate(templatePathStr);
				StringWriter stringWriter = new StringWriter();
				stringTemplate.process(ftlInfo, stringWriter);
				
				Template template = TemplateUtil.getTemplate(file.getName());
				String subPath = stringWriter.toString().substring(templatePath.getAbsolutePath().length());
				File outFile = new File("d:/6d2798e2d86f426b834703be1bc2e859/shengcheng/" + packageName.replaceAll("\\.", "/") + "/" + projectName + "/" + subPath);
				if(!outFile.getParentFile().exists()){
					outFile.getParentFile().mkdirs();
				}
				
				Writer out = new FileWriter(outFile);
				template.process(ftlInfo, out);
				IOUtils.closeQuietly(out);
			}
			String fileName = UUID.randomUUID().toString().replaceAll("-", "") + ".zip";
			map.put("path", fileName);
			File file = new File("d:/6d2798e2d86f426b834703be1bc2e859/yasuo/" + fileName);
			if(!file.getParentFile().exists()){
				file.getParentFile().mkdirs();
			}
			ZipUtil.doZip("d:/6d2798e2d86f426b834703be1bc2e859/shengcheng", file);
			
		} catch (Exception e) {
			DBUtil.close(connection);
			log.error("初始化错误：", e);
		}
		return map;
	}

	private String parseRealmName(String realmName) {
		realmName = realmName.startsWith("www.") ? realmName.substring(4) : realmName;
		String[] split = realmName.split("\\.");
		ArrayUtils.reverse(split);
		return StringUtils.join(split, ".");
	}
	
	private static FtlInfo parseDBTableInfo(DBTableInfo tableInfo, String packageName, String projectName, String entityName, String author, List<ConditionInfo> conditionInfoList) {
		FtlInfo ftlInfo = new FtlInfo();
		ftlInfo.setTableCode(tableInfo.getCode());
		ftlInfo.setTableName(tableInfo.getName());
		ftlInfo.setPackageName(packageName);
		ftlInfo.setProjectName(projectName);
		if(ValidateUtil.isValid(entityName)){
			ftlInfo.setEntityNameFU(StringUtil.capitalize(entityName));
			ftlInfo.setEntityName(StringUtil.uncapitalize(entityName));
		}else{
			ftlInfo.setEntityNameFU(StringUtil.toHumpStr(tableInfo.getCode().substring(tableInfo.getCode().indexOf("_") + 1), "_", false));
			ftlInfo.setEntityName(StringUtil.toHumpStr(tableInfo.getCode().substring(tableInfo.getCode().indexOf("_") + 1), "_", true));
		}
		ftlInfo.setAuthor(author);
		ftlInfo.setUpdateTime(DateUtil.getFormatDateTime());
		ftlInfo.setFilePath(packageName.replaceAll("\\.", "/") + "/");
		
		List<FtlDetail> ftlDetailList = new ArrayList<>();
		for(DBColInfo dBColInfo : tableInfo.getColInfoList()){
			FtlDetail ftlDetail = new FtlDetail();
			ftlDetail.setColCode(dBColInfo.getCode());
			ftlDetail.setColName(dBColInfo.getName());
			ftlDetail.setColType(dBColInfo.getType());
			ftlDetail.setColLen(dBColInfo.getLen());
			ftlDetail.setFieldName(StringUtil.toHumpStr(dBColInfo.getCode(), "_", true));
			ftlDetail.setFieldNameFU(StringUtil.toHumpStr(dBColInfo.getCode(), "_", false));
			ftlDetailList.add(ftlDetail);
		}
		ftlInfo.setConditionInfoList(conditionInfoList);
		ftlInfo.setFtlDetailList(ftlDetailList);
		return ftlInfo;
	}
	/**
	 * 设置查询条件pageIn
	 * v1.0 peng_zheng 2020-8-31上午05:26:27
	 * @param conditionInfoList
	 * @return List<ConditionInfo>
	 */
	private static List<ConditionInfo> setPageIn(List<ConditionInfo> conditionInfoList){
		Map<Integer, String> map = new HashMap<>();
		map.put(2, "pageIn.getTwo()");
		map.put(3, "pageIn.getThree()");
		map.put(4, "pageIn.getFour()");
		map.put(5, "pageIn.getFive()");
		map.put(6, "pageIn.getSix()");
		map.put(7, "pageIn.getSeven()");
		map.put(8, "pageIn.getEight()");
		map.put(9, "pageIn.getNine()");
		map.put(10, "pageIn.getTen()");
		
		Integer index = 2;
		
		for(ConditionInfo conditionInfo : conditionInfoList){
			if(conditionInfo.getSearch() != 0){
				conditionInfo.setPageIn(map.get(index));
				index ++;
			}
		}
		return conditionInfoList;
	}
}
