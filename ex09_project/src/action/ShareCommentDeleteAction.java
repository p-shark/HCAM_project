package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.ShareBoardService;
import vo.ActionForward;
import vo.ShbCommentDTO;

public class ShareCommentDeleteAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 게시판 No
		int shb_no = Integer.parseInt(request.getParameter("shb_no"));
		// 댓글 No
		int sbc_no = Integer.parseInt(request.getParameter("sbc_no"));
		
		ShareBoardService boardSvc = new ShareBoardService();
		
		/* 게시글의 댓글 삭제 */
		boardSvc.deleteComment(sbc_no);
		
		/* 게시글의 댓글 조회 */
		ArrayList<ShbCommentDTO> comments = boardSvc.getCommentByShbno(shb_no);
		
		request.setAttribute("shb_no", shb_no);
		request.setAttribute("comments", comments);
	    
		ActionForward forward = new ActionForward();
		forward.setPath("/view/HCAM_shareCommentByChaging.jsp");
		return forward;
	}

}
