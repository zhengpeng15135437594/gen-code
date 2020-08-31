package com.jingmax.exception;

/**
 * 模板异常
 * 
 * v1.0 zhanghc 2019年6月22日下午2:31:04
 */
public class TemplateException extends RuntimeException{

	private static final long serialVersionUID = 1L;

	public TemplateException(String msg){
		super(msg);
	}
}
