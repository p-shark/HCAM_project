package service;

import static db.JdbcUtil.*;
import java.sql.Connection;
import java.util.ArrayList;

import dao.QuestionDAO;
import vo.AnswerBoardDTO;
import vo.HcamFileDTO;
import vo.QuestionBoardDTO;

public class QuestionService {
	
	public int getListCount() throws Exception{
		int listCount = 0;
		Connection conn = getConnection();
		QuestionDAO questionDAO = QuestionDAO.getInstance();
		questionDAO.setConnection(conn);
		listCount = questionDAO.selectListsCount();
		close(conn);
		
		return listCount;
	}
	
	/* 문의사항 조회 */
	public QuestionBoardDTO getListByQbdNo(int qbd_no) {
		QuestionBoardDTO list = null;
		
		// db connection
		Connection conn = getConnection();
		
		QuestionDAO questiondao = QuestionDAO.getInstance();
		questiondao.setConnection(conn);
		
		/* 게시글 조회 */
		list = questiondao.getListByQbdNo(qbd_no);
		
		close(conn);
		
		return list;
	}
	
	/* 문의사항 전체 정보 */
	public ArrayList<QuestionBoardDTO> getQuestionLists(int page, int limit) throws Exception{
		
		ArrayList<QuestionBoardDTO> questionLists = null;
		
		// db connection
		Connection conn = getConnection();
		
		QuestionDAO questionDAO = QuestionDAO.getInstance();
		questionDAO.setConnection(conn);
		
		/* 문의사항 전체 정보 */
		questionLists = questionDAO.getQuestionLists(page,limit);
		close(conn);
		
		return questionLists;
	}
	
	/* 답변사항 조회 */
	public ArrayList<AnswerBoardDTO> getAnswerLists() throws Exception{
		
		ArrayList<AnswerBoardDTO> answerLists = null;
		
		// db connection
		Connection conn = getConnection();
		
		QuestionDAO questionDAO = QuestionDAO.getInstance();
		questionDAO.setConnection(conn);
		
		/* 답변사항 조회 */
		answerLists = questionDAO.getAllAns();
		close(conn);
		
		return answerLists;
	}
	
	/* 문의사항 작성 */
	public void insertList(QuestionBoardDTO list, HcamFileDTO hcamFile) {
		// db connection
		Connection conn = getConnection();
		
		QuestionDAO questionDAO = QuestionDAO.getInstance();
		questionDAO.setConnection(conn);
		
		/* 문의사항 작성 */
		questionDAO.insertList(list, hcamFile);
		
		commit(conn);
		
		close(conn);
	}
	
	/* 문의사항 수정 */
	public void changeList(QuestionBoardDTO list, HcamFileDTO hcamFile) {
		// db connection
		Connection conn = getConnection();
		
		QuestionDAO questionDAO = QuestionDAO.getInstance();
		questionDAO.setConnection(conn);
		
		/* 문의사항 수정 */
		questionDAO.changeList(list, hcamFile);
		
		commit(conn);
		
		close(conn);
	}
	
	/* 문의사항 삭제 */
	public void deleteQestionList(int qbd_no) {
		// db connection
		Connection conn = getConnection();
		
		QuestionDAO questionDAO = QuestionDAO.getInstance();
		questionDAO.setConnection(conn);
		
		/* 문의사항 삭제 */
		questionDAO.deleteQestionList(qbd_no);
		
		commit(conn);
		
		close(conn);
	}
	
	/* 답변사항 삭제 */
	public void deleteAnswerList(int qbd_no) {
		// db connection
		Connection conn = getConnection();
		
		QuestionDAO questionDAO = QuestionDAO.getInstance();
		questionDAO.setConnection(conn);
		
		/* 답변사항 삭제 */
		questionDAO.deleteAnswerList(qbd_no);
		
		commit(conn);
		
		close(conn);
	}
}
