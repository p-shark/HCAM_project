package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.HcamFileDAO;
import service.ShareBoardService;
import vo.ActionForward;
import vo.SharingBoardDTO;
import vo.ShbCommentDTO;

public class ShareBoardUpdate01Action implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ArrayList<ShbCommentDTO> boards = new ArrayList<ShbCommentDTO>();
		
		int shb_no = Integer.parseInt(request.getParameter("shb_no"));
		
		ShareBoardService boardSvc = new ShareBoardService();
		/* 게시글 조회  */
		SharingBoardDTO board = boardSvc.getBoardByShbNo(shb_no);
		
		HcamFileDAO fileDao = new HcamFileDAO();
		/* 게시글 파일명 조회 */
		String fileName = fileDao.getFileName("shb", shb_no);
		/* 파일경로 조회 */
		String filePath = fileDao.getFilePath("shb", shb_no);
		
		fileDao.dbClose();
		
		request.setAttribute("shb_no", shb_no);
		request.setAttribute("fileName", fileName);
		request.setAttribute("filePath", filePath);
		request.setAttribute("board", board);
		
		ActionForward forward = new ActionForward();
		forward.setPath("/view/HCAM_shareBoardUpdate.jsp");
		return forward;
	}

}
