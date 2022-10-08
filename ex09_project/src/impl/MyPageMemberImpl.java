package impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

import controller.CommandInter;
import model.MypageModel;
import vo.HcamMemDTO;
import vo.PntHistoryDTO;

public class MyPageMemberImpl implements CommandInter{

	static MyPageMemberImpl impl = new MyPageMemberImpl();

	public static MyPageMemberImpl instance(){
		return impl;
	}
	
	public String showData(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		int mem_no = Integer.parseInt(request.getParameter("mem_no"));
		
		MypageModel model = MypageModel.instance();
		
		ArrayList<HcamMemDTO> memberInfo = (ArrayList<HcamMemDTO>) model.selectMemberInfo(mem_no);
		
		request.setAttribute("memberInfo", memberInfo);
		
		return "HCAM_mypageMember.jsp";
	}
}