<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="vo.HcamMemDTO" id="hcamMem"></jsp:useBean>
<jsp:useBean class="dao.MemberDAO" id="memberDao"></jsp:useBean>
<%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw"); 
	
	int mem_no = memberDao.loginResult(id, pw);
	
	if(mem_no != 0) {
		session.setAttribute("id", id);
		session.setAttribute("mem_no", mem_no);
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% if(mem_no != 0) { %>
			<script>location.href = "HCAM_main.jsp"; </script>
	<% }else { 
			/* 회원정보가 없는 경우 id값 파라미터로 던짐 */
			String view = "HCAM_memberLogin.jsp?id=" +id; 
			response.sendRedirect(view);
	} %>
	<%-- <% }else { %>
			<script> window.history.back(); </script>
	<% } %> --%>
	
	<%
		memberDao.dbClose();
	%>
</body>
</html>