package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import db.DBInfo;
import vo.HcamMemDTO;
import vo.HcamMgrDTO;

public class MemberDAO {
	
	Connection conn = null;
	Statement stmt = null;
	
	public MemberDAO() {
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
	
	/* 회원 로그인 호출 */
	public HcamMemDTO loginResult(String id, String pw) {
		
		HcamMemDTO member = new HcamMemDTO();
		
		try {
			String sql = String.format("select * from hcamMem where mem_id = '%s' and mem_pw = '%s';", id, pw);
			ResultSet rs = stmt.executeQuery(sql);
			
			// 해당 회원이 존재하는 경우
			if(rs.next()) {
				member.setMem_no(rs.getInt("mem_no"));
				member.setPnt_no(rs.getInt("pnt_no"));
				member.setMemg_kubun(rs.getString("memg_kubun"));
				member.setMem_name(rs.getString("mem_name"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return member;
	}
	
	/* 매니저 로그인 호출 */
	public HcamMgrDTO mgrLoginResult(String id, String pw) {
		
		HcamMgrDTO manager = new HcamMgrDTO();
		
		try {
			String sql = String.format("select * from hcamMgr where mgr_id = '%s' and mgr_pw = '%s';", id, pw);
			ResultSet rs = stmt.executeQuery(sql);
			
			// 해당 회원이 존재하는 경우
			if(rs.next()) {
				manager.setMgr_no(rs.getInt("mgr_no"));
				manager.setPnt_no(rs.getInt("pnt_no"));
				manager.setMemg_kubun(rs.getString("memg_kubun"));
				manager.setMgr_name(rs.getString("mgr_name"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return manager;
	}
	
	/* 비밀번호 찾기 */
	public boolean pwResult(String id, String email) {
		
		boolean result = false;
		try {
			String sql = String.format("select * from hcamMem where mem_id = '%s' and mem_email = '%s';", id, email);
			ResultSet rs = stmt.executeQuery(sql);
			
			// 해당 회원이 존재하는 경우
			if(rs.next()) {
				result = true;
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}
	
	/* 비밀번호 변경 */
	public void chgPassword(String id, String pw) {
		
		try {
			
			String sql = String.format("update hcamMem set mem_pw = '%s' where mem_id = '%s';", pw, id);
			stmt.executeUpdate(sql);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
