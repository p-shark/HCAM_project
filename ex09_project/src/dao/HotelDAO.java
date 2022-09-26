package dao;

import static db.JdbcUtil.close;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Map;
import java.util.TreeMap;

import javax.sql.DataSource;

import vo.HotelDTO;

public class HotelDAO {
	
	Connection conn;
	
	private static HotelDAO hotelDAO;
	
	private HotelDAO() {}
	
	public static HotelDAO getInstance() {
		if(hotelDAO == null) {
			hotelDAO = new HotelDAO();
		}
		
		return hotelDAO;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	/* 상단바 검색 페이지 처리를 위한 호텔 count */
	public int getListCount(String select01, String select02, String chekIn, String checOut) {
		int listCount = 0;
		
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		try {
			
			cstmt = conn.prepareCall("{call HOTEL_TOPCOUNT_SP(?,?,?,?)}");
			cstmt.setString(1, select01);
			cstmt.setString(2, select02);
			cstmt.setString(3, chekIn.replaceAll("-", ""));
			cstmt.setString(4, checOut.replaceAll("-", ""));
			cstmt.execute();
			
			rs = cstmt.getResultSet();
			
			if(rs.next()) {
				listCount = rs.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			close(rs);
			close(cstmt);
		}
		
		return listCount;
	}
	
	/* 상단바 검색 hotel 목록 */
	public ArrayList<HotelDTO> getHotelAll(String select01, String select02, String chekIn, String checOut, int page, int limit) {
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		ArrayList<HotelDTO> hotelList = new ArrayList<HotelDTO>();
		HotelDTO hotel = null;
		
		int startrow=(page-1)*10; 

		try{
			cstmt = conn.prepareCall("{call HOTEL_TOPLIST_SP(?,?,?,?,?)}");
			cstmt.setString(1, select01);
			cstmt.setString(2, select02);
			cstmt.setString(3, chekIn.replaceAll("-", ""));
			cstmt.setString(4, checOut.replaceAll("-", ""));
			cstmt.setInt(5, startrow);
			cstmt.execute();
			
			rs = cstmt.getResultSet();

			while(rs.next()){
				hotel = new HotelDTO();
				
				hotel.setHtl_no(rs.getInt(1));
				hotel.setMgr_no(rs.getInt(2));
				hotel.setHtl_name(rs.getString(3));
				hotel.setHtl_nation(rs.getString(4));
				hotel.setHtl_location(rs.getString(5));
				hotel.setHtl_addr(rs.getString(6));
				hotel.setHtl_addrdtl(rs.getString(7));
				hotel.setHtl_grade(rs.getInt(8));
				hotel.setHtl_brkf(rs.getInt(9));
				hotel.setHtl_pool(rs.getInt(10));
				hotel.setHtl_park(rs.getInt(11));
				hotel.setHtl_conv(rs.getInt(12));
				hotel.setHtl_lugg(rs.getInt(13));
				hotel.setHtl_inTime(rs.getString(14));
				hotel.setHtl_outTime(rs.getString(15));
				
				hotelList.add(hotel);
			}
			
		} catch(Exception e){
			e.printStackTrace();
		} finally{
			close(rs);
			close(cstmt);
		}

		return hotelList;
	}
	
	/* 상단바 검색 호텔 부가정보 */
	public ArrayList<TreeMap<String, String>> getHotelAdnInfo(String select01, String select02, String chekIn, String checOut, int page, int limit) {
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		int startrow=(page-1)*10; 
		
		// 호텔 부가정보 list
		ArrayList<TreeMap<String, String>> hotelAdnInfos = new ArrayList<>();
		
		try {
			cstmt = conn.prepareCall("{call HOTEL_TOPADDITION_SP(?,?,?,?,?)}");
			cstmt.setString(1, select01);
			cstmt.setString(2, select02);
			cstmt.setString(3, chekIn.replaceAll("-", ""));
			cstmt.setString(4, checOut.replaceAll("-", ""));
			cstmt.setInt(5, startrow);
			cstmt.execute();
			
			rs = cstmt.getResultSet();
			
			while(rs.next()) {
				
				// 요소를 추가할 때 Comparator를 사용하여 key를 정렬하며 그 순서대로 저장
				Comparator<String> comparator = (s1, s2) -> s1.compareTo(s2);
				TreeMap<String, String> oneRow = new TreeMap<String, String>(comparator);
				
				oneRow.put("htl_no", rs.getString(1));		// htl_no
				oneRow.put("review_cnt", rs.getString(2));	// 리뷰 개수
				oneRow.put("avg_sco", rs.getString(3));		// 평점
				oneRow.put("avg_status", rs.getString(4));	// 평점 별 상태
				oneRow.put("min_price", rs.getString(5));	// 해당 호텔의 최저가 객실 요금
				oneRow.put("remain_cnt", rs.getString(6));	// 해당 일자의 남은 객실
				oneRow.put("dis_price", rs.getString(7));	// 해당 호텔의 최저가 객실의 할인된 요금
				
				hotelAdnInfos.add(oneRow);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			close(rs);
			close(cstmt);
		}
		
		return hotelAdnInfos;
	}
	
	/* 좌측 검색 페이지 처리를 위한 호텔 count */
	public int getListCountBySearching(TreeMap<Integer, String> searchList) {
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		int listCount = 0;
		
		try {
			cstmt = conn.prepareCall("{call HOTEL_LEFTCOUNT_SP(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			for(Map.Entry<Integer, String> searchInfo : searchList.entrySet()) {
				if(searchInfo.getKey() == 2 || searchInfo.getKey() == 3) {		// 체크인일자, 체크아웃일자 
					cstmt.setString(searchInfo.getKey(), (searchInfo.getValue()).replaceAll("-", ""));
				}
				else if (searchInfo.getKey() == 6 || searchInfo.getKey() == 7){	// 최소금액, 최대금액
					cstmt.setInt(searchInfo.getKey(), Integer.parseInt(searchInfo.getValue()));
				}
				else {
					cstmt.setString(searchInfo.getKey(), searchInfo.getValue());
				}
			}
			
			cstmt.execute();
			rs = cstmt.getResultSet();
			
			if(rs.next()) {
				listCount = Integer.parseInt(rs.getString(1));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			close(rs);
			close(cstmt);
		}
		
		return listCount;
	}
	
	/* 좌측 검색 조건에 따른 호텔 정보 */
	public ArrayList<HotelDTO> getHotelBysearch(TreeMap<Integer, String> searchList, int page, int limit) {
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		int startrow=(page-1)*10; 
		
		HotelDTO hotel = null;
		// 호텔 부가정보 list
		ArrayList<HotelDTO> hotelList = new ArrayList<HotelDTO>();
		
		try {
			cstmt = conn.prepareCall("{call HOTEL_LEFTLIST_SP(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			for(Map.Entry<Integer, String> searchInfo : searchList.entrySet()) {
				if(searchInfo.getKey() == 2 || searchInfo.getKey() == 3) {		// 체크인일자, 체크아웃일자 
					cstmt.setString(searchInfo.getKey(), (searchInfo.getValue()).replaceAll("-", ""));
				}
				else if (searchInfo.getKey() == 6 || searchInfo.getKey() == 7){	// 최소금액, 최대금액
					cstmt.setInt(searchInfo.getKey(), Integer.parseInt(searchInfo.getValue()));
				}
				else {
					cstmt.setString(searchInfo.getKey(), searchInfo.getValue());
				}
			}
			
			cstmt.setInt(18, startrow);
			
			cstmt.execute();
			rs = cstmt.getResultSet();
			
			while(rs.next()) {
				
				hotel = new HotelDTO();
				hotel.setHtl_no(rs.getInt(1));
				hotel.setMgr_no(rs.getInt(2));
				hotel.setHtl_name(rs.getString(3));
				hotel.setHtl_nation(rs.getString(4));
				hotel.setHtl_location(rs.getString(5));
				hotel.setHtl_addr(rs.getString(6));
				hotel.setHtl_addrdtl(rs.getString(7));
				hotel.setHtl_grade(rs.getInt(8));
				hotel.setHtl_brkf(rs.getInt(9));
				hotel.setHtl_pool(rs.getInt(10));
				hotel.setHtl_park(rs.getInt(11));
				hotel.setHtl_conv(rs.getInt(12));
				hotel.setHtl_lugg(rs.getInt(13));
				hotel.setHtl_inTime(rs.getString(14));
				hotel.setHtl_outTime(rs.getString(15));
				
				hotelList.add(hotel);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			close(rs);
			close(cstmt);
		}
		
		return hotelList;
	}
	
	/* 좌측 검색 조건에 따른 호텔 부가정보 */
	public ArrayList<TreeMap<String, String>> getHotelAdnInfoBySearch(TreeMap<Integer, String> searchList, int page, int limit) {
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		int startrow=(page-1)*10; 
		
		// 호텔 부가정보 list
		ArrayList<TreeMap<String, String>> hotelAdnInfos = new ArrayList<>();
		
		try {
			cstmt = conn.prepareCall("{call HOTEL_LEFTADDITION_SP(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			for(Map.Entry<Integer, String> searchInfo : searchList.entrySet()) {
				if(searchInfo.getKey() == 2 || searchInfo.getKey() == 3) {		// 체크인일자, 체크아웃일자 
					cstmt.setString(searchInfo.getKey(), (searchInfo.getValue()).replaceAll("-", ""));
				}
				else if (searchInfo.getKey() == 6 || searchInfo.getKey() == 7){	// 최소금액, 최대금액
					cstmt.setInt(searchInfo.getKey(), Integer.parseInt(searchInfo.getValue()));
				}
				else {
					cstmt.setString(searchInfo.getKey(), searchInfo.getValue());
				}
			}
			
			cstmt.setInt(18, startrow);
			
			cstmt.execute();
			rs = cstmt.getResultSet();
			
			while(rs.next()) {
				
				// 요소를 추가할 때 Comparator를 사용하여 key를 정렬하며 그 순서대로 저장
				Comparator<String> comparator = (s1, s2) -> s1.compareTo(s2);
				TreeMap<String, String> oneRow = new TreeMap<String, String>(comparator);
				
				oneRow.put("htl_no", rs.getString(1));		// htl_no
				oneRow.put("review_cnt", rs.getString(2));	// 리뷰 개수
				oneRow.put("avg_sco", rs.getString(3));		// 평점
				oneRow.put("avg_status", rs.getString(4));	// 평점 별 상태
				oneRow.put("min_price", rs.getString(5));	// 해당 호텔의 최저가 객실 요금
				oneRow.put("remain_cnt", rs.getString(6));	// 해당 일자의 남은 객실
				oneRow.put("dis_price", rs.getString(7));	// 해당 호텔의 최저가 객실의 할인된 요금
				
				hotelAdnInfos.add(oneRow);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			close(rs);
			close(cstmt);
		}
		
		return hotelAdnInfos;
	}
	
}
