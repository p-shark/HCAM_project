/*package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sevice.marketListService;
import vo.ActionForward;
import vo.marketDTO;
import vo.PageInfo;

public class marketListallAction implements Action{
	 web작업시 예외처리: throws Exception 
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ArrayList<marketDTO> marketLists = new ArrayList<marketDTO>();
		int page=1;
		int limit=6;
		
		if(request.getParameter("page") != null) {
			page=Integer.parseInt(request.getParameter("page"));
		}
		
		 service 호출 
		marketListService ListService = new marketListService();
		int listCount = marketListService.getListCount();
		marketLists = marketListService.getmarketLists(page,limit);
		
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
		request.setAttribute("marketLists", marketLists);
		
		 이동할 주소경로 넘기기 
		ActionForward forward = new ActionForward();
		forward.setPath("/HCAM_marketMain.jsp");
		return forward; // 이동할 경로를 vo 의 ActionForward 메소드를 사용해서 주소를 담아준다. 담은 주소를 controller 에 넘기기
		
	}

}
*/