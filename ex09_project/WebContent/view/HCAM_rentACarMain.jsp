<%@page import="vo.RentACarDTO"%>
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
	
	String[] param_car_kubun = (String[]) request.getAttribute("param_car_kubun");
	String select01 = (String) request.getAttribute("select01");
	String select02 = (String) request.getAttribute("select02");
	String chkInDate = (String) request.getAttribute("chkInDate");
	String chkOutDate = (String) request.getAttribute("chkOutDate");
	String inTime = (String) request.getAttribute("inTime");
	String outTime = (String) request.getAttribute("outTime");
	
	/* 렌터카 전체 select */
	ArrayList<RentACarDTO> carList = (ArrayList<RentACarDTO>) request.getAttribute("carList");
	
	// 남은 차량 대수
	int remain_cnt = 0;
	for(int i=0; i<carList.size(); i++) {
		if(carList.get(i).getBooking_cnt() == 0) {
			remain_cnt++;
		}
	}
	
	// 체크박스 선택된 값 checked
	String car_chk01 = "";
	String car_chk02 = "";
	String car_chk03 = "";
	String car_chk04 = "";
	if(param_car_kubun != null) {
		for(int i=0; i<param_car_kubun.length; i++) {
			if(param_car_kubun[i].equals("RAC01001")) car_chk01 = "checked";
			if(param_car_kubun[i].equals("RAC01002")) car_chk02 = "checked";
			if(param_car_kubun[i].equals("RAC01003")) car_chk03 = "checked";
			if(param_car_kubun[i].equals("RAC01004")) car_chk04 = "checked";
		}
	}
	
	//System.out.println("param_car_kubun >>> " + param_car_kubun);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- jquery -->
<script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script>
<!-- css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/rentAcarMain.css">
<!-- icon -->
<script src="https://kit.fontawesome.com/ae515d5c73.js" crossorigin="anonymous"></script>
<!-- Air datepicker -->
<link href="js/datepicker/css/datepicker.min.css" rel="stylesheet" type="text/css" media="all">
<script src="js/datepicker/js/datepicker.js"></script>		<!-- Air datepicker js -->
<script src="js/datepicker/js/datepicker.ko.js"></script>	<!-- 달력 한글 추가를 위해 커스텀 -->
<!-- timepicker -->
<link href="js/datepicker/css/timepicker.css" rel="stylesheet" type="text/css" media="all">
<script src="js/datepicker/js/timepicker.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/timepicker@1.14.0/jquery.timepicker.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/timepicker@1.14.0/jquery.timepicker.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/timepicker@1.14.0/jquery.timepicker.js"></script>
<script src="https://cdn.jsdelivr.net/npm/timepicker@1.14.0/jquery.timepicker.min.js"></script>
<title>Insert title here</title>
</head>
<script>
	/* 차량 선택하기 */
	function fn_carDetailPopup(car_no, booking_cnt) {
		var url = "carDetail.do?command=carDetailPopup&car_no=" + car_no + "&booking_cnt=" + booking_cnt;
		var title = "popupOpener";
		var status = "toolbar=no,directories=no,scrollbars=no,resizable=no,status=no,menubar=no,width=800,height=730,top=100,left=500";
		window.open(url, title, "width=800, height=730, top=100, left=500");
	}
	
	/* 차량 예약하기 */
	function fn_chjBooking() {
		
		var car_no = $("input[name=car_no]").val();
		
		if(<%=mem_no %> == 0) {
			alert("로그인 후 예약 가능합니다.");
		}
		else if(car_no == "") {
			alert("차량 선택 후 예약 가능합니다.");
		}
	}
	
	/* popup에서 선택 시 display 상태 변경 */
	function fn_chgCheckDisplay(car_no) {
		// css 변경
		$('.div_class_check').css('display', 'none');
		$('.display' + car_no).css('display', 'block');
		
		// 예약 시 파라미터로 가져갈 car_no setting
		$("input[name=car_no]").val(car_no);
	}
	
	/* 렌터카 상단 검색 */
	function fn_carSearching() {
		var result = false;
		
		var sedan = $('#sedan').val();								// 세단
		var cabriolet = $('#cabriolet').val();						// 카리브올레
		var sport = $('#sport').val();								// 스포츠카
		var scooter = $('#scooter').val();							// 스쿠터
		var select01 = $('#car_select01 option:selected').val();	// 지역
		var select02 = $('#car_select02 option:selected').val();	// 지점
		var main_car_chkIn = $("#main_car_chkIn").val();			// 대여일자
		var search_car_intime = $("#search_car_intime").val();		// 대여시간
		var main_car_chkOut = $("#main_car_chkOut").val();			// 반납일자
		var search_car_outtime = $("#search_car_outtime").val();	// 반납시간
		
		// 시간 형식 체크
		var time_pattern = /^([1-9]|[01][0-9]|2[0-3]):([0-5][0-9])$/;
		
		// 날짜 체크
		if(main_car_chkIn >= main_car_chkOut) {
			alert("체크아웃일자는 체크인일자 이후로 선택하세요");
		}
		else if(main_car_chkIn == "" || main_car_chkOut == "") {
			alert("날짜를 선택하세요");
		}
		else if(!time_pattern.test(search_car_intime)) {
			alert("대여시간을 정확히 입력하세요");
		}
		else if(!time_pattern.test(search_car_outtime)) {
			alert("반납시간을 정확히 입력하세요");
		}
		else {
			result = true;
		}
		
		return result;
	}
