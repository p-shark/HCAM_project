package impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

import controller.CommandInter;
import model.MypageModel;

public class MyPageBookingImpl implements CommandInter{

	static MyPageBookingImpl impl = new MyPageBookingImpl();

	public static MyPageBookingImpl instance(){
		return impl;
	}
	
	public String showData(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		int mem_no = Integer.parseInt(request.getParameter("mem_no"));
		
		MypageModel model = MypageModel.instance();
		
		/* 호텔 예약 정보 */
		ArrayList<Map<String, String>> htlBooking = (ArrayList<Map<String, String>>) model.selectHtlBooking(mem_no);
		
		/* 렌터카 예약정보 */
		ArrayList<Map<String, String>> carBooking = (ArrayList<Map<String, String>>) model.selectCarBooking(mem_no);
		
		request.setAttribute("htlBooking", htlBooking);
		request.setAttribute("carBooking", carBooking);
		
		return "HCAM_mypageBooking.jsp";
	}
}