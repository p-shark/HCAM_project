package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import db.DBInfo;

public class HcamFileDAO {
	Connection conn = null;
	Statement stmt = null;
	
	public HcamFileDAO() {
		// TODO Auto-generated constructor stub
		try {
			
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(DBInfo.URL, DBInfo.ROOT, DBInfo.PASSWORD);
			
			stmt = conn.createStatement();
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void dbClose() {
		try {
			stmt.close();
			conn.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	/* 파일경로 조회 */
	public String getFilePath(String hfl_kubun, int kubun_no) {
		
		String filePath = "";
		
		try {
			String sql = String.format("select concat(hfl_path, hfl_name) as filePath from hcamFile where hfl_kubun = '%s' and kubun_no = %d;"
						, hfl_kubun, kubun_no); 
			ResultSet rs = stmt.executeQuery(sql);
			
			if(rs.next()) {
				filePath = rs.getString("filePath");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return filePath;
	}
	
	/* 파일명 조회 */
	public String getFileName(String hfl_kubun, int kubun_no) {
		
		String hfl_name = "";
		
		try {
			String sql = String.format("select hfl_name from hcamFile where hfl_kubun = '%s' and kubun_no = %d;"
						, hfl_kubun, kubun_no); 
			ResultSet rs = stmt.executeQuery(sql);
			
			if(rs.next()) {
				hfl_name = rs.getString("hfl_name");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return hfl_name;
	}
	
	/* 파일 여러개 조회 */
	public ArrayList<String> getFileList(String hfl_kubun, int kubun_no, int pageNo) {
		
		ArrayList<String> fileList = new ArrayList<String>();
		
		int startrow=(pageNo-1)*10;
		
		try {
			String sql = String.format("select concat(hfl_path,hfl_name) as filepath from hcamFile " + 
									   "where hfl_kubun = '%s' and kubun_no = %d;"
									   , hfl_kubun, kubun_no); 
			ResultSet rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				fileList.add(rs.getString("filepath"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return fileList;
	}
	
	/* 파일 테이블 삭제 */
	public void deleteFile(String hfl_kubun, int kubun_no) {
		
		try {
			
			String sql = String.format("delete from hcamFile where hfl_kubun = '%s' and kubun_no = %d;"
						, hfl_kubun, kubun_no);
			stmt.executeUpdate(sql);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
