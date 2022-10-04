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
	
	/* 중복확인 */
	function fn_chkSameId() {
		var memid = document.getElementsByName("memid")[0];
		if (!RegExp.test(memid.value)) {
			alert("8~16자의 영문 대소문자와 숫자로만 입력하세요.");
			memid.value = "";
			memid.focus();
		}
		else {	// DB 체크
			$.ajax({
				url: "HCAM_memberJoinIdChk.jsp",
				type:'POST',
				dataType: "text",
				async:false,
				data: "memid=" + memid.value,
				success: function(result) {			// DB에 동일 아이디 X
					checkIdOk = true;
					memid.readOnly = true;
					alert("사용가능한 아이디입니다.");
					$('#redText_id').hide();
					//location.href = "HCAM_memberJoinIdChk.jsp";
				},
				error: function(request, error) {	// DB에 동일 아이디 O
					//alert(request.status + " / " + request.responseText + " / " + error);
					$('#redText_id').show();
					document.getElementById("hidden_id_text").innerHTML = "*이미 사용중인 아이디입니다.";
				}
			});
		}
	}

	//아이디 focusOut
	function fn_chkId() {
		var memid = document.getElementsByName("memid")[0];
		// 유효성 검사에 맞지 않은 경우
		if(!RegExp.test(memid.value)) {
			document.getElementById("hidden_id_text").innerHTML = "*8~16자의 영문 대소문자와 숫자로만 입력하세요.";
			$('#redText_id').show();
		}
		else {
			// 중복검사까지 통과한 경우
			if(checkIdOk) {
				$('#redText_id').hide();
			}
		}
	}

	// 비밀번호 focusOut
	function fn_chkPassInit() {
		var pw = document.getElementsByName("pass_init")[0];

		if(!RegExp.test(pw.value)) {
			$('#redText_pw').show();
		}
		else {
			$('#redText_pw').hide();
		}
	}

	// 비밀번호확인 focusOut
	function fn_chkPassCheck() {
		var pw_value = document.getElementsByName("pass_init")[0].value;
		var pwc_value = document.getElementsByName("pass_check")[0].value;

		if(pw_value != pwc_value) {
			$('#redText_pwc').show();
		}
		else {
			$('#redText_pwc').hide();
		}
	}

	/* 인증번호받기 */
	function fn_sendRandom() {
		var phone = document.getElementsByName("phone")[0].value;
		var chgPhone = phone.replaceAll('-',''); //'-' 문자제거

		if(chgPhone.length < 11) {
			if(isNaN(chgPhone) == true) {		// isNaN(): true-문자,false-숫자
				alert("휴대폰번호는 숫자만 가능합니다.");
			}
			else {
				alert("휴대폰번호는 11글자이상 가능합니다.");
			}
		}
		else {
			random_number = "";	// 인증번호 초기화

			for(var i=0; i<6; i++) {
				var random = Math.floor(Math.random()*9);	// floor(): 소수점 버림

				if(i == 0) {
					random = Math.floor(Math.random()*8+1);
				}

				random_number += random;
			}

			alert("임시 인증번호: " + random_number);
		}
	}

	/* 인증번호확인 */
	function fn_chkRandom() {
		var nation = document.getElementsByName("nation")[0];
		var phone = document.getElementsByName("phone")[0];
		var phone_check = document.getElementsByName("phone_check")[0];
		if(phone_check.value == "") {
			alert("인증번호를 입력하세요.");
		}
		else {
			if(random_number == phone_check.value) {
				alert("인증번호 확인 성공");
				checkRandomOk = true;
				//nation.disabled = true;	// disabled 하면 데이터가 전송이 안됨....
				nation.readOnly = true;
				//phone.disabled = true;
				phone.readOnly = true;
				//phone_check.disabled = true;
				phone_check.readOnly = true;
			}else {
				alert("인증번호가 잘못 입력되었습니다.");
			}
		}
	}

	/* 날짜 형식 focusout */
	function fn_chkBirth(kubun) {
		var inputs = document.querySelectorAll("input");
		var birth_year = document.getElementsByName("birth_year")[0];
		var birth_month = document.getElementsByName("birth_month")[0];
		var birth_date = document.getElementsByName("birth_date")[0];
		
		if(kubun == "year") {
			if(birth_year.value.length != 4) {
				alert("4자리만 가능합니다.")
				birth_year.value = "";
			}
		}
		if(kubun == "month") {
			if(birth_month.value.length != 2) {

				if(birth_month.value.length == 0) {
					
				}
				else if(birth_month.value < 10) {
					birth_month.value = "0" + birth_month.value;
				}
				else {
					alert("2자리만 가능합니다.")
					birth_month.value = "";
				}
					
			}
		}
		else if(kubun == "date") {
			if(birth_date.value.length != 2) {
				if(birth_date.value.length == 0) {
					
				}
				else if(birth_date.value < 10) {
					birth_date.value = "0" + birth_date.value;
				}
				else {
					alert("2자리만 가능합니다.")
					birth_date.value = "";
				}
			}
		}
	}

	/* 주소검색 */
	function fn_searchAddr() {
		new daum.Postcode({
	        oncomplete: function(data) {
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var addr = ''; 		// 주소 변수
	            var extraAddr = ''; // 참고항목 변수

	            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	            if (data.userSelectedType === 'R') {	// 사용자가 도로명 주소를 선택했을 경우
	                addr = data.roadAddress;
	            } else { 								// 사용자가 지번 주소를 선택했을 경우(J)
	                addr = data.jibunAddress;
	            }

	            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	            if(data.userSelectedType === 'R'){
	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraAddr !== ''){
	                    extraAddr = ' (' + extraAddr + ')';
	                }
	                // 조합된 참고항목을 해당 필드에 넣는다.
	                //document.getElementById("addr_main").value = extraAddr;
	            
	            } else {
	                //document.getElementById("addr_main").value = '';
	            }

	            var postcode = document.getElementById("postcode");
	            var addr_main = document.getElementById("addr_main");
	            var addr_dtl = document.getElementById("addr_dtl");
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            postcode.value = data.zonecode;
	            addr_main.value = addr + ' ' + extraAddr;
	            // 커서를 상세주소 필드로 이동한다.
	            //postcode.disabled = true;
	            //addr_main.disabled = true;
	            postcode.readOnly = true;
	            addr_main.readOnly = true;
	            addr_dtl.focus();
	        }
	    }).open();
	}

	/* 개인정보 동의 */
	function fn_chkAgree(kubun) {
		var chkbox = document.querySelectorAll("input[type=checkbox]");
		
		// all: 전체동의 / sub: 개별동의
		if(kubun == "all") {
			if(chkbox[0].checked == true) {
				for(var i=0; i<chkbox.length; i++) {
					chkbox[i].checked = true;
				}
			}else {
				for(var i=0; i<chkbox.length; i++) {
					chkbox[i].checked = false;
				}
			}
		}
		else {
			var cnt = 0;
			for(var i=1; i<chkbox.length; i++) {
				if(chkbox[i].checked == true) {
					cnt++;
				}
			}
			
			if(cnt == chkbox.length-1) {
				chkbox[0].checked = true;
			}
			else {
				chkbox[0].checked = false;
			}
		}

	}

	/* 회원가입 */
	function fn_join() {
		var result = false;
		
		// (0:아이디 / 1:이름 / 2:이메일 / 3:휴대폰번호 / 4:인증번호 / 5:우편번호 / 6:주소 / 7:상세주소)
		var input_texts = document.querySelectorAll("input[type='text']");	// 비밀번호는 없음 (비밀번호는 type=password);
		// (0:아이디 / 1:이름 / 2:이메일 / 3:휴대폰번호 / 4:인증번호 / 5:우편번호 / 6:주소 / 7: 상세주소)
		var title_lables = document.getElementsByClassName("title_lable");
		//alert(title_lables[0].innerHTML);
		
		// 빈값 체크
		for(var i=0; i<input_texts.length; i++) {
			//alert(title_lables[i].innerHTML);
			if(input_texts[i].value == "") {
			 	alert(title_lables[i].innerHTML + " 필수 입력입니다.");	// 해당 input 인덱스의 이름을 동적으로 가져옴
				return false;
			}
		}

		// (0:아이디 / 1:비밀번호 / 2:비밀번호확인 / 3:이름 / 4:이메일_id / 5: 휴대폰번호 / 6:인증번호 / 7:우편번호
		//	/ 8:주소 / 9:상세주소 / 10~12: 성별radio / 13~15:생년월일 / 16~19: 체크박스 / 20: 회원가입 버튼)
		var inputs = document.querySelectorAll("input");
		var email_addr = document.getElementsByName("email_addr")[0];
		var email = inputs[4].value + email_addr.value;
		var nation = document.getElementsByName("nation")[0];
		var chgPhone = inputs[5].value.replaceAll('-',''); //'-' 문자제거
		
		// 빈값 외 추가 체크
		if(checkIdOk == false) {
			alert("ID 중복체크 후 회원가입이 가능합니다.")
		}
		else if(!RegExp.test(inputs[1].value)) {
			alert("비밀번호는 8~16자의 영문 대소문자와 숫자로만 입력하세요.");
		}
		else if(inputs[1].value != inputs[2].value) {
			alert("비밀번호가 일치하지 않습니다.");
		}
		else if(email_addr.value == "") {
			if(inputs[4].value.indexOf("@") == -1) {	// -1: '@'없음 / 0: '@'있음
				alert("이메일형식에 맞지않습니다. 직접입력하는 경우 '@'포함하여 작성바랍니다.");
			}
		}
		else if(chgPhone.length != 11) {
			if(isNaN(chgPhone) == true) {		// isNaN(): true-문자,false-숫자
				alert("휴대폰번호는 숫자만 가능합니다.");
			}
			else {
				alert("휴대폰번호는 11글자만 가능합니다.");
			}
		}
		else if(checkRandomOk == false) {
			alert("인증번호확인 후 회원가입이 가능합니다.");
		}
		else if(inputs[17].checked == false || inputs[18].checked == false) {
			alert("개인정보보호 동의 후 회원가입이 가능합니다.");
		}
		
		// 얘는 젤 아래 있어야함. result = true 때문에 얘 밑에 쓰면 밑에 쓴 else if 안 탐
		else if(inputs[13].value != "" || inputs[14].value != "" || inputs[15].value != "") {
			if(inputs[13].value.length != 4) {
				alert("생년월일을 잘못 입력하였습니다.");
				inputs[13].value = "";
				inputs[13].focus();
			}
			else if(inputs[14].value.length != 2) {
				if(inputs[14].value < 1 || inputs[14].value > 12) {
					alert("생년월일을 잘못 입력하였습니다.");
					inputs[14].value = "";
					inputs[14].focus();
				}
			}
			else if(inputs[15].value.length != 2) {
				if(inputs[15].value < 1 || inputs[15].value > 12) {
					alert("생년월일을 잘못 입력하였습니다.");
					inputs[15].value = "";
					inputs[15].focus();
				}
			}
			else {
				result = true;
			}
		}
		else {
			/* var outputs = "";
			for(var i=0; i<inputs.length; i++) {
				if( i == 2  || i == 6  || i == 11 || i == 12 || i == 14 || i == 15 ||
					i == 16 || i == 17 || i == 18 || i == 19 || i == 20) {

				}
				else if(i == 4) {
					outputs += email;
					outputs += " / ";
					outputs += nation.value;
					outputs += " / ";
				}
				else if(i == 10) {
					var gender = document.getElementsByName("gender");
					for(var j=0; j<gender.length; j++) {
						if(gender[j].checked) {
							outputs += gender[j].value;
							outputs += " / ";
						}
					}
				}
				else if(i == 13) {
					outputs += inputs[13].value + inputs[14].value + inputs[15].value;
				}
				else {
					outputs += inputs[i].value;
					outputs += " / ";
				}
			}
			
			alert(outputs); */
			
			result = true;
		}
		
		return result;
	}
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