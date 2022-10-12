<%@page import="vo.RacBookingDTO"%>
<%@page import="vo.RentACarDTO"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.HcamMemDTO"%>
<%@page import="vo.HcamPointDTO"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="dao.CommonDAO" id="commonDao"></jsp:useBean>
<jsp:useBean class="dao.HcamFileDAO" id="fileDao"></jsp:useBean>
<%
	request.setCharacterEncoding("utf-8");

	//로그인한 회원정보
	String id = (String) session.getAttribute("id");
	// 세션에 저장된 mem_no 값 가져오기 
	int mem_no = 0;
	if(session.getAttribute("mem_no") != null) {
		mem_no = Integer.parseInt(String.valueOf(session.getAttribute("mem_no")));
	}
	
	// 예약 진행된 차량여부
	String already_bookingYN = (String) request.getAttribute("already_bookingYN");
	/* 회원정보 */
	ArrayList<HcamMemDTO> memberInfo = (ArrayList<HcamMemDTO>) request.getAttribute("memberInfo");
	/* 포인트 정보 */
	ArrayList<Map<String, String>> pointInfo = (ArrayList<Map<String, String>>) request.getAttribute("pointInfo");
	/* 렌터카 select */
	ArrayList<RentACarDTO> car = (ArrayList<RentACarDTO>) request.getAttribute("car");
	/* 호텔 예약 정보 */
	RacBookingDTO racBooking = (RacBookingDTO) request.getAttribute("racBooking");
	
	// 금액 포맷
	DecimalFormat df = new DecimalFormat("#,###");
	// 전화번호 양식
	String phone_number = memberInfo.get(0).getMem_phone();
	phone_number = phone_number.substring(0,3) + "-" + phone_number.substring(3,7) 
				 + "-" + phone_number.substring(7);
	// 날짜 형식
	String fmt_checkIn = racBooking.getCbk_chkInDate().substring(0,4) + "년 " + racBooking.getCbk_chkInDate().substring(4,6) + "월 " + racBooking.getCbk_chkInDate().substring(6) + "일";
	String fmt_checkOut = racBooking.getCbk_chkOutDate().substring(0,4) + "년 " + racBooking.getCbk_chkOutDate().substring(4,6) + "월 " + racBooking.getCbk_chkOutDate().substring(6) + "일";
	String fmt_inTime = racBooking.getCbk_chkInTime().substring(0,2) + ":" + racBooking.getCbk_chkInTime().substring(2);
	String fmt_outTime = racBooking.getCbk_chkOutTime().substring(0,2) + ":" + racBooking.getCbk_chkOutTime().substring(2);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- jquery -->
<script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script>
<!-- css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/rentAcarBookingSuccess.css">
<!-- icon -->
<script src="https://kit.fontawesome.com/ae515d5c73.js" crossorigin="anonymous"></script>
<title>Insert title here</title>
</head>
<script>
	$(document).ready(function() {
		
		if($('input[name=already_bookingYN]').val() == "Y") {
			alert('이미 예약 진행된 차량입니다.');
			history.back();
		}
		else {
			fn_chgTopBooking(3);
		}
	});
	
	// 결제하기 버튼 클릭 시 상단 바 css 변경
	function fn_chgTopBooking(kubun) {
		var fmt_pointBalance = $("input[name='fmt_pointBalance']").val();		// 결제 총 합계
		
		$.ajax({
			url: "view/HCAM_bookingTop.jsp",
			type:'POST',
			dataType: "text",
			async:false,
			data: "title=렌터카" +
				  "&kubun=" + kubun,
			success: function(result) {
				$("#div_topContent").html(result);
			},
			error: function(request, error) {
				alert(request.status + " / " + request.responseText + " / " + error);
			}
		});
	}
