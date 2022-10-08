<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="dao.MemberDAO" id="memberDao"></jsp:useBean>
<%
	String kubun = request.getParameter("kubun");
	String id = request.getParameter("id");
	String pw = request.getParameter("pass_init");
	
	/* 비밀번호 변경 */
	memberDao.chgPassword(id, pw);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
<title>Insert title here</title>
<style>
	div{
		margin: 110px auto;
		width: 440px;
		/* color: #6799FF; */
		font-size: 16px;
		text-align: center;
	}
	input{
		margin: 20px auto;
		width: 60px;
		height: 30px;
		border: none;
		border-radius: 5px;
		background-color: var(--color-blue);
		color: white;
		cursor: pointer;
	}
	svg{
		margin-bottom: 10px;
	}
</style>
</head>
<script>
	function fn_closeLogin(kubun){
		if(kubun == 1) {
			window.opener.location.href="HCAM_memberLogin.jsp";
		}
		window.close();
	}
</script>
<body>
	<div>
		<svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-check-circle" viewBox="0 0 16 16" color="green">
		<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
		<path d="M10.97 4.97a.235.235 0 0 0-.02.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-1.071-1.05z"/>
		</svg><br>
		비밀번호가 변경되었습니다.<br>
		<input type="button" value="확인" onClick='fn_closeLogin(<%=kubun%>)'>
	<div>
	
	<%
		memberDao.dbClose();
	%>
</body>
</html>