</script>
<body>
	<!-- header -->
	<jsp:include page="../include/HCAM_header.jsp"/>
	
	<input type="hidden" name="car_no" value="">
	<div id="div_bodyContent">
		<div id="div_content">
			<div id="top_content">
				<form name="car_searching" method="POST" action="rentAcar.do?command=carMain" onsubmit="return fn_carSearching();">
					<input type="hidden" name="select01" value="<%=select01 %>">
					<input type="hidden" name="select02" value="<%=select02 %>">
	`				<div class="div_rentSearch" style="margin-left: -8px;">
						<div>대여일자</div>
						<div>
							<input type="text" name="main_car_chkIn" id="main_car_chkIn" value="<%=chkInDate %>" placeholder="체크인일자" readonly="true">
						</div>
					</div>
					<div class="div_rentSearch">
						<div>대여 시간</div>
						<div>
							<input type="text" name="search_car_intime" id="search_car_intime" value="<%=inTime %>" placeholder="시간선택" required size="8" maxlength="5">
						</div>
					</div>
					<div class="div_rentSearch">
						<div>반납일자</div>
						<div>
							<input type="text" name="main_car_chkOut" id="main_car_chkOut" value="<%=chkOutDate %>" placeholder="체크인일자" readonly="true">
						</div>
					</div>
					<div class="div_rentSearch">
						<div>반납 시간</div>
						<div>
							<input type="text" name="search_car_outtime" id="search_car_outtime" value="<%=outTime %>" placeholder="시간선택" required size="8" maxlength="5">
						</div>
					</div>
					<div class="div_rentSearch_car">
						<div id="car_kind_sec">
							<div>
								<input type="checkbox" name="car_kubun" id="sedan" value="RAC01001" <%=car_chk01 %>>
								<label for="sedan">
									<img src="image/icon/car_sedan_icon.png"><br>
								</label>
							</div>
							<div>
								<input type="checkbox" name="car_kubun" id="cabriolet" value="RAC01002" <%=car_chk02 %>>
								<label for="cabriolet">
									<img src="image/icon/car_cabriolet_icon.png"><br>
								</label>
							</div>
							<div>
								<input type="checkbox" name="car_kubun" id="sport" value="RAC01003" <%=car_chk03 %>>
								<label for="sport">
									<img src="image/icon/car_sport_icon.png"><br>
								</label>
							</div>
							<div>
								<input type="checkbox" name="car_kubun" id="scooter" value="RAC01004" <%=car_chk04 %>>
								<label for="scooter">
									<img src="image/icon/car_scooter_icon.png"><br>
								</label>
							</div>
						</div>
					</div>
					<div class="div_rentSearch_btn">
						<div>
							<input type="submit" value="검색하기">
						</div>
					</div>
				</form>
			</div>
			<div id="div_carContent">
				<div id="div_location">
					<span class="location_color">
						<i class="fa-solid fa-location-dot"></i>
					</span>
					<span class="location_color"><%=commonDao.getCodeName(select01) %> <%=commonDao.getCodeName(select02) %> 지점</span>
					<span>차량 검색</span>
				</div>
				<div id="div_remainCar">
					<div id="div_remainCnt">
						<span><i class="fa-solid fa-car-on"></i></span>
						<span>예약 가능 차량</span>
						<span><%=remain_cnt %></span>
						<span>대 | 총</span>
						<span><%=carList.size() %></span>
						<span>대</span>
					</div>
					<div id="div_bookingBtn">
						<a onclick="fn_chjBooking();">예약하기</a>
					</div>
				</div>
				<div id="div_allCarContent">
					<% for(int i=0; i<carList.size(); i++) { %>
						<div class="div_eachContent" onclick="fn_carDetailPopup(<%=carList.get(i).getCar_no() %>, <%=carList.get(i).getBooking_cnt() %>);">
							<div class="div_rlContent">
								<div class="div_image">
									<img alt="" src="<%=fileDao.getFilePath("car", carList.get(i).getCar_no()) %>">
									<% if(carList.get(i).getBooking_cnt() > 0) { %>
										<div class="div_class_booking">
											<div class="booking_shape">
												<div class="span_bookingStatus">예약완료</div>
											</div>
										</div>
									<% } else {%>
										<div class="div_class_check display<%=carList.get(i).getCar_no() %>">
											<div class="check_shape">
												<i class="fa-solid fa-check"></i>
											</div>
										</div>
									<% } %>
								</div>
								<div class="div_carName">
									<span><%=carList.get(i).getCar_name() %></span>
								</div>
								<div class="div_OptionContent">
									<div class="top_carOption">
										<div class="carOption carOptionTrue"><%=commonDao.getCodeName(carList.get(i).getCar_fuelKubun()) %></div>
										<div class="carOption <% if(carList.get(i).getCar_optBackCamera() == 1) out.print("carOptionTrue"); %>">후방카메라</div>
									</div>
									<div class="top_carOption">
										<div class="carOption <% if(carList.get(i).getCar_optNavi() == 1) out.print("carOptionTrue"); %>">네비게이션</div>
										<div class="carOption <% if(carList.get(i).getCar_optSmartkey() == 1) out.print("carOptionTrue"); %>">스마트키</div>
									</div>
								</div>
							</div>
						</div>
					<% } %>
				</div>
			</div>
		</div>
	</div>
	
	<!-- footer -->
	<jsp:include page="../include/HCAM_footer.jsp"/>
	
	<%
		commonDao.dbClose();
		fileDao.dbClose();
	%>
	
	<script type="text/javascript">
		
		/* 달력 날짜 선택 */
		datePickerSet($("#main_car_chkIn"), $("#main_car_chkOut"), true); 	// 렌터카메인 날짜 검색. 다중은 시작하는 달력 먼저, 끝달력 2번째
		
		$('#search_car_intime').timepicker({ 
			'scrollDefault': 'now',
			timeFormat: "H:i",    //24시간:분 으로표시
			'minTime': '6:00am',
			'maxTime': '8:30pm'
		});
		$('#search_car_outtime').timepicker({ 
			'scrollDefault': 'now',
			timeFormat: "H:i",    //24시간:분 으로표시
			'minTime': '6:00am',
			'maxTime': '8:30pm'
		});
		
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