package impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

import controller.CommandInter;
import model.RentAcarModel;
import vo.RentACarDTO;

public class RentAcarImpl implements CommandInter{

	static RentAcarImpl impl = new RentAcarImpl();

	public static RentAcarImpl instance(){
		return impl;
	}
	
	public String showData(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String[] param_car_kubun = request.getParameterValues("car_kubun");
		String select01 = request.getParameter("select01");
		String select02 = request.getParameter("select02");
		String chkInDate = request.getParameter("main_car_chkIn");
		String chkOutDate = request.getParameter("main_car_chkOut");
		String inTime = request.getParameter("search_car_intime");
		String outTime = request.getParameter("search_car_outtime");
		
		String chkIn = chkInDate.replaceAll("-", "") + inTime.replaceAll(":", "");
		String chkOut = chkOutDate.replaceAll("-", "") + outTime.replaceAll(":", "");
		
		/* for(String val : car_kubun) {
			System.out.println(val);
		}
		
		System.out.println(select01);
		System.out.println(select02);
		System.out.println(chkInDate.replaceAll("-", ""));
		System.out.println(chkOutDate.replaceAll("-", ""));
		System.out.println(inTime.replaceAll(":", ""));
		System.out.println(outTime.replaceAll(":", ""));
		*/
		
		String car_kubun01 = "";
		String car_kubun02 = "";
		String car_kubun03 = "";
		String car_kubun04 = "";
		
		if(param_car_kubun != null) {
			for(int i=0; i<=4; i++) {
				if(i == param_car_kubun.length) {
					break;
				}
				else {
					if(i == 0) car_kubun01 += param_car_kubun[i];
					else if(i == 1) car_kubun02 += param_car_kubun[i];
					else if(i == 2) car_kubun03 += param_car_kubun[i];
					else if(i == 3) car_kubun04 += param_car_kubun[i];
				}
			}
		}
		else {
			car_kubun01 = "all";
		}

		Map<String, String> param_car = new HashMap<String, String>();
		param_car.put("select01", select01);
		param_car.put("select02", select02);
		param_car.put("chkIn", chkIn);
		param_car.put("chkOut", chkOut);
		param_car.put("car_kubun01", car_kubun01);
		param_car.put("car_kubun02", car_kubun02);
		param_car.put("car_kubun03", car_kubun03);
		param_car.put("car_kubun04", car_kubun04);
		
		RentAcarModel model = RentAcarModel.instance();
		
		/* 렌터카 전체 select */
		ArrayList<RentACarDTO> carList = (ArrayList<RentACarDTO>) model.selectRentAcar(param_car);
		
		request.setAttribute("param_car_kubun", param_car_kubun);
		request.setAttribute("select01", select01);
		request.setAttribute("select02", select02);
		request.setAttribute("chkInDate", chkInDate);
		request.setAttribute("chkOutDate", chkOutDate);
		request.setAttribute("inTime", inTime);
		request.setAttribute("outTime", outTime);
		request.setAttribute("carList", carList);
		
		return "HCAM_rentACarMain.jsp";
	}
}