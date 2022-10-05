package dao;

import static db.JdbcUtil.close;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

import vo.HotelBookingDTO;
import vo.HotelDTO;
import vo.HotelReviewDTO;
import vo.HotelRoomDTO;

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
	
	/* 호텔 정보 */
	public HotelDTO getHotelInfo(int htl_no) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select * from hotel where htl_no = ?;";
		
		HotelDTO hotel = new HotelDTO();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, htl_no);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				hotel.setHtl_no(rs.getInt("htl_no"));
				hotel.setMgr_no(rs.getInt("mgr_no"));
				hotel.setHtl_name(rs.getString("htl_name"));
				hotel.setHtl_nation(rs.getString("htl_nation"));
				hotel.setHtl_location(rs.getString("htl_location"));
				hotel.setHtl_addr(rs.getString("htl_addr"));
				hotel.setHtl_addrdtl(rs.getString("htl_addrdtl"));
				hotel.setHtl_grade(rs.getInt("htl_grade"));
				hotel.setHtl_brkf(rs.getInt("htl_brkf"));
				hotel.setHtl_pool(rs.getInt("htl_pool"));
				hotel.setHtl_park(rs.getInt("htl_park"));
				hotel.setHtl_conv(rs.getInt("htl_conv"));
				hotel.setHtl_lugg(rs.getInt("htl_lugg"));
				hotel.setHtl_inTime(rs.getString("htl_inTime"));
				hotel.setHtl_outTime(rs.getString("htl_outTime"));
				hotel.setHtl_brfkPrice(rs.getInt("htl_brfkPrice"));
			}

		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return hotel;
	}
	
	/* 각 호텔의 전체 객실 정보 */
	public ArrayList<HotelRoomDTO> getRoomAll(int htl_no, String chkIn, String chkOut) {
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList<HotelRoomDTO> htlRoomList = new ArrayList<HotelRoomDTO>();
		HotelRoomDTO htlRoom = null;
		
		String sql = "select hrm.* " 
				   + ",(select count(*) from htlBooking where htl_no = hrm.htl_no and hrm_no = hrm.hrm_no "
				   + "and ((? >= htb_chkIn and ? < htb_chkOut) or (? < htb_chkIn and ? > htb_chkIn))) as booking_cnt "
				   + "from htlRoom hrm where hrm.htl_no = ? order by booking_cnt, hrm_price;";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, chkIn.replaceAll("-", ""));
			pstmt.setString(2, chkIn.replaceAll("-", ""));
			pstmt.setString(3, chkIn.replaceAll("-", ""));
			pstmt.setString(4, chkOut.replaceAll("-", ""));
			pstmt.setInt(5, htl_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				htlRoom = new HotelRoomDTO();
				
				htlRoom.setHrm_no(rs.getInt("hrm_no"));
				htlRoom.setHtl_no(rs.getInt("htl_no"));
				htlRoom.setHrm_name(rs.getString("hrm_name"));
				htlRoom.setHrm_view(rs.getString("hrm_view"));
				htlRoom.setHrm_bed(rs.getString("hrm_bed"));
				htlRoom.setHrm_price(rs.getInt("hrm_price"));
				htlRoom.setHrm_maxpers(rs.getInt("hrm_maxpers"));
				htlRoom.setBooking_cnt(rs.getInt("booking_cnt"));
				
				htlRoomList.add(htlRoom);
			}

		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return htlRoomList;
	}
	
	/* 호텔의 객실 정보 */
	public HotelRoomDTO getRoomInfo(int htl_no, int hrm_no) {
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		HotelRoomDTO htlRoom = null;
		
		String sql = "select * from htlRoom where htl_no = ? and hrm_no = ?;";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, htl_no);
			pstmt.setInt(2, hrm_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				htlRoom = new HotelRoomDTO();
				
				htlRoom.setHrm_no(rs.getInt("hrm_no"));
				htlRoom.setHtl_no(rs.getInt("htl_no"));
				htlRoom.setHrm_name(rs.getString("hrm_name"));
				htlRoom.setHrm_view(rs.getString("hrm_view"));
				htlRoom.setHrm_bed(rs.getString("hrm_bed"));
				htlRoom.setHrm_price(rs.getInt("hrm_price"));
				htlRoom.setHrm_maxpers(rs.getInt("hrm_maxpers"));
			}

		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return htlRoom;
	}
	
	/* 각 호텔의 전체 이용후기 정보(평균값, 총 개수) */
	public HashMap<String, String> getHotelReviewInfo(int htl_no) {
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		HashMap<String, String> reviewInfo = new HashMap<String, String>();
		
		String sql = "select round(avg(hrv_clSco),1) as avg_clSco, round(avg(hrv_loSco),1) as avg_loSco "
				   + ", round(avg(hrv_svcSco),1) as avg_svcSco, round(avg(hrv_conSco),1) as avg_conSco "
				   + ", round(avg(hrv_totalSco),1) as avg_totalSco, count(*) as review_cnt "
				   + ", ReviewCondition_FN(htl_no) as htl_cond "
				   + "from htlReview where htl_no = ?;"; 
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, htl_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				reviewInfo.put("avg_clSco", rs.getString("avg_clSco"));
				reviewInfo.put("avg_loSco", rs.getString("avg_loSco"));
				reviewInfo.put("avg_svcSco", rs.getString("avg_svcSco"));
				reviewInfo.put("avg_conSco", rs.getString("avg_conSco"));
				reviewInfo.put("avg_totalSco", rs.getString("avg_totalSco"));
				reviewInfo.put("review_cnt", rs.getString("review_cnt"));
				reviewInfo.put("htl_cond", rs.getString("htl_cond"));
			}

		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return reviewInfo;
	}
	
	/* 호텔 이용후기 */ 
	public ArrayList<HotelReviewDTO> getHtlReview(int htl_no) {
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList<HotelReviewDTO> reviewList = new ArrayList<HotelReviewDTO>();
		HotelReviewDTO review = null;
		
		String sql = "select hrv.*, date_format(hrv_date, '%Y-%m-%d %H:%i') as hrv_fmdate from htlReview hrv where htl_no = ?"; 
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, htl_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				review = new HotelReviewDTO();
				
				review.setHrv_no(rs.getInt("hrv_no"));
				review.setHtl_no(rs.getInt("htl_no"));
				review.setMem_no(rs.getInt("mem_no"));
				review.setHrv_clSco(rs.getInt("hrv_clSco"));
				review.setHrv_loSco(rs.getInt("hrv_loSco"));
				review.setHrv_svcSco(rs.getInt("hrv_svcSco"));
				review.setHrv_conSco(rs.getInt("hrv_conSco"));
				review.setHrv_totalSco(rs.getDouble("hrv_totalSco"));
				review.setHrv_content(rs.getString("hrv_content"));
				review.setHrv_date(rs.getString("hrv_fmdate"));
				
				reviewList.add(review);
			}

		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return reviewList;
	}
	
	/* 호텔 예약 */
	public int insertHtlBooking(HotelBookingDTO htlBooking) {
		
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		int htb_no = 0;
		
		try {
			cstmt = conn.prepareCall("{call HOTEL_BOOKING_SP(?,?,?,?,?,?,?,?,?,?,?)}");
			
			cstmt.setInt(1, htlBooking.getHtl_no());
			cstmt.setInt(2, htlBooking.getHrm_no());
			cstmt.setInt(3, htlBooking.getMem_no());
			cstmt.setString(4, htlBooking.getHtb_rlpName());
			cstmt.setString(5, htlBooking.getHtb_rlpEmail());
			cstmt.setString(6, htlBooking.getHtb_rlpNation());
			cstmt.setString(7, htlBooking.getHtb_rlpPhone());
			cstmt.setString(8, htlBooking.getHtb_chkIn());
			cstmt.setString(9, htlBooking.getHtb_chkOut());
			cstmt.setInt(10, htlBooking.getHtb_stayTerm());
			cstmt.setInt(11, htlBooking.getHtb_brkfCnt());
			
			cstmt.execute();
			
			rs = cstmt.getResultSet();
			
			if(rs.next()) {
				htb_no = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			close(rs);
			close(cstmt);
		}
		
		return htb_no;
	}
	
	/* 호텔 예약 정보 */
	public HotelBookingDTO getHtlBookingInfo(int htb_no) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		HotelBookingDTO htlBooking = null;
		
		String sql = "select htb.*, date_format(htb_date, '%Y-%m-%d %H:%i') as htb_fmDate from htlBooking htb where htb_no = ?;";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, htb_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				htlBooking = new HotelBookingDTO();
				
				htlBooking.setHtb_no(rs.getInt("htb_no"));
				htlBooking.setHtl_no(rs.getInt("htl_no"));
				htlBooking.setHrm_no(rs.getInt("hrm_no"));
				htlBooking.setMem_no(rs.getInt("mem_no"));
				htlBooking.setHtb_rlpName(rs.getString("htb_rlpName"));
				htlBooking.setHtb_rlpEmail(rs.getString("htb_rlpEmail"));
				htlBooking.setHtb_rlpNation(rs.getString("htb_rlpNation"));
				htlBooking.setHtb_rlpPhone(rs.getString("htb_rlpPhone"));
				htlBooking.setHtb_chkIn(rs.getString("htb_chkIn"));
				htlBooking.setHtb_chkOut(rs.getString("htb_chkOut"));
				htlBooking.setHtb_stayTerm(rs.getInt("htb_stayTerm"));
				htlBooking.setHtb_brkfCnt(rs.getInt("htb_brkfCnt"));
				htlBooking.setHtb_brkfPrice(rs.getInt("htb_brkfPrice"));
				htlBooking.setHtb_rlpRoomPrice(rs.getInt("htb_rlpRoomPrice"));
				htlBooking.setHtb_totalPrice(rs.getInt("htb_totalPrice"));
				htlBooking.setHtb_date(rs.getString("htb_fmDate"));
				
			}

		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return htlBooking;
	}
	
}
