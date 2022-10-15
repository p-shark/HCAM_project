<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="vo.RentACarDTO"%>
<%@page import="java.util.Map"%>
<%@page import="vo.HcamMemDTO"%>
<%@page import="java.util.ArrayList"%>
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
	int pnt_no = 0;
	if(session.getAttribute("pnt_no") != null) {
		pnt_no = Integer.parseInt(String.valueOf(session.getAttribute("pnt_no")));
	}
	
	int car_no = (Integer) request.getAttribute("car_no");
	String chkInDate = (String) request.getAttribute("chkInDate");
	String chkOutDate = (String) request.getAttribute("chkOutDate");
	String inTime = (String) request.getAttribute("inTime");
	String outTime = (String) request.getAttribute("outTime");
	
	/* 회원정보 */
	ArrayList<HcamMemDTO> memberInfo = (ArrayList<HcamMemDTO>) request.getAttribute("memberInfo");
	/* 포인트 정보 */
	ArrayList<Map<String, String>> pointInfo = (ArrayList<Map<String, String>>) request.getAttribute("pointInfo");
	/* 렌터카 select */
	ArrayList<RentACarDTO> car = (ArrayList<RentACarDTO>) request.getAttribute("car");
	
	// 금액 포맷
	DecimalFormat df = new DecimalFormat("#,###");
	// 전화번호 양식
	String phone_number = memberInfo.get(0).getMem_phone();
	phone_number = phone_number.substring(0,3) + "-" + phone_number.substring(3,7) 
				 + "-" + phone_number.substring(7);
	// 날짜 차이 구하기
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
    Date stDt = format.parse(chkInDate + " " + inTime);
    Date edDt = format.parse(chkOutDate + " " + outTime);
    long diff = edDt.getTime() - stDt.getTime();
    long minuteTerm = diff / (60 * 1000);
    double hourTerm = (double) minuteTerm / 60;	// 30분 단위는 소수점으로 나오게 하려고 minute -> hour로 다시 계산함
    // 포인트 콤마 제거
    String num_pnt_balance = (pointInfo.get(0).get("pnt_balance")).replace(",", "");
 	// 적립예정 포인트
 	long accum_point = car.get(0).getCar_price();
 	accum_point = (int) Math.round(accum_point * hourTerm * 0.45 * 0.05);
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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/rentAcarBooking.css">
<!-- icon -->
<script src="https://kit.fontawesome.com/ae515d5c73.js" crossorigin="anonymous"></script>
<title>Insert title here</title>
</head>
<script>
	$(document).ready(function() {
		$('#div_difPerson').hide();
		/* 상단 바 css 변경 */
		fn_chgTopBooking(1);
		
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
	
	// 결제 전 체크
	function fn_chkBooking() {
		var result = false;
		
		var pnt_balance = parseInt($("input[name='pnt_balance']").val());			// 잔액
		var num_booking_totalPrice = parseInt($("input[name='num_booking_totalPrice']").val());		// 결제 총 합계
		
		//alert($("input[name='num_booking_totalPrice']").val());
		/* 결제하기 버튼 클릭 시 상단 바 css 변경 */
		fn_chgTopBooking(2);
		
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
			var htb_rlpPhone = $("input[name='htb_rlpPhone']").val();
			
			if(htb_rlpName == "" || htb_rlpEmail == "" || htb_rlpPhone == "") {
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
	function fn_chgTopBooking(kubun) {
		var fmt_pointBalance = $("input[name='fmt_pointBalance']").val();		// 결제 총 합계
		
		$.ajax({
			url: "view/HCAM_bookingTop.jsp",
			type:'POST',
			dataType: "text",
			async:false,
			data: "title=렌터카" + 
				  "&kubun=" + kubun +
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
		
		var url = "${pageContext.request.contextPath}/view/HCAM_pointDeposit.jsp";
		var title = "popupOpener";
		var status = "toolbar=no,directories=no,scrollbars=no,resizable=no,status=no,menubar=no,width=470,height=500,top=100,left=500";
		window.open(url, title, "width=470, height=500, top=100, left=500");
		
	}
	
	// 포인트 충전 후 부모창의 포인트 잔액 값 변경
	function fn_parentValue(value) {
		var pnt_balance = $("input[name='pnt_balance']");		// 결제 총 합계
		pnt_balance.val(parseInt(pnt_balance.val()) + parseInt(value));
	}
</script>
<body>
	<!-- header -->
	<jsp:include page="../include/HCAM_header.jsp"/>
	
	<div id="div_topContent">
		<div id="top_content">
			<div id="top_left">
				<div>렌터카 예약</div>
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
					<span><input type="text" name="fmt_pointBalance" value="<%=pointInfo.get(0).get("pnt_balance") %>"></span>
				</div>
			</div>
		</div>
	</div>
		
	<div id="div_content">
		<form name="booking_form" method="POST" action="car.do?command=carBookingSuccess" onsubmit="return fn_chkBooking();">
			<input type="hidden" name="pnt_balance" value="<%=num_pnt_balance %>">	<!-- 포인트 잔액 체크용 -->
			
			<input type="hidden" name="mem_no" value="<%=mem_no %>">				<!-- 로그인한 mem_no -->
			<input type="hidden" name="pnt_no" value="<%=pnt_no %>">				<!-- pnt_no -->
			<input type="hidden" name="car_no" value="<%=car_no %>">				<!-- hotle No -->
			<input type="hidden" name="rlp_useYn" value="0">						<!-- 예약자와 투숙객 동일여부(0:같음/1:다름) -->
			<input type="hidden" name="chkInDate" value="<%=chkInDate %>">			<!-- 파라미터로 넘어온 체크인일자 -->
			<input type="hidden" name="chkOutDate" value="<%=chkOutDate %>">		<!-- 파라미터로 넘어온 체크아웃일자 -->
			<input type="hidden" name="inTime" value="<%=inTime %>">				<!-- 파라미터로 넘어온 체크인시간 -->
			<input type="hidden" name="outTime" value="<%=outTime %>">				<!-- 파라미터로 넘어온 체크아웃시간 -->
			<input type="hidden" name="rlpCarPrice" value="<%=Math.round(car.get(0).getCar_price() * 0.45) %>">				<!-- 파라미터로 넘어온 체크아웃시간 -->
			<input type="hidden" name="cbk_stayTerm" value="<%=hourTerm %>">		<!-- 머무는 기간 -->
			<input type="hidden" name="accum_point" value="<%=accum_point %>">		<!-- 적립예정포인트 -->
			
			<div id="content_left">
				<div id="div_hoteContent">
					<div id="hotel_image">
						<img alt="" src="<%=fileDao.getFilePath("car", car_no) %>">
					</div>
					<div id="hotel_detail">
						<div id="hotel_name"><%=car.get(0).getCar_name() %></div>
						<div id="hotel_lct"><%=commonDao.getCodeName(car.get(0).getCar_location()) %> <%=commonDao.getCodeName(car.get(0).getCar_branch()) %> 지점</div>
						<div id="car_kind"><%=commonDao.getCodeName(car.get(0).getCar_kubun()) %></div>
						<div id="car_fuel">
							<span><%=commonDao.getCodeName(car.get(0).getCar_fuelKubun()) %></span>
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
								<input type="text" readonly="readonly" value="<%=phone_number %>">
							</div>
							<div>
								<input type="text" name="nation">
							</div>
						</div>
					</div>
					<div id="div_chkbox">
						<span><input type="checkbox" id="difPs" onclick="fn_slideBox();"></span>
						<span><label for="difPs">예약자와 운전자가 다를 경우 클릭해서 운전자 정보를 입력해 주세요.</label></span>
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
							<div>고객님의 계정으로 HcamPoint (₩ <%=df.format(accum_point) %>)가 적립되며, 2023년 1월 11일까지 사용하실 수 있습니다. (실제 차량 결제금액의 5%)</div>
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
						<span>차량 예약정보</span>
					</div>
					<div id="div_roomMiddle">
						<div id="div_bookingDate">
							<div><%=chkInDate %> <%=inTime %> ~ <%=chkOutDate %> <%=outTime %></div>
							<div><%=hourTerm %> (시간)</div>
						</div>
					</div>
				</div>
				<div id="div_booking">
					<div id="div_bookingTitle">
						<span>결제 요금내역</span>
					</div>
					<div id="top_booking">
						<div class="booking_title">
							<span>* TODAY * 55% 할인</span>
						</div>
						<div class="booking_initFee">
							<div>최초 요금 (차량 요금 x 시간)</div>
							<div>
								<span>₩</span>
								<span><input type="text" name="car_price" value="<%=df.format(car.get(0).getCar_price() * hourTerm) %>"></span>
							</div>
						</div>
						<div class="booking_fee">
							<div>할인 요금 (차량 요금 x 시간)</div>
							<div>
								<span>₩</span>
								<span><input type="text" name="car_disPrice" value="<%=df.format(car.get(0).getCar_price()*0.45 * hourTerm) %>"></span>
							</div>
						</div>
					</div>
					<div id="bottom_booking">
						<div id="div_totalPrice">
							<div>합계</div>
							<div>
								<span>₩</span>
								<input type="hidden" name="num_booking_totalPrice" value="<%=Math.round(car.get(0).getCar_price()*0.45 * hourTerm) %>">
								<span><input type="text" name="booking_totalPrice" value="<%=df.format(car.get(0).getCar_price()*0.45 * hourTerm) %>"></span>
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