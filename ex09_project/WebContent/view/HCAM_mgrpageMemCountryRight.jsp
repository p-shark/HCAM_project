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
		fn_callInitChart();
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
	var mcObject = "";
	/* 그래프 데이터 json 방식 */
	function fn_callInitChart() {
		var mgr_no = $("input[name='mgr_no']").val();			// 매니저 번호
		alert(111);
		$.ajax({
			type : 'POST',
			url : 'view/HCAM_mgrpageMemCountryChart.jsp',
			dataType : 'json',
			data: "mgr_no=" + mgr_no,
			success : function(data) {
				//alert(JSON.stringify(data,null, 2));
				mcObject = data;
				// json으로 데이터를 받기 전에 구글차트가 먼저 load되는 경우를 방지하기 위해 펑션을 나눔
				fn_callMcChart();
			},
			error : function(xhr, type) {
				alert('server msg : ' + xhr.status);
			}
		});
	}
	
	/* 구글 차트 onload */
	function fn_callMcChart() {
		google.charts.load('current', {'packages':['geochart'],});
		google.charts.setOnLoadCallback(drawMcChart);
	}
	
	/* 구글 차트 데이터 set */
	function drawMcChart() {
		var data = google.visualization.arrayToDataTable(mcObject);

        var options = {};

        var chart = new google.visualization.GeoChart(document.getElementById('regionChart_material'));

        chart.draw(data, options);
	}
	
	/* 구글 차트 데이터 set */
	/* function drawMcChart() {
		var data = google.visualization.arrayToDataTable([
          ['Country', 'Popularity'],
          ['Germany', 200],
          ['United States', 300],
          ['Brazil', 400],
          ['Canada', 500],
          ['France', 600],
          ['RU', 700]
        ]);

        var options = {};

        var chart = new google.visualization.GeoChart(document.getElementById('regionChart_material'));

        chart.draw(data, options);
	} */
	
</script>
<body>
	<input type="hidden" name="mgr_no" value="<%=mgr_no %>">
	
	<div id="regionChart_material" style="width: 830px; height: 550px;"></div>

	<%
		commonDao.dbClose();
	%>
	
</body>
</html>