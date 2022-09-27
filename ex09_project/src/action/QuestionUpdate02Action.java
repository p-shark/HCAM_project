package action;

import java.io.File;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dao.HcamFileDAO;
import service.QuestionService;
import vo.ActionForward;
import vo.HcamFileDTO;
import vo.QuestionBoardDTO;
public class QuestionUpdate02Action implements Action{

	/* web작업시 예외처리: throws Exception */
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//한글 깨짐 방지
		request.setCharacterEncoding("UTF-8");
		
		String uploadPath=request.getRealPath("/uploadFile/questionBoard");
		
		int size = 10*1024*1024;
		String filename1="";
		String filename2="";
		String origfilename1="";
		String origfilename2="";

		QuestionBoardDTO list = new QuestionBoardDTO();
		HcamFileDTO hcamfile = new HcamFileDTO();
		
		try{
			MultipartRequest multi = new MultipartRequest(request, uploadPath, size, "UTF-8", new DefaultFileRenamePolicy());
		
			Enumeration<String> files = multi.getFileNames();
			
			String file1 = (String) files.nextElement();
			filename1 = multi.getFilesystemName(file1);
			origfilename1 = multi.getOriginalFileName(file1);
			
			list.setQbd_no(Integer.parseInt(multi.getParameter("qbd_no")));
			list.setQbd_ctgry(multi.getParameter("qbd_ctgry"));
			list.setQbd_title(multi.getParameter("qbd_title"));
			list.setQbd_content(multi.getParameter("qbd_content"));
			
			if(filename1 != null) {
				HcamFileDAO fileDao = new HcamFileDAO();
				// 이전 서버 파일 삭제
				String before_file = fileDao.getFileName("qbd", Integer.parseInt(multi.getParameter("qbd_no")));	// 이전 파일명
				String uploadedFileName =  request.getServletContext().getRealPath("/uploadFile/questionBoard/") + before_file;
			    File realFile = new File(uploadedFileName);  //파일객체 생성
			    boolean isDel = realFile.delete(); //boolean type 리턴
				
			    // 새로운 파일 객체 생성
				hcamfile.setKubun_no(Integer.parseInt(multi.getParameter("qbd_no")));
				hcamfile.setHfl_kubun("qbd");
				hcamfile.setHfl_path("uploadFile/questionBoard/");
				hcamfile.setHfl_name(filename1);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		/* 문의사항 수정 */
		QuestionService questionservice = new QuestionService();
		questionservice.changeList(list, hcamfile);
		
		ActionForward forward = new ActionForward();
		forward.setPath("questionMain.co");
		return forward;
	}

}
