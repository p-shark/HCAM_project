package action;


import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CommonDAO;
import service.HotelService;
import service.MemberService;
import vo.ActionForward;
import vo.HcamMemDTO;
import vo.HcamPointDTO;
import vo.HotelBookingDTO;
import vo.HotelDTO;
import vo.HotelRoomDTO;
import vo.PntHistoryDTO;

public class HotelBookingSuccessAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		
		HcamMemDTO member = new HcamMemDTO();
		HcamPointDTO point = new HcamPointDTO();
		HotelDTO hotel = new HotelDTO();
		HotelRoomDTO htlRoom = new HotelRoomDTO();
		HotelBookingDTO htlBooking = new HotelBookingDTO();
		
		int mem_no = Integer.parseInt(request.getParameter("mem_no"));
		int htl_no = Integer.parseInt(request.getParameter("htl_no"));
		int hrm_no = Integer.parseInt(request.getParameter("hrm_no"));
		String chkIn = request.getParameter("chkIn");										// 예약일자
		String chkOut = request.getParameter("chkOut");										// 예약일자
		int htb_stayTerm = Integer.parseInt(request.getParameter("htb_stayTerm"));			// 머무는 기간
		int htb_brkfCnt = Integer.parseInt(request.getParameter("htb_brkfCnt"));			// 조식 총 수량
		int accum_point = Integer.parseInt(request.getParameter("accum_point"));			// 적립예정포인트
		int rlp_useYn = Integer.parseInt(request.getParameter("rlp_useYn"));				// 예약자와 투숙객 동일여부(0:같음/1:다름)
		
		String htb_rlpName = "";							// 실제투숙객 정보
		String htb_rlpEmail = "";							// 실제투숙객 정보
		String htb_rlpNation = "";							// 실제투숙객 정보
		String htb_rlpPhone = "";							// 실제투숙객 정보
					
		if(rlp_useYn == 1) {
			htb_rlpName = request.getParameter("htb_rlpName");
			htb_rlpEmail = request.getParameter("htb_rlpEmail");
			htb_rlpNation = request.getParameter("htb_rlpNation");
			htb_rlpPhone = request.getParameter("htb_rlpPhone");
		}
		
		htlBooking = new HotelBookingDTO();
		
		htlBooking.setHtl_no(htl_no);
		htlBooking.setHrm_no(hrm_no);
		htlBooking.setMem_no(mem_no);
		htlBooking.setHtb_rlpName(htb_rlpName);
		htlBooking.setHtb_rlpEmail(htb_rlpEmail);
		htlBooking.setHtb_rlpNation(htb_rlpNation);
		htlBooking.setHtb_rlpPhone(htb_rlpPhone);
		htlBooking.setHtb_chkIn(chkIn);
		htlBooking.setHtb_chkOut(chkOut);
		htlBooking.setHtb_stayTerm(htb_stayTerm);
		htlBooking.setHtb_brkfCnt(htb_brkfCnt);
		
		HotelService hotelsvc = new HotelService();
		MemberService membersvc = new MemberService();
		CommonDAO commonDao = new CommonDAO();
		
		ActionForward forward = new ActionForward();
		
		int htb_no = 0;		// 테스트하느라 1로 둠 0으로 변경 요망
		/* 호텔 예약 */
		htb_no = hotelsvc.insertHtlBooking(htlBooking);
		
		if(htb_no == 0){
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('이미 예약 진행된 객실입니다.');");
			out.println("history.back()");
			out.println("</script>");
		}
		else{
			/* 회원 정보 */
			member = membersvc.getMemberInfo(mem_no);
			/* 회원의 포인트 정보 */
			point = membersvc.getMemPoint(mem_no);
			/* 호텔 정보 */
			hotel = hotelsvc.getHotelInfo(htl_no);
			/* 호텔 객실 정보 */
			htlRoom = hotelsvc.getRoomInfo(htl_no, hrm_no);
			/* 호텔 예약 정보 */
			htlBooking = hotelsvc.getHtlBookingInfo(htb_no);
			
			PntHistoryDTO pntHistory = new PntHistoryDTO();
			
			/* 포인트 차감 */
			pntHistory.setPnt_no(point.getPnt_no());
			pntHistory.setPhs_kubun("htb");
			pntHistory.setPhs_kubunNo(htb_no);
			pntHistory.setPhs_kind("PNT01003");
			pntHistory.setPhs_historyAmt(htlBooking.getHtb_totalPrice());
			pntHistory.setPhs_comment("(호텔 예약) " + hotel.getHtl_name());
			commonDao.updatePoint(pntHistory);
			
			/* 포인트 적립 */
			pntHistory.setPhs_kind("PNT01002");
			pntHistory.setPhs_historyAmt(accum_point);
			pntHistory.setPhs_comment("(호텔 예약 적립) " + hotel.getHtl_name());
			commonDao.updatePoint(pntHistory);
			
			commonDao.dbClose();
			
			request.setAttribute("member", member);
			request.setAttribute("point", point);
			request.setAttribute("hotel", hotel);
			request.setAttribute("htlRoom", htlRoom);
			request.setAttribute("htlBooking", htlBooking);
			
			forward.setPath("view/HCAM_hotelBookingSuccess.jsp"); 
		}
		
		return forward;
	}

}
