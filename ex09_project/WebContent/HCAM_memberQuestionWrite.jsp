<%@page import="java.util.Map"%>
<%@page import="java.util.TreeMap"%>
<%@page import="vo.QuestionBoardDTO"%>
<%@page import="dao.QuestionDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="dao.CommonDAO" id="commonDao"></jsp:useBean>
<%
	//한글 깨짐 방지
	request.setCharacterEncoding("UTF-8");

	//세션에 저장된 mem_no 값 가져오기
	int mem_no = 0; 
	if(session.getAttribute("mem_no") != null){
		mem_no = Integer.parseInt(String.valueOf(session.getAttribute("mem_no")));
	}
	
	/* 코드별 공통코드 전체 조회 */
	TreeMap<String, String> commCodes = commonDao.getCodeAllByCode("CTG01");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- jquery -->
	<script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href="css/common.css">
	<title>문의사항 작성하기</title>
	<style type="text/css">
		section{
			width: 100%;
			padding: 40px 0px 100px 30px;
			margin: 0px auto;
			min-height: 710px;
			border: 1px soild black;
		}
		#total_left{
			width: 20%;
			float: left;
		}
		#total_center{
			width: 50%;
			float: left;
		}
		#total_right{
			width: 30%;
		}
		#total_left ul{
			width: 200px;
			border: 1px solid rgb(242, 242, 242);
		}
		.total_title{
			padding: 5px 0px 35px 1px;
			font-weight: 500;
			font-size: 28px;
		    line-height: 35px;
		    color: rgb(51, 51, 51);
		    letter-spacing: -1px;
		}
		.sub_title{
			height: 10px;
			border-bottom: 1px solid rgb(242, 242, 242);
			width: 160px;
			height: 20px;
			line-height: 22px;
			padding: 14px 20px 16px;
			font-size: 14px;
			color: rgb(102, 102, 102);
		}
		.sub_title:last-child{
			border-bottom: none;
		}
		.arrow{
			background-image: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI2IiBoZWlnaHQ9IjExIiB2aWV3Qm94PSIwIDAgNiAxMSI+CiAgICA8cGF0aCBmaWxsPSIjOTk5IiBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGQ9Ik0xIDExTDYgNS41IDEgMCAwIDEuMSA0IDUuNSAwIDkuOXoiLz4KPC9zdmc+Cg==);
			display: inline-block;
		    width: 6px;
		    height: 11px;
		    margin-left: 80px;
		}
		#title_head{
			width: 100%;
			padding: 15px 30px 20px 30px;
    		border-top: 2px solid rgb(51, 51, 51);
    		vertical-align: middle;
		}
		#title_head table tr td:first-child{
			width: 140px;
			height: 45px;
			font-size: 14px;
    		line-height: 44px;
    		margin-top: 0px;
		}
		.redStar{
			color: red;
		}
		.selectBox{
			width: 778px;
			height: 45px;
			padding-left: 11px;
			border: 1px solid rgb(221, 221, 221);
		}
		.inputBox{
			width: 750px;
			height: 45px;
			padding: 0px 11px 1px 15px;
		    border-radius: 4px;
		    border: 1px solid rgb(221, 221, 221);
		}
		.inputBox_context{
			width: 750px;
			height: 300px;
			padding: 0px 11px 1px 15px;
		    border-radius: 4px;
		    border: 1px solid rgb(221, 221, 221);
		}
		textarea::placeholder{
			font-size: 13px;
		    line-height: 20px;
		    color: rgb(153, 153, 153);
		}
		#bt_cam{
			width: 60px;
			height: 60px;
			border: 1px solid rgb(221, 221, 221);
   			border-radius: 6px;
   			background-color: white;
		}
		#image_container {
			margin-top: 10px;
			margin-bottom: 10px;
			width: 800px;
			height: 20px;
		}
		#bt_cam_pic{
			display: inline-block;
		    width: 1.875rem;
		    height: 1.875rem;
		    background-image: url(data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzAiIGhlaWdodD0iMzAiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CiAgICA8ZyBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPgogICAgICAgIDxwYXRoIGQ9Ik0wIDBoMzB2MzBIMHoiLz4KICAgICAgICA8ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSg0Ljc3OSA2LjExMSkiIHN0cm9rZT0iIzMzMyIgc3Ryb2tlLXdpZHRoPSIxLjMiPgogICAgICAgICAgICA8cGF0aCBkPSJNMTEuNzkyIDBjLjM5OSAwIC43MTcuMDU2Ljk1NS4xNy4xNzkuMDg0LjM0Ni4xOTkuNTAzLjM0NGwuMTUzLjE1NS42MzEuNzAzYy4xMjIuMTMuMjM0LjIzMy4zMzcuMzFhLjk1Ljk1IDAgMCAwIC4zNC4xNmMuMTI1LjAzMS4yOTIuMDQ3LjUwMy4wNDdsMi45MDYtLjAwM2MxLjI4NCAwIDIuMzI0IDEuMDYyIDIuMzI0IDIuMzd2MTEuMTUxYzAgMS4zMS0xLjA0IDIuMzctMi4zMjQgMi4zN0gyLjMyNGMtMS4yODMgMC0yLjMyNC0xLjA2LTIuMzI0LTIuMzdWNC4yNTdjMC0xLjMxIDEuMDQtMi4zNyAyLjMyNC0yLjM3aDIuOTgzYy4yNDUtLjAwOS40MzItLjA0NS41NTktLjEwOC4xMS0uMDU1LjIzLS4xNDUuMzYtLjI3bC4xMzQtLjEzNy42MzEtLjcwM2MuMi0uMjIuNDE4LS4zODcuNjU3LS41LjE5LS4wOS40MzItLjE0NC43MjUtLjE2Mkw4LjYwMyAwaDMuMTg5eiIvPgogICAgICAgICAgICA8Y2lyY2xlIGN4PSIxMC4xNDIiIGN5PSI5LjUyOSIgcj0iMy41NTYiLz4KICAgICAgICA8L2c+CiAgICA8L2c+Cjwvc3ZnPgo=);
		    background-size: cover;
		    background-position: center center;
		    background-repeat: no-repeat;
		}
		#regLine{
			width: 100%;
			height: 70px;
			text-align: center;
			margin: 10px;
			border-top: 1px solid rgb(221, 221, 221);;
		}
		#bt_reg{
		    width: 160px;
		    height: 56px;
		    margin-top: 15px;
		    padding: 0px 10px;
		    text-align: center;
		    font-size: 16px;
		    line-height: 20px;
		    color: white;
		    cursor: pointer;
		    border: 1px solid rgb(221, 221, 221);
		    background-color:#5392F9;
		    font-weight: 500;
		    border-radius: 5px;
		}		    
}
	</style>
