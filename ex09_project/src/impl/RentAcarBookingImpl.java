package impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

import controller.CommandInter;
import model.MypageModel;
import model.RentAcarModel;
import vo.HcamMemDTO;
import vo.RentACarDTO;

public class RentAcarBookingImpl implements CommandInter{

	static RentAcarBookingImpl impl = new RentAcarBookingImpl();

	public static RentAcarBookingImpl instance(){
		return impl;
	}
	
	public String showData(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		
		int mem_no = Integer.parseInt(request.getParameter("mem_no"));
		int pnt_no = Integer.parseInt(request.getParameter("pnt_no"));
		int car_no = Integer.parseInt(request.getParameter("car_no"));
		String chkInDate = request.getParameter("chkInDate");
		String chkOutDate = request.getParameter("chkOutDate");
		String inTime = request.getParameter("inTime");
		String outTime = request.getParameter("outTime");
		
		/*// -, : 제거
		chkInDate = chkInDate.replaceAll("-", "");
		chkOutDate = chkOutDate.replaceAll("-", "");
		inTime = inTime.replaceAll(":", "");
		outTime = outTime.replaceAll(":", "");*/
		
		/*Map<String, String> param_car = new HashMap<String, String>();
		param_car.put("car_no", car_no);
		param_car.put("select01", select01);
		param_car.put("select02", select02);
		param_car.put("chkInDate", chkInDate);
		param_car.put("chkOutDate", chkOutDate);
		param_car.put("inTime", inTime);
		param_car.put("outTime", outTime);*/
		
		RentAcarModel car_model = RentAcarModel.instance();
		MypageModel mypage_model = MypageModel.instance();
		
		/* 회원정보 */
		ArrayList<HcamMemDTO> memberInfo = (ArrayList<HcamMemDTO>) mypage_model.selectMemberInfo(mem_no);
		/* 포인트 정보 */
		ArrayList<Map<String, String>> pointInfo = (ArrayList<Map<String, String>>) mypage_model.selectPointInfo(pnt_no);
		/* 렌터카 select */
		ArrayList<RentACarDTO> car = (ArrayList<RentACarDTO>) car_model.getRentAcar(car_no);
		
		request.setAttribute("car_no", car_no);
		request.setAttribute("chkInDate", chkInDate);
		request.setAttribute("chkOutDate", chkOutDate);
		request.setAttribute("inTime", inTime);
		request.setAttribute("outTime", outTime);
		request.setAttribute("memberInfo", memberInfo);
		request.setAttribute("pointInfo", pointInfo);
		request.setAttribute("car", car);
		
		return "HCAM_rentAcarBooking.jsp";
	}
}