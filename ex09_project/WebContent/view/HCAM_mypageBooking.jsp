<%@page import="dao.CommonDAO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="dao.CommonDAO" id="commonDao"></jsp:useBean>
<jsp:useBean class="dao.HcamFileDAO" id="fileDao"></jsp:useBean>
<%
	//로그인한 회원정보
	String id = (String) session.getAttribute("id");
	// 세션에 저장된 mem_no 값 가져오기 
	int mem_no = 0;
	if(session.getAttribute("mem_no") != null) {
		mem_no = Integer.parseInt(String.valueOf(session.getAttribute("mem_no")));
	}
	String mem_name = "";
	if(session.getAttribute("mem_name") != null) {
		mem_name = String.valueOf(session.getAttribute("mem_name"));
	}
	
	/* 호텔 예약 정보 */
	ArrayList<Map<String, String>> htlBooking = (ArrayList<Map<String, String>>) request.getAttribute("htlBooking");
	
	/* 렌터카 예약 정보 */
	ArrayList<Map<String, String>> carBooking = (ArrayList<Map<String, String>>) request.getAttribute("carBooking");
	
	// 금액 포맷
	DecimalFormat df = new DecimalFormat("#,###");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
	$(function() {
		/* 오른쪽 tab */
		$('ul.inner_tab_tit li').click(function() {
			
			var inner_onTab = $(this).attr('data-tab');
			$('ul.inner_tab_tit li').removeClass('inner_on');
			$('.inner_cnt').removeClass('inner_on');
			$(this).addClass('inner_on');
			$('#' + inner_onTab).addClass('inner_on');
	
		})
	});
