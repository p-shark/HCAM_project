package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CommonDAO;
import service.HotelService;
import vo.ActionForward;
import vo.PntHistoryDTO;

public class HotelBookingCancelAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		
		int htb_no = Integer.parseInt(request.getParameter("htb_no"));
		
		HotelService hotelsvc = new HotelService();
		CommonDAO commonDao = new CommonDAO();
		
		ActionForward forward = new ActionForward();
	
		/* 호텔 예약 취소 */
		int deleteCount = hotelsvc.cancelHtlBooking(htb_no);
		
		// 예약 취소 정상이면 포인트 복구
		if(deleteCount > 0) {
			PntHistoryDTO pntHistory = new PntHistoryDTO();
			pntHistory.setPhs_kubun("htb");
			pntHistory.setPhs_kubunNo(htb_no);
			
			/* 예약,주문 취소로 인한 포인트 복구 */
			commonDao.setBackPoint(pntHistory.getPhs_kubun(), pntHistory.getPhs_kubunNo());
		}
		
		commonDao.dbClose();
		
		forward.setPath("view/HCAM_mypageMain.jsp"); 
		
		return forward;
	}

}
