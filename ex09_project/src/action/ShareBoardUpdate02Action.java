package action;

import java.io.File;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dao.HcamFileDAO;
import service.ShareBoardService;
import vo.ActionForward;
import vo.HcamFileDTO;
import vo.SharingBoardDTO;

public class ShareBoardUpdate02Action implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//한글 깨짐 방지
		request.setCharacterEncoding("UTF-8");
		
		String uploadPath=request.getRealPath("/uploadFile/shareBoard");
		
		int size = 10*1024*1024;
		String filename1="";
		String filename2="";
		String origfilename1="";
		String origfilename2="";

		SharingBoardDTO board = new SharingBoardDTO();
		HcamFileDTO hcamfile = new HcamFileDTO();
		
		try{
			MultipartRequest multi = new MultipartRequest(request, uploadPath, size, "UTF-8", new DefaultFileRenamePolicy());
		
			Enumeration<String> files = multi.getFileNames();
			
			String file1 = (String) files.nextElement();
			filename1 = multi.getFilesystemName(file1);
			origfilename1 = multi.getOriginalFileName(file1);
			
			board.setShb_no(Integer.parseInt(multi.getParameter("shb_no")));
			board.setShb_ctgry(multi.getParameter("category"));
			board.setShb_title(multi.getParameter("title"));
			board.setShb_content(multi.getParameter("content"));
			
			if(filename1 != null) {
				HcamFileDAO fileDao = new HcamFileDAO();
				// 이전 서버 파일 삭제
				String before_file = fileDao.getFileName("shb", Integer.parseInt(multi.getParameter("shb_no")));	// 이전 파일명
				String uploadedFileName =  request.getServletContext().getRealPath("/uploadFile/shareBoard/") + before_file;
			    File realFile = new File(uploadedFileName);  //파일객체 생성
			    boolean isDel = realFile.delete(); //boolean type 리턴
				
			    // 새로운 파일 객체 생성
				hcamfile.setKubun_no(Integer.parseInt(multi.getParameter("shb_no")));
				hcamfile.setHfl_kubun("shb");
				hcamfile.setHfl_path("uploadFile/shareBoard/");
				hcamfile.setHfl_name(filename1);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		/* 게시글 수정 */
	    ShareBoardService boardSvc = new ShareBoardService();
	    boardSvc.changeBoard(board, hcamfile);
		
		ActionForward forward = new ActionForward();
		forward.setPath("shareBoard.ho");
		return forward;
	}

}
