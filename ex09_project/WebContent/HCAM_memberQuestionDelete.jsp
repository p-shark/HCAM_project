<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>
<jsp:useBean class="vo.QuestionBoardDTO" id="list"></jsp:useBean>
<jsp:useBean class="dao.QuestionDAO" id="listConn"></jsp:useBean>
<%
	//한글 깨짐 방지
	request.setCharacterEncoding("UTF-8");
	int qbd_no = Integer.parseInt(request.getParameter("qbd_no"));
	/* 게시글 수정 */
	listConn.deleteAnswerList(qbd_no);
	listConn.deleteQestionList(qbd_no);
	
	response.sendRedirect("questionMain.co");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
</body>
</html>