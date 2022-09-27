<%@page import="vo.NoticeBoardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="dao.NoticeDAO" id="noticeDao"></jsp:useBean>
<jsp:useBean class="dao.CommonDAO" id="commonDao"></jsp:useBean>
<%
	int ntc_no = Integer.parseInt(request.getParameter("ntc_no"));

	/* 게시글 조회  */
	NoticeBoardDTO noticeList = noticeDao.getListsByNtcNo(ntc_no);
	
	// textarea로 입력 받은 글을 공백과 줄바꿈을 살려 출력하기
	String noticeContent = (noticeList.getNtc_content()).replaceAll("\n", "<br>");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- jquery -->
<script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script>
<!-- css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
<!-- icon -->
<script src="https://kit.fontawesome.com/ae515d5c73.js" crossorigin="anonymous"></script>
<title>Insert title here</title>
<style type="text/css">
	#div_content {
		margin: 0 auto;
		margin-top: 50px;
		margin-bottom: 150px;
		width: 800px;
	}
		#div_title {
			color: #f25555;
		}
		#div_info {
			margin-bottom: 5px;
		}
			#div_info div {
				display: inline-block;
				margin-right: 5px;
			}
			#div_info #div_ctgry {
				color: #f25555;
				font-weight: bold;
			}
			#div_info #div_name {
				font-weight: bold;
			}
		#div_button {
			color: #90949c;
		}
			#div_button div {
				display: inline-block;
			}
				#div_button div a {
					color: #90949c;
				}
			#kubun {
				font-size: 11px;
			    color: #dcdece;
			}
		.div_line {
			margin: 0px;
			margin-top: 20px;
			margin-bottom: 30px;
			min-width: 1px;
		    width: 800px;
		    height: 1px;
		    flex: 1 1 0%;
		    border-bottom: 1px solid rgb(221, 223, 226);
		}
		#board_content {
			width: 800px;
			min-height: 580px;
			margin-bottom: 30px;
		}
			#board_content div:first-child {
				margin-bottom: 30px;
			}
				
		#div_etc div {
			display: inline-block;
			margin-top: 15px;
			margin-right: 10px;
		}
			#div_etc div .fa-heart {
				margin-right: 2px;
				color: #f25555;
			}
			#div_etc div .fa-comment-dots {
				margin-right: 2px;
				color: #909090;
			}
			#div_etc div span {
				color: #909090;
			}
</style>
</head>
<body>
	<!-- header -->
	<jsp:include page="../include/HCAM_header.jsp"/>
	
	<div id="div_content">
		<div id="board_info">
			<div id="div_title"><h1><%=noticeList.getNtc_title()%></h1></div>
			<div id="div_info">
				<div id="div_ctgry"><%=commonDao.getCodeName(noticeList.getNtc_ctgry()) %></div>
				<div><%=noticeList.getNtc_date()%></div>
			</div>
		</div>
		<div class="div_line"></div>
		<div id="board_content">
			<div><font size="4pt"><%=noticeContent%></font></div>
		</div>
	</div>
	<!-- footer -->
	<jsp:include page="../include/HCAM_footer.jsp"/>
	
	<%
		commonDao.dbClose();
	%>
</body>
</html>