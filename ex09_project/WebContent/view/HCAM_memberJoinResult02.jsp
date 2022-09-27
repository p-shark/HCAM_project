<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
<!-- icon -->
<script src="https://kit.fontawesome.com/ae515d5c73.js" crossorigin="anonymous"></script>
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
	function fn_closeJoin(){
		window.opener.location.href="${pageContext.request.contextPath}/HCAM_main.jsp";
		window.close();
		
	}
</script>
<body>
	<div>
		<i class="fa-solid fa-person-circle-plus fa-3x"></i><br><br>
		회원가입 되었습니다.<br>
		<input type="button" value="확인" onClick="fn_closeJoin()">
	<div>
</body>
</html>