package impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

import controller.CommandInter;
import model.RentAcarModel;
import vo.RentACarDTO;

public class RentAcarPopupImpl implements CommandInter{

	static RentAcarPopupImpl impl = new RentAcarPopupImpl();

	public static RentAcarPopupImpl instance(){
		return impl;
	}
	
	public String showData(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		int car_no = Integer.parseInt(request.getParameter("car_no"));
		int booking_cnt = Integer.parseInt(request.getParameter("booking_cnt"));
		
		RentAcarModel model = RentAcarModel.instance();
		
		/* 렌터카 select */
		ArrayList<RentACarDTO> car = (ArrayList<RentACarDTO>) model.getRentAcar(car_no);
		
		request.setAttribute("booking_cnt", booking_cnt);
		request.setAttribute("car", car);
		
		return "HCAM_rentAcarPopup.jsp";
	}
}