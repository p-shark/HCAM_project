<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
						width: 340px;
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
						width: 100px;
						border: 1px solid #E6E6E6;
					}
						#telecom select {
							padding: 0 10px;
							width: 90px;
							height: 30px;
							border: none;
							outline: none;
						}
					#phone_box #phone_num {
						display: inline-block;
					}
						#phone_num input {
							width: 59px;
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
					width: 240px;
					border: 1px solid #E6E6E6;
				}
					#chkNumber_box input {
						width: 230px;
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
			#div_button input[type=submit] {
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
</script>
<body>
	<div id="div_content">
		<div id="point_title">
			<div>포인트 충전</div>
		</div>
		<div id="div_pointContent">
			<div id="point_text">
				<div>충전금액</div>
				<div id="div_pointBalance">
					<span>현재 포인트 잔액</span>
					<span>155,000</span>
				</div>
			</div>
			<div id="point_inputBox">
				<div>
					<input type="number" name="depositAmt" value="0" placeholder="충전할 포인트 입력">
				</div>
			</div>
			<div id="point_btn">
				<div>
					<a onclick="fn_chgPoint('1');">최대금액</a>
					<a onclick="fn_chgPoint('2');">+5만P</a>
					<a onclick="fn_chgPoint('3');">+3만P</a>
					<a onclick="fn_chgPoint('4');">+1만P</a>
				</div>
			</div>
		</div>
		<div id="div_payment">
			<div id="payment_title">
				<div>휴대폰 결제</div>
				<div>
					<a>인증번호 발송</a>
				</div>
			</div>
			<div id="payment_content">
				<div id="phone_box">
					<div id="telecom">
						<select>
							<option value="">선택</option>
							<option value="SKT">SKT</option>
							<option value="KT">KT</option>
							<option value="LG">LG U+</option>
						</select>
					</div>
					<div id="phone_num">
						<input type="number" value="010" readonly="readonly">
						<span>-</span>
						<input type="number" value="" maxlength="4" oninput="fn_maxLengthCheck(this)">
						<span>-</span>
						<input type="number" value="" maxlength="4" oninput="fn_maxLengthCheck(this)">
					</div>
				</div>
				<div id="chkNumber_box">
					<div>
						<input type="number" maxlength="6" oninput="fn_maxLengthCheck(this)" placeholder="인증번호 입력">
					</div>
					<div id="chkNum_btn">
						<a>인증번호 확인</a>
					</div>
				</div>
			</div>
		</div>
		<div id="div_button">
			<input type="submit" value="충전하기">
		</div>
	</div>
</body>
</html>