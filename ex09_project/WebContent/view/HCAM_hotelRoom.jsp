<%@page import="vo.HotelReviewDTO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="vo.HotelRoomDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.HotelDTO"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.util.Map"%>
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

	//국가, 지역
	String select01 = (String) request.getAttribute("select01");
	String select02 = (String) request.getAttribute("select02");
	
	// 체크인, 체크아웃 일자
	String checkIn = (String) request.getAttribute("chkIn");
	String checkOut = (String) request.getAttribute("chkOut");
	
	//System.out.println(checkIn);
	
	// htl_no
	int htl_no = (Integer) request.getAttribute("htl_no");
	/* 호텔 정보 */
	HotelDTO hotel = (HotelDTO) request.getAttribute("hotel");
	/* 호텔 정보 */
	ArrayList<HotelRoomDTO> htlRoomList = (ArrayList<HotelRoomDTO>) request.getAttribute("htlRoomList");
	/* 각 호텔의 전체 이용후기 정보(평균값, 총 개수) */
	HashMap<String, Integer> reviewInfo = (HashMap<String, Integer>) request.getAttribute("reviewInfo");
	/* 호텔 이용후기 */
	ArrayList<HotelReviewDTO> reviewList = (ArrayList<HotelReviewDTO>) request.getAttribute("reviewList");
	
	int remainCnt = 0;	// 잔여 객실수
	ArrayList<HotelRoomDTO> htlRemainRoom = new ArrayList<HotelRoomDTO>();	// 잔여 객실 리스트
	ArrayList<HotelRoomDTO> htlSoldOutRoom = new ArrayList<HotelRoomDTO>();	// 판매완료 객실 리스트
	
	for(int i=0; i<htlRoomList.size(); i++) {
		// 예약 가능한 경우
		if(htlRoomList.get(i).getBooking_cnt() == 0) {
			remainCnt++;
			htlRemainRoom.add(htlRoomList.get(i));
		}
		// 이미 판매완료된 경우
		else {
			htlSoldOutRoom.add(htlRoomList.get(i));
		}
	}
	
	// 금액 포맷
	DecimalFormat df = new DecimalFormat("#,###");
	
	// 객실 사진 관련 변수
	int roomImgNum = 0;
	
	/* 파일 여러개 조회 */
	ArrayList<String> fileList = fileDao.getFileList("htl", htl_no, 0);
	
	/* 코드별 공통코드 전체 조회 */
	TreeMap<String, String> commCodes = commonDao.getCodeAllByCode("CCD02");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- jquery -->