</script>
<body>
	<input type="hidden" name="already_bookingYN" value="<%= already_bookingYN%>">
	
	<% if(already_bookingYN == "N") { %>
	
		<!-- header -->
		<jsp:include page="../include/HCAM_header.jsp"/>
		
		<div id="div_topContent">
			<input type="hidden" name="fmt_pointBalance" value="<%=pointInfo.get(0).get("pnt_balance") %>">
		</div>
		
		<div id="div_content">
			<div id="div_compleTitle">
				<div>
					<img alt="" src="image/icon/hotel_bookingSuceess.png">
				</div>
				<div>렌터카 예약이 완료되었습니다.</div>
			</div>
			<div class="div_line"></div>
			<div id="div_hoteContent">
				<div id="top_hoteContent">
					<div>
						<span>렌터카 예약일시:</span>
						<span><%=racBooking.getCbk_date() %></span>
					</div>
				</div>
				<div id="mid_hoteContent">
					<div id="hotel_image">
						<img alt="" src="<%=fileDao.getFilePath("car", car.get(0).getCar_no()) %>">
					</div>
					<div id="hotel_detail">
						<div id="hotel_name"><%=car.get(0).getCar_name() %></div>
						<div id="room_name"><%=car.get(0).getCar_name() %></div>
					</div>
				</div>
				<div class="div_line"></div>
				<div id="botm_hoteContent">
					<div id="botm_left">
						<div class="botm_left_top">대여일시</div>
						<div class="botm_left_mid"><%=fmt_checkIn %></div>
						<div class="botm_left_botm"><%=fmt_inTime %></div>
					</div>
					<div id="botm_center">
						<div><%=racBooking.getCbk_rentTerm() %> 시간</div>
					</div>
					<div id="botm_right">
						<div class="botm_left_top">반납일시</div>
						<div class="botm_left_mid"><%=fmt_checkOut %></div>
						<div class="botm_left_botm"><%=fmt_outTime %></div>
					</div>
				</div>
			</div>
			<div id="div_member">
				<div id="member_title">
					<span><i class="fa-regular fa-address-card"></i></span>
					<span>연락처 정보</span>
				</div>
				<div id="member_info">
					<div class="input_title">
						<div>
							<span>이름</span><span>*</span>
						</div>
						<div>
							<span>이메일</span><span>*</span>
						</div>
					</div>
					<div class="input_context">
						<div>
							<input type="text" readonly="readonly" value="<%=memberInfo.get(0).getMem_name() %>">
						</div>
						<div>
							<input type="text" readonly="readonly" value="<%=memberInfo.get(0).getMem_email() %>">
						</div>
					</div>
					<div class="input_title">
						<div>
							<span>전화번호</span><span>*</span>
						</div>
						<div>
							<span>거주 국가/지역</span><span>(선택사항)</span>
						</div>
					</div>
					<div class="input_context">
						<div>
							<input type="text" readonly="readonly" value="<%=memberInfo.get(0).getMem_phone() %>">
						</div>
						<div>
							<input type="text" readonly="readonly" name="nation">
						</div>
					</div>
				</div>
				<div id="div_difPerson">
					<div id="person_title">
						<span>실제 이용자 정보</span>
					</div>
					<div id="person_info">
						<div class="pers_input_title">
							<div>
								<span>이름</span><span>*</span>
							</div>
							<div>
								<span>이메일</span><span>*</span>
							</div>
						</div>
						<div class="pers_input_context">
							<div>
								<input type="text" name="htb_rlpName" maxlength="80" readonly="readonly" value="<%=racBooking.getCbk_rlpName() %>">
							</div>
							<div>
								<input type="text" name="htb_rlpEmail" maxlength="16" readonly="readonly" value="<%=racBooking.getCbk_rlpEmail() %>">
							</div>
						</div>
						<div class="pers_input_title">
							<div>
								<span>전화번호(숫자만 입력)</span><span>*</span>
							</div>
							<div>
								<span>거주 국가/지역</span><span>(선택사항)</span>
							</div>
						</div>
						<div class="pers_input_context">
							<div>
								<input type="number" name="htb_rlpPhone" maxlength="15" readonly="readonly" value="<%=racBooking.getCbk_rlpPhone() %>">
							</div>
							<div>
								<input type="text" name="htb_rlpNation" maxlength="80" readonly="readonly" value="<%=racBooking.getCbk_rlpNation() %>">
							</div>
						</div>
					</div>
				</div>
			</div>
			<div id="div_booking">
				<div id="booking_left">
					<div id="div_bookingTitle">
						<span>결제 요금내역</span>
					</div>
					<div class="booking_fee">
						<div>차량 요금 (차량 요금 x <%=racBooking.getCbk_rentTerm() %> 시간)</div>
						<div>
							<span>₩</span>
							<span><input type="text" name="hrm_disPrice" value="<%=df.format(racBooking.getCbk_rlpCarPrice() * racBooking.getCbk_rentTerm()) %>"></span>
						</div>
					</div>
					<div class="div_line02"></div>
					<div id="div_totalPrice">
						<div>총 결제 금액</div>
						<div>
							<span>₩</span>
							<span><input type="text" name="booking_totalPrice" value="<%=df.format(racBooking.getCbk_totalPrice()) %>"></span>
						</div>
					</div>
				</div>
				<div id="booking_right">
					<button>예약취소</button>
				</div>
			</div>
		</div>
		
		<!-- footer -->
		<jsp:include page="../include/HCAM_footer.jsp"/>
		
		<%
			commonDao.dbClose();
			fileDao.dbClose();
		%>
	
		<input type="text" name="car_no" value="<%=car.get(0).getCar_no() %>">
	<% } %>
	
</body>
</html>