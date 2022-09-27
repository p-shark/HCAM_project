<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- jquery -->
	<script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script>
	<!-- js -->
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js" ></script> 
	<!-- css -->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/join.css">
	<!-- 주소 api -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<title>회원가입</title>
</head>
<script>
	/* init window */
	$(document).ready(function(){
		$('.redText').hide();
	});

	var RegExp = /^[a-zA-Z0-9]{8,16}$/;	//id와 pwassword 유효성 검사 정규식
	var n_RegExp = /^[가-힣]{2,15}$/; //이름 유효성검사 정규식
	var checkIdOk = false;		// 아이디중복체크
	var random_number = "";		// 인증번호
	var checkRandomOk = false;	// 인증번호체크
	
</script>
<body>
	<!-- header -->
	<jsp:include page="../include/HCAM_header.jsp"/>
	
	<div id="joinBox">
		<form name="form_join" method="POST" action="HCAM_memberJoinResult01.jsp" onsubmit="return fn_join();">
			<table id="join_table">
				<tr>
					<td colspan="3">회 원 가 입</td>
				</tr>
				<tr>
					<td colspan="3" height="15px"></td>
				</tr>
				<tr>
					<td class="td_text">
						<span class="title_lable">아이디</span>
					</td>
					<td>
						<input class="input294" type="text" name="memid" maxlength="16" onblur="fn_chkId();" placeholder="  아이디를 입력하세요">
					</td>
					<td>
						<button type="button" name="id_check" onclick="fn_chkSameId();">중복확인</button>
					</td>
				</tr>
				<tr class="redText" id="redText_id">
					<td></td>
					<td colspan="2" style="line-height: 15px;">
						<span class="span_red" id="hidden_id_text">*8~16자의 영문 대소문자와 숫자를 사용하세요.</span>
					</td>
				</tr>
				<tr>
					<td class="td_text">
						<span>비밀번호</span>
					</td>
					<td>
						<input class="input294" type="password" name="pass_init" maxlength="16" onblur="fn_chkPassInit();" placeholder="  비밀번호를 입력하세요">
					</td>
				</tr>
				<tr class="redText" id="redText_pw">
					<td></td>
					<td colspan="2" style="line-height: 15px;">
						<span class="span_red" id="hidden_pw_text">*8~16자의 영문 대소문자와 숫자를 사용하세요.</span>
					</td>
				</tr>
				<tr>
					<td class="td_text">
						<span>비밀번호확인</span>
					</td>
					<td>
						<input class="input294" type="password" name="pass_check" maxlength="16" onblur="fn_chkPassCheck();" placeholder="  비밀번호를 한번 더 입력하세요">
					</td>
				</tr>
				<tr class="redText" id="redText_pwc">
					<td></td>
					<td colspan="2" style="line-height: 15px;">
						<span class="span_red" id="hidden_pwc_text">*비밀번호가 일치하지 않습니다.</span>
					</td>
				</tr>
				<tr>
					<td class="td_text">
						<span class="title_lable">이름</span>
					</td>
					<td>
						<input class="input294" type="text" name="name" placeholder="  이름을 입력하세요">
					</td>
				</tr>
				<tr>
					<td class="td_text">
						<span class="title_lable">이메일</span>
					</td>
					<td>
						<input class="input169" type="text" name="email_id" placeholder="  이메일을 입력하세요">
						<select name="email_addr" size="1" >
							<option value="">직접입력</option>
							<option value="@naver.com">@naver.com</option>
							<option value="@gmail.com">@gmail.com</option>
							<option value="@nate.com">@nate.com</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="td_text">
						<span class="title_lable">휴대폰번호</span>
					</td>
					<td>
						<select name="nation" style="width: 96.5px;">
							<option value="233">가나 +233</option>
							<option value="30">그리스 +30</option>
							<option value="31">네덜란드 +31</option>
							<option value="82">대한민국 +82</option>
						</select>
						<input class="input193" type="text" name="phone" maxlength="20" placeholder="  숫자만 입력하세요">
					</td>
					<td>
						<button type="button" name="phone_send" onclick="fn_sendRandom();">인증번호받기</button>
					</td>
				</tr>
				<tr>
					<td class="td_text">
						<span class="title_lable span_hidden">인증번호</span>
					</td>
					<td>
						<input type="text" name="phone_check" placeholder="   인증번호를 입력하세요" class="input294">
					</td>
					<td>
						<button type="button" name="chkRandom" onclick="fn_chkRandom();">인증번호확인</button>
					</td>
				</tr>
				<tr>
					<td class="td_text">
						<!-- 다음 우편번호 검색 api -->
						<span class="title_lable span_hidden">우편번호</span>
						<span class="title_lable">주소</span>
					</td>
					<td>
						<input class="input93" type="text" name="postcode" id="postcode" style="width: 95px;" placeholder="우편번호">
						<input class="input193" type="text" name="addr_main" id="addr_main"  style="width: 192px" placeholder="  주소를 검색하세요">
					</td>
					<td>
						<button type="button" name="addr_search" onclick="fn_searchAddr();">주소검색</button>
					</td>
				</tr>
				<tr>
					<td class="td_text">
						<span class="title_lable">상세주소</span>
					</td>
					<td>
						<input class="input294" type="text" name="addr_dtl" id="addr_dtl" placeholder="  상세주소를 입력하세요">
					</td>
				</tr>
				<tr>
					<td class="td_text">
						<span>성별</span>
					</td>
					<td>
						<input type="radio" name="gender" value="male" id="male" style="margin-right: 4px">
						<label for="male">남자</label>
						<input type="radio" name="gender" value="female" id="female" style="margin-left: 56px; margin-right: 4px">
						<label for="female">여자</label>
						<input type="radio" name="gender" value="" id="blank" checked style="margin-left: 56px; margin-right: 4px">
						<label for="blank">선택안함</label>
					</td>
					<td></td>
				</tr>
				<tr>
					<td class="td_text">
						<span>생년월일</span>
						<span class="title_lable span_hidden">연도</span>
						<span class="title_lable span_hidden">월</span>
						<span class="title_lable span_hidden">일</span>
					</td>
					<td >
						<input class="input93" type="number" name="birth_year" min="0" max="9999" onfocusout="fn_chkBirth('year');" placeholder="YYYY">
						<input class="input93" type="number" name="birth_month" min="0" max="12" onfocusout="fn_chkBirth('month');" placeholder="MM">
						<input class="input93" type="number" name="birth_date" min="0" max="31"  onfocusout="fn_chkBirth('date');"placeholder="DD">
					</td>
					<td></td>
				</tr>
				<tr>
					<td colspan="3" height="15px"></td>
				</tr>
				<tr style="border-bottom: 1px solid black"></tr>
				<tr>
					<td style="line-height: 50px; font-weight: bold;">이용약관동의</td>
					<td colspan="2">
						<input type="checkbox" name="agreeAll" id="agreeAll" onchange="fn_chkAgree('all');">
						<label for="agreeAll">
							<font style="font-size: 11pt; font-weight: bold;">&nbsp본인은 아래의 모든 개인정보 처리방침에 동의합니다</font>
						</label><br>
					</td>
				</tr>
				<tr>
					<td></td>
					<td colspan="2">
						&nbsp&nbsp&nbsp<input type="checkbox" name="agree1" id="agree1" onchange="fn_chkAgree('sub');">
						<label for="agree1">
							<font style="color: red;">(필수)</font>
							<font> 본 서비스 약관에 동의하며 18세 이상임을 확인합니다.</font>
						</label>
					</td>
				</tr>
				<tr>
					<td></td>
					<td colspan="2">
						&nbsp&nbsp&nbsp<input type="checkbox" name="agree2" id="agree2" onchange="fn_chkAgree('sub');">
						<label for="agree2">
							<font style="color: red;">(필수)</font>
							<font> 본인은 개인정보 처리방침에 따라 본인의 개인 정보를</font><br>
							<font>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp사용하고 수집하는 것에 동의합니다.</font>
						</label>
					</td>
				</tr>
				<tr>
					<td></td>
					<td colspan="2">
						&nbsp&nbsp&nbsp<input type="checkbox" name="agree3" id="agree3" onchange="fn_chkAgree('sub');">
						<label for="agree3">
							<font>(선택) 본인은 개인정보 처리방침에 따라 대한민국 또는 해외에</font><br>
							<font>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp있는 제3자에 본인의 개인 정보를 제공하는것에 동의합니다.</font>
						</label>
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<input type="submit" id="btn_join" name="btn_join" value="회원가입">
						<!-- <button type="submit" id="btn_join" name="btn_join" onsubmit="fn_join();">회원가입</button> -->
					</td>
				</tr>
			</table>
		</form>
	</div>
	
	<!-- footer -->
	<jsp:include page="../include/HCAM_footer.jsp"/>
	
</body>
</html>