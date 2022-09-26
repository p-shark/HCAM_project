package dao;

import static db.JdbcUtil.close;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import db.DBInfo;
import vo.NoticeBoardDTO;

public class NoticeDAO {
	
	Connection conn = null;
	Statement stmt = null;
	private static NoticeDAO noticeDAO;
	
	public NoticeDAO() {
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
	public static NoticeDAO getInstance() {
		if(noticeDAO == null) {
			noticeDAO = new NoticeDAO();
		}
		return noticeDAO;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public void DBclose() {
		try {
			conn.close();
			stmt.close();
		}catch(Exception e) {
			e.printStackTrace();
		}

	}
	
	public int selectListsCount() {
		
		int listCount = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = conn.prepareStatement("select count(*) from noticeboard;");
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				listCount = rs.getInt(1);
			}
		}catch(Exception ex) {
			ex.printStackTrace();

		}finally {
			close(rs);
			close(pstmt);
		}
		
		return listCount;
	}
	
	public ArrayList<NoticeBoardDTO> getAllnoticeLists(int page, int limit){
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String notice_list_sql="select * from noticeboard order by ntc_date desc limit ?,10";
		
		ArrayList<NoticeBoardDTO> noticeLists = new ArrayList<NoticeBoardDTO>();
		NoticeBoardDTO noticeDTO = null;
		int startrow=(page-1)*10;
		
		try {
			pstmt = conn.prepareStatement(notice_list_sql);
			pstmt.setInt(1, startrow);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				noticeDTO = new NoticeBoardDTO();
				
				noticeDTO.setNtc_no(rs.getInt("ntc_no"));
				noticeDTO.setNtc_ctgry(rs.getString("ntc_ctgry"));
				noticeDTO.setNtc_title(rs.getString("ntc_title"));
				noticeDTO.setNtc_content(rs.getString("ntc_content"));
				noticeDTO.setNtc_date(rs.getString("ntc_date"));
				
				noticeLists.add(noticeDTO);
			}
		}catch(Exception ex) {
				ex.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return noticeLists;
	}
}
