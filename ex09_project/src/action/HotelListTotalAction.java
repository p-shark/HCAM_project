package action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.HotelService;
import vo.ActionForward;
import vo.HotelDTO;
import vo.PageInfo;

public class HotelListTotalAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// hotel 전체 list 
		ArrayList<HotelDTO> hotelList = new ArrayList<HotelDTO>();
		// 호텔 부가정보 list
		ArrayList<TreeMap<String, String>> hotelAdnInfos = new ArrayList<>();
		
		// 현재일자 setting
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		String chekIn = sdf.format(cal.getTime());
		cal.add(Calendar.DATE, 1);
		String checOut = sdf.format(cal.getTime());
		
		// 국가, 지역
		String select01 = "1";
		String select02 = "1";
		
		if(request.getParameter("select01") != null) {
			select01 = request.getParameter("select01");
		}
		if(request.getParameter("select02") != null) {
			select02 = request.getParameter("select02");
		}
		// 상단바 검색
		if(request.getParameter("top_chkIn") != null) {
			chekIn = request.getParameter("top_chkIn");
		}
		if(request.getParameter("top_chkOut") != null) {
			checOut = request.getParameter("top_chkOut");
		}
		// 메인 검색
		if(request.getParameter("main_htl_chkIn") != null) {
			chekIn = request.getParameter("main_htl_chkIn");
		}
		if(request.getParameter("main_htl_chkOut") != null) {
			checOut = request.getParameter("main_htl_chkOut");
		}
		
		// 페이지 처리를 위한 변수
		int page = 1;
		int limit = 10;
		
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		
		HotelService hotelSvc = new HotelService();
		
		/* 페이지 처리를 위한 호텔 count */
		int listCount = hotelSvc.getListCount(select01, select02, chekIn, checOut);
		/* 호텔 전체 목록 */
		hotelList = hotelSvc.getHotelAll(select01, select02, chekIn, checOut, page, limit);
		/* 호텔 부가정보 */
		hotelAdnInfos = hotelSvc.getHotelAdnInfo(select01, select02, chekIn, checOut, page, limit);
		
		// 페이지 처리를 위한 변수
		int maxPage = (int) ((double)listCount/limit + 0.95);
		int startPage = (((int) ((double)page / 10 + 0.9)) - 1) * 10 + 1;
		int endPage = startPage+10-1;
		
		if (endPage > maxPage) endPage = maxPage;
		
		PageInfo pageInfo = new PageInfo();
		pageInfo.setEndPage(endPage);
		pageInfo.setListCount(listCount);
		pageInfo.setMaxPage(maxPage);
		pageInfo.setPage(page);
		pageInfo.setStartPage(startPage);
		
		request.setAttribute("select01", select01);		// 국가
		request.setAttribute("select02", select02);		// 지역
		request.setAttribute("chekIn", chekIn);
		request.setAttribute("checOut", checOut);
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("hotelList", hotelList);
		request.setAttribute("hotelAdnInfos", hotelAdnInfos);
		
		ActionForward forward = new ActionForward();
		forward.setPath("view/HCAM_hotelMain.jsp");
		return forward;
	}

}
