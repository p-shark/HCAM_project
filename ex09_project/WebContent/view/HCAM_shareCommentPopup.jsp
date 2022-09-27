<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="dao.CommonDAO" id="commonDao"></jsp:useBean>
<%
	//한글 깨짐 방지
	request.setCharacterEncoding("UTF-8");

	//로그인한 id
	String id = (String) session.getAttribute("id");
	//세션에 저장된 mem_no 값 가져오기 
	int mem_no = 0;
	if(session.getAttribute("mem_no") != null) {
		mem_no = Integer.parseInt(String.valueOf(session.getAttribute("mem_no")));
	}
	
	/* 로그인한 회원 이름 조회 */
	String mem_name = commonDao.getLoginMember(mem_no);
	
	// 이전 화면에서 넘어온 값
	String kubun = (String) request.getAttribute("kubun");
	int sbc_no = 0;
	int shb_no = 0;
	int sbc_RE_GRP = 0;
	int sbc_RE_LEV = 0;
	int sbc_RE_SEQ = 0;
	
	// 내용 조회
	String sbc_content = "";
	
	if("insert".equals(kubun)) {
		sbc_no = (Integer) request.getAttribute("sbc_no");
		shb_no = (Integer) request.getAttribute("shb_no");
		sbc_RE_GRP = (Integer) request.getAttribute("sbc_RE_GRP");
		sbc_RE_LEV = (Integer) request.getAttribute("sbc_RE_LEV");
		sbc_RE_SEQ = (Integer) request.getAttribute("sbc_RE_SEQ");
	}
	else {
		sbc_no = (Integer) request.getAttribute("sbc_no");
		sbc_content = (String) request.getAttribute("sbc_content");
	}
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
<style>
	#body_content {
		width: 100%;
	}
		#top_text {
			width: 100%;
			height: 50px;
			background-color: #F0F3F7;
			font-size: 15pt;
		}
			#top_text div {
				margin-left: 20px;
				line-height: 50px;
				width: 150px;
				height: 50px;
			}
		#content {
			margin: 0 auto;
			margin-top: 30px;
			width: 300px;
			height: 350px;
		}
			#content_name {
				font-size: 11.5pt;
			}
			#content_text {
				margin-top: 10px;
				width: 285px;
				height: 220px;
			}
				.inputBox_comment{
					margin-bottom: 15px;
					padding: 7px 7px 1px 7px;
					width: 285px;
					height: 200px;
				    border: 1px solid rgb(221, 221, 221);
				}
			#content_btn {
				margin-top: 10px;
				text-align: right;
			}
				#content_btn button {
					display: inline-block;
					width: 70px;
					height: 32px;
					border-radius: 30px;
				}
				#content_btn button:nth-child(1) {
					background-color: var(--color-white);
					border: 1px solid rgb(221, 221, 221);
				}
				#content_btn button:nth-child(2) {
					background-color: #f25555;
					color: var(--color-white);
					border: 1px solid #f25555
				}
</style>
</head>
<script>
	function fn_saveComment() {
		var comment = document.getElementsByName("comment")[0].value;
		
		if(comment != "") {
			fn_callAjaxComment(comment);
		}
		else {
			alert("내용을 입력하세요");
			return;
		}
	}
	
	function fn_callAjaxComment(comment) {
		
		var allData = {
			"kubun" : $("input[name='kubun']").val(),
			"mem_no" : $("input[name='mem_no']").val(),
			"sbc_no" : $("input[name='sbc_no']").val(),
			"shb_no" : $("input[name='shb_no']").val(),
			"sbc_RE_GRP" : $("input[name='sbc_RE_GRP']").val(),
			"sbc_RE_LEV" : $("input[name='sbc_RE_LEV']").val(),
			"sbc_RE_SEQ" : $("input[name='sbc_RE_SEQ']").val(),
			"comment" : comment
		};
		
		$.ajax({
			url: "shareCommentPopupSave.ho",
			type:'POST',
			dataType: "text",
			async:false,
			data: allData,
			success: function(result) {
				opener.location.reload();
				window.close();
			},
			error: function(request, error) {
				alert(request.status + " / " + request.responseText + " / " + error);
			}
		});
		
	}
</script>
<body>
	<div id="body_content">
		<div id="top_text">
			<div>댓글에 댓글</div>
		</div>
		<div id="content">
			<input type="hidden" name="mem_no" value="<%=mem_no %>">
			<input type="hidden" name="kubun" value="<%=kubun %>">
			<input type="hidden" name="sbc_no" value="<%=sbc_no %>">
			<input type="hidden" name="shb_no" value="<%=shb_no %>">
			<input type="hidden" name="sbc_RE_GRP" value="<%=sbc_RE_GRP %>">
			<input type="hidden" name="sbc_RE_LEV" value="<%=sbc_RE_LEV %>">
			<input type="hidden" name="sbc_RE_SEQ" value="<%=sbc_RE_SEQ %>">
			
			<div id="content_name"><%=mem_name %></div>
			<div id="content_text">
				<% if("insert".equals(request.getParameter("kubun"))) { %>
					<textarea class="inputBox_comment" name="comment" placeholder="댓글을 입력해주세요."></textarea>
				<% }
				   else {%>
					<textarea class="inputBox_comment" name="comment" placeholder="댓글을 입력해주세요."><%=sbc_content %></textarea>
				<% } %>
			</div>
			<div id="content_btn">
				<button onclick="window.close();">취소</button>
				
				<% if("insert".equals(request.getParameter("kubun"))) { %>
					<button onclick="fn_saveComment();">저장</button>
				<% }
				   else {%>
					<button onclick="fn_saveComment();">수정</button>
				<% } %>
			</div>
		</div>
	</div>
	
	<%
		commonDao.dbClose();
	%>

</body>
</html>