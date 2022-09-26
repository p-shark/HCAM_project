package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.ShareBoardService;
import vo.ActionForward;
import vo.SharingBoardDTO;
import vo.ShbCommentDTO;

public class ShareBoardDetailAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ArrayList<ShbCommentDTO> boards = new ArrayList<ShbCommentDTO>();
		
		int shb_no = Integer.parseInt(request.getParameter("shb_no"));
		
		ShareBoardService boardSvc = new ShareBoardService();
		
		/* 게시글 조회  */
		SharingBoardDTO board = boardSvc.getBoardByShbNo(shb_no);
		
		/* 게시글의 댓글 조회 */
		ArrayList<ShbCommentDTO> comments = boardSvc.getCommentByShbno(shb_no);
		
		request.setAttribute("shb_no", shb_no);
		request.setAttribute("board", board);
		request.setAttribute("comments", comments);
		
		ActionForward forward = new ActionForward();
		forward.setPath("HCAM_shareBoardDetail.jsp");
		return forward;
	}

}
