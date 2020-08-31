package com.jingmax.conf;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * 应用配置
 * 
 * v1.0 zhanghc 2019年9月29日下午2:30:20
 */
@Configuration
public class ApplicationCfg implements WebMvcConfigurer {

	@Override
	public void addViewControllers(ViewControllerRegistry registry) {
		registry.addRedirectViewController("/", "home/login");
	}
}
