<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>
<jsp:useBean class="vo.QuestionBoardDTO" id="list"></jsp:useBean>
<jsp:useBean class="dao.QuestionDAO" id="questionDAO"></jsp:useBean>
<%
	//한글 깨짐 방지
	request.setCharacterEncoding("UTF-8");
	
	// 세션에 저장된 mem_no 값 가져오기
	int mem_no = 0; 
	if(session.getAttribute("mem_no") != null){
		mem_no = Integer.parseInt(String.valueOf(session.getAttribute("mem_no")));
	}
	
	String ctgry = request.getParameter("qbd_ctgry");
	String title = request.getParameter("qbd_title");
	String content = request.getParameter("qbd_content");
	
	list.setMem_no(mem_no);
	list.setQbd_ctgry(ctgry);
	list.setQbd_title(title);
	list.setQbd_content(content);
	
	/* 질문사항 등록 */
	questionDAO.insertList(list);
	
	response.sendRedirect("questionMain.co");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>

<body>
	
</body>
</html>