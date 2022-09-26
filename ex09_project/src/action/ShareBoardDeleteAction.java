package action;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.HcamFileDAO;
import service.ShareBoardService;
import vo.ActionForward;

public class ShareBoardDeleteAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		int shb_no = Integer.parseInt(request.getParameter("shb_no"));
		
		// 서버 파일 삭제
		String uploadedFileName =  request.getServletContext().getRealPath("/uploadFile/shareBoard/") + request.getParameter("fileName");
	    File realFile = new File(uploadedFileName);  //파일객체 생성
	    boolean isDel = realFile.delete(); //boolean type 리턴
		
	    /* 파일 테이블 삭제 */
	    HcamFileDAO fileDao = new HcamFileDAO();
	    fileDao.deleteFile("shb", shb_no);
	    
	    /* 게시글 삭제 */
	    ShareBoardService boardSvc = new ShareBoardService();
	    boardSvc.deleteBoard(shb_no);
	    
	    fileDao.dbClose();
	    
		ActionForward forward = new ActionForward();
		forward.setPath("shareBoard.ho");
		return forward;
	}

}
