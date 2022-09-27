package service;
/*package sevice;

import static db.JdbcUtil.*;
import java.sql.Connection;
import java.util.ArrayList;

import dao.marketDAO;
import vo.marketDTO;

public class marketListService {
	
	public int getListCount() throws Exception{
		int listCount = 0;
		Connection conn = getConnection();
		marketDAO marketDAO = marketDAO.getInstance();
		marketDAO.setConnection(conn);
		listCount = marketDAO.selectListsCount();
		close(conn);
		
		return listCount;
	}
	
	
	public ArrayList<marketDTO> getmarketLists(int page, int limit) throws Exception{
		
		ArrayList<marketDTO> marketLists = null;
		Connection conn = getConnection();
		marketDAO marketDAO = marketDAO.getInstance();
		marketDAO.setConnection(conn);
		
		marketLists = marketDAO.selectmarketLists(page,limit);
		close(conn);
		return marketLists;
	}
}
*/