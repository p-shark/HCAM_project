<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="dao.CommonDAO" id="commonDao"></jsp:useBean>
<%
	request.setCharacterEncoding("utf-8");

	//로그인한 회원정보
	String id = (String) session.getAttribute("id");
	// 세션에 저장된 mem_no 값 가져오기 
	int mem_no = 0;
	if(session.getAttribute("mem_no") != null) {
		mem_no = Integer.parseInt(String.valueOf(session.getAttribute("mem_no")));
	}
	int pnt_no = 0;
	if(session.getAttribute("pnt_no") != null) {
		pnt_no = Integer.parseInt(String.valueOf(session.getAttribute("pnt_no")));
	}
	
	/* 포인트 잔액 조회 */
	int pnt_balance = commonDao.getPnt_balance(pnt_no);
	
	// 금액 포맷
	DecimalFormat df = new DecimalFormat("#,###");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- jquery -->
<script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script>
<!-- css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
<title>Insert title here</title>
<style type="text/css">
	/* number 초기화 */
	input[type="number"]::-webkit-outer-spin-button,
	input[type="number"]::-webkit-inner-spin-button {
	    -webkit-appearance: none;
	    -moz-appearance: none;
	    appearance: none;
	}
	
	#div_content {
		margin-top: 25px;
		padding: 0 25px 0px 20px;
	}
		/* 포인트 충전 */
		#div_content #point_title {
			font-size: 15pt;
			font-weight: bold;
		}
		/* 포인트 충전 내용 */
		#div_content #div_pointContent {
			margin-top: 30px;
			height: 170px;
		}
			/* 충전금액, 현재 잔액 */
			#div_pointContent #point_text {
				height: 40px;
			}
				#point_text div:first-child {
					float: left;
					font-size: 11pt;
					font-weight: bold;
				}
				#point_text #div_pointBalance {
					float: right;
				}
					#div_pointBalance span:first-child {
						color: #9C9C9C;
						font-size: 9pt;
					}
					#div_pointBalance span:last-child {
						font-weight: bold;
						font-size: 11pt;
						color: var(--color-purple);
						border-bottom: 1px solid #9C9C9C;
					}
			/* 충전할 금액 */
			#div_pointContent #point_inputBox {
				
			}
				#point_inputBox div {
					border: 1px solid #E6E6E6;
				}
					#point_inputBox input {
						padding-right: 10px;
						width: 410px;
						height: 40px;
						font-size: 12pt;
						border: none;
						outline: none;
						text-align: right;
					}
			/* 충전 금액 상세 */
			#div_pointContent #point_btn {
				margin-top: 20px;
			}
				#point_btn div {
					float: right;
				}
				#point_btn a {
					margin-left: 5px;
					padding: 5px 8px;
					font-weight: bold;
					border: 1px solid #E6E6E6;
				}
		/* 휴대폰 결제 */
		#div_content #div_payment {
			
		}
			/* title */
			#payment_title {
				height: 35px;
			} 
				#payment_title div:first-child {
					float: left;
					font-size: 11pt;
					font-weight: bold;
				}
				#payment_title div:last-child {
					float: right;
				}
					#payment_title div:last-child a {
						padding: 4px 10px;
						color: var(--color-white);
						border-radius: 2px;
						background-color: var(--color-blue);
					}
			/* 휴대폰 번호 입력 */
			#payment_content {
				clear: right;
			}
				#phone_box {
				
				}
					#phone_box #telecom {
						display: inline-block;
						margin-right: 10px;
						width: 122px;
						border: 1px solid #E6E6E6;
					}
						#telecom select {
							padding: 0 10px;
							width: 112px;
							height: 30px;
							border: none;
							outline: none;
						}
					#phone_box #phone_num {
						display: inline-block;
					}
						#phone_num input {
							width: 75px;
							height: 27px;
							text-align: center;
							font-size: 10.5pt;
							border: 1px solid #E6E6E6;
							outline: none;
						}
						#phone_num span {
							margin: 0 2px;
							font-size: 15pt;
						}
			/* 인증번호 입력 */
			#chkNumber_box {
				margin-top: 12px;
			}		
				#chkNumber_box div {
					display: inline-block;
					vertical-align: top;
				}
				#chkNumber_box div:first-child {
					width: 308px;
					border: 1px solid #E6E6E6;
				}
					#chkNumber_box input {
						width: 295px;
						height: 27px;
						text-align: right;
						font-size: 10.5pt;
						border: none;
						outline: none;
					}
				#chkNumber_box #chkNum_btn {
					margin-top: 7px;
					margin-left: 6px;
					background-color: red;
				}
					#chkNum_btn a {
						padding: 6px 9px 6px 10px;
						border-radius: 2px;
						color: var(--color-white);
						background-color: var(--color-blue);
					}
		#div_button {
			margin-top: 30px;
		}
			#div_button button {
				padding: 10px 0;
				width: 100%;
				border: none;
				border-radius: 2px;
				color: var(--color-white);
				background-color: var(--color-purple);
			}
