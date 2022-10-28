<%@page import="java.util.TreeMap"%>
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
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
	/* init window */
	$(document).ready(function(){
		fn_callMbRight();
	});

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
	
	/* 오른쪽 영역 재호출 */
	function fn_callMbRight() {
		$.ajax({
			url: "view/HCAM_mgrpageMemDataRight.jsp",
			type:'POST',
			dataType: "text",
			async:false,
			success: function(result) {
				$(".right_chart").html(result);
			},
			error: function(request, error) {
				alert(request.status + " / " + request.responseText + " / " + error);
			}
		});
	}
</script>
<body>
	<div class="right_inner">
		<div class="right_top">
			<div>기간별 예약내역</div>
			<div>(HCAM 사이트 내 등록되 회원의 정보)</div>
		</div>
		<div class="right_chart">
			
		</div>
	</div>
	
	<%
		commonDao.dbClose();
	%>
	
</body>
</html>