<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="vo.HcamMemDTO"%>
<%@page import="java.util.ArrayList"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<body>
<table border="1">
	<tr><td>사번</td><td>이름</td><td>직급</td><td>전화</td></tr>
<%
	ArrayList<HcamMemDTO> list = (ArrayList<HcamMemDTO>)request.getAttribute("data");
	for(HcamMemDTO dto : list){
%>
	<tr>
		<td><%=dto.getMem_no()%></td>
		<td><%=dto.getMem_id()%></td>
		<td><%=dto.getMem_pw()%></td>
		<td><%=dto.getMem_name()%></td>
	</tr>

<%		
	}
%>
</table>

</body>
</html>




