<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	session.removeAttribute("id");
	session.removeAttribute("mem_no");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- css -->
<link rel="stylesheet" type="text/css" href="css/common.css">
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
	function fn_closeLogout(){
		window.opener.location.href="HCAM_main.jsp";
		window.close();
		
	}
</script>
<body>
	<div>
		<svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-door-open" viewBox="0 0 16 16">
			<path d="M8.5 10c-.276 0-.5-.448-.5-1s.224-1 .5-1 .5.448.5 1-.224 1-.5 1z"/>
			<path d="M10.828.122A.5.5 0 0 1 11 .5V1h.5A1.5 1.5 0 0 1 13 2.5V15h1.5a.5.5 0 0 1 0 1h-13a.5.5 0 0 1 0-1H3V1.5a.5.5 0 0 1 .43-.495l7-1a.5.5 0 0 1 .398.117zM11.5 2H11v13h1V2.5a.5.5 0 0 0-.5-.5zM4 1.934V15h6V1.077l-6 .857z"/>
		</svg><br>
		로그아웃 되었습니다.<br>
		<input type="button" value="확인" onClick="fn_closeLogout()">
	<div>
</body>
</html>