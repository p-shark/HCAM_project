/*package dao;

import static db.JdbcUtil.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.sql.DataSource;

import vo.marketDTO;

public class MarketDAO {
	
	DataSource ds;
	Connection conn;
	private static MarketDAO marketDAO;
	
	private MarketDAO() {
	}
	
	public static MarketDAO getInstance() {
		if(marketDAO == null) {
			marketDAO = new MarketDAO();
		}
		return marketDAO;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public int selectListsCount() {
		
		int listCount = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = conn.prepareStatement("select count(*) from market");
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
	
	public ArrayList<marketDTO> selectmarketLists(int page, int limit){
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String market_list_sql="select * from market order by cmp_no asc,cmp_location asc limit ?,6";
		
		ArrayList<marketDTO> marketLists = new ArrayList<marketDTO>();
		marketDTO marketDTO = null;
		int startrow=(page-1)*6;
		
		try {
			pstmt = conn.prepareStatement(market_list_sql);
			pstmt.setInt(1, startrow);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				marketDTO = new marketDTO();
				
				marketDTO.setCmp_no(rs.getInt("cmp_no"));
				marketDTO.setMgr_no(rs.getInt("mgr_no"));
				marketDTO.setCmp_kubun(rs.getString("cmp_kubun"));
				marketDTO.setCmp_location(rs.getString("cmp_location"));
				marketDTO.setCmp_name(rs.getString("cmp_name"));
				marketDTO.setCmp_addr(rs.getString("cmp_addr"));
				marketDTO.setCmp_addrdtl(rs.getString("cmp_addrdtl"));
				marketDTO.setCmp_pool(rs.getInt("cmp_pool"));
				marketDTO.setCmp_public(rs.getInt("cmp_public"));
				marketDTO.setCmp_conv(rs.getInt("cmp_conv"));
				marketDTO.setCmp_pet(rs.getInt("cmp_pet"));
				marketDTO.setCmp_cook(rs.getInt("cmp_cook"));
				marketDTO.setCmp_inTime(rs.getString("cmp_inTime"));
				marketDTO.setCmp_outTime(rs.getString("cmp_outTime"));
				
				marketLists.add(marketDTO);
			}
		}catch(Exception ex) {
				ex.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return marketLists;
	}
}
*/