<script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script>
<!-- css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/hotelRoom.css">
<!-- icon -->
<script src="https://kit.fontawesome.com/ae515d5c73.js" crossorigin="anonymous"></script>
<!-- kakaoMap api -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2ba53fbf9c283e34734ca1b92dfbf253&libraries=services"></script>
<!-- Air datepicker -->
<link href="js/datepicker/css/datepicker.min.css" rel="stylesheet" type="text/css" media="all">
<script src="js/datepicker/js/datepicker.js"></script>		<!-- Air datepicker js -->
<script src="js/datepicker/js/datepicker.ko.js"></script>	<!-- 달력 한글 추가를 위해 커스텀 -->
<title>Insert title here</title>
</head>
<script type="text/javascript">
	/* init window */
	$(document).ready(function(){
		/* 호텔 옵션 관련 */
		var brkf = $("input[name='brkf']").val();
		var pool = $("input[name='pool']").val();
		var parking = $("input[name='parking']").val();
		var conv = $("input[name='conv']").val();
		var lugg = $("input[name='lugg']").val();
		
		if(brkf == 0) {
			$('#brkf_icon img').addClass('chgOpacity');
		}
		if(pool == 0) {
			$('#pool_icon img').addClass('chgOpacity');
		}
		if(parking == 0) {
			$('#parking_icon img').addClass('chgOpacity');
		}
		if(conv == 0) {
			$('#conv_icon img').addClass('chgOpacity');
		}
		if(lugg == 0) {
			$('#lugg_icon img').addClass('chgOpacity');
		}
	});

	/* 체크인, 체크아웃 일자 변경 시 체크 */
	function fn_chgDate(obj, kubun) {
		
		var oldValue = obj.value;
	
		var today = $("input[name='today']").val();
		var tomorrow = $("input[name='tomorrow']").val();
		
		if(kubun == 1) {
			if(oldValue < today) {
				alert("현재 일자 이전의 날짜는 선택할 수 없습니다.")
				obj.value = today;
			}
		}
		else {
			if(oldValue < tomorrow) {
				alert("다음날 일자 이전의 날짜는 선택할 수 없습니다.")
				obj.value = tomorrow;
			}
		}
	}
	
	/* 상단 검색 바 */
	function fn_topSearching() {
		var result = false;
		
		var select01 = $('#select01 option:selected').val();
		var select02 = $('#select02 option:selected').val();
		var top_chkIn = $("#top_chkIn").val();
		var top_chkOut = $("#top_chkOut").val();

		// 날짜 체크
		if(top_chkIn >= top_chkOut) {
			alert("체크아웃일자는 체크인일자 이후로 선택하세요");
		}
		else if(top_chkIn == "" || top_chkOut == "") {
			alert("날짜를 선택하세요");
		}
		else {
			result = true;
		}
		
		return result;
	}
	
	/* 국가 select박스 변경될 시 */
	function fn_chgSelectbox(NationCode) {
		if($('#select01 option:selected').val() == "") {
			//$('#select02').val("").prop("selected", true);
			$("#select02 option").remove();
			$("#select02").append("<option value=''>전체</option>");
		}
		else {
			$.ajax({
				url: "view/HCAM_mainSelectbox.jsp",
				type:'POST',
				dataType: "text",
				async:false,
				data: "topCode=" + NationCode.value +
					  "&kubun=top",
				success: function(result) {
					$(".li_select02").html(result);
				},
				error: function(request, error) {
					alert(request.status + " / " + request.responseText + " / " + error);
				}
			});
		}
	}
	
	/* 호텔 예약으로 이동 */
	function fn_goBooking(htl_no, hrm_no, booking_cnt) {
		
		var mem_no = $("input[name='mem_no']").val();
		var param_chkIn = $("input[name='param_chkIn']").val();
		var param_chkOut = $("input[name='param_chkOut']").val();
		
		if(mem_no == 0) {
			alert("로그인 후 이용가능합니다.");
			return;
		}
		
		if (booking_cnt == 0) {
			location.href = "hotelBooking.ho?mem_no=" + mem_no + "&htl_no=" + htl_no + "&hrm_no=" + hrm_no
						  + "&chkIn=" + param_chkIn + "&chkOut=" + param_chkOut;
		}
	}
	
