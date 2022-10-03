package action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.HotelService;
import vo.ActionForward;
import vo.HotelDTO;
import vo.HotelRoomDTO;

public class HotelRoomListAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HotelDTO hotel = new HotelDTO();
		ArrayList<HotelRoomDTO> htlRoomList = new ArrayList<HotelRoomDTO>();
		
		// 현재일자 setting
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		String chkIn = sdf.format(cal.getTime());
		cal.add(Calendar.DATE, 1);
		String chkOut = sdf.format(cal.getTime());
				
		// 국가, 지역
		String select01 = "1";
		String select02 = "1";
		
		int htl_no = Integer.parseInt(request.getParameter("htl_no"));
		
		if(request.getParameter("select01") != null) {
			select01 = request.getParameter("select01");
		}
		if(request.getParameter("select02") != null) {
			select02 = request.getParameter("select02");
		}
		if(request.getParameter("top_chkIn") != null) {
			chkIn = request.getParameter("top_chkIn");
		}
		if(request.getParameter("top_chkOut") != null) {
			chkOut = request.getParameter("top_chkOut");
		}
		
		HotelService hotelsvc = new HotelService();
		
		/* 호텔 정보 */
		hotel = hotelsvc.getHotelInfo(htl_no);
		/* 각 호텔의 전체 객실 정보 */
		htlRoomList = hotelsvc.getRoomAll(htl_no, chkIn, chkOut);
				
		request.setAttribute("select01", select01);		// 국가
		request.setAttribute("select02", select02);		// 지역
		request.setAttribute("chkIn", chkIn);
		request.setAttribute("chkOut", chkOut);
		request.setAttribute("htl_no", htl_no);
		request.setAttribute("hotel", hotel);
		request.setAttribute("htlRoomList", htlRoomList);
		
		ActionForward forward = new ActionForward();
		forward.setPath("view/HCAM_hotelRoom.jsp");
		return forward;
	}

}
