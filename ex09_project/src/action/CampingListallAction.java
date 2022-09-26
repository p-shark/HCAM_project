package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.campingListService;
import vo.ActionForward;
import vo.CampingDTO;
import vo.PageInfo;

public class CampingListallAction implements Action{
	/* web작업시 예외처리: throws Exception */
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ArrayList<CampingDTO> campingLists = new ArrayList<CampingDTO>();
		int page=1;
		int limit=6;
		String optionValue="";
		
		if(request.getParameter("page") != null) {
			page=Integer.parseInt(request.getParameter("page"));
		}
		if(request.getParameter("optionValue") != null) {
			optionValue = request.getParameter("optionValue");
		}
		
		/* service 호출 */
		campingListService campingListService = new campingListService();
		
		int listCount = 0;
		
		if(request.getParameter("optionValue")==null || request.getParameter("optionValue")=="") {
			listCount = campingListService.getListCount();
			campingLists = campingListService.getAllCampingLists(page, limit);
		}
		else {
			listCount = campingListService.getCtgListCount(optionValue);
			campingLists = campingListService.getcampingListsByCtg(optionValue, page, limit);
		}
		
		int maxPage = (int)((double)listCount/limit+0.95); 
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
		request.setAttribute("optionValue",optionValue);
		request.setAttribute("campingLists", campingLists);

		/* 이동할 주소경로 넘기기 */
		ActionForward forward = new ActionForward();
		forward.setPath("/HCAM_campingMain.jsp");
		return forward; // 이동할 경로를 vo 의 ActionForward 메소드를 사용해서 주소를 담아준다. 담은 주소를 controller 에 넘기기
		
	}

}
