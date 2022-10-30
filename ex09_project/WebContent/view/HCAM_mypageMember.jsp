<%@page import="vo.HcamMemDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그인한 회원정보
	String id = (String) session.getAttribute("id");
	// 세션에 저장된 mem_no 값 가져오기 
	int mem_no = 0;
	if(session.getAttribute("mem_no") != null) {
		mem_no = Integer.parseInt(String.valueOf(session.getAttribute("mem_no")));
	}
	String mem_name = "";
	if(session.getAttribute("mem_name") != null) {
		mem_name = String.valueOf(session.getAttribute("mem_name"));
	}
	
	/* 회원 정보 */
	ArrayList<HcamMemDTO> memberInfo = (ArrayList<HcamMemDTO>) request.getAttribute("memberInfo");
	
	// 전화번호 양식
	String phone_number = memberInfo.get(0).getMem_phone();
	phone_number = phone_number.substring(0,3) + "-" + phone_number.substring(3,7) 
				 + "-" + phone_number.substring(7);
	// 날짜 형식
	String birth_date = memberInfo.get(0).getMem_birth();
	birth_date = birth_date.substring(0,4) + "/" + birth_date.substring(4,6) + "/" + birth_date.substring(6);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
	/* 비밀번호 변경 */
	function fn_findPw(kubun) {
		var id = $("input[name='id']").val();
		var email = $("input[name='email']").val();
		
		var url = "view/HCAM_memberFindPwResult01.jsp?kubun=" + kubun + "&id=" + id + "&email=" + email;
		var title = "popupOpener";
		var status = "toolbar=no,directories=no,scrollbars=no,resizable=no,status=no,menubar=no,width=500,height=300,top=100,left=500";
		
		window.open(url, title, "width=500, height=380, top=100, left=500");
	}
</script>
<body>
	<div class="right_inner">
		<div class="right_top">
			<div class="inner_top_left">
				<div>HCAM</div>
			</div>
			<div class="inner_top_right">
				<div><%=mem_name %>님, VIP 등급이 되어보세요!</div>
				<div>2건의 숙박을 더 완료해 VIP 할인과 혜택을 누려보세요!</div>
			</div>
		</div>
		<div class="inner_single_content">
			<div class="div_member_title">
				<span><i class="fa-solid fa-circle-user"></i></span>
				<span>사용자정보</span>
				<a onclick="fn_findPw(2);">비밀번호 재설정</a>
			</div>
			<div class="div_member_content">
				<div class="div_memberInfo">
					<div>아이디</div>
					<div>
						<input type="text" name="id" value="<%=memberInfo.get(0).getMem_id() %>" readonly="readonly">
					</div>
				</div>
				<div class="div_memberInfo">
					<div>이름</div>
					<div>
						<input type="text" value="<%=memberInfo.get(0).getMem_name() %>" readonly="readonly">
					</div>
				</div>
				<div class="div_memberInfo">
					<div>이메일</div>
					<div>
						<input type="text" name="email" value="<%=memberInfo.get(0).getMem_email() %>" readonly="readonly">
					</div>
				</div>
				<div class="div_memberInfo">
					<div>휴대폰번호</div>
					<div>
						<input type="text" value="<%=phone_number %>" readonly="readonly">
					</div>
				</div>
				<div class="div_memberInfo">
					<div>성별</div>
					<div>
						<input type="text" value="<%=memberInfo.get(0).getMem_gender() %>" readonly="readonly">
					</div>
				</div>
				<div class="div_memberInfo">
					<div>생년월일</div>
					<div>
						<input type="text" value="<%=birth_date %>" readonly="readonly">
					</div>
				</div>
				<div class="div_addr_memberInfo">
					<div>주소</div>
					<div class="member_addr01">
						<input type="text" value="<%=memberInfo.get(0).getMem_post() %>" readonly="readonly">
						<input type="text" value="<%=memberInfo.get(0).getMem_addr() %>" readonly="readonly">
					</div>
					<div class="member_addr02">
						<input type="text" value="<%=memberInfo.get(0).getMem_addrdtl() %>" readonly="readonly">
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>