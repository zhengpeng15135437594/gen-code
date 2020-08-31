package com.jingmax.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 * 压缩文件
 * 
 * v1.0 zhanghc 2019年6月28日上午10:47:39
 */
public class ZipUtil {
	/**
	 * 压缩文件
	 * 
	 * @param sourceDir
	 *            原文件目录
	 * @param zipFile
	 *            压缩后的文件名称
	 * @throws Exception
	 */
	public static void doZip(String sourceDir, File zipFile) throws Exception {
		OutputStream os = new FileOutputStream(zipFile);
		BufferedOutputStream bos = new BufferedOutputStream(os);
		ZipOutputStream zos = new ZipOutputStream(bos);
		File file = new File(sourceDir);
		String basePath = null;
		if (file.isDirectory()) {
			basePath = file.getPath();
		} else {
			basePath = file.getParent();
		}
		zipFile(file, basePath, zos);
		zos.closeEntry();
		zos.close();
	}

	/**
	 * 压缩文件
	 * 
	 * @param source
	 * @param basePath
	 * @param zos
	 * @throws Exception
	 */
	private static void zipFile(File source, String basePath, ZipOutputStream zos) throws Exception {
		File[] files = new File[0];
		if (source.isDirectory()) {
			files = source.listFiles();
		} else {
			files = new File[1];
			files[0] = source;
		}
		String pathName;
		byte[] buf = new byte[1024];
		int length = 0;
		for (File file : files) {
			if (file.isDirectory()) {
				pathName = file.getPath().substring(basePath.length() + 1) + "/";
				zos.putNextEntry(new ZipEntry(pathName));
				zipFile(file, basePath, zos);
			} else {
				pathName = file.getPath().substring(basePath.length() + 1);
				InputStream is = new FileInputStream(file);
				BufferedInputStream bis = new BufferedInputStream(is);
				zos.putNextEntry(new ZipEntry(pathName));
				while ((length = bis.read(buf)) > 0) {
					zos.write(buf, 0, length);
				}
				is.close();
			}
		}
	}
}