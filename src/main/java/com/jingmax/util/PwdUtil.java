package com.jingmax.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;

public class PwdUtil {
	
	private static String path = "d:/6d2798e2d86f426b834703be1bc2e859/pwd.txt";
	
	public static String getPwd(){
		String line = null;
        try {
			File file = new File(path);
	        if(!file.exists()) {
	            file.createNewFile();
	            FileWriter fileWriter =new FileWriter(file);
	            fileWriter.write("admin");
	            fileWriter.flush();
	            fileWriter.close();
	        }
		
			FileInputStream fileInputStream = new FileInputStream(path);

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
	
	public static void updatePwd(String oldPwd,String newPwd){
		try {
	        File file = new File(path);
	        if(!file.exists()) {
	            file.createNewFile();
	        }
            FileWriter fileWriter =new FileWriter(file);
            fileWriter.write("");
            fileWriter.flush();
            fileWriter.close();
            
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
		String pwd = getPwd();
		System.out.println(pwd);
	}
}
