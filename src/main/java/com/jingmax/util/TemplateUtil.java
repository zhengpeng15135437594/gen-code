package com.jingmax.util;

import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import java.util.Collection;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.filefilter.DirectoryFileFilter;
import org.apache.commons.io.filefilter.NotFileFilter;
import org.apache.commons.io.filefilter.TrueFileFilter;

import com.jingmax.exception.TemplateException;

import freemarker.cache.FileTemplateLoader;
import freemarker.cache.MultiTemplateLoader;
import freemarker.cache.StringTemplateLoader;
import freemarker.cache.TemplateLoader;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateExceptionHandler;

/**
 * 模板工具类
 * 
 * v1.0 zhanghc 2015-5-6下午05:27:17
 */
public class TemplateUtil {
	private static Configuration configuration = null;
	private static Configuration stringConfiguration = null;
	private static String TEMPLATE_DIR = null;
	static {
		try {
			TEMPLATE_DIR = TemplateUtil.class.getResource("/").toURI().getPath() + "/templates/";
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
	}

	private TemplateUtil() {

	}

	/**
	 * 获取实例
	 * 
	 * v1.0 zhanghc 2019年6月26日上午10:03:22
	 * @return Configuration
	 */
	private static Configuration getStringInstance() {
		try {
			if (stringConfiguration != null) {
				return stringConfiguration;
			}
			synchronized (TemplateUtil.class) {
				if (stringConfiguration != null) {
					return stringConfiguration;
				}
				stringConfiguration = new Configuration(Configuration.VERSION_2_3_22);
				stringConfiguration.setTemplateLoader(new StringTemplateLoader());
				stringConfiguration.setDefaultEncoding("UTF-8");
				stringConfiguration.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);
				stringConfiguration.setLogTemplateExceptions(false);
				stringConfiguration.setWrapUncheckedExceptions(true);
				return stringConfiguration;
			}
		} catch (Exception e) {
			throw new TemplateException("初始化模板配置失败：" + e.getMessage());
		}
	}
	
	/**
	 * 获取实例
	 * 
	 * v1.0 zhanghc 2019年6月26日上午10:03:22
	 * @return Configuration
	 */
	private static Configuration getInstance() {
		try {
			if (configuration != null) {
				return configuration;
			}
			synchronized (TemplateUtil.class) {
				if (configuration != null) {
					return configuration;
				}
				configuration = new Configuration(Configuration.VERSION_2_3_22);
				//configuration.setDirectoryForTemplateLoading(new File(TemplateUtil.class.getResource("/").getPath() + "/templates"));
				configuration.setDefaultEncoding("UTF-8");
				configuration.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);
				configuration.setLogTemplateExceptions(false);
				configuration.setWrapUncheckedExceptions(true);
				return configuration;
			}
		} catch (Exception e) {
			throw new TemplateException("初始化模板配置失败：" + e.getMessage());
		}
	}
	
	/**
	 * 设置模板目录
	 * 
	 * v1.0 zhanghc 2019年6月26日上午9:17:20
	 * @param dir 模板目录（相对路径） 
	 * void
	 */
	public static void setDir(String dir){
		Collection<File> templateDirs = FileUtils.listFilesAndDirs(new File(TEMPLATE_DIR + dir), 
				new NotFileFilter(TrueFileFilter.INSTANCE), DirectoryFileFilter.DIRECTORY);
		TemplateLoader[] templateLoaders = new TemplateLoader[templateDirs.size()];
		int i = 0;
		for(File templateDir : templateDirs){
			try {
				templateLoaders[i++] = new FileTemplateLoader(templateDir);
			} catch (IOException e) {
				throw new TemplateException("设置模板目录失败：" + e.getMessage());
			}
		}
		getInstance().setTemplateLoader(new MultiTemplateLoader(templateLoaders));
	}

	/**
	 * 获取模板
	 * 
	 * v1.0 zhanghc 2019年6月22日下午3:00:12
	 * @param name 模板名称（包括后缀名）
	 * @return Template
	 */
	public static Template getTemplate(String name) {
		try {
			return getInstance().getTemplate(name);
		} catch (Exception e) {
			throw new TemplateException("获取模板失败：" + e.getMessage());
		}
	}
	
	/**
	 * 获取模板
	 * 
	 * v1.0 zhanghc 2019年6月22日下午3:00:12
	 * @param content
	 * @return Template
	 */
	public static Template getStringTemplate(String content) {
		try {
			Configuration stringInstance = getStringInstance();
			StringTemplateLoader stringTemplateLoader = new StringTemplateLoader();
			stringTemplateLoader.putTemplate("msg", content);
			stringInstance.setTemplateLoader(stringTemplateLoader);
			return stringInstance.getTemplate("msg");
		} catch (Exception e) {
			throw new TemplateException("获取模板失败：" + e.getMessage());
		}
	}
	
	/**
	 * 获取基础目录
	 * 
	 * v1.0 zhanghc 2019年6月26日上午9:41:09
	 * @return String
	 */
	public static String getBaseDir(){
		return TEMPLATE_DIR;
	}
	
	public static void main(String[] args) {
		Collection<File> listFiles = FileUtils.listFiles(new File("d:/test"), null, true);
		for (File file : listFiles) {
			System.err.println(file.getAbsolutePath());
		}
	}
}