</head>
<script>
	function fn_regiList(){
		var title = document.getElementsByName("qbd_title")[0].value;
		var content = document.getElementsByName("qbd_content")[0].value;	
		
		var result = false;
		if(title != "" && content != ""){
			result = true;
		}
		else{
			alert("제목 또는 내용을 입력해주세요.")
		}
		
		return result;
	}

	// **************************  썸네일은 여러개 볼 수 있는데 업로드는 하나만 됨. 추후 수정 예정  ******************************
	// 사진 미리보기
	function setThumbnail(event) {
		var image_con = document.querySelector("div#image_container");
		var section = document.querySelector("section");
		
		// 이미지 초기화
		$("div#image_container").html("");
		image_con.style.height = "155px";
		section.style.height = "755px";
		
		var cnt = 1;
		var totalCnt = 2;
		for (var image of event.target.files) {
			var reader = new FileReader();
			
			reader.onload = function(event) {
				var img = document.createElement("img");
				img.setAttribute("src", event.target.result);
				img.style.width = "150px";
				img.style.height = "150px";
				img.style.marginTop = "5px";
				img.style.marginRight = "5px";
				
				document.querySelector("div#image_container").appendChild(img);
			};
			
			if(cnt%6 == 0) {
				image_con.style.height = (155 * totalCnt) + "px";
				section.style.height = (600 + 155 * totalCnt) + "px";
				totalCnt++;
			}
			
			cnt++;
			
			reader.readAsDataURL(image);
		}
	}
