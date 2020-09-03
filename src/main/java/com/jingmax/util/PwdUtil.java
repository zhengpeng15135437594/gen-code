package com.jingmax.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URISyntaxException;

public class PwdUtil {
	
	private static String FILE_DIR = null;
	
	static {
		try {
			FILE_DIR = PwdUtil.class.getResource("/").toURI().getPath() + "/files/pwd";
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 获取基础目录
	 * v1.0 peng_zheng 2020年9月3日上午9:43:23
	 * @return String
	 */
	public static String getBaseDir(){
		return FILE_DIR;
	}
	
	/**
	 * 获取文件内容
	 * v1.0 peng_zheng 2020年9月3日上午9:52:49
	 * @return String
	 */
	public static String getPwd(){
		String line = null;
        try {
			File file = new File(FILE_DIR);
	        if(!file.exists()) {
	            file.createNewFile();
	            FileWriter fileWriter =new FileWriter(file);
	            fileWriter.write("admin");
	            fileWriter.flush();
	            fileWriter.close();
	        }
		
			FileInputStream fileInputStream = new FileInputStream(file);

			BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(fileInputStream));

			line = bufferedReader.readLine();
			
			fileInputStream.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return line;
	}
	
	/**
	 * 修改文件内容
	 * v1.0 peng_zheng 2020年9月3日上午9:53:09
	 * @param oldPwd
	 * @param newPwd void
	 */
	public static void updatePwd(String oldPwd,String newPwd){
		try {
	        File file = new File(FILE_DIR);
	        if(!file.exists()) {
	            file.createNewFile();
	        }       
			FileOutputStream fileOutputStream = new FileOutputStream(file);
			fileOutputStream.write(newPwd.getBytes());

			fileOutputStream.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) {
		String baseDir = getBaseDir();
		File file = new File(baseDir);
		try {
		FileInputStream fileInputStream = new FileInputStream(file);

		BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(fileInputStream));

		String readLine = bufferedReader.readLine();
		System.out.println(readLine);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
