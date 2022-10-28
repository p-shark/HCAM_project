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
		fn_callMbAgeChart();
		fn_callMbGenderChart();
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
	
	// 연령대 json 데이터 변수
	var queryAgeObject = "";
	/* 연령대 그래프 데이터 json 방식 */
	function fn_callMbAgeChart() {
		
		$.ajax({
			type : 'POST',
			url : 'view/HCAM_mgrpageMemDataChart.jsp',
			dataType : 'json',
			data: "kubun=age",
			success : function(data) {
				queryAgeObject = data;
				fn_callAgeChart();
			},
			error : function(xhr, type) {
				//alert('server error occoured')
				alert('server msg : ' + xhr.status);
			}
		});
	}
	
	/* 연령대 구글 차트 onload */
	function fn_callAgeChart() {
		google.charts.load('current', {'packages':['corechart']}); 
	    google.charts.setOnLoadCallback(drawAgeChart);
	}
	
	/* 연령대 구글 차트 데이터 set */
    function drawAgeChart() {
        var data = new google.visualization.DataTable();
        data.addColumn('string','연령대');
        data.addColumn('number','비중');

        data.addRows(queryAgeObject);
        
        var opt = {
                'title':'연령대 별 회원 수',
                'width':450,
                'height':450,
                pieSliceText:'label',
                legend:'none' 
        };
        var chart = new google.visualization.PieChart(document.getElementById('circlechart_age'));
        chart.draw(data,opt);
    }
    
 	// 성별 json 데이터 변수
	var queryGenderObject = "";
	/* 성별 그래프 데이터 json 방식 */
	function fn_callMbGenderChart() {
		
		$.ajax({
			type : 'POST',
			url : 'view/HCAM_mgrpageMemDataChart.jsp',
			dataType : 'json',
			data: "kubun=gender",
			success : function(data) {
				queryGenderObject = data;
				fn_callGenderChart();
			},
			error : function(xhr, type) {
				//alert('server error occoured')
				alert('server msg : ' + xhr.status);
			}
		});
	}
	
	/* 성별 구글 차트 onload */
	function fn_callGenderChart() {
		google.charts.load('current', {'packages':['corechart']}); 
	    google.charts.setOnLoadCallback(drawGenderChart);
	}
	
	/* 성별 구글 차트 데이터 set */
    function drawGenderChart() {
        var data = new google.visualization.DataTable();
        data.addColumn('string','성별');
        data.addColumn('number','비중');

        data.addRows(queryGenderObject);
        
        var opt = {
                'title':'성별 회원 수',
                'width':450,
                'height':450,
                pieSliceText:'label',
                legend:'none' 
        };
        var chart = new google.visualization.PieChart(document.getElementById('circlechart_gender'));
        chart.draw(data,opt);
    }
</script>
<body>
	<div id="circlechart_age" style="width: 370px; height: 550px;"></div>
	<div id="circlechart_gender" style="width: 300px; height: 550px;"></div>

	<%
		commonDao.dbClose();
	%>
	
</body>
</html>