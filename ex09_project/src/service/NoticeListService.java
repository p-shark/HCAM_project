package service;

import static db.JdbcUtil.*;
import java.sql.Connection;
import java.util.ArrayList;

import dao.NoticeDAO;
import vo.NoticeBoardDTO;

public class NoticeListService {
	
	public int getListCount() throws Exception{
		int listCount = 0;
		Connection conn = getConnection();
		NoticeDAO noticeDAO = NoticeDAO.getInstance();
		noticeDAO.setConnection(conn);
		listCount = noticeDAO.selectListsCount();
		close(conn);
		
		return listCount;
	}
	
	
	public ArrayList<NoticeBoardDTO> getAllnoticeLists(int page, int limit) throws Exception{
		
		ArrayList<NoticeBoardDTO> noticeLists = null;
		Connection conn = getConnection();
		NoticeDAO noticeDAO = NoticeDAO.getInstance();
		noticeDAO.setConnection(conn);
	
		noticeLists = noticeDAO.getAllnoticeLists(page,limit);
		close(conn);
		
		return noticeLists;
	}
}