</script>
<body>
	<div class="right_inner">
		<div class="right_top">
			<div class="inner_top_left">
				<div>HCAM</div>
			</div>
			<div class="inner_top_right">
				<div><%=mem_name %>님, VIP 등급이 되어보세요!</div>
				<div>2건의 숙박을 더 완료해 VIP 할인과 혜택을 누려보세요!</div>
			</div>
		</div>
		<div class="inner_content">
			<div class="tab_navi">
				<ul class="inner_tab_tit">
					<li class="inner_on" data-tab="inner_tab1">
						<span class="inner_tab_icon"><i class="fa-solid fa-hotel"></i></span>
						<span class="inner_tab_title">호텔 예약관리</span>
					</li>
					<!-- <li data-tab="inner_tab2">
						<span class="inner_tab_icon"><i class="fa-solid fa-campground"></i></span>
						<span class="inner_tab_title">캠핑 예약관리</span>
					</li> -->
					<li data-tab="inner_tab3">
						<span class="inner_tab_icon"><i class="fa-solid fa-car-rear"></i></span>
						<span class="inner_tab_title">렌터카 예약관리</span>
					</li>
				</ul>
			</div>
			<!-- 호텔 예약관리 -->
			<div id="inner_tab1" class="inner_cnt inner_on">
				<% for(int i=0; i<htlBooking.size(); i++) { %>
					<div class="tab_content">
						<div class="tab_hotel_content">
							<div class="tab_hotel_bookingDate">
								<span>예약일시: </span>
								<span><%=htlBooking.get(i).get("fmt_htb_date") %></span>
							</div>
							<div class="tab_hotelBooingInfo">
								<div class="tab_hotel_top">
									<div class="tab_hotel_left">
										<img alt="" src="<%=htlBooking.get(i).get("file_path") %>">
									</div>
									<div class="tab_hotel_center">
										<div class="tab_hotelCnter_top">
											<div class="tab_hotel_name"><%=htlBooking.get(i).get("htl_name") %></div>
											<div class="tab_hotel_no">
												<span>예약번호: </span>
												<span><%=String.valueOf(htlBooking.get(i).get("htb_no")) %></span>
											</div>
											<div class="tab_hotelComple">
												<% if("Y".equals(htlBooking.get(i).get("bookingComple"))) { %>
													<span class="tab_hotelBlue"><i class="fa-solid fa-circle-check"></i></span>
													<span class="tab_hotelBlue">투숙완료</span>
												<% } else { %>
													<span class="tab_hotelGreen"><i class="fa-solid fa-user-clock"></i></span>
													<span class="tab_hotelGreen">예약중</span>
												<% } %>
											</div>
										</div>
										<div class="tab_room_name"><%=htlBooking.get(i).get("hrm_name") %></div>
										<div class="tab_brfk_amt">
											<span>조식 총 금액: </span>
											<span>₩ <%=df.format(htlBooking.get(i).get("htb_brkfPrice")) %></span>
										</div>
									</div>
									<div class="tab_hotel_right">
										<div class="tab_hotel_chkInOut">
											<div class="tab_hotel_chk border_left">
												<div class="tab_chk_title">체크인</div>
												<div class="tab_chk_date">
													<div class="tab_chk_day"><%=(htlBooking.get(i).get("htb_chkIn")).substring(6) %></div>
													<div class="tab_chk_monYr">
														<div><%=(htlBooking.get(i).get("htb_chkIn")).substring(4,6) %>월</div>
														<div><%=(htlBooking.get(i).get("htb_chkIn")).substring(0,4) %></div>
													</div>
												</div>
											</div>
											<div class="tab_hotel_chk">
												<div class="tab_chk_title">체크아웃</div>
												<div class="tab_chk_date">
													<div class="tab_chk_day"><%=(htlBooking.get(i).get("htb_chkOut")).substring(6) %></div>
													<div class="tab_chk_monYr">
														<div><%=(htlBooking.get(i).get("htb_chkOut")).substring(4,6) %>월</div>
														<div><%=(htlBooking.get(i).get("htb_chkOut")).substring(0,4) %></div>
													</div>
												</div>
											</div>
										</div>
										<div class="tab_hotel_totalAmt">₩ <%=df.format(htlBooking.get(i).get("htb_totalPrice")) %></div>
									</div>
								</div>
								<div class="tab_hotel_btn">
									<a class="tab_hotelBtn_detail">자세히 보기</a>
									<% if("N".equals(htlBooking.get(i).get("bookingComple"))) { %>
										<a class="tab_hotelBtn_cancel" href="hotelBookingCancel.ho?htb_no=<%=String.valueOf(htlBooking.get(i).get("htb_no")) %>">예약취소</a>
									<% } %>
								</div>
							</div>
						</div>
					</div>
				<% } %>
			</div>
			<!-- <div id="inner_tab2" class="inner_cnt">
				<h2>오늘의 할일</h2>
				<ul>
					<li>홍삼먹기</li>
					<li>연차</li>
				</ul>
			</div> -->
			<!-- 렌터카 예약관리 -->
			<div id="inner_tab3" class="inner_cnt">
				<% for(int i=0; i<carBooking.size(); i++) { %>
					<div class="tab_content">
						<div class="tab_hotel_content">
							<div class="tab_hotel_bookingDate">
								<span>예약일시: </span>
								<span><%=carBooking.get(i).get("fmt_cbk_date") %></span>
							</div>
							<div class="tab_hotelBooingInfo">
								<div class="tab_hotel_top">
									<div class="tab_car_left">
										<img alt="" src="<%=carBooking.get(i).get("file_path") %>">
									</div>
									<div class="tab_car_center">
										<div class="tab_hotelCnter_top">
											<div class="tab_hotel_name"><%=carBooking.get(i).get("car_name") %></div>
											<div class="tab_hotel_no">
												<span>예약번호: </span>
												<span><%=String.valueOf(carBooking.get(i).get("cbk_no")) %></span>
											</div>
											<div class="tab_hotelComple">
												<% if("Y".equals(carBooking.get(i).get("bookingComple"))) { %>
													<span class="tab_hotelBlue"><i class="fa-solid fa-circle-check"></i></span>
													<span class="tab_hotelBlue">이용완료</span>
												<% } else { %>
													<span class="tab_hotelGreen"><i class="fa-solid fa-user-clock"></i></span>
													<span class="tab_hotelGreen">예약중</span>
												<% } %>
											</div>
										</div>
										<div class="tab_car_location">
											<span>
												<%=commonDao.getCodeName(carBooking.get(i).get("car_location")) %>
												<%=commonDao.getCodeName(carBooking.get(i).get("car_branch")) %>
												지점
											</span>
										</div>
										<div class="tab_car_option">
											<span><%=commonDao.getCodeName(carBooking.get(i).get("car_kubun")) %> / </span>
											<span><%=commonDao.getCodeName(carBooking.get(i).get("car_fuelKubun")) %> </span>
										</div>
									</div>
									<div class="tab_hotel_right">
										<div class="tab_hotel_chkInOut">
											<div class="tab_hotel_chk border_left">
												<div class="tab_chk_title">대여일시</div>
												<div class="tab_chk_date">
													<div class="tab_chk_day"><%=(carBooking.get(i).get("cbk_chkInDate")).substring(6) %></div>
													<div class="tab_chk_monYr">
														<div><%=(carBooking.get(i).get("cbk_chkInDate")).substring(4,6) %>월</div>
														<div><%=(carBooking.get(i).get("cbk_chkInDate")).substring(0,4) %></div>
													</div>
												</div>
												<div class="tab_chk_time">
													<span><%=(carBooking.get(i).get("cbk_chkInTime")).substring(0,2) %></span>
													<span>:</span>
													<span><%=(carBooking.get(i).get("cbk_chkInTime")).substring(2) %></span>
												</div>
											</div>
											<div class="tab_hotel_chk">
												<div class="tab_chk_title">반납일시</div>
												<div class="tab_chk_date">
													<div class="tab_chk_day"><%=(carBooking.get(i).get("cbk_chkOutDate")).substring(6) %></div>
													<div class="tab_chk_monYr">
														<div><%=(carBooking.get(i).get("cbk_chkOutDate")).substring(4,6) %>월</div>
														<div><%=(carBooking.get(i).get("cbk_chkOutDate")).substring(0,4) %></div>
													</div>
												</div>
												<div class="tab_chk_time">
													<span><%=(carBooking.get(i).get("cbk_chkOutTime")).substring(0,2) %></span>
													<span>:</span>
													<span><%=(carBooking.get(i).get("cbk_chkOutTime")).substring(2) %></span>
												</div>
											</div>
										</div>
										<div class="tab_hotel_totalAmt">₩ <%=df.format(carBooking.get(i).get("cbk_totalPrice")) %></div>
									</div>
								</div>
								<div class="tab_hotel_btn">
									<a class="tab_hotelBtn_detail">자세히 보기</a>
									<% if("N".equals(carBooking.get(i).get("bookingComple"))) { %>
										<a class="tab_hotelBtn_cancel" href="car.do?command=carBookingCancel&cbk_no=<%=String.valueOf(carBooking.get(i).get("cbk_no")) %>">예약취소</a>
									<% } %>
								</div>
							</div>
						</div>
					</div>
				<% } %>
			</div>
		</div>
	</div>

</body>
</html>