</script>

<body>
	<!-- header -->
	<jsp:include page="HCAM_header.jsp"/>
	<!-- section -->
	<section>
		<form method="post" enctype="multipart/form-data" action="memberQuestionWrite02.co" onsubmit="return fn_regiList();">
			<input type="hidden" name="mem_no" value="<%=mem_no%>">
			<div id="total_left">
				<div class="total_title">고객센터</div>
				<ul>
					<div class="sub_title">
						<li>
							<a>공지사항<div class="arrow"></div>
							</a>
						</li>
					</div>
					<div class="sub_title">
						<li>
							<a>문의사항<div class="arrow" style="margin-left:90px"></div>
							</a>
						</li>
					</div>
				</ul>
			</div>
			<div id="total_center">
				<div class="total_title">문의사항</div>
				<div id="title_head">
					<table>
						<div>
							<tr>
								<td colspan="2">분류<span class="redStar">*</span></td>
								<td colspan="5">
									<select name="qbd_ctgry" class="selectBox">
										<% 
											for(Map.Entry<String, String> code : commCodes.entrySet()) { 
												out.println("<option value='" + code.getKey() + "'>" + code.getValue() + "</option>");
											}
										%>
									</select>
								</td>
							</tr>
						</div>
						<div>
							<tr>
								<td colspan="2">제목<span class="redStar">*</span></td>
								<td colspan="5">
									<input type="text" name="qbd_title" class="inputBox" placeholder="제목을 입력해주세요">
								</td>
							</tr>
							<tr>
								<td colspan="2">내용<span class="redStar">*</span></td>
								<td colspan="5">
									<textarea class="inputBox_context" name="qbd_content" placeholder="&#13;&#10;1:1 문의 작성 전 확인해주세요&#13;&#10;&#13;&#10;반품/환불&#13;&#10;-하자 혹은 이상으로 환불(반품)이 필요한 경우 사진과 함께 구체적인 내용을 남겨주세요.&#13;&#10;&#13;&#10;취소&#13;&#10;-주문마감 시간에 임박할수록 취소 가능 시간이 짧아질 수 있습니다.&#13;&#10;-일부 예약상품은 배송 3~4일 전에만 취소 가능합니다.&#13;&#10;-주문상품의 부분취소는 불가능합니다.&#13;&#10;*전체 주문 취소 후 다시 구매 해주세요.&#13;&#10;&#13;&#10;배송&#13;&#10;-전화번호, 주소, 계좌번호 등의 상세 개인정보가 문의 내용에 저장되지 않도록 주의하세요."></textarea>
								</td>
							</tr>
							<tr>
								<td colspan="2"></td>
								<td colspan="5">
									<input type="file" name="filename" accept="uploadFile/*" onchange="setThumbnail(event);" multiple required>
									<div id="image_container"></div>
								</td>
							</tr>
							<tr>
								<td colspan="2"></td>
								<td colspan="5">
									<font color="#999999">
										- 30MB 이하의 이미지만 업로드 가능합니다.<br>
										- 상품과 무관한 내용이거나  불법적인 내용은 통보없이 삭제 될 수 있습니다.<br>
										- 사진은 최대 8장까지 등록가능합니다.
									</font>
								</td>
							</tr>
						</div>
					</table>
					<div id="regLine">
						<input type="submit" value="등록" id="bt_reg">
					</div>	
				</div>
			</div>
			<div id="total_right">
			</div>
		</form>
	</section>
	
	<!-- footer -->
	<jsp:include page="HCAM_footer.jsp"/>
	
	<%
		commonDao.dbClose();
	%>
	
</body>
</html>