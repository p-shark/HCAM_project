package impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

import controller.CommandInter;
import model.MypageModel;
import vo.PntHistoryDTO;

public class MyPageLikeImpl implements CommandInter{

	static MyPageLikeImpl impl = new MyPageLikeImpl();

	public static MyPageLikeImpl instance(){
		return impl;
	}
	
	public String showData(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		int mem_no = Integer.parseInt(request.getParameter("mem_no"));
		
		MypageModel model = MypageModel.instance();
		
		return "HCAM_mypageLike.jsp";
	}
}