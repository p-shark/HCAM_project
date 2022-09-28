<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- jquery -->
<script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script>
<!-- css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/join.css">
<title>Insert title here</title>
<style type="text/css">
	#div_bodyContent {
		padding: 100px 0 170px;
		width: 100%;
		height: 100%;
		background: url(../image/car/@temp-short-mbg.png) 0 0 no-repeat;
		background-size: 100% 100%;
	}
		#div_bodyContent div {
			justify-content: left;
		    position: relative;
		    width: 1280px;
		    min-width: 1280px;
		    height: 870px;
		    margin: 0 auto;
		    background-color: white;
		}
</style>
</head>
<body>
	<!-- header -->
	<jsp:include page="../include/HCAM_header.jsp"/>
	
	<div id="div_bodyContent">
		<div>
		</div>
	</div>
	
	<!-- footer -->
	<jsp:include page="../include/HCAM_footer.jsp"/>
</body>
</html>