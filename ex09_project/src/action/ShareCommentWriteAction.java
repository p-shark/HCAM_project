package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.ShareBoardService;
import vo.ActionForward;
import vo.ShbCommentDTO;

public class ShareCommentWriteAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//한글 깨짐 방지
		request.setCharacterEncoding("UTF-8");
		
		ArrayList<ShbCommentDTO> boards = new ArrayList<ShbCommentDTO>();
		
		// 로그인한 mem
		int mem_no = Integer.parseInt(request.getParameter("mem_no"));
		// 게시판 No
		int shb_no = Integer.parseInt(request.getParameter("shb_no"));
		// 댓글 내용
		String sbc_content = request.getParameter("comment");
		
		ShareBoardService boardSvc = new ShareBoardService();
		
		/* 게시글의 댓글 작성 */
		boardSvc.insertComment(shb_no, mem_no, sbc_content);
		
		/* 게시글의 댓글 조회 */
		ArrayList<ShbCommentDTO> comments = boardSvc.getCommentByShbno(shb_no);
		
		request.setAttribute("shb_no", shb_no);
		request.setAttribute("comments", comments);
		
		ActionForward forward = new ActionForward();
		forward.setPath("/view/HCAM_shareCommentByChaging.jsp");
		return forward;
	}

}
