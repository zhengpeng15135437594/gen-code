package com.jingmax.exception;

/**
 * 数据库异常
 * 
 * v1.0 zhanghc 2019年6月22日下午2:31:04
 */
public class DBException extends RuntimeException{

	private static final long serialVersionUID = 1L;

	public DBException(String msg){
		super(msg);
	}
}
