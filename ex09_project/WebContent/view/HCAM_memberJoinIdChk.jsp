<%@page import="db.DBInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
	String memid = request.getParameter("memid");
	
	Connection conn = null;
	Statement stmt = null;

	try {
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(DBInfo.URL, DBInfo.ROOT, DBInfo.PASSWORD);
		stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("select * from hcamMem where mem_id = '" + memid + "';");
		
		if(rs.next()) {
			// DB에 동일한 아이디의 데이터가 존재하면 강제 error 발생시킴
			response.sendError(HttpServletResponse.SC_FORBIDDEN);
			//String id = rs.getString("mem_id");
			//request.setAttribute("id", id);
			//out.println("id " + id);
		}
		
	}finally {
		try {
			stmt.close();
		}catch(Exception e) {
			
		}
		
		try {
			conn.close();
		}catch(Exception e) {
			
		}
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<input type="text" name="a" value="${id}">
</body>
</html>