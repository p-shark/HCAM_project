<%@page import="java.util.Map"%>
<%@page import="java.util.TreeMap"%>
<%@page import="vo.SharingBoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="dao.CommonDAO" id="commonDao"></jsp:useBean>
<%
	//한글 깨짐 방지
	request.setCharacterEncoding("UTF-8");

	//로그인한 회원정보
	String id = (String) session.getAttribute("id");
	// 세션에 저장된 mem_no 값 가져오기 
	int mem_no = 0;
	if(session.getAttribute("mem_no") != null) {
		mem_no = Integer.parseInt(String.valueOf(session.getAttribute("mem_no")));
	}
	
	int shb_no = (Integer) request.getAttribute("shb_no");
	/* 게시글 파일명 조회 */
	String fileName = (String) request.getAttribute("fileName");
	/* 파일경로 조회 */
	String filePath = (String) request.getAttribute("filePath");
	
	/* 게시글 조회  */
	SharingBoardDTO board = (SharingBoardDTO) request.getAttribute("board");
	
	/* 코드별 공통코드 전체 조회 */
	TreeMap<String, String> commCodes = commonDao.getCodeAllByCode("SHB01");
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
	<style type="text/css">
		section{
			width: 100%;
			padding: 40px 0px 100px 30px;
			margin: 0px auto;
			height: 755px;
			border: 1px soild black;
		}
		#total_center{
			margin: 0px auto;
			width: 940px;
			height: 600px;
		}
		.sub_title{
			height: 10px;
			border-bottom: 1px solid rgb(242, 242, 242);
			padding: 14px 20px 16px;
			line-height: 19px;
			font-size: 14px;
			color: rgb(102, 102, 102);
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
			border-radius: 4px;
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
			padding: 15px 11px 1px 15px;
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
			height: 175px;
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
			margin-top: 40px;
			width: 100%;
			height: 70px;
			text-align: center;
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
		    background-color: var(--color-blue);
		    font-weight: 500;
		    border-radius: 5px;
		}		 
		#btn_update{
		    width: 160px;
		    height: 56px;
		    margin-top: 15px;
		    margin-right: 10px;
		    padding: 0px 10px;
		    text-align: center;
		    font-size: 16px;
		    line-height: 20px;
		    color: white;
		    cursor: pointer;
		    border: 1px solid rgb(221, 221, 221);
		    background-color: var(--color-blue);
		    font-weight: 500;
		    border-radius: 5px;
		}	
		#btn_delete {
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
		    background-color: #F63434;
		    font-weight: 500;
		    border-radius: 5px;
		}	    

	</style>
</head>
<script>
	// 수정
	function fn_updateBoard() {
		var title = document.getElementsByName("title")[0].value;
		var content = document.getElementsByName("content")[0].value;
		
		var result = false;
		if(title != "" && content != "") {
			result = true;
		}
		else {
			alert("제목 또는 내용을 입력하세요");
		}
		
		return result;
	}
	
	// 삭제
	function fn_deleteBoard(shb_no, fileName) {
		var result = confirm("정말 삭제하시겠습니끼?");
		if(result == true) {
			location.href = "shareBoardDelete.ho?shb_no=" + shb_no + "&fileName=" + fileName;
		}
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
	
	<section>
		<form action="shareBoardUpdate02.ho" method="post" enctype="multipart/form-data" onsubmit="return fn_updateBoard();">
			<input type="hidden" name="shb_no" value="<%=board.getShb_no() %>">
			<div id="total_center">
				<div id="title_head">
					<table>
						<div>
							<tr>
								<td colspan="2">카테고리<span class="redStar"> *</span></td>
								<td colspan="5">
									<select name="category" class="selectBox">
										<% 
											for(Map.Entry<String, String> code : commCodes.entrySet()) { 
												if(code.getKey().equals(board.getShb_ctgry())) {
													out.println("<option value='" + code.getKey() + "' selected>" + code.getValue() + "</option>");
												}
												else {
													out.println("<option value='" + code.getKey() + "'>" + code.getValue() + "</option>");
												}
											}
										%>
									</select>
								</td>
							</tr>
						</div>
						<div>
							<tr>
								<td colspan="2">제목<span class="redStar"> *</span></td>
								<td colspan="5">
									<input type="text" class="inputBox" name="title" placeholder="제목을 입력해주세요" value="<%=board.getShb_title()%>">
								</td>
							</tr>
							<tr>
								<td colspan="2">내용<span class="redStar"> *</span></td>
								<td colspan="5">
									<textarea class="inputBox_context" name="content"><%=board.getShb_content()%></textarea>
								</td>
							</tr>
							<tr>
								<td colspan="2"></td>
								<td colspan="5">
									<input type="file" name="filename" accept="uploadFile/*" onchange="setThumbnail(event);" multiple>
									<div id="image_container">
										<img alt="" src="<%=filePath %>" style="width: 150px; height: 150px; margin-top: 5px; margin-right: 5px;">
									</div>
									<!-- <button type="button" name="bt_attachPic" id="bt_cam">
										<span id="bt_cam_pic"></span>
									</button> -->
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
						<input type="submit" value="수정" id="btn_update">
						<input type="button" value="삭제" id="btn_delete" onclick="fn_deleteBoard('<%=board.getShb_no()%>', '<%=fileName %>');">
					</div>	
				</div>
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