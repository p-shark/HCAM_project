package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.ShareBoardService;
import vo.ActionForward;
import vo.ShbCommentDTO;

public class ShareCommentPopupSaveAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//한글 깨짐 방지
		request.setCharacterEncoding("UTF-8");
		
		String kubun = request.getParameter("kubun");
		
		ShareBoardService boardSvc = new ShareBoardService();
		
		ShbCommentDTO comment = new ShbCommentDTO();
		
		if("insert".equals(kubun)) {
			comment.setMem_no(Integer.parseInt(request.getParameter("mem_no")));
			comment.setSbc_no(Integer.parseInt(request.getParameter("sbc_no")));
			comment.setShb_no(Integer.parseInt(request.getParameter("shb_no")));
			comment.setSbc_RE_GRP(Integer.parseInt(request.getParameter("sbc_RE_GRP")));
			comment.setSbc_RE_LEV(Integer.parseInt(request.getParameter("sbc_RE_LEV")));
			comment.setSbc_RE_SEQ(Integer.parseInt(request.getParameter("sbc_RE_SEQ")));
			comment.setSbc_content(request.getParameter("comment"));
			
			boardSvc.insertReComment(comment);
		}
		else {
			comment.setSbc_no(Integer.parseInt(request.getParameter("sbc_no")));
			comment.setSbc_content(request.getParameter("comment"));
			
			boardSvc.updateComment(comment);
		}
		
		ActionForward forward = null;
		//forward.setPath("HCAM_shareCommentSave.jsp");
		return forward;
	}

}
