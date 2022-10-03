package action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.HotelService;
import service.MemberService;
import vo.ActionForward;
import vo.HcamMemDTO;
import vo.HcamPointDTO;
import vo.HotelDTO;
import vo.HotelRoomDTO;
import vo.PageInfo;

public class HotelBookingAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HcamMemDTO member = new HcamMemDTO();
		HcamPointDTO point = new HcamPointDTO();
		HotelDTO hotel = new HotelDTO();
		HotelRoomDTO htlRoom = new HotelRoomDTO();
		
		int mem_no = Integer.parseInt(request.getParameter("mem_no"));
		int htl_no = Integer.parseInt(request.getParameter("htl_no"));
		int hrm_no = Integer.parseInt(request.getParameter("hrm_no"));
		
		String chkIn = request.getParameter("chkIn");
		String chkOut = request.getParameter("chkOut");
		
		chkIn = chkIn.replaceAll("-", "");
		chkOut = chkOut.replaceAll("-", "");
		
		HotelService hotelsvc = new HotelService();
		MemberService membersvc = new MemberService();
		
		/* 회원 정보 */
		member = membersvc.getMemberInfo(mem_no);
		/* 회원의 포인트 정보 */
		point = membersvc.getMemPoint(mem_no);
		/* 호텔 정보 */
		hotel = hotelsvc.getHotelInfo(htl_no);
		/* 호텔 객실 정보 */
		htlRoom = hotelsvc.getRoomInfo(htl_no, hrm_no);
		
		request.setAttribute("chkIn", chkIn);
		request.setAttribute("chkOut", chkOut);
		request.setAttribute("member", member);
		request.setAttribute("point", point);
		request.setAttribute("hotel", hotel);
		request.setAttribute("htlRoom", htlRoom);
		
		ActionForward forward = new ActionForward();
		forward.setPath("view/HCAM_hotelBooking.jsp");
		return forward;
	}

}
