package action;

import java.io.File;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.HcamFileDAO;
import service.NoticeListService;
import service.QuestionService;
import vo.ActionForward;
import vo.AnswerBoardDTO;
import vo.NoticeBoardDTO;
import vo.PageInfo;
import vo.QuestionBoardDTO;

public class QuestionDeleteAction implements Action{

	/* web작업시 예외처리: throws Exception */
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		int qbd_no = Integer.parseInt(request.getParameter("qbd_no"));
		
		HcamFileDAO fileDao = new HcamFileDAO();
		
		/* 게시글 파일명 조회 */
		String fileName = fileDao.getFileName("qbd", qbd_no);
		
		// 서버 파일 삭제
		String uploadedFileName =  request.getServletContext().getRealPath("/uploadFile/questionBoard/") + fileName;
	    File realFile = new File(uploadedFileName);  //파일객체 생성
	    boolean isDel = realFile.delete(); //boolean type 리턴
	    
	    /* 파일 테이블 삭제 */
	    fileDao.deleteFile("qbd", qbd_no);
		
		/* 게시글 삭제 */
	    QuestionService questionservice = new QuestionService();
		questionservice.deleteAnswerList(qbd_no);
		questionservice.deleteQestionList(qbd_no);
		
		fileDao.dbClose();
		
		/* 이동할 주소경로 넘기기 */
		ActionForward forward = new ActionForward();
		forward.setPath("questionMain.co");
		return forward; // 이동할 경로를 vo 의 ActionForward 메소드를 사용해서 주소를 담아준다. 담은 주소를 controller 에 넘기기
		
	}

}
