package service;

import static db.JdbcUtil.*;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.TreeMap;

import dao.HotelDAO;
import vo.HotelDTO;

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
	
}
