<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/* 로그인 실패 시 아이디값 존재 */
	String id = request.getParameter("id");

	// 회원, 매니저 로그인 구분
	String kubun = request.getParameter("kubun");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- jquery -->
	<script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script>
	<!-- css -->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css">
	<title>로그인</title>
</head>
<script>
	/* init window */
	$(document).ready(function(){
		
	});

	/* 로그인 */
	function fn_login() {
		var id = document.getElementsByName("id")[0].value;
		var pw = document.getElementsByName("pw")[0].value;
		
		var result = false;
		if(id != "" && pw != "") {
			result = true;
		}
		else {
			alert("아이디, 비밀번호 모두 입력해주세요");
		}
		
		return result;
	}
	
	function fn_goWebsite(kubun) {
		if(kubun == "google") {
			location.href = "http://www.google.com";
		}
		else if(kubun == "naver") {
			location.href = "http://www.naver.com";
		}
		else {
			location.href = "http://www.kakao.com";
		}
		
	}
</script>
<body>
	<!-- header -->
	<jsp:include page="../include/HCAM_header.jsp"/>
	
	<div id="loginBox">
		<form name="form_login" method="POST" action="HCAM_memberLoginResult01.jsp" onsubmit="return fn_login();">
			<input type="hidden" name="kubun" value="<%=kubun %>">
			<table id="login_table">
				<tr>
					<% if("mem".equals(kubun)) { %>
						<td colspan="2">로 그 인</td>
					<% } else { %>
						<td colspan="2">매 니 저 로 그 인</td>
					<% } %>
				</tr>
				<tr>
					<% if(id != null) { %>
						<td colspan="2">
							<div class="div_wrong">
								<div>
									<img src="../image/icon/wrong_x2.png">
								</div>
								<div>회원정보가 존재하지 않거나 비밀번호가 일치하지 않습니다.</div>
							</div>
						<td>
					<% }else { %>
						<td colspan="2"></td>
					<% } %>
					
				</tr>
				<tr>
					<td class="td_text" colspan="2">
						<span class="title_lable">아이디</span>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<% if(id != null) { 
							out.println("<input class='input294' type='text' name='id' maxlength='16' value='" + id + "'>");
						   }else { %>
							<input class="input294" type="text" name="id" maxlength="16">
						<% } %>
					</td>
				</tr>
				<tr>
					<td class="td_text"  colspan="2">
						<span>비밀번호</span>
					</td>
				</tr>
				<tr>
					<td  colspan="2">
						<input class="input294" type="password" name="pw" maxlength="16">
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" id="btn_login" name="btn_login" value="로그인">
					</td>
				</tr>
				<tr>
					<td><a href="HCAM_memberJoin.jsp">회원가입</a></td>
					<td style="text-align: right;"><a href="HCAM_memberFindPw.jsp">비밀번호를 잊으셨나요?</a></td>
				</tr>
				<tr>
					<td colspan="2">
						<div id="td_float">
							<div class="div_line"></div>
							<div>혹은 아래 계정을 이용해 로그인</div>
							<div class="div_line"></div>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<button type="button" id="btn_google" onclick="fn_goWebsite('google');">
							<img src="../image/icon/google.png" style="width: 25px; height: 25px;">
						</button>
					</td>
				</tr>
				<tr>
					<td>
						<button type="button" id="btn_naver" onclick="fn_goWebsite('naver');">
							<img src="../image/icon/naver.png" style="width: 18px; height: 18px;">
						</button>
					</td>
					<td>
						<button type="button" id="btn_kakao" onclick="fn_goWebsite('kakao');">
							<img src="../image/icon/kakao.png" style="width: 18px; height: 18px;">
						</button>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center">이용 약관 및 개인정보 처리방침에 동의합니다.</td>
				</tr>
			</table>
		</form>
	</div>
	
	<!-- footer -->
	<jsp:include page="../include/HCAM_footer.jsp"/>
</body>
</html>