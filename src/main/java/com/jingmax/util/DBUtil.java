package com.jingmax.util;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.jingmax.entity.DBColInfo;
import com.jingmax.entity.DBTableInfo;
import com.jingmax.exception.DBException;

/**
 * 数据库工具类
 * 
 * @author zhanghc 2015-5-2上午09:21:54
 */
public class DBUtil {
//	private static Connection connection = null;

	private DBUtil() {

	}

	/**
	 * 获取连接
	 * 
	 * v1.0 zhanghc 2015-5-8下午03:22:29
	 * 
	 * @param driverName
	 * @param jdbcUrl
	 * @param userName
	 * @param password
	 * @return Connection
	 */
	public static Connection getConnection(String driverName, String jdbcUrl, String userName, String password) {
		try {
//			if (connection != null) {
//				return connection;
//			}
//			synchronized (DBUtil.class) {
//				if (connection != null) {
//					return connection;
//				}

				Class.forName(driverName);
				Connection connection = DriverManager.getConnection(jdbcUrl, userName, password);
				return connection;
//			}
		} catch (Exception e) {
			throw new DBException("连接数据库失败：" + e.getMessage());
		}
	}

	/**
	 * 释放连接
	 * 
	 * v1.0 zhanghc 2015-5-8下午03:24:14
	 * 
	 * @param ress
	 *            void
	 */
	public static void close(Object... ress) {
		for (Object res : ress) {
			if (res instanceof ResultSet) {
				try {
					((ResultSet) res).close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (res instanceof Statement) {
				try {
					((Statement) res).close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (res instanceof Connection) {
				try {
					((Connection) res).close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}

	/**
	 * 解析元数据
	 * 
	 * v1.0 zhanghc 2015-5-8下午03:21:18
	 * @param connection
	 * @param instanceName
	 * @param tableName
	 * @return TableInfo
	 */
	public static DBTableInfo parseMetaData(Connection connection, String instanceName, String tableName) {
		try {
			DatabaseMetaData metaData = connection.getMetaData();
			ResultSet resultSet = metaData.getTables(instanceName, null, tableName, new String[] { "TABLE" });
			DBTableInfo tableInfo = null;
			try {
				tableInfo = new DBTableInfo();
				while (resultSet.next()) {
					tableInfo.setCode(resultSet.getString("TABLE_NAME").toUpperCase());
					tableInfo.setName(resultSet.getString("REMARKS"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			DBUtil.close(resultSet);

			resultSet = metaData.getColumns(instanceName, null, tableName, null);
			List<DBColInfo> colInfoList = null;
			try {
				colInfoList = new ArrayList<>();
				while (resultSet.next()) {
					DBColInfo colInfo = new DBColInfo();
					colInfo.setCode(resultSet.getString("COLUMN_NAME"));
					colInfo.setName(resultSet.getString("REMARKS"));
					colInfo.setType(resultSet.getString("TYPE_NAME"));
					colInfo.setLen(resultSet.getInt("COLUMN_SIZE"));
					colInfoList.add(colInfo);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			DBUtil.close(resultSet);
			tableInfo.setColInfoList(colInfoList);
			return tableInfo;
		} catch (Exception e) {
			throw new DBException("解析元数据失败：" + e.getMessage());
		}
	}
}
