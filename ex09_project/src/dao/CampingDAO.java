package dao;

import static db.JdbcUtil.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.sql.DataSource;

import db.DBInfo;
import vo.HcamFileDTO;
import vo.CampingDTO;

public class CampingDAO {
	
	Statement stmt = null;
	ResultSet rs = null;
	DataSource ds;
	Connection conn;
	private static CampingDAO campingDAO;
	
	private CampingDAO() {
	}
	
	public static CampingDAO getInstance() {
		if(campingDAO == null) {
			campingDAO = new CampingDAO();
		}
		return campingDAO;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public int selectListsCount() {
		int listCount = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = conn.prepareStatement("select count(*) from camping;");
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
	
	public ArrayList<CampingDTO> getAllCampingLists(int page, int limit){

		PreparedStatement pstmt = null;
		String camping_list_sql="select * from camping order by cmp_no asc,cmp_location asc limit ?,6";
		
		ArrayList<CampingDTO> campingLists = new ArrayList<CampingDTO>();
		CampingDTO campingDTO = null;
		int startrow=(page-1)*6;
		
		try {
			pstmt = conn.prepareStatement(camping_list_sql);
			pstmt.setInt(1, startrow);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				campingDTO = new CampingDTO();
				
				campingDTO.setCmp_no(rs.getInt("cmp_no"));
				campingDTO.setMgr_no(rs.getInt("mgr_no"));
				campingDTO.setCmp_kubun(rs.getString("cmp_kubun"));
				campingDTO.setCmp_location(rs.getString("cmp_location"));
				campingDTO.setCmp_name(rs.getString("cmp_name"));
				campingDTO.setCmp_addr(rs.getString("cmp_addr"));
				campingDTO.setCmp_addrdtl(rs.getString("cmp_addrdtl"));
				campingDTO.setCmp_pool(rs.getInt("cmp_pool"));
				campingDTO.setCmp_public(rs.getInt("cmp_public"));
				campingDTO.setCmp_conv(rs.getInt("cmp_conv"));
				campingDTO.setCmp_pet(rs.getInt("cmp_pet"));
				campingDTO.setCmp_cook(rs.getInt("cmp_cook"));
				campingDTO.setCmp_inTime(rs.getString("cmp_inTime"));
				campingDTO.setCmp_outTime(rs.getString("cmp_outTime"));
				
				campingLists.add(campingDTO);
			}
		}catch(Exception ex) {
				ex.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return campingLists;
	}
	
	/* 카테고리 별 캠핑장 조회 */
	
	public int selectCtgListsCount(String optionValue) {
		int listCount = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = conn.prepareStatement("select count(*) from camping where cmp_location = '" + optionValue + "';");
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
	
	public ArrayList<CampingDTO> getCtgCampingLists(String optionValue, int page, int limit) {
		PreparedStatement pstmt = null;
		String sql = "select * from camping where cmp_location = '" + optionValue + "' order by cmp_no desc limit ?,6";	//pstmt.setInt(1,starrow); 1은 첫번째 물음표라는 뜻 그 값이 starrow
		
		ArrayList<CampingDTO> campingListsByCtg = new ArrayList<CampingDTO>();
		CampingDTO campingDTO = null;
		int startrow=(page-1)*6; 
		
		try {
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startrow);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				campingDTO = new CampingDTO();
				
				campingDTO.setCmp_no(rs.getInt("cmp_no"));
				campingDTO.setMgr_no(rs.getInt("mgr_no"));
				campingDTO.setCmp_kubun(rs.getString("cmp_kubun"));
				campingDTO.setCmp_location(rs.getString("cmp_location"));
				campingDTO.setCmp_name(rs.getString("cmp_name"));
				campingDTO.setCmp_addr(rs.getString("cmp_addr"));
				campingDTO.setCmp_addrdtl(rs.getString("cmp_addrdtl"));
				campingDTO.setCmp_pool(rs.getInt("cmp_pool"));
				campingDTO.setCmp_public(rs.getInt("cmp_public"));
				campingDTO.setCmp_conv(rs.getInt("cmp_conv"));
				campingDTO.setCmp_pet(rs.getInt("cmp_pet"));
				campingDTO.setCmp_cook(rs.getInt("cmp_cook"));
				campingDTO.setCmp_inTime(rs.getString("cmp_inTime"));
				campingDTO.setCmp_outTime(rs.getString("cmp_outTime"));
				
				campingListsByCtg.add(campingDTO);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		
		return campingListsByCtg;
	}
}
