<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
<title>Insert title here</title>
</head>
<style type="text/css">
	#chgPwBox {
		margin: 0 auto;
		width: 440px;
	}
		#chgPw_table {
			border-collapse: collapse;
			margin-left: auto; 
			margin-right: auto;
		}
			/* 비밀번호변경 */
			#chgPw_table tr:nth-child(1) {
				height: 100px;
				border-bottom: 1px solid black;
			}
			#chgPw_table tr:nth-child(2),
			#chgPw_table tr:nth-child(4)
			{
				height: 50px;
			}
			#chgPw_table tr:nth-child(3),
			#chgPw_table tr:nth-child(5)
			{
				height: 30px;
			}
			#chgPw_table tr:nth-child(6) {
				height: 100px;
			}
				#chgPw_table td {
					line-height: 200%;
				}
				#chgPw_table tr:first-child td {
					font-weight: bold;
					font-size: 18pt;
					height: 40px;
					text-align: center;
					/*border-bottom: 2px solid;*/
				}
				
				/* 비밀번호변경 버튼 */
				#chgPw_table #btn_chgPw {
					width: 440px; 
					height: 40px; 
					font-size: 12pt;
					font-weight: bold;
					letter-spacing: 0.1em;
					border: 0;
					border-radius: 4px;
					color: white;
					background-color: var(--color-blue);
				}
				#chgPw_table input[type=text]
				,input[type=password] {
					border: 1px solid darkgray;
					border-radius: 4px;
				}
				.td_text {
					font-weight: bold;
				}
					#td_float div {
						float: left;
					}
					#td_float div:first-child {
						margin-right: 10px;
					}
					#td_float div:last-child {
						margin-left: 10px;
					}

				input {
					margin: 0;
					padding: 0;
				}
				input:focus {
					outline:none;
					box-shadow: 0px 0px 4px #3399ff;
				}
				.input93 {
					margin-right: 0;
					width: 93px;
					height: 28px;
					text-align: center;
				}
				.input193 {
					margin-right: 0;
					width: 193px;
					height: 28px;
				}
				.input169 {
					margin-right: 0;
					width: 169.5px;
					height: 28px;
				}
				.input294 {
					margin-right: 0;
					width: 440px;
					height: 28px;
				}
</style>
<script>
	/* 비밀번호 찾기 */
	function fn_chgPw() {
		var pw = document.getElementsByName("pass_init")[0];
		var pwc = document.getElementsByName("pass_check")[0];
		var RegExp = /^[a-zA-Z0-9]{8,16}$/;	// password 유효성 검사 정규식
		
		var result = false;
		if(pw.value != pwc.value) {
			alert("비밀번호가 일치하지 않습니다.");
		}else if(!RegExp.test(pw.value)) {
			alert("비밀번호는 8~16자의 영문 대소문자와 숫자로만 입력하세요.");
		}else {
			result = true;
		}
		
		return result;
	}
</script>
<body>
	<form action="HCAM_memberFindPwResult03.jsp" name="form_chgPw" method="POST" onsubmit="return fn_chgPw();">
		<input type="hidden" name="id" value="<%=id %>">
		<div id="chgPwBox">
			<table id="chgPw_table">
				<tr>
					<td colspan="2">비밀번호 변경</td>
				</tr>
				<tr>
					<td class="td_text" colspan="2">
						<span class="title_lable">비밀번호</span>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input class="input294" type="password" name="pass_init" placeholder="비밀번호">
					</td>
				</tr>
				<tr>
					<td class="td_text" colspan="2">
						<span class="title_lable">비밀번호확인</span>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input class="input294" type="password" name="pass_check" placeholder="비밀번호확인">
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" id="btn_chgPw" name="btn_chgPw" value="비밀번호 변경">
					</td>
				</tr>
			</table>
		</div>
	</form>
</body>
</html>