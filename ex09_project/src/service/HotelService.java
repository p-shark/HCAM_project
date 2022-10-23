package service;

import static db.JdbcUtil.*;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.TreeMap;

import dao.HotelDAO;
import vo.HotelBookingDTO;
import vo.HotelDTO;
import vo.HotelReviewDTO;
import vo.HotelRoomDTO;

public class HotelService {

	/* 페이지 처리를 위한 호텔 count */
	public int getListCount(String select01, String select02, String chekIn, String checOut) throws Exception {
		
		int listCount = 0;
		// db connection
		Connection conn = getConnection();
		
		HotelDAO hotelDAO = HotelDAO.getInstance();
		hotelDAO.setConnection(conn);
		
		/* 페이지 처리를 위한 호텔 count */
		listCount = hotelDAO.getListCount(select01, select02, chekIn, checOut);
		
		close(conn);
		
		return listCount;
	}
	
	/* hotel 전체 목록 */
	public ArrayList<HotelDTO> getHotelAll(String select01, String select02, String chekIn, String checOut, int page, int limit) {
		
		ArrayList<HotelDTO> hotelList = null;
		// db connection
		Connection conn = getConnection();
		
		HotelDAO hotelDAO = HotelDAO.getInstance();
		hotelDAO.setConnection(conn);
		
		/* hotel 전체 목록 */
		hotelList = hotelDAO.getHotelAll(select01, select02, chekIn, checOut, page, limit);
		
		close(conn);
		
		return hotelList;
	}
	
	/* 호텔 부가정보 */
	public ArrayList<TreeMap<String, String>> getHotelAdnInfo(String select01, String select02, String chekIn, String checOut, int page, int limit) {
		
		ArrayList<TreeMap<String, String>> hotelAdnInfos = null;
		// db connection
		Connection conn = getConnection();
		
		HotelDAO hotelDAO = HotelDAO.getInstance();
		hotelDAO.setConnection(conn);
		
		/* hotel 전체 목록 */
		hotelAdnInfos = hotelDAO.getHotelAdnInfo(select01, select02, chekIn, checOut, page, limit);
		
		close(conn);
		
		return hotelAdnInfos;
	}
	
	/* 좌측 검색 페이지 처리를 위한 호텔 count */
	public int getListCountBySearching(TreeMap<Integer, String> searchList) {
		
		int listCount = 0;
		// db connection
		Connection conn = getConnection();
		
		HotelDAO hotelDAO = HotelDAO.getInstance();
		hotelDAO.setConnection(conn);
		
		/* 페이지 처리를 위한 호텔 count */
		listCount = hotelDAO.getListCountBySearching(searchList);
		
		close(conn);
		
		return listCount;
	}
	
	/* 좌측 검색 조건에 따른 호텔 정보 */
	public ArrayList<HotelDTO> getHotelBysearch(TreeMap<Integer, String> searchList, int page, int limit) {
		
		ArrayList<HotelDTO> hotelList = null;
		// db connection
		Connection conn = getConnection();
		
		HotelDAO hotelDAO = HotelDAO.getInstance();
		hotelDAO.setConnection(conn);
		
		/* hotel 전체 목록 */
		hotelList = hotelDAO.getHotelBysearch(searchList, page, limit);
		
		close(conn);
		
		return hotelList;
	}
	
	/* 좌측 검색 조건에 따른 호텔 부가정보 */
	public ArrayList<TreeMap<String, String>> getHotelAdnInfoBySearch(TreeMap<Integer, String> searchList, int page, int limit) {
		
		ArrayList<TreeMap<String, String>> hotelAdnInfos = null;
		// db connection
		Connection conn = getConnection();
		
		HotelDAO hotelDAO = HotelDAO.getInstance();
		hotelDAO.setConnection(conn);
		
		/* hotel 전체 목록 */
		hotelAdnInfos = hotelDAO.getHotelAdnInfoBySearch(searchList, page, limit);
		
		close(conn);
		
		return hotelAdnInfos;
	}
	
