package service;

import static db.JdbcUtil.*;
import java.sql.Connection;
import java.util.ArrayList;

import dao.CampingDAO;
import vo.CampingDTO;

public class campingListService {
	
	public int getListCount() throws Exception{
		int listCount = 0;
		Connection conn = getConnection();
		CampingDAO campingDAO = CampingDAO.getInstance();
		campingDAO.setConnection(conn);
		listCount = campingDAO.selectListsCount();
		close(conn);
		
		return listCount;
	}
	
	public ArrayList<CampingDTO> getAllCampingLists(int page, int limit) throws Exception{
		ArrayList<CampingDTO> campingLists = null;
		Connection conn = getConnection();
		CampingDAO campingDAO = CampingDAO.getInstance();
		campingDAO.setConnection(conn);
		
		campingLists = campingDAO.getAllCampingLists(page, limit);
		close(conn);
		return campingLists;
	}
	
	/* 카테고리별 */
	public int getCtgListCount(String optionValue) throws Exception{
		int listCount = 0;
		Connection conn = getConnection();
		CampingDAO campingDAO = CampingDAO.getInstance();
		campingDAO.setConnection(conn);
		listCount = campingDAO.selectCtgListsCount(optionValue);
		close(conn);
		
		return listCount;
	}
	
	public ArrayList<CampingDTO> getcampingListsByCtg(String optionValue, int page, int limit) throws Exception{
		ArrayList<CampingDTO> campingListsByCtg = null;
		Connection conn = getConnection();
		CampingDAO campingDAO = CampingDAO.getInstance();
		campingDAO.setConnection(conn);
		
		campingListsByCtg = campingDAO.getCtgCampingLists(optionValue, page,limit);
		close(conn);
		
		
		return campingListsByCtg;
	}
}
