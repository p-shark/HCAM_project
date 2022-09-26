package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.questionListService;
import vo.ActionForward;
import vo.AnswerBoardDTO;
import vo.PageInfo;
import vo.QuestionBoardDTO;

public class QuestionListallAction implements Action{

	/* web작업시 예외처리: throws Exception */
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ArrayList<QuestionBoardDTO> questionLists = new ArrayList<QuestionBoardDTO>();
		ArrayList<AnswerBoardDTO> answerLists = new ArrayList<AnswerBoardDTO>();
		int page=1;
		int limit=6;
		
		if(request.getParameter("page") != null) {
			page=Integer.parseInt(request.getParameter("page"));
		}
		
		/* service 호출 */
		questionListService questionListService = new questionListService();
		int listCount = questionListService.getListCount();
		questionLists = questionListService.getQuestionLists(page,limit);
		answerLists = questionListService.getAnswerLists();
		
		int maxPage=(int)((double)listCount/limit+0.95); 
   		int startPage = (((int) ((double)page / 6 + 0.9)) - 1) * 6 + 1;
   	    int endPage = startPage+6-1;

   		if (endPage> maxPage) endPage= maxPage;

   		PageInfo pageInfo = new PageInfo();
   		pageInfo.setEndPage(endPage);
   		pageInfo.setListCount(listCount);
		pageInfo.setMaxPage(maxPage);
		pageInfo.setPage(page);
		pageInfo.setStartPage(startPage);	
		
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("questionLists", questionLists);
		request.setAttribute("answerLists", answerLists);
		
		/* 이동할 주소경로 넘기기 */
		ActionForward forward = new ActionForward();
		forward.setPath("/HCAM_memberQuestion.jsp");
		return forward; // 이동할 경로를 vo 의 ActionForward 메소드를 사용해서 주소를 담아준다. 담은 주소를 controller 에 넘기기
		
	}

}
