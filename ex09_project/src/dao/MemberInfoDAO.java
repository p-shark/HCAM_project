package dao;

import static db.JdbcUtil.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import vo.HcamMemDTO;
import vo.HcamPointDTO;

public class MemberInfoDAO {
	Connection conn;
	
	private static MemberInfoDAO memberDAO;
	
	private MemberInfoDAO() {}
	
	public static MemberInfoDAO getInstance() {
		if(memberDAO == null) {
			memberDAO = new MemberInfoDAO();
		}
		
		return memberDAO;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	/* 회원 정보 */
	public HcamMemDTO getMemberInfo(int mem_no) {
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select * from hcamMem where mem_no = ?";
		
		HcamMemDTO member = new HcamMemDTO();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mem_no);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				member.setMem_no(rs.getInt("mem_no"));
				member.setPnt_no(rs.getInt("pnt_no"));
				member.setMemg_kubun(rs.getString("memg_kubun"));
				member.setMem_id(rs.getString("mem_id"));
				member.setMem_pw(rs.getString("mem_pw"));
				member.setMem_name(rs.getString("mem_name"));
				member.setMem_email(rs.getString("mem_email"));
				member.setMem_nation(rs.getString("mem_nation"));
				member.setMem_phone(rs.getString("mem_phone"));
				member.setMem_post(rs.getString("mem_post"));
				member.setMem_addr(rs.getString("mem_addr"));
				member.setMem_addrdtl(rs.getString("mem_addrdtl"));
				member.setMem_gender(rs.getString("mem_gender"));
				member.setMem_birth(rs.getString("mem_birth"));
			}

		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return member;
	}
	
	/* 회원의 포인트 정보 */
	public HcamPointDTO getMemPoint(int mem_no) {
		
		int pnt_balance = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String member_sql = "select pnt_no from hcamMem where mem_no = ?";
		String point_sql = "select * from hcamPoint where pnt_no = ?";
		
		HcamPointDTO point = null;
		
		try {
			pstmt = conn.prepareStatement(member_sql);
			pstmt.setInt(1, mem_no);
			rs = pstmt.executeQuery();

			int pnt_no = 0;
			if(rs.next()) {
				pnt_no = rs.getInt("pnt_no");
			}
			
			close(rs); close(pstmt);
			
			pstmt = conn.prepareStatement(point_sql);
			pstmt.setInt(1, pnt_no);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				point = new HcamPointDTO();
				
				point.setPnt_no(rs.getInt("pnt_no"));
				point.setPnt_balance(rs.getInt("pnt_balance"));
			}

		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return point;
	}
}
