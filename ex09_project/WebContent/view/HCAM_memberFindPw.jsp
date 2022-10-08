<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
<title>Insert title here</title>
<style type="text/css">
	#findPwBox {
		margin: 0 auto;
		margin-top: 30px;
		margin-bottom: 30px;
		padding-bottom: 30px;
		width: 440px;
	}
		#findPw_table {
			border-collapse: collapse;
			margin-left: auto; 
			margin-right: auto;
		}
			/* 비밀번호찾기 */
			#findPw_table tr:nth-child(1) {
				height: 100px;
				border-bottom: 1px solid black;
			}
			#findPw_table tr:nth-child(2),
			#findPw_table tr:nth-child(11)
			{
				height: 80px;
			}
			#findPw_table tr:nth-child(3),
			#findPw_table tr:nth-child(4),
			#findPw_table tr:nth-child(7),
			#findPw_table tr:nth-child(9)
			{
				height: 50px;
			}
			#findPw_table tr:nth-child(5),
			#findPw_table tr:nth-child(10) {
				height: 100px;
			}
				#findPw_table td {
					line-height: 200%;
				}
				#findPw_table tr:first-child td {
					font-weight: bold;
					font-size: 18pt;
					height: 40px;
					text-align: center;
					/*border-bottom: 2px solid;*/
				}
				
				/* 로그인으로 돌아가기? a 태그 */
				#findPw_table td a {
					font-size: 11pt;
					color: var(--color-blue);
				}
				/* 비밀번호재설정 버튼 */
				#findPw_table #btn_findPw {
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
				#findPw_table input[type=text]
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
						.div_line {
							margin: 0px;
							min-width: 1px;
						    width: 196px;
						    height: 13px;
						    flex: 1 1 0%;
						    border-bottom: 1px solid rgb(221, 223, 226);
						}
					#btn_google {
						width: 440px;
						height: 40px;
						background-color: var(--color-white);
						border: 1px solid var(--color-blue);
						border-radius: 4px;
						color: var(--color-blue);
						font-weight: bold;
					}
					#btn_naver {
						margin-right: 5px;
						width: 213px;
						height: 40px;
						background-color: var(--color-white);
						border: 1px solid var(--color-blue);
						border-radius: 4px;
						color: var(--color-blue);
						font-weight: bold;
					}
					#btn_kakao {
						margin-left: 5px;
						width: 213px;
						height: 40px;
						background-color: var(--color-white);
						border: 1px solid var(--color-blue);
						border-radius: 4px;
						color: var(--color-blue);
						font-weight: bold;
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
</head>
<script>
	/* 비밀번호 찾기 */
	function fn_findPw(kubun) {
		var id = document.getElementsByName("id")[0].value;
		var email = document.getElementsByName("email")[0].value;
		
		if(id != "" && email != "") {
			var url = "HCAM_memberFindPwResult01.jsp?kubun=" + kubun + "&id=" + id + "&email=" + email;
			var title = "popupOpener";
			var status = "toolbar=no,directories=no,scrollbars=no,resizable=no,status=no,menubar=no,width=500,height=300,top=100,left=500";
			window.open(url, title, "width=500, height=380, top=100, left=500");
			
			/* frm.target = title;
			frm.action = url;
			frm.metho = "post";
			frm.submit(); */
		}
		else {
			alert("아이디, 이메일을 입력해주세요");
		}
	}
</script>
<body>
	<!-- header -->
	<jsp:include page="../include/HCAM_header.jsp"/>
	
	<div id="findPwBox">
		<form name="form_findPw" method="POST" onsubmit="fn_findPw(1);">
			<table id="findPw_table">
				<tr>
					<td colspan="2">비밀번호 찾기</td>
				</tr>
				<tr>
					<td colspan="2">비밀번호찾기 없이 지금 아래 계정으로 간편하게 로그인하세요!</td>
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
					<td colspan="2">
						<div id="td_float">
							<div class="div_line"></div>
							<div>혹은</div>
							<div class="div_line"></div>
						</div>
					</td>
				</tr>
				<tr>
					<td class="td_text" colspan="2">
						<span class="title_lable">아이디</span>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input class="input294" type="text" name="id" placeholder="아이디">
					</td>
				</tr>
				<tr>
					<td class="td_text" colspan="2">
						<span class="title_lable">이메일</span>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input class="input294" type="text" name="email" placeholder="이메일">
					</td>
				</tr>
				<tr>
					<td colspan="2">상단 입력란에 아이디를 입력하세요. 비밀번호 재설정을 위한 링크를 보내드리겠습니다.</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" id="btn_findPw" name="btn_findPw" value="비밀번호 재설정하기">
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center;"><a href="HCAM_memberLogin.jsp">로그인으로 돌아가기</a></td>
				</tr>
			</table>
		</form>
	</div>
	
	<!-- footer -->
	<jsp:include page="../include/HCAM_footer.jsp"/>
</body>
</html>