</style>
</head>
<script>
	/* 숫자 maxLength */
	function fn_maxLengthCheck(obj) {
		if (obj.value.length > obj.maxLength){
			obj.value = obj.value.slice(0, obj.maxLength);
	    }
	}
	
	var random_number = "";		// 인증번호
	var checkRandomOk = false;	// 인증번호체크
	
	/* 인증번호받기 */
	function fn_sendRandom() {
		var phone01 = document.getElementsByName("phone01")[0].value;
		var phone02 = document.getElementsByName("phone02")[0].value;
		var phone03 = document.getElementsByName("phone03")[0].value;
		//var chgPhone = phone.replaceAll('-',''); //'-' 문자제거

		if(phone01.length != 3 || phone02.length != 4 || phone03.length != 4) {
			// isNaN(): true-문자,false-숫자
			if(isNaN(phone01) == true || isNaN(phone02) == true || isNaN(phone03) == true) {
				alert("휴대폰번호는 숫자만 가능합니다.");
			}
			else {
				alert("휴대폰번호를 정확히 입력하세요");
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
		
		var tele = document.getElementsByName("tele")[0];
		var phone01 = document.getElementsByName("phone01")[0];
		var phone02 = document.getElementsByName("phone02")[0];
		var phone03 = document.getElementsByName("phone03")[0];
		
		var phone_check = document.getElementsByName("phone_check")[0];
		
		if(phone_check.value == "") {
			alert("인증번호를 입력하세요.");
		}
		else {
			if(random_number == phone_check.value) {
				
				alert("인증번호 확인 성공");
				checkRandomOk = true;
				tele.disabled = true;
				phone01.readOnly = true;
				phone02.readOnly = true;
				phone03.readOnly = true;
				phone_check.readOnly = true;
			}else {
				alert("인증번호가 잘못 입력되었습니다.");
			}
		}
	}
	
	/* 충전 금액 변경 */
	function fn_chgPoint(kubun) {
		// 충전금액
		var depositAmt = $("input[name='depositAmt']");
		var fmt_depositAmt = (depositAmt.val()).replace(/\,/g,"");
		// 충전금액 int로 변경
		var num_depositAmt = parseInt(fmt_depositAmt);
		
		if (isNaN(num_depositAmt) == true) {
			num_depositAmt = 0;
		}
		if(kubun == 1) num_depositAmt = 500000;			// 최대금액은 500,000만원
		else if(kubun == 2) num_depositAmt += 50000;
		else if(kubun == 3) num_depositAmt += 30000;
		else if(kubun == 4) num_depositAmt += 10000;
		
		// 500,000 만원 이상 입력 안됨
		if(num_depositAmt > 500000) num_depositAmt = 500000;
		
		// 천단위 콤마 추가
		fmt_depositAmt = num_depositAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		
		depositAmt.val(fmt_depositAmt);
		$("input[name='phs_historyAmt']").val(num_depositAmt);	// 콤마제거값
	}
	
	/* 충전하기 */
	function fn_depositPoint() {
		var pnt_no = $("input[name='pnt_no']").val();
		// 충전금액
		var phs_historyAmt = $("input[name='phs_historyAmt']").val();
		var num_depositAmt = parseInt(phs_historyAmt);
		
		// 숫자만 입력되어 있는지 체크
		if(isNaN(num_depositAmt) == true) {
			alert("숫자만 입력 가능합니다.");
		}
		else if(num_depositAmt <= 0) {
			alert("금액을 입력하세요.");
		}
		else if(checkRandomOk == false) {
			alert("인증번호확인 포인트 충전 가능합니다.");
		}
		else {
			
			$.ajax({
				url: "pointDeposit.ho",
				type:'POST',
				dataType: "text",
				async:false,
				data: "pnt_no=" + pnt_no + 
					  "&phs_historyAmt=" + phs_historyAmt,
				success: function(result) {
					alert("포인트가 정상 충전 되었습니다.");
					
					// 부모창에 해당 함수가 있으면 호출. (hotelBooking에서 호출하는 경우 해당 함수 있음)
					if(opener.fn_chgTopBooking) {
						alert(1);
						opener.fn_chgTopBooking(2);
					}
					// 부모창에 해당 함수가 있으면 호출. (hotelBooking에서 호출하는 경우 해당 함수 있음)
					if(opener.fn_parentValue) {
						alert(2);
						opener.fn_parentValue(phs_historyAmt);
					}
					// 부모창에 해당 함수가 있으면 호출. (HCAM_mypagePoint에서 호출하는 경우 해당 함수 있음)
					if(opener.go_tabPage) {
						alert(3);
						opener.go_tabPage("mypage.do?command=mpPoint");
					}
					//$("#div_header", opener.document).load(opener.location.href + "#div_header");
					window.close();
				},
				error: function(request, error) {
					alert(request.status + " / " + request.responseText + " / " + error);
				}
			});
			
		}
		
	}
	
</script>
<body>
	<input type="hidden" name="phs_historyAmt" value="0">
	<input type="hidden" name=pnt_no value="<%=pnt_no %>">
	<div id="div_content">
		<div id="point_title">
			<div>포인트 충전</div>
		</div>
		<div id="div_pointContent">
			<div id="point_text">
				<div>충전금액</div>
				<div id="div_pointBalance">
					<span>현재 포인트 잔액</span>
					<span><%=df.format(pnt_balance) %></span>
				</div>
			</div>
			<div id="point_inputBox">
				<div>
					<input type="text" name="depositAmt" value="0" placeholder="충전할 포인트 입력">
				</div>
			</div>
			<div id="point_btn">
				<div>
					<a onclick="fn_chgPoint(1);">최대금액</a>
					<a onclick="fn_chgPoint(2);">+5만P</a>
					<a onclick="fn_chgPoint(3);">+3만P</a>
					<a onclick="fn_chgPoint(4);">+1만P</a>
				</div>
			</div>
		</div>
		<div id="div_payment">
			<div id="payment_title">
				<div>휴대폰 결제</div>
				<div>
					<a onclick="fn_sendRandom();">인증번호 발송</a>
				</div>
			</div>
			<div id="payment_content">
				<div id="phone_box">
					<div id="telecom">
						<select name="tele">
							<option value="SKT">SKT</option>
							<option value="KT">KT</option>
							<option value="LG">LG U+</option>
						</select>
					</div>
					<div id="phone_num">
						<input type="number" value="" name="phone01" maxlength="3" oninput="fn_maxLengthCheck(this)">
						<span>-</span>
						<input type="number" value="" name="phone02" maxlength="4" oninput="fn_maxLengthCheck(this)">
						<span>-</span>
						<input type="number" value="" name="phone03" maxlength="4" oninput="fn_maxLengthCheck(this)">
					</div>
				</div>
				<div id="chkNumber_box">
					<div>
						<input type="number" name="phone_check" maxlength="6" oninput="fn_maxLengthCheck(this)" placeholder="인증번호 입력">
					</div>
					<div id="chkNum_btn">
						<a onclick="fn_chkRandom();">인증번호 확인</a>
					</div>
				</div>
			</div>
		</div>
		<div id="div_button">
			<button onclick="fn_depositPoint();">충전하기</button>
		</div>
	</div>
	<%
		commonDao.dbClose();
	%>
</body>
</html>