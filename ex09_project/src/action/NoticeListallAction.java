package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.NoticeListService;
import vo.ActionForward;
import vo.NoticeBoardDTO;
import vo.PageInfo;

public class NoticeListallAction implements Action{
	/* web작업시 예외처리: throws Exception */
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ArrayList<NoticeBoardDTO> noticeLists = new ArrayList<NoticeBoardDTO>();
		int page=1;
		int limit=10;
		
		if(request.getParameter("page") != null) {
			page=Integer.parseInt(request.getParameter("page"));
		}
		
		/* service 호출 */
		NoticeListService noticeListService = new NoticeListService();
		int listCount = noticeListService.getListCount();
		noticeLists = noticeListService.getAllnoticeLists(page,limit);
		
		int maxPage=(int)((double)listCount/limit+0.95); 
   		int startPage = (((int) ((double)page / 10 + 0.9)) - 1) * 10 + 1;
   	    int endPage = startPage+10-1;

   		if (endPage> maxPage) endPage= maxPage;

   		PageInfo pageInfo = new PageInfo();
   		pageInfo.setEndPage(endPage);
   		pageInfo.setListCount(listCount);
		pageInfo.setMaxPage(maxPage);
		pageInfo.setPage(page);
		pageInfo.setStartPage(startPage);	
		
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("noticeLists", noticeLists);
		
		/* 이동할 주소경로 넘기기 */
		ActionForward forward = new ActionForward();
		forward.setPath("/view/HCAM_memberNotice.jsp");
		return forward; // 이동할 경로를 vo 의 ActionForward 메소드를 사용해서 주소를 담아준다. 담은 주소를 controller 에 넘기기
		
	}

}
