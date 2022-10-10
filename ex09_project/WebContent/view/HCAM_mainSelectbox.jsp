<%@page import="java.util.Map"%>
<%@page import="java.util.TreeMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="dao.CommonDAO" id="commonDao"></jsp:useBean>
<%
	String topCode = request.getParameter("topCode");
	String kubun = request.getParameter("kubun");

	/* 코드별 하위코드 전체 조회 */
	TreeMap<String, String> commCodes = commonDao.getCodeByTopCode(topCode);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% if("top".equals(kubun)) { %>
		<div class="search_sec_icon">
		</div>
		<select class="search_sec_input" name="select02" id="select02">
			<option value="1">전체
			<% 
				for(Map.Entry<String, String> code : commCodes.entrySet()) { 
					out.println("<option value='" + code.getKey() + "'>" + code.getValue() + "</option>");
				}
			%>
		</select>
	<% } else if("main".equals(kubun)) { %>
		<div class="search_hotel_icon">
		</div>
		<select class="search_hotel_select" name="select02" id="htl_select02">
			<option value="1">전체
			<% 
				for(Map.Entry<String, String> code : commCodes.entrySet()) { 
					out.println("<option value='" + code.getKey() + "'>" + code.getValue() + "</option>");
				}
			%>
		</select>
	<% } else if("car".equals(kubun)) { %>
		<div class="search_car_icon">
		</div>
		<select class="search_car_select" name="select02" id="car_select02">
			<% 
				for(Map.Entry<String, String> code : commCodes.entrySet()) { 
					out.println("<option value='" + code.getKey() + "'>" + code.getValue() + "</option>");
				}
			%>
		</select>
	<% } %>
	
	<%
		commonDao.dbClose();
	%>
</body>
</html>