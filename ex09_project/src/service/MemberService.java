package service;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;

import dao.MemberInfoDAO;
import vo.HcamMemDTO;
import vo.HcamPointDTO;

public class MemberService {
	
	/* 회원 정보 */
	public HcamMemDTO getMemberInfo(int mem_no) throws Exception {
		
		HcamMemDTO member = null;
		// db connection
		Connection conn = getConnection();
		
		MemberInfoDAO memberDAO = MemberInfoDAO.getInstance();
		memberDAO.setConnection(conn);
		
		/* 회원 정보 */
		member = memberDAO.getMemberInfo(mem_no);
		
		close(conn);
		
		return member;
	}
	
	/* 회원의 포인트 정보 */
	public HcamPointDTO getMemPoint(int mem_no) {
		
		HcamPointDTO point = null;
		
		// db connection
		Connection conn = getConnection();
		
		MemberInfoDAO memberDAO = MemberInfoDAO.getInstance();
		memberDAO.setConnection(conn);
		
		/* 회원의 포인트 정보 */
		point = memberDAO.getMemPoint(mem_no);
		
		close(conn);
		
		return point;
	}
	
}
