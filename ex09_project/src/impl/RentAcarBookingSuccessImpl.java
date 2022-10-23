package impl;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

import controller.CommandInter;
import dao.CommonDAO;
import model.MypageModel;
import model.RentAcarModel;
import vo.HcamMemDTO;
import vo.PntHistoryDTO;
import vo.RacBookingDTO;
import vo.RentACarDTO;

public class RentAcarBookingSuccessImpl implements CommandInter{

	static RentAcarBookingSuccessImpl impl = new RentAcarBookingSuccessImpl();

	public static RentAcarBookingSuccessImpl instance(){
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
		int rlpCarPrice = Integer.parseInt(request.getParameter("rlpCarPrice"));		// 1시간당 실제 차량 가격
		int booking_totalPrice = Integer.parseInt(request.getParameter("num_booking_totalPrice"));		// 실제 결제 총 금액
		double cbk_rentTerm = Double.parseDouble(request.getParameter("cbk_stayTerm"));	// 머무는 기간
		int accum_point = Integer.parseInt(request.getParameter("accum_point"));	// 적립예정포인트
		int rlp_useYn = Integer.parseInt(request.getParameter("rlp_useYn"));		// 예약자와 투숙객 동일여부(0:같음/1:다름)
		
		String cbk_rlpName = "";							// 실제투숙객 정보
		String cbk_rlpEmail = "";							// 실제투숙객 정보
		String cbk_rlpNation = "";							// 실제투숙객 정보
		String cbk_rlpPhone = "";							// 실제투숙객 정보
					
		if(rlp_useYn == 1) {
			cbk_rlpName = request.getParameter("htb_rlpName");
			cbk_rlpEmail = request.getParameter("htb_rlpEmail");
			cbk_rlpNation = request.getParameter("htb_rlpNation");
			cbk_rlpPhone = request.getParameter("htb_rlpPhone");
		}
		System.out.println("cbk_rlpName222 >>> " + cbk_rlpName);
		/*System.out.println("mem_no >>> " + mem_no);
		System.out.println("pnt_no >>> " + pnt_no);
		System.out.println("car_no >>> " + car_no);
		System.out.println("chkInDate >>> " + chkInDate);
		System.out.println("chkOutDate >>> " + chkOutDate);
		System.out.println("inTime >>> " + inTime);
		System.out.println("outTime >>> " + outTime);
		System.out.println("cbk_stayTerm >>> " + cbk_stayTerm);
		System.out.println("accum_point >>> " + accum_point);
		System.out.println("rlp_useYn >>> " + rlp_useYn);*/
		
		// -, : 제거
		chkInDate = chkInDate.replaceAll("-", "");
		chkOutDate = chkOutDate.replaceAll("-", "");
		inTime = inTime.replaceAll(":", "");
		outTime = outTime.replaceAll(":", "");
		
		RacBookingDTO racBooking = new RacBookingDTO();
		
		racBooking.setCar_no(car_no);
		racBooking.setMem_no(mem_no);
		racBooking.setCbk_rlpName(cbk_rlpName);
		racBooking.setCbk_rlpEmail(cbk_rlpEmail);
		racBooking.setCbk_rlpNation(cbk_rlpNation);
		racBooking.setCbk_rlpPhone(cbk_rlpPhone);
		racBooking.setCbk_chkInDate(chkInDate);
		racBooking.setCbk_chkOutDate(chkOutDate);
		racBooking.setCbk_chkInTime(inTime);
		racBooking.setCbk_chkOutTime(outTime);
		racBooking.setCbk_rentTerm(cbk_rentTerm);
		racBooking.setCbk_rlpCarPrice(rlpCarPrice);
		racBooking.setCbk_totalPrice(booking_totalPrice);
		
		RentAcarModel car_model = RentAcarModel.instance();
		MypageModel mypage_model = MypageModel.instance();
		CommonDAO commonDao = new CommonDAO();
		
		// 원래는 int인데 예약이 진행된 차량이 아닌 경우에 sql에서 null로 넘어오기 때문에 int로 하지 않고 String으로 함
		String str_cbk_no = "";
		String already_bookingYN = "";
		
		/* 예약된 렌터카 정보 */
		// 뒤로가기 눌렀다가 다시 올때 예약 못하게 막는 용도
		str_cbk_no = car_model.checkBooking(racBooking);
		
		if(str_cbk_no != null){
			already_bookingYN = "Y";
		}
		else {
			already_bookingYN = "N";
			
			/* 렌터카 예약 */ 
			car_model.insertBooking(racBooking);
			
			/* 예약된 렌터카 정보 */
			// 방금 예약한 렌터카정보 가져오는 용동
			str_cbk_no = car_model.checkBooking(racBooking);
			int cbk_no = Integer.parseInt(str_cbk_no);		// 조회된 cbk_no가 String 이니까 int로 형변환 함
			
			/* 회원정보 */
			ArrayList<HcamMemDTO> memberInfo = (ArrayList<HcamMemDTO>) mypage_model.selectMemberInfo(mem_no);
			/* 포인트 정보 */
			ArrayList<Map<String, String>> pointInfo = (ArrayList<Map<String, String>>) mypage_model.selectPointInfo(pnt_no);
			/* 렌터카 select */
			ArrayList<RentACarDTO> car = (ArrayList<RentACarDTO>) car_model.getRentAcar(car_no);
			/* 렌터카 예약 정보 */
			racBooking = (RacBookingDTO) car_model.getRacBooking(cbk_no);
			
			PntHistoryDTO pntHistory = new PntHistoryDTO();
			
			/* 포인트 차감 */
			pntHistory.setPnt_no(pnt_no);
			pntHistory.setPhs_kubun("cbk");
			pntHistory.setPhs_kubunNo(racBooking.getCbk_no());
			pntHistory.setPhs_kind("PNT01003");
			pntHistory.setPhs_historyAmt(racBooking.getCbk_totalPrice());
			pntHistory.setPhs_comment("(렌터카 예약) " + car.get(0).getCar_name());
			commonDao.updatePoint(pntHistory);
			
			/* 포인트 적립 */
			pntHistory.setPhs_kind("PNT01002");
			pntHistory.setPhs_historyAmt(accum_point);
			pntHistory.setPhs_comment("(렌터카 예약 적립) " + car.get(0).getCar_name());
			commonDao.updatePoint(pntHistory);
			
			commonDao.dbClose();
			
			request.setAttribute("memberInfo", memberInfo);
			request.setAttribute("pointInfo", pointInfo);
			request.setAttribute("car", car);
			request.setAttribute("racBooking", racBooking);
		}
		
		request.setAttribute("already_bookingYN", already_bookingYN);
		
		return "HCAM_rentAcarBookingSuccess.jsp";
	}
}