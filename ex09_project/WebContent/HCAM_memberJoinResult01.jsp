<%@page import="db.DBInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
	// 한글 깨짐 방지
	request.setCharacterEncoding("UTF-8");

	String memid = request.getParameter("memid");
	String pass_init = request.getParameter("pass_init");
	String name = request.getParameter("name");
	String email_id = request.getParameter("email_id");
	String email_addr = request.getParameter("email_addr");
	String nation = request.getParameter("nation");
	String phone = request.getParameter("phone");
	String postcode = request.getParameter("postcode");
	String addr_main = request.getParameter("addr_main");
	String addr_dtl = request.getParameter("addr_dtl");
	String gender = request.getParameter("gender");
	String birth_year = request.getParameter("birth_year");
	String birth_month = request.getParameter("birth_month");
	String birth_date = request.getParameter("birth_date");
	
	Connection conn = null;
	Statement stmt = null;
	
	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(DBInfo.URL, DBInfo.ROOT, DBInfo.PASSWORD);
		stmt = conn.createStatement();
		
		// 1.포인트 테이블 insert
		String hcamPoint_sql = "insert into hcamPoint(pnt_balance) values(0);";
		stmt.execute(hcamPoint_sql);
		
		// 2.포인트 테이블 insert 후 pnt_no 값 반환
		ResultSet rs = stmt.executeQuery("select max(pnt_no) as max_pntNo from hcamPoint;");
		int max_pntNo = 0;
		if(rs.next()) {
			max_pntNo = rs.getInt("max_pntNo");
		}
		
		// 3.회원정보 테이블 insert
		String hcamMem_sql = String.format("insert into hcamMem(pnt_no, mem_id, mem_pw, mem_name, mem_email, " + 
						"mem_nation, mem_phone, mem_post, mem_addr, mem_addrdtl, mem_gender, mem_birth) " +
						"values('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s');",
						max_pntNo, memid, pass_init, name, email_id + email_addr, nation, phone, postcode, 
						addr_main, addr_dtl, gender, birth_year + birth_month + birth_date);
		stmt.execute(hcamMem_sql);
		
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
	<!-- jquery -->
	<script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script>
	<!-- css -->
	<link rel="stylesheet" type="text/css" href="css/common.css">
	<title>Insert title here</title>
	
	
</head>
<script>
	/* init window */
	$(document).ready(function(){
		fn_join();
	});
	
	/* 회원가입 성공 */
	function fn_join() {
		var url = "HCAM_memberJoinResult02.jsp";
		var title = "popupOpener";
		var status = "toolbar=no,directories=no,scrollbars=no,resizable=no,status=no,menubar=no,width=500,height=300,top=100,left=500";
		window.open(url, title, "width=500, height=380, top=100, left=500");
	}
</script>
<body>

</body>
</html>