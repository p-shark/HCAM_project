package action;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import service.ShareBoardService;
import vo.ActionForward;
import vo.HcamFileDTO;
import vo.SharingBoardDTO;

public class ShareBoardWriteAction implements Action{

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
			
			board.setMem_no(Integer.parseInt(multi.getParameter("mem_no")));
			board.setShb_ctgry(multi.getParameter("category"));
			board.setShb_title(multi.getParameter("title"));
			board.setShb_content(multi.getParameter("content"));
			
			hcamfile.setHfl_kubun("shb");
			hcamfile.setHfl_path("uploadFile/shareBoard/");
			hcamfile.setHfl_name(filename1);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		/* 게시글 등록 */
		ShareBoardService boardSvc = new ShareBoardService();
		boardSvc.insertBoard(board, hcamfile);
		
		ActionForward forward = new ActionForward();
		forward.setPath("shareBoard.ho");
		return forward;
	}

}
