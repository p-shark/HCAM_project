<%@page import="java.util.Map"%>
<%@page import="java.util.TreeMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="dao.CommonDAO" id="commonDao"></jsp:useBean>
<%
	String topCode = request.getParameter("topCode");

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
</body>
</html>