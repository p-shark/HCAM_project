<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
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
	String mem_name = "";
	if(session.getAttribute("mem_name") != null) {
		mem_name = String.valueOf(session.getAttribute("mem_name"));
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- jquery -->
<script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script>
<!-- css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/mgrpageMain.css">
<!-- icon -->
<script src="https://kit.fontawesome.com/ae515d5c73.js" crossorigin="anonymous"></script>
<!-- google chart -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<title>Insert title here</title>
<style>
	
			
</style>
</head>
<script>
	/* init window */
	$(document).ready(function(){
		/* 탭 메뉴 오른쪽 화면 호출 */
		go_tabPage("mgrpage.do?command=peroidBooking");
	});

	$(function() {
		/* 왼쪽 tab */
		$('ul.left_tab_tit li').click(function() {
			var url_onTab = $(this).attr('data-tab');
			$('ul.left_tab_tit li').removeClass('on');
			//$('.left_cnt').removeClass('on');
			$(this).addClass('on');
			//$('#' + onTab).addClass('on');

			/* 탭 메뉴 오른쪽 화면 호출 */
			go_tabPage(url_onTab);
		})
	});
	
	/* 탭 메뉴 오른쪽 화면 호출 */
	function go_tabPage(url_onTab) {
		var mem_no = $("input[name='mem_no']").val();
		var pnt_no = $("input[name='pnt_no']").val();
		
		$.ajax({
			url: url_onTab,
			type:'POST',
			dataType: "text",
			async:false,
			data: "mem_no=" + mem_no + 
				  "&pnt_no=" + pnt_no,
			success: function(result) {
				$("#right_content").html(result);
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
	
	<input type="hidden" name="mem_no" value="<%=mem_no %>">
	<input type="hidden" name="pnt_no" value="<%=pnt_no %>">
	<div id="div_content">
		<div id="left_content">
			<ul class="left_tab_tit">
				<li class="on" data-tab="mgrpage.do?command=peroidBooking">
					<span class="left_tab_icon"><i class="fa-regular fa-calendar-check"></i></span>
					<span class="left_tab_title">기간별 예약내역</span>
				</li>
				<li data-tab="mgrpage.do?command=timeLineBooking">
					<span class="left_tab_icon"><i class="fa-brands fa-shopify"></i></span>
					<span class="left_tab_title">요일/시간대별 내역</span>
				</li>
				<li data-tab="mgrpage.do?command=memberData">
					<span class="left_tab_icon"><i class="fa-solid fa-heart"></i></span>
					<span class="left_tab_title">HCAM 회원 데이터</span>
				</li>
				<li data-tab="mgrpage.do?command=memberCountry">
					<span class="left_tab_icon"><i class="fa-brands fa-product-hunt"></i></span>
					<span class="left_tab_title">회원 지역별 분포</span>
				</li>
				<li data-tab="mgrpage.do?command=expectedProfit">
					<span class="left_tab_icon"><i class="fa-solid fa-circle-user"></i></span>
					<span class="left_tab_title">수익률</span>
				</li>
			</ul>
		</div>
		<div id="right_content">
			
		</div>
	</div>
	
	<!-- footer -->
	<jsp:include page="../include/HCAM_footer.jsp"/>
	
</body>
</html>