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

public class HotelMainBySearchingAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ArrayList<HotelDTO> hotelList = new ArrayList<HotelDTO>();
		ArrayList<TreeMap<String, String>> hotelAdnInfos = new ArrayList<TreeMap<String, String>>();
		
		// 페이지 처리를 위한 변수
		int page = 1;
		int limit = 8;
		
		if(request.getParameter("pageNo") != null) {
			page = Integer.parseInt(request.getParameter("pageNo"));
		}
				
		TreeMap<Integer, String> searchList = new TreeMap<>();
		searchList.put(1, request.getParameter("select01"));
		searchList.put(2, request.getParameter("select02"));
		searchList.put(3, request.getParameter("top_chkIn"));
		searchList.put(4, request.getParameter("top_chkOut"));
		searchList.put(5, request.getParameter("lctName"));
		searchList.put(6, request.getParameter("min_fee"));
		searchList.put(7, request.getParameter("max_fee"));
		searchList.put(8, request.getParameter("grade01"));
		searchList.put(9, request.getParameter("grade02"));
		searchList.put(10, request.getParameter("grade03"));
		searchList.put(11, request.getParameter("service01"));
		searchList.put(12, request.getParameter("service02"));
		searchList.put(13, request.getParameter("service03"));
		searchList.put(14, request.getParameter("service04"));
		searchList.put(15, request.getParameter("service05"));
		searchList.put(16, request.getParameter("review_score"));
		searchList.put(17, request.getParameter("sortBy"));
		
		HotelService hotelsvc = new HotelService();
		
		int listCount = 0;
		/* 좌측 검색 페이지 처리를 위한 호텔 count */
		listCount = hotelsvc.getListCountBySearching(searchList);
		/* 좌측 검색 조건에 따른 호텔 정보 */
		hotelList = hotelsvc.getHotelBysearch(searchList, page, limit);
		/* 좌측 검색 조건에 따른 호텔 부가정보 */
		hotelAdnInfos = hotelsvc.getHotelAdnInfoBySearch(searchList, page, limit);
		
		// 페이지 처리를 위한 변수
		int maxPage = (int) ((double)listCount/limit + 0.95);
		int startPage = (((int) ((double)page / 8 + 0.9)) - 1) * 8 + 1;
		int endPage = startPage+10-1;
		
		if (endPage > maxPage) endPage = maxPage;
		
		PageInfo pageInfo = new PageInfo();
		pageInfo.setEndPage(endPage);
		pageInfo.setListCount(listCount);
		pageInfo.setMaxPage(maxPage);
		pageInfo.setPage(page);
		pageInfo.setStartPage(startPage);
		
		request.setAttribute("hotelList", hotelList);
		request.setAttribute("hotelAdnInfos", hotelAdnInfos);
		request.setAttribute("pageInfo", pageInfo);
				
		ActionForward forward = new ActionForward();
		forward.setPath("view/HCAM_hotelMainBySearching.jsp");
		return forward;
	}

}
