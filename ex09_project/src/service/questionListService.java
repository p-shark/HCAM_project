package service;

import static db.JdbcUtil.*;
import java.sql.Connection;
import java.util.ArrayList;

import dao.QuestionDAO;
import vo.AnswerBoardDTO;
import vo.QuestionBoardDTO;

public class questionListService {
	
	public int getListCount() throws Exception{
		int listCount = 0;
		Connection conn = getConnection();
		QuestionDAO questionDAO = QuestionDAO.getInstance();
		questionDAO.setConnection(conn);
		listCount = questionDAO.selectListsCount();
		close(conn);
		
		return listCount;
	}
	
	
	public ArrayList<QuestionBoardDTO> getQuestionLists(int page, int limit) throws Exception{
		
		ArrayList<QuestionBoardDTO> questionLists = null;
		Connection conn = getConnection();
		QuestionDAO questionDAO = QuestionDAO.getInstance();
		questionDAO.setConnection(conn);
		
		questionLists = questionDAO.selectQuestionLists(page,limit);
		close(conn);
		
		return questionLists;
	}
	
	/* 답변 */
	public ArrayList<AnswerBoardDTO> getAnswerLists() throws Exception{
		
		ArrayList<AnswerBoardDTO> answerLists = null;
		Connection conn = getConnection();
		QuestionDAO questionDAO = QuestionDAO.getInstance();
		questionDAO.setConnection(conn);
		
		answerLists = questionDAO.getSelectAllAns();
		close(conn);
		
		return answerLists;
	}
}
