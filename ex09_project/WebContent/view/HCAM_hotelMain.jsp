<%@page import="db.DBInfo"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.TreeMap"%>
<%@page import="vo.PageInfo"%>
<%@page import="vo.HotelDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="dao.CommonDAO" id="commonDao"></jsp:useBean>
<jsp:useBean class="dao.HcamFileDAO" id="fileDao"></jsp:useBean>
<%
	// 국가, 지역
	String select01 = (String) request.getAttribute("select01");
	String select02 = (String) request.getAttribute("select02");
	
	// 체크인, 체크아웃 일자
	String checkIn = (String) request.getAttribute("chekIn");
	String checkOut = (String) request.getAttribute("checOut");
	/* 호텔 전체 목록 */
	ArrayList<HotelDTO> hotelList = (ArrayList<HotelDTO>) request.getAttribute("hotelList");
	/* 호텔 부가정보 */
	ArrayList<TreeMap<String, String>> hotelAdnInfos = (ArrayList<TreeMap<String, String>>) request.getAttribute("hotelAdnInfos");
	PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
	
	/* 코드별 공통코드 전체 조회 */
	TreeMap<String, String> commCodes = commonDao.getCodeAllByCode("CCD02");
	
	int pageNo = 1;
	
	// 페이징 처리를 위한 변수
	int listCount=pageInfo.getListCount();
	int nowPage=pageInfo.getPage();
	int maxPage=pageInfo.getMaxPage();
	int startPage=pageInfo.getStartPage();
	int endPage=pageInfo.getEndPage();
	
	//현재일자, 다음날일자 구하기
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	Calendar cal = Calendar.getInstance();
	String today = sdf.format(cal.getTime());
	cal.add(Calendar.DATE, 1);
	String tomorrow = sdf.format(cal.getTime());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- jquery -->
