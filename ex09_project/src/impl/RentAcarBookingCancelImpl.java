package impl;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

import controller.CommandInter;
import dao.CommonDAO;
import model.MypageModel;
import model.RentAcarModel;
import vo.PntHistoryDTO;

public class RentAcarBookingCancelImpl implements CommandInter{

	static RentAcarBookingCancelImpl impl = new RentAcarBookingCancelImpl();

	public static RentAcarBookingCancelImpl instance(){
		return impl;
	}
	
	public String showData(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		
		int cbk_no = Integer.parseInt(request.getParameter("cbk_no"));
		
		RentAcarModel car_model = RentAcarModel.instance();
		CommonDAO commonDao = new CommonDAO();
		
		int result = car_model.cancelBooking(cbk_no);
		
		if(result > 0) {
			PntHistoryDTO pntHistory = new PntHistoryDTO();
			pntHistory.setPhs_kubun("cbk");
			pntHistory.setPhs_kubunNo(cbk_no);
			
			/* 예약,주문 취소로 인한 포인트 복구 */
			commonDao.setBackPoint(pntHistory.getPhs_kubun(), pntHistory.getPhs_kubunNo());
		}
		
		commonDao.dbClose();
		
		return "HCAM_mypageMain.jsp";
	}
}