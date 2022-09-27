package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CommonDAO;
import service.ShareBoardService;
import vo.ActionForward;
import vo.PageInfo;
import vo.SharingBoardDTO;

public class ShareBoardTotalAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ArrayList<SharingBoardDTO> boards = new ArrayList<SharingBoardDTO>();
		
		// 페이지 처리를 위한 변수
		int page = 1;
		int limit = 8;
		
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		
		ShareBoardService boardSvc = new ShareBoardService();
		
		// 페이지 처리를 위한 count (공통 메소드 호출)
		CommonDAO commonDao = new CommonDAO();
		int listCount = commonDao.getListCount("sharingBoard");
		
		// 카테고리
		String category = "";
		// 카테고리 별 페이징처리 값이 넘어오는 경우, 카테고리값이 '전체'일 때와 아닐 때 각각 처리
		if(request.getParameter("category") == null || request.getParameter("category") == "") {
			/* 게시판 전체 정보 */
			boards = boardSvc.getBoardAll(page, limit);
		} else {
			category = request.getParameter("category");
			/* 카테고리 별 게시글 조회 */
			boards = boardSvc.getBoardByCtgry(category, page, limit);
		}
		
		// 페이지 처리를 위한 변수
		int maxPage = (int) ((double)listCount/limit + 0.95);
		int startPage = (((int) ((double)page / 8 + 0.9)) - 1) * 8 + 1;
		int endPage = startPage+10-1;
		
		if (endPage > maxPage) endPage = maxPage;
		
		PageInfo pageInfo = new PageInfo();
		pageInfo.setEndPage(endPage);
		pageInfo.setListCount(listCount);
		pageInfo.setMaxPage(maxPage);
		pageInfo.setPage(page);
		pageInfo.setStartPage(startPage);
		
		request.setAttribute("category", category);
		request.setAttribute("boards", boards);
		request.setAttribute("pageInfo", pageInfo);
		
		commonDao.dbClose();
				
		ActionForward forward = new ActionForward();
		forward.setPath("view/HCAM_shareBoard.jsp");
		return forward;
	}

}
