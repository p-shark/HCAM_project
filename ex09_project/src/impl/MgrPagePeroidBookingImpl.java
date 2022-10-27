package impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

import controller.CommandInter;
import model.MgrpageModel;
import model.MypageModel;

public class MgrPagePeroidBookingImpl implements CommandInter{

	static MgrPagePeroidBookingImpl impl = new MgrPagePeroidBookingImpl();

	public static MgrPagePeroidBookingImpl instance(){
		return impl;
	}
	
	public String showData(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String mgr_no = request.getParameter("mem_no");
		
		Map<String, String> param_graph = new HashMap<String, String>();
		param_graph.put("mgr_no", mgr_no);
		param_graph.put("date_kubun", "day");
		
		MgrpageModel model = MgrpageModel.instance();
		
		/* 일/주/월 별 호텔,렌터카 예약 건수 */
		ArrayList<Map<String, String>> peroidBooking = (ArrayList<Map<String, String>>) model.selectPeroidBooking(param_graph);
		
		request.setAttribute("peroidBooking", peroidBooking);
		
		return "HCAM_mgrpagePeroidBooking.jsp";
	}
}