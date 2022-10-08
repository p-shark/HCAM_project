package impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

import controller.CommandInter;
import model.MypageModel;
import vo.PntHistoryDTO;

public class MyPagePointImpl implements CommandInter{

	static MyPagePointImpl impl = new MyPagePointImpl();

	public static MyPagePointImpl instance(){
		return impl;
	}
	
	public String showData(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		int mem_no = Integer.parseInt(request.getParameter("mem_no"));
		int pnt_no = Integer.parseInt(request.getParameter("pnt_no"));
		
		MypageModel model = MypageModel.instance();
		
		/* 포인트 정보 */
		ArrayList<Map<String, String>> pointInfo = (ArrayList<Map<String, String>>) model.selectPointInfo(pnt_no);
		
		/* 포인트 히스토리 정보 */
		ArrayList<PntHistoryDTO> pntHistory = (ArrayList<PntHistoryDTO>) model.selectPntHistoryInfo(pnt_no);
		
		request.setAttribute("pointInfo", pointInfo);
		request.setAttribute("pntHistory", pntHistory);
		
		return "HCAM_mypagePoint.jsp";
	}
}