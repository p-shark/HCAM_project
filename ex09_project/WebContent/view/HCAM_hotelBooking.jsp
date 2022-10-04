<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="vo.HcamPointDTO"%>
<%@page import="vo.HcamMemDTO"%>
<%@page import="vo.HotelRoomDTO"%>
<%@page import="vo.HotelDTO"%>
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
	
	// 체크인, 체크아웃 일자
	String checkIn = (String) request.getAttribute("chkIn");
	String checkOut = (String) request.getAttribute("chkOut");
	
	/* 회원 정보 */
	HcamMemDTO member = (HcamMemDTO) request.getAttribute("member");
	/* 회원의 포인트 정보 */
	HcamPointDTO point = (HcamPointDTO) request.getAttribute("point");
	/* 호텔 정보 */
	HotelDTO hotel = (HotelDTO) request.getAttribute("hotel");
	/* 호텔 객실 정보 */
	HotelRoomDTO htlRoom = (HotelRoomDTO) request.getAttribute("htlRoom");
	/* 파일 여러개 조회 */
	ArrayList<String> fileList = fileDao.getFileList("htl", hotel.getHtl_no(), 0);
	
	//System.out.println("brfk >>> " + hotel.getHtl_brkf());
	
	// 금액 포맷
	DecimalFormat df = new DecimalFormat("#,###");
	// 전화번호 양식
	String phone_number = member.getMem_phone();
	phone_number = phone_number.substring(0,3) + "-" + phone_number.substring(3,7) 
				 + "-" + phone_number.substring(7);
	// 날짜 형식
	String fmt_checkIn = checkIn.substring(0,4) + "년 " + checkIn.substring(4,6) + "월 " + checkIn.substring(6) + "일";
	String fmt_checkOut = checkOut.substring(0,4) + "년 " + checkOut.substring(4,6) + "월 " + checkOut.substring(6) + "일";
	// 날짜 차이 구하기
	SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
    Date stDt = format.parse(checkIn);
    Date edDt = format.parse(checkOut);
    long diff = edDt.getTime() - stDt.getTime();
    long dayTerm = diff / (24 * 60 * 60 * 1000);
	// 적립예정 포인트
	long accum_point = htlRoom.getHrm_price();
	accum_point = (int) Math.round(accum_point * dayTerm * 0.75 * 0.05);
	//System.out.println("accum_point >>> " + accum_point);
    
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- jquery -->
<script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script>
<!-- css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/hotelBooking.css">
<!-- icon -->
<script src="https://kit.fontawesome.com/ae515d5c73.js" crossorigin="anonymous"></script>
<title>Insert title here</title>
</head>
<script>
	$(document).ready(function() {
		$('#div_difPerson').hide();
		
		var brfk_yn = $("input[name='htl_brfk']").val(); // 조식 제공여부
		if(brfk_yn == 1) {
			$('#brfk_Ybox').css("display", "block");
		}
		else {
			$('#brfk_Nbox').css("display", "block");
		}
	});
	
	/* 예약자와 투숙객 다를 시 */
	function fn_slideBox() {
		
		if($('#difPs').is(':checked')) {
			$("input[name='rlp_useYn']").val("1");
			$('#div_difPerson').slideDown();
		}
		else {
			$("input[name='rlp_useYn']").val("0");
			$('#div_difPerson').slideUp();
		}
		
	}
	
	/* 수량 change */
	function fn_chgAmount(type)  {
		
		var htb_brkfCnt = $("input[name='htb_brkfCnt']");				// 수량
		var brfk_price = $("input[name='brfk_price']");					// 1인당 가격
		var brfk_totalPrice = $("input[name='brfk_totalPrice']");		// 조식 합산 금액
		var hrm_disPrice = $("input[name='hrm_disPrice']");				// (결제 요금내역) 객실 할인 요금
		var hrm_brfkPrice = $("input[name='hrm_brfkPrice']");			// (결제 요금내역) 조식 요금
		var booking_totalPrice = $("input[name='booking_totalPrice']");	// (결제 요금내역) 총 합계
		
		// 1인당 가격 천단위 콤마 제거
		var fmt_brfk_price = (brfk_price.val()).replace(/\,/g,"");
		var fmt_hrm_disPrice = (hrm_disPrice.val()).replace(/\,/g,"");
		// 수량 value
		var number = parseInt(htb_brkfCnt.val());
		
		// 더하기/빼기
		if(type === 'plus') {
			number++;
		}
		else if(type === 'minus')  {
			// 마이너스값 입력 제어
			if(number == 0) {
				htb_brkfCnt.val(0);
				return;
			}
			
		  	number--;
		}
		
		// 조식 합계 = (1인당 가격) * (총수량)
		var total_brfkPrice = parseInt(fmt_brfk_price) * number;
		// 총 합계 = (할인 요금 ) + (조식 합계)
		var total_price = parseInt(fmt_hrm_disPrice) + total_brfkPrice;
		
		// 천단위 콤마
		var fmt_total_brfkPrice = total_brfkPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		var fmt_total_price = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		
		htb_brkfCnt.val(number);					// 조식 수량
		brfk_totalPrice.val(fmt_total_brfkPrice);	// 조식 총 합계
		hrm_brfkPrice.val(fmt_total_brfkPrice);		// (결제 요금내역) 조식 합계
		booking_totalPrice.val(fmt_total_price);	// (결제 요금내역) 총 합계
		$('#brfk_cnt').html(number);
		
		$("input[name='num_booking_totalPrice']").val(total_price);	// 파라미터로 넘길 조식 총 합계
		
	}
	
	// 결제 전 체크
	function fn_chkBooking() {
		var result = false;
		
		var pnt_balance = parseInt($("input[name='pnt_balance']").val());			// 잔액
		var num_booking_totalPrice = parseInt($("input[name='num_booking_totalPrice']").val());		// 결제 총 합계
		
		//alert($("input[name='num_booking_totalPrice']").val());
		/* 결제하기 버튼 클릭 시 상단 바 css 변경 */
		fn_chgTopBooking();
		
		// 포인트 잔액 < 결제 총합계
		if(pnt_balance < num_booking_totalPrice) {
			var pnt_flag = confirm("포인트 잔액이 부족합니다. 충전하시겠습니까?");
			event.preventDefault();	// confirm 창 띄우고나면 submit 자동으로 돼서 막음 
			
			if(pnt_flag){	//확인 버튼 클릭 true 
				/* 포인트 충전 popup 호출 */
				fn_depositPoint();
			}
		}
		else if($('#difPs').is(':checked')) { // 예약자와 투숙객 다름 체크한 경우
			var htb_rlpName = $("input[name='htb_rlpName']").val();
			var htb_rlpEmail = $("input[name='htb_rlpEmail']").val();
			var htb_rlpNation = $("input[name='htb_rlpNation']").val();
			
			if(htb_rlpName == "" || htb_rlpEmail == "" || htb_rlpNation == "") {
				alert("예약자와 투숙객이 다른 경우 필수값을 입력하세요.");
			}
			else {
				var confirm_flag = confirm("예약 진행하시겠습니까?");
				
				if(confirm_flag){	//확인 버튼 클릭 true 
					result = true;
				}
			}
		}
		else {
			var confirm_flag = confirm("예약 진행하시겠습니까?");
			
			if(confirm_flag){	//확인 버튼 클릭 true 
				result = true;
			}
		}
		
		return result;
	}
	
	// 결제하기 버튼 클릭 시 상단 바 css 변경
	function fn_chgTopBooking() {
		var fmt_pointBalance = $("input[name='fmt_pointBalance']").val();		// 결제 총 합계
		
		$.ajax({
			url: "view/HCAM_bookingTop.jsp",
			type:'POST',
			dataType: "text",
			async:false,
			data: "kubun=2" +
				  "&fmt_pointBalance=" + fmt_pointBalance,
			success: function(result) {
				$("#div_topContent").html(result);
			},
			error: function(request, error) {
				alert(request.status + " / " + request.responseText + " / " + error);
			}
		});
	}
	
	// 포인트 충전 popup 호출 
	function fn_depositPoint() {
		var mem_no = $("input[name='mem_no']").val();		// 결제 총 합계
		
		var url = "${pageContext.request.contextPath}/view/HCAM_pointDeposit.jsp?mem_no=" + mem_no;
		var title = "popupOpener";
		var status = "toolbar=no,directories=no,scrollbars=no,resizable=no,status=no,menubar=no,width=400,height=500,top=100,left=500";
		window.open(url, title, "width=400, height=500, top=100, left=500");
	}