</script>
<body>
<input type="hidden" name="mem_no" value="<%=mem_no%>">			<!-- 로그인한 mem_no -->
<input type="hidden" name="param_chkIn" value="<%=checkIn%>">			<!-- 검색완료된 체크인날짜 -->
<input type="hidden" name="param_chkOut" value="<%=checkOut%>">			<!-- 검색완료된 체크아웃날짜 -->


	<!-- header -->
	<jsp:include page="../include/HCAM_header.jsp"/>
	
	<div class="search_content" id="search_content">
		<section class="search_section">
			<form name="top_searching" method="POST" action="hotelRoom.ho" onsubmit="return fn_topSearching();">
				<input type="hidden" name="htl_no" id="htl_no" value="<%=htl_no %>">
				<ul>
					<li>
						<div class="search_sec_icon">
							<svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
								<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
							</svg>
						</div>
						<select class="search_sec_input" name="select01" id="select01" onchange="fn_chgSelectbox(this);">
							<option value="1">전체
							<% 
								for(Map.Entry<String, String> code : commCodes.entrySet()) { 
									if(code.getKey().equals(select01)) {
										out.println("<option value='" + code.getKey() + "' selected>" + code.getValue() + "</option>");
									}
									else {
										out.println("<option value='" + code.getKey() + "'>" + code.getValue() + "</option>");
									}
								}
							%>
						</select>
					</li>
					<li class="li_select02">
						<div class="search_sec_icon">
						</div>
						<select class="search_sec_input" name="select02" id="select02">
							<option value="1">전체
							<% 
								if(select02 != null || select02 != "") {
									TreeMap<String, String> subCodes = commonDao.getCodeByTopCode(select01);
									
									for(Map.Entry<String, String> code : subCodes.entrySet()) { 
										if(code.getKey().equals(select02)) {
											out.println("<option value='" + code.getKey() + "' selected>" + code.getValue() + "</option>");
										}
										else {
											out.println("<option value='" + code.getKey() + "'>" + code.getValue() + "</option>");
										}
									}
								} 
							%>
						</select>
					</li>
					<li>
						<div class="search_sec_icon">
							<svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-calendar-check" viewBox="0 0 16 16">
							  <path d="M10.854 7.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L7.5 9.793l2.646-2.647a.5.5 0 0 1 .708 0z"/>
							  <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4H1z"/>
							</svg>
						</div>
						<%-- <input class="search_sec_input" type="date" name="top_chkIn" id="top_chkIn" value="<%=checkIn %>" onblur="fn_chgDate(this ,1);" placeholder="체크인일자"> --%>
						<input class="search_sec_input" type="text" name="top_chkIn" id="top_chkIn" value="<%=checkIn %>" onblur="fn_chgDate(this ,1);" placeholder="체크인일자">
					</li>
					<li>
						<div class="search_sec_icon">
							<svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-calendar-check" viewBox="0 0 16 16">
							  <path d="M10.854 7.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L7.5 9.793l2.646-2.647a.5.5 0 0 1 .708 0z"/>
							  <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4H1z"/>
							</svg>
						</div>
						<%-- <input class="search_sec_input" type="date" name="top_chkOut" id="top_chkOut" value="<%=checkOut %>" onblur="fn_chgDate(this ,2)" placeholder="체크아웃"> --%>
						<input class="search_sec_input" type="text" name="top_chkOut" id="top_chkOut" value="<%=checkOut %>" onblur="fn_chgDate(this ,2)" placeholder="체크아웃">
					</li>
					<li>
						<input type="submit" value="검색하기">
					</li>
				</ul>
			</form>
		</section>
	</div>
	
	<div id="div_content">
		<div id="div_image">
			<div id="image_main">
				<img src="<%=fileList.get(0) %>">
				<div id="div_heart">
					<div id="heart_shape">
						<i class="fa-regular fa-heart fa-2x"></i>
					</div>
				</div>
			</div>
			<div id="image_sub">
				<div id="image_sub01">
					<img src="<%=fileList.get(1) %>">
					<img src="<%=fileList.get(2) %>">
					<img src="<%=fileList.get(3) %>">
				</div>
				<div id="image_sub02">
					<img src="<%=fileList.get(4) %>">
					<img src="<%=fileList.get(5) %>">
					<img src="<%=fileList.get(6) %>">
				</div>
			</div>
		</div>
		<div id="div_ankor">
			<div id="left_ankor">
				<ul>
					<li><a href="#div_hotelTitle">소개</a></li>
					<li><a href="#div_hotelfeature">편의시설/서비스</a></li>
					<li><a href="#div_room">객실</a></li>
					<li><a href="#htlReview">이용후기</a></li>
				</ul>
			</div>
			<div id="right_ankor">
				<div id="ankor_fee">
					<span>시작가</span>
					<span>₩</span>
					<span><%=df.format(htlRoomList.get(0).getHrm_price()*0.75) %></span>
				</div>
				<div id="ankor_btn">
					<a href="#div_room">객실 상품 보기</a>
				</div>
			</div>
		</div>
		<div id="div_hotelInfo">
			<div id="left_hotelInfo">
				<div class="div_border" id="div_hotelTitle">
					<div id="hotel_icon">
						<img class="sale_icon" alt="" src="image/icon/sale_icon.png">
					</div>
					<div id="hotel_name">
						<span><%=hotel.getHtl_name() %></span>
						<span>&nbsp</span>
						<span>
							<% for(int i=0; i<hotel.getHtl_grade(); i++) { %>
								<img class="star_icon" alt="" src="image/icon/star_icon.png">
							<% } %>
						</span>
					</div>
					<div id="hotel_lct"><%=hotel.getHtl_addrdtl() %><%=hotel.getHtl_addr() %></div>
					<div class="div_line"></div>
					<div id="hotel_intro">주차 및 Wi-Fi가 항상 무료로 제공되므로 언제든지 차량을 입출차할 수 있으며 연락을 취하실 수 있습니다. <b><%=commonDao.getCodeName(hotel.getHtl_nation()) %></b>의 <b><%=commonDao.getCodeName(hotel.getHtl_location()) %></b>에 위치한 본 숙소는 관광 명소 및 흥미로운 레스토랑과 가깝습니다. 떠나기 전 유명한 <b>경복궁</b>을/를 방문해 보세요. <b>별 <%=hotel.getHtl_grade() %>개</b>를 받은 본 고급 숙소는 투숙객에게 숙소 내 레스토랑, 실내 수영장 및 피트니스 센터을/를 제공합니다.</div>
				</div>
				<div class="div_border" id="div_hotelfeature">
					<div id="featcher_title">편의시설/서비스</div>
					<div id="featcher_icon">
						<input type="hidden" name="brkf" value="<%=hotel.getHtl_brkf() %>">
						<input type="hidden" name="pool" value="<%=hotel.getHtl_pool() %>">
						<input type="hidden" name="parking" value="<%=hotel.getHtl_park() %>">
						<input type="hidden" name="conv" value="<%=hotel.getHtl_conv() %>">
						<input type="hidden" name="lugg" value="<%=hotel.getHtl_lugg() %>">
						<div id="brkf_icon">
							<div><img src="image/icon/brkf_icon.png"></div>
							<div>조식운영</div>
						</div>
						<div id="pool_icon">
							<div><img src="image/icon/pool_icon.png"></div>
							<div>수영장</div>
						</div>
						<div id="parking_icon">
							<div><img src="image/icon/parking_icon.png"></div>
							<div>주차</div>
						</div>
						<div id="conv_icon">
							<div><img src="image/icon/conv_icon.png"></div>
							<div>편의시설</div>
						</div>
						<div id="lugg_icon">
							<div><img src="image/icon/lugg_icon.png"></div>
							<div>수하물보관</div>
						</div>
					</div>
				</div>
			</div>
			<div id="right_hotelInfo">
				<div class="div_border" id="hotelInfo_review">
					<div class="review_left">	
						<div class="review_total"><%=reviewInfo.get("avg_totalSco") %></div>
					</div>
					<div class="review_right">
						<div><%=reviewInfo.get("htl_cond") %></div>
						<div><%=reviewInfo.get("review_cnt") %> 건의 이용후기</div>
					</div>
					<div class="review_detail">
						<div class="review_each">
							<div class="review_eachSub">
								<div>숙소 청결 상태</div>
								<div><%=reviewInfo.get("avg_clSco") %></div>
							</div>
							<div><input type="range" name="" min="0" max="10" value="<%=reviewInfo.get("avg_clSco") %>"></div>
						</div>
						<div class="review_each">
							<div class="review_eachSub">
								<div>부대시설</div>
								<div><%=reviewInfo.get("avg_conSco") %></div>
							</div>
							<div><input type="range" name="" min="0" max="10" value="<%=reviewInfo.get("avg_conSco") %>"></div>
						</div>
						<div class="review_each">
							<div class="review_eachSub">
								<div>위치</div>
								<div><%=reviewInfo.get("avg_loSco") %></div>
							</div>
							<div><input type="range" name="" min="0" max="10" value="<%=reviewInfo.get("avg_loSco") %>"></div>
						</div>
						<div class="review_each">
							<div class="review_eachSub">
								<div>서비스</div>
								<div><%=reviewInfo.get("avg_svcSco") %></div>
							</div>
							<div><input type="range" name="" min="0" max="10" value="<%=reviewInfo.get("avg_svcSco") %>"></div>
						</div>
					</div>
				</div>
				<div class="div_border" id="hotelInfo_lct">
					<div id="bl_map_space">
						<!-- Trigger/Open The Modal -->
						<a id="btn_modal">
							<div id="map_image">
								<img id="img1" alt="" src="image/bkg-map-entry.svg">
								<img id="img2" alt="" src="image/img-map-pin-red.svg">
								<span>지도에서 숙소 보기</span>
							</div>
						</a>
						<!-- The Modal -->
						<div id="myModal" class="modal">
							<!-- Modal content -->
							<div class="modal-content">
								<span class="close">&times;</span>
								<div id="map" style="width:1000px; height:500px;"></div>
							</div>
						</div>
					</div>
					<div class="div_line02"></div>
					<div id="hotelInfo_atrt">
						<div id="atrt_title">인기 관광지</div>
						<div class="atrt_name">인기 관광지</div>
						<div class="atrt_name">인기 관광지</div>
						<div class="atrt_name">인기 관광지</div>
					</div>
				</div>
			</div>
		</div>
		<div id="div_room">
			<div id="room_cnt">예약가능한 객실 종류 <b style="color: #e12d2d;"><%=remainCnt %></b>개 | 총 <b><%=htlRoomList.size() %></b>개 객실</div>
			
			<% for(int i=0; i<htlRoomList.size(); i++) { %>
				<div id="room_each" class="div_border <% if(htlRoomList.get(i).getBooking_cnt() > 0) out.print("chgOpacity"); %>">
					<div id="room_name"><%=htlRoomList.get(i).getHrm_name() %></div>
					<div id="room_total">
						<div id="room_title">
							<div class="room_image">객실/투숙 공간</div>
							<div class="room_servie">상품 안내</div>
							<div class="room_pers">최대 인원</div>
							<div class="room_price">1박당 요금</div>
							<div class="room_btn">예약하기</div>
						</div>
						<div id="room_content">
							<div class="room_image">
								<div id="img_space">
									<% 
										if(roomImgNum == 7) roomImgNum = 0;		// 호텔 당 사진 7개. 사진 그만 넣고싶어... 있는걸로 돌리자
										
										out.println("<div id='img_space01'>");
										out.println("<img src=" + fileList.get(roomImgNum) + ">");
										
										roomImgNum++;
										if(roomImgNum == 7) roomImgNum = 0;
										
										out.println("</div>");
										out.println("<div id='img_space02'>");
										out.println("<div><img src=" + fileList.get(roomImgNum) + "></div>");
										
										roomImgNum++;
										if(roomImgNum == 7) roomImgNum = 0;
										
										out.println("<div><img src=" + fileList.get(roomImgNum) + "></div>");
										out.println("</div>");
										
										roomImgNum++;
										if(roomImgNum == 7) roomImgNum = 0;
									%>
								</div>
							</div>
							<div class="div_roomBox">
								<div class="room_servie">
									<div class="roomSvc_comment">《예약 가능한 최저가》</div>
									<div>
										<b>[서비스/혜택]</b>
									</div>
									<div>
										<span><i class="fa-solid fa-panorama"></i></span>
										<span class="text_red"><%=commonDao.getCodeName(htlRoomList.get(i).getHrm_view()) %></span>
									</div>
									<div>
										<span><i class="fa-solid fa-bed"></i></span>
										<span class="text_red"><%=commonDao.getCodeName(htlRoomList.get(i).getHrm_bed()) %></span>
									</div>
									<div class="div_half">
										<span><i class="fa-solid fa-check"></i></span>
										<span>무료 Wi-Fi</span>
									</div>
									<div>
										<span><i class="fa-solid fa-check"></i></span>
										<span>1일 전 예약 취소 시, 예약 무료 취소 가능</span>
									</div>
								</div>
								<div class="room_pers">
									<div>
										<span><i class="fa-solid fa-person"></i></span>
										<span><i class="fa-solid fa-person"></i></span>
										<span><i class="fa-solid fa-person person-small"></i></span>
										<span><i class="fa-solid fa-person person-small"></i></span>
									</div>
									<div>아동 2명(18세 미만) 무료 투숙 가능</div>
									<div><%=htlRoomList.get(i).getHrm_maxpers() %>명</div>
								</div>
								<div class="room_price">
									<div class="price_comment">*오늘 25% 할인*</div>
									<div class="content_price">
										<div>₩<%=df.format(htlRoomList.get(i).getHrm_price()) %></div>
									</div>
									<div class="content_disPrice">
										<div>
											<span>₩</span>
											<span><%=df.format(htlRoomList.get(i).getHrm_price()*0.75) %></span>
										</div>
									</div>
									<div class="price_comment02">
										<div>1박당 요금 시작가</div>
									</div>
								</div>
								<div class="room_btn">
									<div class="book_btn">
										<button onclick="fn_goBooking(<%=htl_no %>, <%=htlRoomList.get(i).getHrm_no() %>, <%=htlRoomList.get(i).getBooking_cnt() %>)">예약하기</button>
									</div>
									<div class="btn_comment">
										<div>[부담제로]</div>
										<div>예약 취소 요금 없음</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			<% } %>
		</div>
		<div id="htlReview">
			<div class="htlRv_title"><%=hotel.getHtl_name() %> 실제 투숙객 작성 이용후기</div>
			<div class="htlRv_total div_border">
				<div class="htlRv_comment">종합 이용후기 점수</div>
				<div id="htlRv_review">
					<div id="htlRv_div_rv01">
						<div class="htlRv_div_left">	
							<div class="review_total"><%=reviewInfo.get("avg_totalSco") %></div>
						</div>
						<div class="htlRv_div_right">
							<div><%=reviewInfo.get("htl_cond") %></div>
							<div><%=reviewInfo.get("review_cnt") %> 건의 이용후기</div>
						</div>
					</div>
					<div class="htlRv_div_rv02">
						<div><%=reviewInfo.get("avg_clSco") %></div>
						<div>숙소청결 상태</div>
					</div>
					<div class="htlRv_div_rv02">
						<div><%=reviewInfo.get("avg_loSco") %></div>
						<div>숙소위치 점수</div>
					</div>
					<div class="htlRv_div_rv02">
						<div><%=reviewInfo.get("avg_conSco") %></div>
						<div>부대시설 점수</div>
					</div>
					<div class="htlRv_div_rv02_final">
						<div><%=reviewInfo.get("avg_svcSco") %></div>
						<div>서비스 점수</div>
					</div>
				</div>
			</div>
			<div class="div_line03"></div>
			<% for(int i=0; i<reviewList.size(); i++) { %>
				<div class="each_review">
					<div class="review_mem">
						<div class="div_reviewMem">
							<div><%=reviewList.get(i).getHrv_totalSco() %></div>
							<div></div>
							<div><%=commonDao.getLoginMember(reviewList.get(i).getMem_no()) %></div>
						</div>
					</div>
					<div class="review_content">
						<div class="div_review_cont"><%=reviewList.get(i).getHrv_content() %></div>
						<div class="div_line04"></div>
						<div class="div_review_date">작성일자: <%=reviewList.get(i).getHrv_date() %></div>
					</div>
					<div class="div_line03"></div>
				</div>
			<% } %>
		</div>
	</div>
	
	<!-- footer -->
	<jsp:include page="../include/HCAM_footer.jsp"/>
	
	<%
		commonDao.dbClose();
		fileDao.dbClose();
	%>
	
	<script>
		/* map */
		// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
		var infowindow = new kakao.maps.InfoWindow({zIndex:1});
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };  
		// 지도를 생성합니다
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		// 장소 검색 객체를 생성합니다
		var ps = new kakao.maps.services.Places(map); 
		// 카테고리로 호텔을 검색합니다
		ps.categorySearch('AD5', placesSearchCB, {useMapBounds:true}); 
		
		// 키워드 검색 완료 시 호출되는 콜백함수 입니다
		function placesSearchCB (data, status, pagination) {
		    if (status === kakao.maps.services.Status.OK) {
		        for (var i=0; i<data.length; i++) {
		            displayMarker(data[i]);    
		        }       
		    }
		}
		
		// 지도에 마커를 표시하는 함수입니다
		function displayMarker(place) {
		    // 마커를 생성하고 지도에 표시합니다
		    var marker = new kakao.maps.Marker({
		        map: map,
		        position: new kakao.maps.LatLng(place.y, place.x) 
		    });
		
		    // 마커에 클릭이벤트를 등록합니다
		    kakao.maps.event.addListener(marker, 'click', function() {
		        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
		        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
		        infowindow.open(map, marker);
		    });
		}
		
		/* Modal */
		// Get the modal
		var modal = document.getElementById("myModal");
		// Get the button that opens the modal
		var btn = document.getElementById("btn_modal");
		// Get the <span> element that closes the modal
		var span = document.getElementsByClassName("close")[0];
		
		// When the user clicks the button, open the modal 
		btn.onclick = function() {
			modal.style.display = "block";
			map.relayout();
			map.setCenter(new kakao.maps.LatLng(37.566826, 126.9786567));
			ps.categorySearch('AD5', placesSearchCB, {useMapBounds:true}); 
		}
	
		// When the user clicks on <span> (x), close the modal
		span.onclick = function() {
			modal.style.display = "none";
		}
	
		// When the user clicks anywhere outside of the modal, close it
		window.onclick = function(event) {
			if (event.target == modal) {
				modal.style.display = "none";
			}
		}
		
		/* 상단 검색 바  */
		//Get the button
		var searchCon = document.getElementById("search_content");	// Top Searching 버튼

		// When the user scrolls down 20px from the top of the document, show the button
		window.onscroll = function() {scrollFunction()};

		function scrollFunction() {
			var scrollTop = $(window).scrollTop();		// 위로 스크롤된 길이
			
			if (document.body.scrollTop > 50 || document.documentElement.scrollTop > 50) {
				searchCon.style.position = "fixed";
			} else {
				searchCon.style.position = "static";
			}
		}
		
		/* 달력 날짜 선택 */
		datePickerSet($("#top_chkIn"), $("#top_chkOut"), true); //다중은 시작하는 달력 먼저, 끝달력 2번째
		/*
		    * 달력 생성기
		    * @param sDate 파라미터만 넣으면 1개짜리 달력 생성
		    * @example   datePickerSet($("#datepicker"));
		    * 
		    * 
		    * @param sDate, 
		    * @param eDate 2개 넣으면 연결달력 생성되어 서로의 날짜를 넘어가지 않음
		    * @example   datePickerSet($("#datepicker1"), $("#datepicker2"));
		*/
		function datePickerSet(sDate, eDate, flag) {
	
		    //시작 ~ 종료 2개 짜리 달력 datepicker	
		    if (!isValidStr(sDate) && !isValidStr(eDate) && sDate.length > 0 && eDate.length > 0) {
		        var sDay = sDate.val();
		        var eDay = eDate.val();
	
		        if (flag && !isValidStr(sDay) && !isValidStr(eDay)) { //처음 입력 날짜 설정, update...			
		            var sdp = sDate.datepicker().data("datepicker");
		            sdp.selectDate(new Date(sDay.replace(/-/g, "/")));  //익스에서는 그냥 new Date하면 -을 인식못함 replace필요
	
		            var edp = eDate.datepicker().data("datepicker");
		            edp.selectDate(new Date(eDay.replace(/-/g, "/")));  //익스에서는 그냥 new Date하면 -을 인식못함 replace필요
		        }
	
		        /* 쟁구리가 고친곳임 (오늘일자 선택불가, 체크아웃일자는 체크인일자 다음날부터  선택가능하도록 고침) */
		        var now_utc = Date.now() 	// 지금 날짜를 밀리초로
				// getTimezoneOffset()은 현재 시간과의 차이를 분 단위로 반환
				var timeOff = new Date().getTimezoneOffset()*60000; // 분단위를 밀리초로 변환
				var today = new Date(now_utc-timeOff).toISOString().split("T")[0];
				// 체크아웃일자는 체크인일자 다음날로 선택가능하도록
		        var endDate = new Date(sDay.replace(/-/g, "/"));
		        endDate.setDate(endDate.getDate() + 1);
		        var fmt_endDate = new Date(endDate-timeOff).toISOString().split("T")[0];
				
				// 오늘일자 이전 선택 불가하도록
	            sDate.datepicker({
	            	minDate: new Date(today.replace(/-/g, "/"))
	            });
		        sDate.datepicker({
		            language: 'ko',
		            autoClose: true,
		            onSelect: function () {
		                datePickerSet(sDate, eDate);
		            }
		        });
	
		        //종료일자 세팅하기 날짜가 없는경우엔 제한을 걸지 않음
		        if (!isValidStr(sDay)) {
		            eDate.datepicker({
		                minDate: new Date(fmt_endDate.replace(/-/g, "/"))
		            });
		        }
		        eDate.datepicker({
		            language: 'ko',
		            autoClose: true,
		            onSelect: function () {
		                datePickerSet(sDate, eDate);
		            }
		        });
	
		        //한개짜리 달력 datepicker
		    } else if (!isValidStr(sDate)) {
		        var sDay = sDate.val();
		        if (flag && !isValidStr(sDay)) { //처음 입력 날짜 설정, update...			
		            var sdp = sDate.datepicker().data("datepicker");
		            sdp.selectDate(new Date(sDay.replace(/-/g, "/"))); //익스에서는 그냥 new Date하면 -을 인식못함 replace필요
		        }
	
		        sDate.datepicker({
		            language: 'ko',
		            autoClose: true
		        });
		    }
	
		    function isValidStr(str) {
		        if (str == null || str == undefined || str == "")
		            return true;
		        else
		            return false;
		    }
		}
	</script>
</body>
</html>