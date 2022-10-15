<%@page import="java.util.ArrayList"%>
<%@page import="vo.HotelBookingDTO"%>
<%@page import="vo.HotelRoomDTO"%>
<%@page import="vo.HotelDTO"%>
<%@page import="vo.HcamMemDTO"%>
<%@page import="vo.HcamPointDTO"%>
<%@page import="java.text.DecimalFormat"%>
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
	
	/* 회원 정보 */
	HcamMemDTO member = (HcamMemDTO) request.getAttribute("member");
	/* 회원의 포인트 정보 */
	HcamPointDTO point = (HcamPointDTO) request.getAttribute("point");
	/* 호텔 정보 */
	HotelDTO hotel = (HotelDTO) request.getAttribute("hotel");
	/* 호텔 객실 정보 */
	HotelRoomDTO htlRoom = (HotelRoomDTO) request.getAttribute("htlRoom");
	/* 호텔 예약 정보 */
	HotelBookingDTO htlBooking = (HotelBookingDTO) request.getAttribute("htlBooking");
	/* 파일 여러개 조회 */
	ArrayList<String> fileList = fileDao.getFileList("htl", hotel.getHtl_no(), 0);
	
	String checkIn = htlBooking.getHtb_chkIn();
	String checkOut = htlBooking.getHtb_chkOut();
	
	// 금액 포맷
	DecimalFormat df = new DecimalFormat("#,###");
	// 전화번호 양식
	String phone_number = member.getMem_phone();
	phone_number = phone_number.substring(0,3) + "-" + phone_number.substring(3,7) 
				 + "-" + phone_number.substring(7);
	// 날짜 형식
	String fmt_checkIn = checkIn.substring(0,4) + "년 " + checkIn.substring(4,6) + "월 " + checkIn.substring(6) + "일";
	String fmt_checkOut = checkOut.substring(0,4) + "년 " + checkOut.substring(4,6) + "월 " + checkOut.substring(6) + "일";
		
	String fmt_pointBalance = df.format(point.getPnt_balance());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- jquery -->
<script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script>
<!-- css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/hotelBookingSuccess.css">
<!-- icon -->
<script src="https://kit.fontawesome.com/ae515d5c73.js" crossorigin="anonymous"></script>
<title>Insert title here</title>
</head>
<script>
	$(document).ready(function() {
		fn_chgTopBooking(3);
	});
	
	// 결제하기 버튼 클릭 시 상단 바 css 변경
	function fn_chgTopBooking(kubun) {
		var fmt_pointBalance = $("input[name='fmt_pointBalance']").val();		// 결제 총 합계
		
		$.ajax({
			url: "view/HCAM_bookingTop.jsp",
			type:'POST',
			dataType: "text",
			async:false,
			data: "title=HOTEL" +
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
	<!-- header -->
	<jsp:include page="../include/HCAM_header.jsp"/>
	
	<div id="div_topContent">
		<input type="hidden" name="fmt_pointBalance" value="<%=df.format(point.getPnt_balance()) %>">
	</div>
	
	<div id="div_content">
		<div id="div_compleTitle">
			<div>
				<img alt="" src="image/icon/hotel_bookingSuceess.png">
			</div>
			<div>호텔 예약이 완료되었습니다.</div>
		</div>
		<div class="div_line"></div>
		<div id="div_hoteContent">
			<div id="top_hoteContent">
				<div>
					<span>호텔 예약일시:</span>
					<span><%=htlBooking.getHtb_date() %></span>
				</div>
			</div>
			<div id="mid_hoteContent">
				<div id="hotel_image">
					<img alt="" src="<%=fileList.get(0) %>">
				</div>
				<div id="hotel_detail">
					<div id="hotel_name"><%=hotel.getHtl_name() %></div>
					<%-- <div id="hotel_grade">
						<% for(int i=0; i<hotel.getHtl_grade(); i++) { %>
							<img class="star_icon" alt="" src="image/icon/star_icon.png">
						<% } %>
					</div> --%>
					<!-- <div id="hotel_grade">
						<img class="star_icon" alt="" src="image/icon/star_icon.png">
						<img class="star_icon" alt="" src="image/icon/star_icon.png">
						<img class="star_icon" alt="" src="image/icon/star_icon.png">
					</div> -->
					<div id="room_name"><%=htlRoom.getHrm_name() %></div>
					<div id="room_view">
						<span>
							<i class="fa-solid fa-panorama"></i>
						</span>
						<span><%=commonDao.getCodeName(htlRoom.getHrm_view()) %></span>
					</div>
					<div id="room_bed">
						<span>
							<i class="fa-solid fa-bed"></i>
						</span>
						<span><%=commonDao.getCodeName(htlRoom.getHrm_bed()) %></span>
					</div>
				</div>
			</div>
			<div class="div_line"></div>
			<div id="botm_hoteContent">
				<div id="botm_left">
					<div class="botm_left_top">체크인</div>
					<div class="botm_left_mid"><%=fmt_checkIn %></div>
					<div class="botm_left_botm"><%=hotel.getHtl_inTime() %></div>
				</div>
				<div id="botm_center">
					<div><%=htlBooking.getHtb_stayTerm() %>박</div>
				</div>
				<div id="botm_right">
					<div class="botm_left_top">체크인</div>
					<div class="botm_left_mid"><%=fmt_checkOut %></div>
					<div class="botm_left_botm"><%=hotel.getHtl_outTime() %></div>
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
						<input type="text" readonly="readonly" value="<%=member.getMem_name() %>">
					</div>
					<div>
						<input type="text" readonly="readonly" value="<%=member.getMem_email() %>">
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
						<input type="text" readonly="readonly" value="<%=phone_number %>">
					</div>
					<div>
						<input type="text" readonly="readonly" name="nation">
					</div>
				</div>
			</div>
			<div id="div_difPerson">
				<div id="person_title">
					<span>실제 투숙객 정보</span>
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
							<input type="text" name="htb_rlpName" maxlength="80" readonly="readonly" value="<%=htlBooking.getHtb_rlpName() %>">
						</div>
						<div>
							<input type="text" name="htb_rlpEmail" maxlength="16" readonly="readonly" value="<%=htlBooking.getHtb_rlpEmail() %>">
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
							<input type="number" name="htb_rlpPhone" maxlength="15" readonly="readonly" value="<%=htlBooking.getHtb_rlpPhone() %>">
						</div>
						<div>
							<input type="text" name="htb_rlpNation" maxlength="80" readonly="readonly" value="<%=htlBooking.getHtb_rlpNation() %>">
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
					<div>객실 요금 (객실 요금 x <%=htlBooking.getHtb_stayTerm() %>박)</div>
					<div>
						<span>₩</span>
						<span><input type="text" name="hrm_disPrice" value="<%=df.format(htlBooking.getHtb_rlpRoomPrice() * htlBooking.getHtb_stayTerm()) %>"></span>
					</div>
				</div>
				<div class="booking_fee">
					<div>
						<span>조식 요금 (조식 요금 x <%=htlBooking.getHtb_brkfCnt() %></span>
						<span id="brfk_cnt"></span>
						<span>인)</span>
					</div>
					<div>
						<span>₩</span>
						<span><input type="text" name="hrm_brfkPrice" value="<%=htlBooking.getHtb_brkfPrice() %>"></span>
					</div>
				</div>
				<div class="div_line02"></div>
				<div id="div_totalPrice">
					<div>총 결제 금액</div>
					<div>
						<span>₩</span>
						<span><input type="text" name="booking_totalPrice" value="<%=df.format(htlBooking.getHtb_totalPrice()) %>"></span>
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
</body>
</html>