package db;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class JdbcUtil {
	
	// DB connection 리턴
	public static Connection getConnection() {
		Connection conn = null;
		
		try {
			Context initCtx = new InitialContext();
			Context envCtx = (Context)initCtx.lookup("java:comp/env");
			DataSource ds = (DataSource)envCtx.lookup("jdbc/MySQLDB");
			conn = ds.getConnection();
			conn.setAutoCommit(false);
		} catch (Exception e) {
			System.out.print(e);
		}
		return conn;
	}
	
	// DB Connection 종료
	public static void close(Connection conn){
		
		try {
			conn.close();
		} catch (Exception e) {
			System.out.print(e);
		}
		
	}
	
	public static void close(Statement stmt){
		
		try {
			stmt.close();
		} catch (Exception e) {
			System.out.print(e);
		}
		
	}
	
	public static void close(CallableStatement cstmt){
		
		try {
			cstmt.close();
		} catch (Exception e) {
			System.out.print(e);
		}
		
	}
	
	public static void close(ResultSet rs){
		
		try {
			rs.close();
		} catch (Exception e) {
			System.out.print(e);
		}
		
	}
	
	// DB commit
	public static void commit(Connection conn) {
		try {
			conn.commit();
			System.out.println("commit success");
		} catch (Exception e) {
			System.out.print(e);
		}
	}
	
	// DB rollback
	public static void rollback(Connection conn){
		
		try {
			conn.rollback();
			System.out.println("rollback success");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
}
