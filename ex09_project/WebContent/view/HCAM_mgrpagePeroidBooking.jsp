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
	
	/* 일/주/월 별 호텔,렌터카 예약 건수 */
	ArrayList<Map<String, String>> peroidBooking = (ArrayList<Map<String, String>>) request.getAttribute("peroidBooking");
	
	/* for(int i=0; i<peroidBooking.size(); i++) {
		for(Map.Entry<String, String> code : peroidBooking.get(i).entrySet()) { 
			System.out.println("key: " + code.getKey() + " / value: " + code.getValue());
		}
	} */
	
	// 금액 포맷
	DecimalFormat df = new DecimalFormat("#,###");
	
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
		<div id="columnchart_material" style="width: 800px; height: 500px;"></div>
	</div>

	<script>
		google.charts.load('current', {'packages':['bar']});
		google.charts.setOnLoadCallback(drawChart);
		 
		function drawChart() {
		    var data = google.visualization.arrayToDataTable([
		        ['10월', '호텔', '렌터카'],
		        ['2014', 1000, 200],
		        ['2015', 1170, 250],
		        ['2016', 660, 1120],
		        ['2017', 1030, 540]
		    ]);
		 
		    var options = {
		        chart: {
		        title: '일 별 호텔, 렌터카 예약 건수',
		        subtitle: '호텔, 렌터카: 2022/10',
		        }
		    };
		 
		    var chart = new google.charts.Bar(document.getElementById('columnchart_material'));
		 
		    chart.draw(data, google.charts.Bar.convertOptions(options));
		}
	</script>
	
</body>
</html>