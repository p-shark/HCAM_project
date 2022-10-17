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
						<span class="inner_tab_title">호텔 좋아요</span>
					</li>
					<li data-tab="inner_tab2">
						<span class="inner_tab_icon"><i class="fa-solid fa-campground"></i></span>
						<span class="inner_tab_title">렌터카 좋아요</span>
					</li>
					<li data-tab="inner_tab3">
						<span class="inner_tab_icon"><i class="fa-solid fa-car-rear"></i></span>
						<span class="inner_tab_title">마켓 좋아요</span>
					</li>
				</ul>
			</div>
			<!-- 호텔 예약관리 -->
			<div id="inner_tab1" class="inner_cnt inner_on">
				11
			</div>
			<div id="inner_tab2" class="inner_cnt">
				<h2>오늘의 할일</h2>
				<ul>
					<li>홍삼먹기</li>
					<li>연차</li>
				</ul>
			</div>
			<!-- 렌터카 예약관리 -->
			<div id="inner_tab3" class="inner_cnt">
				33
			</div>
		</div>
	</div>
</body>
</html>