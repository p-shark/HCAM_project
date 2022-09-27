package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.ShareBoardService;
import vo.ActionForward;

public class ShareCommentPopupAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//한글 깨짐 방지
		request.setCharacterEncoding("UTF-8");
		
		String kubun = request.getParameter("kubun");
		int sbc_no = 0;
		int shb_no = 0;
		int sbc_RE_GRP = 0;
		int sbc_RE_LEV = 0;
		int sbc_RE_SEQ = 0;
		
		// 내용 조회
		String sbc_content = "";
		
		ShareBoardService boardSvc = new ShareBoardService();
		
		if("insert".equals(kubun)) {
			sbc_no = Integer.parseInt(request.getParameter("sbc_no"));
			shb_no = Integer.parseInt(request.getParameter("shb_no"));
			sbc_RE_GRP = Integer.parseInt(request.getParameter("sbc_RE_GRP"));
			sbc_RE_LEV = Integer.parseInt(request.getParameter("sbc_RE_LEV"));
			sbc_RE_SEQ = Integer.parseInt(request.getParameter("sbc_RE_SEQ"));
		}
		else {
			sbc_no = Integer.parseInt(request.getParameter("sbc_no"));
			/* 게시글의 댓글 content 조회 */
			sbc_content = boardSvc.getCommentBySbcno(sbc_no);
		}
		
		request.setAttribute("kubun", kubun);
		request.setAttribute("sbc_no", sbc_no);
		request.setAttribute("shb_no", shb_no);
		request.setAttribute("sbc_RE_GRP", sbc_RE_GRP);
		request.setAttribute("sbc_RE_LEV", sbc_RE_LEV);
		request.setAttribute("sbc_RE_SEQ", sbc_RE_SEQ);
		request.setAttribute("sbc_content", sbc_content);
		
		ActionForward forward = new ActionForward();
		forward.setPath("/view/HCAM_shareCommentPopup.jsp");
		return forward;
	}

}
