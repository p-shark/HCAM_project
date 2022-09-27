<%@page import="vo.PageInfo"%>
<%@page import="java.util.Map"%>
<%@page import="vo.HotelDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.TreeMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="dao.CommonDAO" id="commonDao"></jsp:useBean>
<jsp:useBean class="dao.HcamFileDAO" id="fileDao"></jsp:useBean>
<%
	//로그인한 회원정보
	String id = (String) session.getAttribute("id");
	//세션에 저장된 mem_no 값 가져오기 
	int mem_no = 0;
	if(session.getAttribute("mem_no") != null) {
		mem_no = Integer.parseInt(String.valueOf(session.getAttribute("mem_no")));
	}
	
	/* 좌측 검색 조건에 따른 호텔 정보 */
	ArrayList<HotelDTO> hotelList = (ArrayList<HotelDTO>) request.getAttribute("hotelList");
	
	/* 좌측 검색 조건에 따른 호텔 부가정보 */
	ArrayList<TreeMap<String, String>> hotelAdnInfos = (ArrayList<TreeMap<String, String>>) request.getAttribute("hotelAdnInfos");
	
	// 페이징 처리
	PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
	
	int pageNo = 1;
	
	// 페이징 처리를 위한 변수
	int listCount=pageInfo.getListCount();
	int nowPage=pageInfo.getPage();
	int maxPage=pageInfo.getMaxPage();
	int startPage=pageInfo.getStartPage();
	int endPage=pageInfo.getEndPage();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="right_content">
		<input type="hidden" name="endPage" value="<%=endPage %>">	<!-- 마지막 페이지 -->
		<% for(int i=0; i<hotelList.size(); i++) { %>
			<div class="each_content">
				<div class="content_left">
					<%
						ArrayList<String> fileList = fileDao.getFileList("htl", hotelList.get(i).getHtl_no(), pageNo);
						if(fileList.size() == 0) {
					%>
							<div class="div_main_image">
								<%-- <div><%=hotelList.get(i).getHtl_no() %></div> --%>
								<img alt="" src="image/main_f_sebu.jpg">
							</div>
							<div class="div_sub_image">
								<img alt="" src="image/main_f_sebu.jpg">
								<img alt="" src="image/main_f_sebu.jpg">
								<img alt="" src="image/main_f_sebu.jpg">
								<img alt="" src="image/main_f_sebu.jpg">
							</div>
					<%		
						}
						else {
							for(int j=0; j<5; j++) {
								if(j == 0) {
									out.println("<div class='div_main_image'>");
									/* out.println("<div>" + hotelList.get(i).getHtl_no() + "</div>"); */
									out.println("<img src='" + fileList.get(j) + "'>");
									out.println("</div>");
									out.println("<div class='div_sub_image'>");
								}
								else {
									out.println("<img src='" + fileList.get(j) + "'>");
								}
							}
							out.println("</div>");
						}
					%>
				</div>
				<div class="content_center">
					<div class="hotelName">
						<font><%=hotelList.get(i).getHtl_name() %></font>
					</div>
					<div class="hotelGrade">
						<% for(int j=0; j<hotelList.get(i).getHtl_grade(); j++) { %>
							<img class="star_icon" alt="" src="image/icon/star_icon.png">
						<% } %>
					</div>
					<div class="hotelLct">
						<div>
							<img alt="" src="image/icon/location_pin_icon.png">
						</div>
						<div>
							<%=commonDao.getCodeName(hotelList.get(i).getHtl_nation()) %>
							<%=commonDao.getCodeName(hotelList.get(i).getHtl_location()) %>
						</div>
					</div>
					<div class="hotelFct">
						<% 
							if(hotelList.get(i).getHtl_brkf() == 1) {
								out.println("<div>조식</div>");
							}
							if(hotelList.get(i).getHtl_pool() == 1) {
								out.println("<div>수영장</div>");
							}
							if(hotelList.get(i).getHtl_park() == 1) {
								out.println("<div>주차가능</div>");
							}
							if(hotelList.get(i).getHtl_conv() == 1) {
								out.println("<div>편의시설</div>");
							}
							if(hotelList.get(i).getHtl_lugg() == 1) {
								out.println("<div>수하물보관</div>");
							}
						%>
					</div>
				</div>
				<%
					TreeMap<String, String> hotelTreeMap = hotelAdnInfos.get(i);
					String htl_no = "";			// htl_no
					String review_cnt = "";		// 리뷰 개수
					String avg_sco = "";		// 평점
					String avg_status = "";		// 평점 별 상태
					String min_price = "";		// 해당 호텔의 최저가 객실 요금
					String remain_cnt = "";		// 해당 일자의 남은 객실
					String dis_price = "";		// 해당 호텔의 최저가 객실의 할인된 요금
					for(Map.Entry<String, String> hotelAdnInfo : hotelTreeMap.entrySet()) {
						if("htl_no".equals(hotelAdnInfo.getKey())) {
							htl_no = hotelAdnInfo.getValue();
						}
						if("review_cnt".equals(hotelAdnInfo.getKey())) {
							review_cnt = hotelAdnInfo.getValue();
						}
						if("avg_sco".equals(hotelAdnInfo.getKey())) {
							avg_sco = hotelAdnInfo.getValue();
						}
						if("avg_status".equals(hotelAdnInfo.getKey())) {
							avg_status = hotelAdnInfo.getValue();
						}
						if("min_price".equals(hotelAdnInfo.getKey())) {
							min_price = hotelAdnInfo.getValue();
						}
						if("remain_cnt".equals(hotelAdnInfo.getKey())) {
							remain_cnt = hotelAdnInfo.getValue();
						}
						if("dis_price".equals(hotelAdnInfo.getKey())) {
							dis_price = hotelAdnInfo.getValue();
						}
					}
				%>
				<div class="content_right">
					<div class="content_review">
						<div class="review_right">	
							<div><%=avg_sco %></div>
						</div>
						<div class="review_left">
							<div><%=avg_status %></div>
							<div><%=review_cnt %> 건의 이용후기</div>
						</div>
					</div>
					<div class="content_remain">
						<div>이 요금 객실 <%=remain_cnt %>개 남음</div>
					</div>
					<div class="content_priceText">
						<div>1박당 요금 시작가</div>
					</div>
					<div class="content_price">
						<div><%=min_price %></div>
					</div>
					<div class="content_disPrice">
						<div>₩<%=dis_price %></div>
					</div>
					<div class="content_freeText">
						<div>예약 무료 취소</div>
					</div>
					<div class="content_btn_room">
						<button>
							<div>객실 선택하기</div>
							<div>
								<svg width="1em" height="1em" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
									<path d="M15.485 12L6.293 2.808a1 1 0 0 1 1.414-1.415l9.9 9.9a1 1 0 0 1 0 1.414l-9.9 9.9a1 1 0 0 1-1.414-1.415L15.485 12z"></path>
								</svg>									
							</div>
						</button>
					</div>
				</div>
			</div>
		<% } %>
		<% if(nowPage < maxPage){ %>
			<div class="append_hotel">
				<button onclick="fn_appendHotel();">호텔 더보기 (More)</button>
			</div>
		<% } %>
	</div>
	
	<%
		commonDao.dbClose();
		fileDao.dbClose();
	%>
</body>
</html>