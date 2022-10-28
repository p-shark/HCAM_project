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
	String mgr_no = request.getParameter("mgr_no"); 
	String date_kubun = request.getParameter("date_kubun");
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
		fn_callPdChart();
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
	
	// json 데이터 변수
	var queryObject = "";
	/* 그래프 데이터 json 방식 */
	function fn_callPdChart() {
		var mgr_no = $("input[name='mgr_no']").val();			// 매니저 번호
		var date_kubun = $("input[name='date_kubun']").val();	// date_kubun(일/월)
		
		$.ajax({
			type : 'POST',
			url : 'view/HCAM_mgrpagePeroidChart.jsp',
			dataType : 'json',
			data: "mgr_no=" + mgr_no + 
			  	  "&date_kubun=" + date_kubun,
			success : function(data) {
				//alert(JSON.stringify(data,null, 2));
				queryObject = data;
				// json으로 데이터를 받기 전에 구글차트가 먼저 load되는 경우를 방지하기 위해 펑션을 나눔
				fn_callChart();
				//queryObject = eval('(' + JSON.stringify(data,null, 2) + ')');
				//queryObjectLen = queryObject.dustlist.length;
				//alert('Total lines : ' + queryObjectLen + 'EA');
			},
			error : function(xhr, type) {
				//alert('server error occoured')
				alert('server msg : ' + xhr.status);
			}
		});
	}
	
	/* 구글 차트 onload */
	function fn_callChart() {
		google.charts.load('current', {'packages':['bar']});
		google.charts.setOnLoadCallback(drawChart);
	}
	
	/* 구글 차트 데이터 set */
	function drawChart() {
	    var data = google.visualization.arrayToDataTable(queryObject, false);
	 
	    var options = {
	        chart: {
	        title: '호텔, 렌터카 예약 건수',
	        subtitle: '호텔, 렌터카: 2022/10',
	        }
	    };
	 
	    var chart = new google.charts.Bar(document.getElementById('columnchart_material'));
	 
	    chart.draw(data, google.charts.Bar.convertOptions(options));
	}
	
</script>
<body>
	<input type="hidden" name="mgr_no" value="<%=mgr_no %>">
	<input type="hidden" name="date_kubun" value="<%=date_kubun %>">
	
	<div id="columnchart_material" style="width: 830px; height: 550px;"></div>

	<%
		commonDao.dbClose();
	%>
	
</body>
</html>