</script>
<body>

	<!-- header -->
	<jsp:include page="../include/HCAM_header.jsp"/>
	
	<div id="div_topContent">
		<div id="top_content">
			<div id="top_left">
				<div>호텔 예약</div>
			</div>
			<div id="top_middle">
				<ul>
					<li>
						<div class="top_number">
							<div class="top_line01 top_lineGray"></div>
							<div class="top_num01 top_numBlue">1</div>
						</div>
						<div class="top_comment">
							<div class="top_comment01 top_Commentblue">고객정보</div>
						</div>
					</li>
					<li>
						<div class="top_number">
							<div class="top_line0201 top_lineGray"></div>
							<div class="top_line0202 top_lineGray"></div>
							<div class="top_num02 top_numGray">2</div>
						</div>
						<div class="top_comment">
							<div class="top_comment02 top_CommentGray">결제 진행중</div>
						</div>
					</li>
					<li>
						<div class="top_number">
							<div class="top_line03 top_lineGray"></div>
							<div class="top_num03 top_numGray">
								<span><i class="fa-solid fa-check"></i></span>
							</div>
						</div>
						<div class="top_comment">
							<div class="top_comment03 top_CommentGray">예약완료</div>
						</div>
					</li>
				</ul>
			</div>
			<div id="top_right">
				<div>
					<span>포인트잔액</span>
					<span><input type="text" name="fmt_pointBalance" value="<%=df.format(point.getPnt_balance()) %>"></span>
				</div>
			</div>
		</div>
	</div>
		
	<div id="div_content">
		<form name="booking_form" method="POST" action="hotelBookingSuccess.ho" onsubmit="return fn_chkBooking();">
			<input type="hidden" name="pnt_balance" value="<%=point.getPnt_balance() %>">	<!-- 포인트 잔액 체크용 -->
			<input type="hidden" name="htl_brfk" value="<%=hotel.getHtl_brkf() %>">			<!-- 호텔 조식 제공여부 (1:제공/0:미제공) -->
			
			<input type="hidden" name="mem_no" value="<%=mem_no %>">						<!-- 로그인한 mem_no -->
			<input type="hidden" name="htl_no" value="<%=hotel.getHtl_no() %>">				<!-- hotle No -->
			<input type="hidden" name="hrm_no" value="<%=htlRoom.getHrm_no() %>">			<!-- htlRoom No -->
			<input type="hidden" name="rlp_useYn" value="0">								<!-- 예약자와 투숙객 동일여부(0:같음/1:다름) -->
			<input type="hidden" name="chkIn" value="<%=checkIn %>">						<!-- 파라미터로 넘어온 체크인일자 -->
			<input type="hidden" name="chkOut" value="<%=checkOut %>">						<!-- 파라미터로 넘어온 체크아웃일자 -->
			<input type="hidden" name="htb_stayTerm" value="<%=dayTerm %>">					<!-- 머무는 기간 -->
			<input type="hidden" name="accum_point" value="<%=accum_point %>">				<!-- 적립예정포인트 -->
			
			<div id="content_left">
				<div id="div_hoteContent">
					<div id="hotel_image">
						<img alt="" src="<%=fileList.get(0) %>">
					</div>
					<div id="hotel_detail">
						<div id="hotel_name"><%=hotel.getHtl_name() %></div>
						<div id="hotel_grade">
							<% for(int i=0; i<hotel.getHtl_grade(); i++) { %>
								<img class="star_icon" alt="" src="image/icon/star_icon.png">
							<% } %>
						</div>
						<div id="hotel_lct"><%=hotel.getHtl_addrdtl() %><%=hotel.getHtl_addr() %></div>
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
								<input type="text" name="nation">
							</div>
						</div>
					</div>
					<div id="div_chkbox">
						<span><input type="checkbox" id="difPs" onclick="fn_slideBox();"></span>
						<span><label for="difPs">예약자와 투숙자가 다를 경우 클릭해서 투숙객 정보를 입력해 주세요.</label></span>
					</div>
					<div id="div_difPerson">
						<div id="person_title">
							<span>투숙객 정보</span>
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
									<input type="text" name="htb_rlpName" maxlength="80">
								</div>
								<div>
									<input type="text" name="htb_rlpEmail" maxlength="16">
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
									<input type="number" name="htb_rlpPhone" maxlength="15">
								</div>
								<div>
									<input type="text" name="htb_rlpNation" maxlength="80">
								</div>
							</div>
						</div>
					</div>
				</div>
				<div id="div_brfk">
					<div id="brfk_title">《 조식 옵션 추가 》</div>
					<div id="brfk_addBox">
						<div id="brfk_Ybox">
							<div id="brfk_box01">
								<div>조식 서비스를 제공하는 호텔입니다.</div>
								<div>
									<span>(1인당) 가격 :</span>
									<span>₩ <input type="text" name="brfk_price" value="<%=df.format(hotel.getHtl_brfkPrice()) %>"></span>
								</div>
							</div>
							<div id="brfk_box02">
								<span><input type='button' name="amount_minus" onclick="fn_chgAmount('minus')" value='-'/></span>
								<span><input type="number" name="htb_brkfCnt" value="0"></span>		<!-- 조식 수량 -->
								<span><input type='button' name="amount_plus" onclick="fn_chgAmount('plus')" value='+'/></span>
							</div>
							<div id="brfk_box03">
								<span>총 합계:</span>
								<span>&nbsp</span>
								<span>₩</span>
								<span><input type="text" name="brfk_totalPrice" value="0" readonly="readonly"></span>
							</div>
							<!-- <div id="brfk_box04">
								<button>추가</button>
							</div> -->
						</div>
						<div id="brfk_Nbox">
							<div id="brfk_box05">
								<div>조식 서비스를 제공하지않는 호텔입니다.</div>
							</div>
						</div>
					</div>
				</div>
				<div id="div_point">
					<div id="point_title">
						<span><i class="fa-solid fa-circle-dollar-to-slot"></i></span>
						<span>포인트 적립</span>
					</div>
					<div id="point_addBox">
						<div id="point_left">
							<i class="fa-brands fa-product-hunt"></i>
						</div>
						<div id="point_center">
							<div>HcamPoint</div>
							<div>고객님의 계정으로 HcamPoint (₩ <%=df.format(accum_point) %>)가 적립되며, 2023년 1월 11일까지 사용하실 수 있습니다. (실제 객실 결제금액의 5%)</div>
						</div>
						<div id="point_right">
							<span><%=df.format(accum_point) %></span>
							<span>₩</span>
						</div>
					</div>
				</div>
			</div>
			<div id="content_right">
				<div id="div_room">
					<div id="div_roomTitle">
						<span>객실 예약정보</span>
					</div>
					<div id="div_roomMiddle">
						<div id="div_bookingDate">
							<div><%=fmt_checkIn %> - <%=fmt_checkOut %></div>
							<div>(<%=dayTerm %>박)</div>
						</div>
						<div class="div_line"></div>
						<div id="div_roomName"><%=htlRoom.getHrm_name() %></div>
						<div class="div_line"></div>
						<div id="div_roomContent">
							<div id="div_roomImage">
								<img alt="" src="<%=fileList.get(1) %>">
							</div>
							<div id="div_roomInfo">
								<div>
									<span>
										<i class="fa-solid fa-panorama"></i>
									</span>
									<span><%=commonDao.getCodeName(htlRoom.getHrm_view()) %></span>
								</div>
								<div>
									<span>
										<i class="fa-solid fa-bed"></i>
									</span>
									<span><%=commonDao.getCodeName(htlRoom.getHrm_bed()) %></span>
								</div>
								<div>
									<span>
										<svg width="1em" height="1em" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" class="SvgIconstyled__SvgIconStyled-sc-1i6f60b-0 ibyDZc"><path d="M16.475 17.5H15.18l-.5 5.004a.5.5 0 0 1-.498.45H9.818a.5.5 0 0 1-.497-.45l-.5-5.004H7.524l-.21 2.095a.5.5 0 0 1-.497.45H3.182a.5.5 0 0 1-.498-.45l-.41-4.095H.455a.5.5 0 0 1-.5-.5v-2.273a5.045 5.045 0 0 1 8.757-3.419A5.927 5.927 0 0 1 12 8.318c1.216 0 2.347.365 3.29.99a5.045 5.045 0 0 1 8.756 3.419V15a.5.5 0 0 1-.5.5h-1.82l-.41 4.095a.5.5 0 0 1-.498.45h-3.636a.5.5 0 0 1-.498-.45l-.21-2.095zm1.005 0l.154 1.545h2.732l.41-4.095a.5.5 0 0 1 .497-.45h1.772v-1.773a4.045 4.045 0 0 0-6.97-2.795 5.938 5.938 0 0 1 1.88 4.34V17a.5.5 0 0 1-.475.5zm-8.46-7.187a.501.501 0 0 1-.168.134 4.945 4.945 0 0 0-1.807 3.826V16.5h2.228a.5.5 0 0 1 .497.45l.5 5.005h3.46l.5-5.005a.5.5 0 0 1 .497-.45h2.228v-2.227a4.955 4.955 0 0 0-7.934-3.96zm-1.096-.381a4.045 4.045 0 0 0-6.97 2.796V14.5h1.773a.5.5 0 0 1 .498.45l.41 4.095h2.73L6.52 17.5A.5.5 0 0 1 6.045 17v-2.727c0-1.712.723-3.255 1.88-4.341zM5 7a3 3 0 1 1 0-6 3 3 0 0 1 0 6zm0-1a2 2 0 1 0 0-4 2 2 0 0 0 0 4zm7 1.5a3.5 3.5 0 1 1 0-7 3.5 3.5 0 0 1 0 7zm0-1a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5zm7 .5a3 3 0 1 1 0-6 3 3 0 0 1 0 6zm0-1a2 2 0 1 0 0-4 2 2 0 0 0 0 4z"></path></svg>
									</span>
									<span>최대인원: 성인 <%=htlRoom.getHrm_maxpers() %>명, 아동 1 명 (0~12세)</span>
								</div>
								<div>
									<span>
										<i class="fa-solid fa-check"></i>
									</span>
									<span>무료 Wi-Fi</span>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div id="div_booking">
					<div id="div_bookingTitle">
						<span>결제 요금내역</span>
					</div>
					<div id="top_booking">
						<div class="booking_title">
							<span>* TODAY * 25% 할인</span>
						</div>
						<div class="booking_initFee">
							<div>최초 요금 (객실 요금 x <%=dayTerm %>박)</div>
							<div>
								<span>₩</span>
								<span><input type="text" name="hrm_price" value="<%=df.format(htlRoom.getHrm_price() * dayTerm) %>"></span>
							</div>
						</div>
						<div class="booking_fee">
							<div>할인 요금 (객실 요금 x <%=dayTerm %>박)</div>
							<div>
								<span>₩</span>
								<span><input type="text" name="hrm_disPrice" value="<%=df.format(htlRoom.getHrm_price()*0.75 * dayTerm) %>"></span>
							</div>
						</div>
						<div class="booking_fee">
							<div>
								<span>조식 요금 (조식 요금 x </span>
								<span id="brfk_cnt">0</span>
								<span>인)</span>
							</div>
							<div>
								<span>₩</span>
								<span><input type="text" name="hrm_brfkPrice" value="0"></span>
							</div>
						</div>
					</div>
					<div id="bottom_booking">
						<div id="div_totalPrice">
							<div>합계</div>
							<div>
								<span>₩</span>
								<input type="hidden" name="num_booking_totalPrice" value="<%=Math.round(htlRoom.getHrm_price()*0.75 * dayTerm) %>">
								<span><input type="text" name="booking_totalPrice" value="<%=df.format(htlRoom.getHrm_price()*0.75 * dayTerm) %>"></span>
							</div>
						</div>
					</div>
				</div>
				<div id="div_nextBtn">
					<div>
						<input type="submit" value="결제하기">
					</div>
				</div>
			</div>
		</form>
	</div>
	
	<!-- footer -->
	<jsp:include page="../include/HCAM_footer.jsp"/>
	
	<%
		commonDao.dbClose();
		fileDao.dbClose();
	%>
</body>
</html>