<script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script>
<!-- css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/hotelMain.css">
<!-- kakaoMap api -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2ba53fbf9c283e34734ca1b92dfbf253&libraries=services"></script>
<title>Insert title here</title>
</head>
<script>
	/* init window */
	$(document).ready(function(){
		var now_utc = Date.now() 	// 지금 날짜를 밀리초로
		var tomo_utc = new Date();	// 다음 날짜를 밀리초로
		tomo_utc.setDate(tomo_utc.getDate() + 1); 			// 1일 더하여 setting
		
		// getTimezoneOffset()은 현재 시간과의 차이를 분 단위로 반환
		var timeOff = new Date().getTimezoneOffset()*60000; // 분단위를 밀리초로 변환
		
		var today = new Date(now_utc-timeOff).toISOString().split("T")[0];
		var tomorrow = new Date(tomo_utc-timeOff).toISOString().split("T")[0];
		
		document.getElementById("top_chkIn").setAttribute("min", today);
		document.getElementById("top_chkOut").setAttribute("min", tomorrow);
	});
	
	/* 체크인, 체크아웃 일자 변경 시 체크 */
	function fn_chgDate(obj, kubun) {
		
		var oldValue = obj.value;

		var today = $("input[name='today']").val();				// 최저요금
		var tomorrow = $("input[name='tomorrow']").val();				// 최저요금
		
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
	
	/* range 값 변경 시*/
	function fn_chgRange(value) {
		var max_fee = $("input[name='max_fee']");
		max_fee.val(value);
	}
	
	// 호텔 더보기용 페이지No
	var va_page_no = 2;
	/*호텔 더보기 */
	function fn_appendHotel() {
		fn_leftSearch(va_page_no);
		va_page_no++;
	}
	
	/* left 추가 검색 */
	function fn_leftSearch(p_pageNo) {
		
		var select01 = $('#select01 option:selected').val();
		var select02 = $('#select02 option:selected').val();
		var top_chkIn = $("input[name='top_chkIn']").val();			// 체크인일자
		var top_chkOut = $("input[name='top_chkOut']").val();		// 체크아웃일자
		var min_fee = $("input[name='min_fee']").val();				// 최저요금
		var max_fee = $("input[name='max_fee']").val();				// 최고요금
		// 텍스트검색에 아무값이 없거나, 체크박스 미선택 시 0으로 세팅 (why? 스토어드프로시저에서 dynamic query할때 빈값을 제대로 체크 못함)
		var lctName = "0";											// 텍스트 검색
		var grade01 = "0";
		var grade02 = "0";
		var grade03 = "0";
		var service01 = "0";
		var service02 = "0";
		var service03 = "0";
		var service04 = "0";
		var service05 = "0";
		var review_score = "0";
		var sortBy = "0"			// ***************** 이걸 넣으면 fileDAO.getFileList 에 orderby도 변경해야하는데.....   **********************/
		var v_pageNo = 1;
		var v_endNo = $("input[name='endPage']").val();
		
		if($("input[name='lctName']").val() != "") {
			lctName = $("input[name='lctName']").val()
		}
		if($("#grade01").is(":checked") == true){
			grade01 = $("#grade01").val();
		}
		if($("#grade02").is(":checked") == true){
			grade02 = $("#grade02").val();
		}
		if($("#grade03").is(":checked") == true){
			grade03 = $("#grade03").val();
		}
		
		if($("#service01").is(":checked") == true){
			service01 = $("#service01").val();
		}
		if($("#service02").is(":checked") == true){
			service02 = $("#service02").val();
		}
		if($("#service03").is(":checked") == true){
			service03 = $("#service03").val();
		}
		if($("#service04").is(":checked") == true){
			service04 = $("#service04").val();
		}
		if($("#service05").is(":checked") == true){
			service05 = $("#service05").val();
		}
		
		if($("input:radio[name=review_score]").is(":checked") == true){
			review_score = $("input[name='review_score']:checked").val();
		}
		
		if($("input:radio[name=sortBy]").is(":checked") == true){
			sortBy = $("input[name='sortBy']:checked").val();
		}
		
		// p_pageNo 파리미터가 넘어오지 않는 경우(ex.left 검색바) undefined 이면 첫페이지니까 v_page_no=1
		if(typeof p_pageNo == "undefined") {
	    	v_page_no = 1;
	    	// 전역변수인 va_page_no를 2로 초기화
			va_page_no = 2;
	    }
		else { // undefined 아닌 경우는 호텔더보기 클릭한 경우니까 넘어온 p_pageNo 파리미터로 세팅
			v_page_no = p_pageNo;
		}
		
		/* var gradeValues = "/";										// 호텔성급
		$("input[name='grade']").each(function(i) {
			if($(this).is(":checked") == true){
				gradeValues += $(this).val() + "/";
			}
			else {
				gradeValues += "/";
			}
	    });
		
		/* 
		// 배열 만들기
		var gradeValues = [];										// 호텔성급
		$("input[name='grade']:checked").each(function(i) {
			gradeValues.push($(this).val());
	    });
		var serviceValues = [];								// 이용가능 서비스 / 옵션
		$("input[name='service']:checked").each(function(i) {
			serviceValues.push($(this).val());
	    });
		var reviewValues = [];								// 투숙객 평가점수
		$("input[name='review_score']:checked").each(function(i) {
			reviewValues.push($(this).val());
	    }); */
	    
	    var RegExpNumber = /^[0-9]+$/; 	// 숫자 체크
		if(!RegExpNumber.test(min_fee)) {
			alert("금액은 숫자만 입력 가능합니다.");
			return;
		}
		else if(!RegExpNumber.test(max_fee)) {
			alert("금액은 숫자만 입력 가능합니다.");
			return;
		}
	    
	    if(min_fee >= max_fee) {
	    	alert("최소/최대금액값을 확인하세요.");
	    	return;
	    }
	    
		var allData = {
			"select01" : select01,
			"select02" : select02,
			"top_chkIn" : top_chkIn,
			"top_chkOut" : top_chkOut,
			"lctName" : lctName,
			"min_fee" : min_fee,
			"max_fee" : max_fee,
			"grade01" : grade01,
			"grade02" : grade02,
			"grade03" : grade03,
			"service01" : service01,
			"service02" : service02,
			"service03" : service03,
			"service04" : service04,
			"service05" : service05,
			"review_score" : review_score,
			"sortBy" : sortBy,
			"pageNo" : v_page_no
		};
	    
		$.ajax({
			url: "view/HCAM_hotelMainBySearching.jsp",
			type:'POST',
			dataType: "text",
			async:false,
			data: allData,
			success: function(result) {
				if(v_page_no == 1) {
					$("#right_content").html(result);
			    }
				else {
					$(".append_hotel").remove();
			    	$("#right_content").append(result);
			    }
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
	
	<input type="hidden" name="today" value="<%=today %>">			<!-- 현재일자 -->
	<input type="hidden" name="tomorrow" value="<%=tomorrow %>">	<!-- 다음날일자 -->
	<div class="search_content" id="search_content">
		<section class="search_section">
			<form name="top_searching" method="POST" action="hotelMain.ho" onsubmit="return fn_topSearching();">
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
						<input class="search_sec_input" type="date" name="top_chkIn" id="top_chkIn" value="<%=checkIn %>" onblur="fn_chgDate(this ,1);" placeholder="체크인일자">
	
					</li>
					<li>
						<div class="search_sec_icon">
							<svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-calendar-check" viewBox="0 0 16 16">
							  <path d="M10.854 7.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L7.5 9.793l2.646-2.647a.5.5 0 0 1 .708 0z"/>
							  <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4H1z"/>
							</svg>
						</div>
						<input class="search_sec_input" type="date" name="top_chkOut" id="top_chkOut" value="<%=checkOut %>" onblur="fn_chgDate(this ,2)" placeholder="체크아웃">
					</li>
					<li>
						<input type="submit" value="검색하기">
					</li>
				</ul>
			</form>
		</section>
	</div>
	
	<div id="div_content">
		<button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>
		<div id="div_left">
			<form name="left_searching" action="">
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
				<div id="bl_search_space">
					<div class="div_seacrch">
						<input class="left_search_input" type="text" name="lctName" onkeypress="javascript:if(event.keyCode == 13) {fn_leftSearch();}" placeholder="텍스트 검색">
						<div class="lctName_sec_icon">
							<a onclick="fn_leftSearch();">
								<svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
									<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
								</svg>
							</a>
						</div>
					</div>
				</div>
				<div id="bl_fee_space">
					<div id="fee_text_space1">
						<div>
							<p>서울 인기 검색 조건</p>
							<p>요금 범위 (1박당)</p>
						</div>
					</div>
					<div id="fee_slider_space">
						<div>
							<input type="range" name="fee_range" min="0" max="1000000" step="1000" value="500000" oninput="fn_chgRange(this.value);" onchange="fn_leftSearch();">
						</div>
					</div>
					<div id="fee_text_space2">
						<div>
							<span>이상</span>
							<span>이하</span>
						</div>
						
					</div>
					<div id="fee_minMax_space">
						<div>
							<img alt="" src="image/icon/won_sign_icon.png">
							<input type="number" name="min_fee" value="0" onchange="fn_leftSearch();">
						</div>
						<div>
							<img alt="" src="image/icon/won_sign_icon.png">
							<input type="number" name="max_fee" value="500000" onchange="fn_leftSearch();">
						</div>
					</div>
				</div>
				<div class="div_line"></div>
				<div class="bl_space">
					<div class="bl_title">
						<span>호텔 성급</span>
					</div>
					<div class="bl_checkboxes_grade">
						<input type="checkbox" name="grade" value="5" id="grade01" onclick="fn_leftSearch();">
						<label for="grade01">
							<img class="star_icon" alt="" src="image/icon/star_icon.png">
							<img class="star_icon" alt="" src="image/icon/star_icon.png">
							<img class="star_icon" alt="" src="image/icon/star_icon.png">
							<img class="star_icon" alt="" src="image/icon/star_icon.png">
							<img class="star_icon" alt="" src="image/icon/star_icon.png">
						</label><br>
						<input type="checkbox" name="grade" value="4" id="grade02" onclick="fn_leftSearch();">
						<label for="grade02">
							<img class="star_icon" alt="" src="image/icon/star_icon.png">
							<img class="star_icon" alt="" src="image/icon/star_icon.png">
							<img class="star_icon" alt="" src="image/icon/star_icon.png">
							<img class="star_icon" alt="" src="image/icon/star_icon.png">
						</label><br>
						<input type="checkbox" name="grade" value="3" id="grade03" onclick="fn_leftSearch();">
						<label for="grade03">
							<img class="star_icon" alt="" src="image/icon/star_icon.png">
							<img class="star_icon" alt="" src="image/icon/star_icon.png">
							<img class="star_icon" alt="" src="image/icon/star_icon.png">
						</label>
						<!-- <input type="radio" name="grade" value="5" id="grade5">
						<label for="grade5">
							<img class="star_icon" alt="" src="image/icon/star_icon.png">
							<img class="star_icon" alt="" src="image/icon/star_icon.png">
							<img class="star_icon" alt="" src="image/icon/star_icon.png">
							<img class="star_icon" alt="" src="image/icon/star_icon.png">
							<img class="star_icon" alt="" src="image/icon/star_icon.png">
						</label><br>
						<input type="radio" name="grade" value="5" id="grade4">
						<label for="grade4">
							<img class="star_icon" alt="" src="image/icon/star_icon.png">
							<img class="star_icon" alt="" src="image/icon/star_icon.png">
							<img class="star_icon" alt="" src="image/icon/star_icon.png">
							<img class="star_icon" alt="" src="image/icon/star_icon.png">
						</label><br>
						<input type="radio" name="grade" value="5" id="grade3">
						<label for="grade3">
							<img class="star_icon" alt="" src="image/icon/star_icon.png">
							<img class="star_icon" alt="" src="image/icon/star_icon.png">
							<img class="star_icon" alt="" src="image/icon/star_icon.png"><br>
						</label> -->
					</div>
				</div>
				<div class="div_line"></div>
				<div class="bl_space">
					<div class="bl_title">
						<span>이용 가능 서비스 / 옵션</span>
					</div>
					<div class="bl_checkboxes_text">
						<input type="checkbox" name="service" value="1" id="service01" onclick="fn_leftSearch();">
						<label for="service01">조식</label><br>
						<input type="checkbox" name="service" value="1" id="service02" onclick="fn_leftSearch();">
						<label for="service02">수영장</label><br>
						<input type="checkbox" name="service" value="1" id="service03" onclick="fn_leftSearch();">
						<label for="service03">주차 가능</label><br>
						<input type="checkbox" name="service" value="1" id="service04" onclick="fn_leftSearch();">
						<label for="service04">편의시설</label><br>
						<input type="checkbox" name="service" value="1" id="service05" onclick="fn_leftSearch();">
						<label for="service05">수하물 보관</label> 
					</div>
				</div>
				<div class="div_line"></div>
				<div class="bl_space">
					<div class="bl_title">
						<span>투숙객 평가 점수</span>
					</div>
					<div class="bl_checkboxes_text">
						<input type="radio" name="review_score" value="9" id="review01" onclick="fn_leftSearch();">
						<label for="review01"><b>9+</b> 최고</label><br>
						<input type="radio" name="review_score" value="8" id="review02" onclick="fn_leftSearch();">
						<label for="review02"><b>8+</b> 우수</label><br>
						<input type="radio" name="review_score" value="7" id="review03" onclick="fn_leftSearch();">
						<label for="review03"><b>7+</b> 좋음</label><br>
						<input type="radio" name="review_score" value="6" id="review04" onclick="fn_leftSearch();">
						<label for="review04"><b>6+</b> 양호</label><br>
					</div>
				</div>
			</form>
		</div>
		<div id="div_right">
			<div id="right_top">
				<ul id="right_top_ul">
					<div><li>정렬 기준</li></div>
					<div>
						<li>
							<input type="radio" name="sortBy" value="recomm" id="sortBy01" onclick="fn_leftSearch();">
							<label for="sortBy01">추천 상품</label>
						</li>
					</div>
					<div>
						<li>
							<input type="radio" name="sortBy" value="review" id="sortBy02" onclick="fn_leftSearch();">
							<label for="sortBy02">투숙객 평점 높은 순</label>
						</li>
					</div>
					<div>
						<li>
							<input type="radio" name="sortBy" value="low" id="sortBy03" onclick="fn_leftSearch();">
							<label for="sortBy03">낮은 요금순</label>
						</li>
					</div>
					<div>
						<li>
							<input type="radio" name="sortBy" value="high" id="sortBy04" onclick="fn_leftSearch();">
							<label for="sortBy04">높은 요금순</label>
						</li>
					</div>
				</ul>
			</div>
			<div id="right_middle">
				<div class="middle_line"></div>
				<div><span>검색 결과 목록</span></div>
				<div class="middle_line"></div>
			</div>
			<div id="right_content">
				<input type="hidden" name="endPage" value="<%=endPage %>">	<!-- 마지막 페이지 -->
				<% for(int i=0; i<hotelList.size(); i++) { %>
					<input type="hidden" name="htl_no" value="<%=hotelList.get(i).getHtl_no() %>">	<!-- 호텔 No -->
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
				<div class="append_hotel">
					<button onclick="fn_appendHotel();">호텔 더보기 (More)</button>
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
		var mybutton = document.getElementById("myBtn");			// Top 버튼
		var searchCon = document.getElementById("search_content");	// Top Searching 버튼

		// When the user scrolls down 20px from the top of the document, show the button
		window.onscroll = function() {scrollFunction()};

		function scrollFunction() {
			var scrollTop = $(window).scrollTop();		// 위로 스크롤된 길이
			var windowHeight = $(window).height();		// 웹브라우저의 창의 높이
			var documentHeight = $(document).height();	// 문서 전체의 높이
			var isBottom = scrollTop + windowHeight + 50 >= documentHeight; // 스크롤이 바닥까지 내려왔는지 체크
			
			var v_endNo = $("input[name='endPage']").val();
			
			// 스크롤이 최하단까지 내려오면 다음 페이지의 데이터 조회
			/* if(isBottom) {
				fn_leftSearch(2);
				s_pageNo++;
			} */
			
			if (document.body.scrollTop > 50 || document.documentElement.scrollTop > 50) {
				searchCon.style.position = "fixed";
			} else {
				searchCon.style.position = "static";
			}
			
			/* if(scrollTop + windowHeight + 200 >= documentHeight) {
				mybutton.style.bottom = "230px";
			}
			else {
				mybutton.style.bottom = "20px";
			} */
		}

		// When the user clicks on the button, scroll to the top of the document
		function topFunction() {
		  document.body.scrollTop = 0;
		  document.documentElement.scrollTop = 0;
		}
	</script>
</body>
</html>