	/* 호텔 정보 */
	public HotelDTO getHotelInfo(int htl_no) {
		HotelDTO hotel = null;
		
		// db connection
		Connection conn = getConnection();
		
		HotelDAO hotelDAO = HotelDAO.getInstance();
		hotelDAO.setConnection(conn);
		
		/* 호텔 정보 */
		hotel = hotelDAO.getHotelInfo(htl_no);
		
		close(conn);
		
		return hotel;
	}
	
	/* 각 호텔의 전체 객실 정보 */
	public ArrayList<HotelRoomDTO> getRoomAll(int htl_no, String chkIn, String chkOut) {
		
		ArrayList<HotelRoomDTO> hotelRoomList = null;
		
		// db connection
		Connection conn = getConnection();
		
		HotelDAO hotelDAO = HotelDAO.getInstance();
		hotelDAO.setConnection(conn);
		
		/* 각 호텔의 전체 객실 정보 */
		hotelRoomList = hotelDAO.getRoomAll(htl_no, chkIn, chkOut);
		
		close(conn);
		
		return hotelRoomList;
	}
	
	/* 호텔의 객실 정보 */
	public HotelRoomDTO getRoomInfo(int htl_no, int hrm_no) {
		
		HotelRoomDTO htlRoom = null;
		
		// db connection
		Connection conn = getConnection();
		
		HotelDAO hotelDAO = HotelDAO.getInstance();
		hotelDAO.setConnection(conn);
		
		/* 각 호텔의 전체 객실 정보 */
		htlRoom = hotelDAO.getRoomInfo(htl_no, hrm_no);
		
		close(conn);
		
		return htlRoom;
	}
	
	/* 각 호텔의 전체 이용후기 정보(평균값, 총 개수) */
	public HashMap<String, String> getHotelReviewInfo(int htl_no) {
		
		HashMap<String, String> reviewInfo = new HashMap<String, String>();
		
		// db connection
		Connection conn = getConnection();
		
		HotelDAO hotelDAO = HotelDAO.getInstance();
		hotelDAO.setConnection(conn);
		
		reviewInfo = hotelDAO.getHotelReviewInfo(htl_no);
		
		close(conn);
		
		return reviewInfo;
	}
	
	/* 호텔 이용후기 */ 
	public ArrayList<HotelReviewDTO> getHtlReview(int htl_no) {
		
		ArrayList<HotelReviewDTO> reviewList = new ArrayList<HotelReviewDTO>();
		
		// db connection
		Connection conn = getConnection();
		
		HotelDAO hotelDAO = HotelDAO.getInstance();
		hotelDAO.setConnection(conn);
		
		reviewList = hotelDAO.getHtlReview(htl_no);
		
		close(conn);
		
		return reviewList;
	}
	
	/* 호텔 예약 */
	public int insertHtlBooking(HotelBookingDTO htlBooking) {
		
		int htb_no = 0;
		
		// db connection
		Connection conn = getConnection();
		
		HotelDAO hotelDAO = HotelDAO.getInstance();
		hotelDAO.setConnection(conn);
		
		/* 호텔 예약 */
		htb_no = hotelDAO.insertHtlBooking(htlBooking);
		
		if(htb_no > 0) {
			commit(conn);
		}
		else {
			rollback(conn);
		}
		
		close(conn);
		
		return htb_no;
	}
	
	/* 호텔 예약 취소 */
	public int cancelHtlBooking(int htb_no) {
		
		int deleteCount=0;
		
		// db connection
		Connection conn = getConnection();
		
		HotelDAO hotelDAO = HotelDAO.getInstance();
		hotelDAO.setConnection(conn);
		
		/* 호텔 예약 취소 */
		deleteCount = hotelDAO.cancelHtlBooking(htb_no);
		
		if(deleteCount > 0) {
			commit(conn);
		}
		else {
			rollback(conn);
		}
		
		close(conn);
		
		return deleteCount;
	}
	
	/* 호텔 예약 정보 */
	public HotelBookingDTO getHtlBookingInfo(int htb_no) {
		
		HotelBookingDTO htlBooking = null;
				
		// db connection
		Connection conn = getConnection();
		
		HotelDAO hotelDAO = HotelDAO.getInstance();
		hotelDAO.setConnection(conn);
		
		/* 호텔 예약 정보 */
		htlBooking = hotelDAO.getHtlBookingInfo(htb_no);
		
		close(conn);
		
		return htlBooking;
	}
	
}
