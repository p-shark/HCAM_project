package action;

import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import service.NoticeListService;
import service.QuestionService;
import vo.ActionForward;
import vo.AnswerBoardDTO;
import vo.HcamFileDTO;
import vo.NoticeBoardDTO;
import vo.PageInfo;
import vo.QuestionBoardDTO;

public class QuestionWriteAction implements Action{

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
		
		try {
			MultipartRequest multi = new MultipartRequest(request, uploadPath, size, "UTF-8", new DefaultFileRenamePolicy());

			Enumeration<String> files = multi.getFileNames();
			
			String file1 = (String) files.nextElement();
			filename1 = multi.getFilesystemName(file1);
			origfilename1 = multi.getOriginalFileName(file1);

			int mem_no = Integer.parseInt(multi.getParameter("mem_no"));
			String ctgry = multi.getParameter("qbd_ctgry");
			String title = multi.getParameter("qbd_title");
			String content = multi.getParameter("qbd_content");

			list.setMem_no(mem_no);
			list.setQbd_ctgry(ctgry);
			list.setQbd_title(title);
			list.setQbd_content(content);
			
			hcamfile.setHfl_kubun("qbd");
			hcamfile.setHfl_path("uploadFile/questionBoard/");
			hcamfile.setHfl_name(filename1);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		/* 문의사항 등록 */
		QuestionService questionservice = new QuestionService();
		questionservice.insertList(list, hcamfile);
		
		/* 이동할 주소경로 넘기기 */
		ActionForward forward = new ActionForward();
		forward.setPath("questionMain.co");
		return forward; // 이동할 경로를 vo 의 ActionForward 메소드를 사용해서 주소를 담아준다. 담은 주소를 controller 에 넘기기
		
	}

}
