<%@page import="vo.ShbCommentDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.SharingBoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="dao.CommonDAO" id="commonDao"></jsp:useBean>
<jsp:useBean class="dao.HcamFileDAO" id="fileDao"></jsp:useBean>
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
	
	int shb_no = (Integer) request.getAttribute("shb_no");
	/* 게시글 조회  */
	SharingBoardDTO board = (SharingBoardDTO) request.getAttribute("board");
	/* 게시글의 댓글 조회 */
	ArrayList<ShbCommentDTO> comments = (ArrayList<ShbCommentDTO>) request.getAttribute("comments");
	
	/* 게시글 파일명 조회 */
	String fileName = fileDao.getFileName("shb", shb_no);
	/* 파일경로 조회 */
	String filePath = fileDao.getFilePath("shb", shb_no);
	
	/* 회원 별 호텔,캠핑,여행리뷰 각 좋아요 여부 */
	int hlk_useYn = commonDao.getLikeYn("shb", mem_no, shb_no);
	/* 좋아요 총 개수 */
	int hlk_count = commonDao.getLikeCount("shb", shb_no);
	
	// textarea로 입력 받은 글을 공백과 줄바꿈을 살려 출력하기
	String boardContent = (board.getShb_content()).replaceAll("\n", "<br>");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- jquery -->
<script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script>
<!-- css -->
<link rel="stylesheet" type="text/css" href="css/common.css">
<!-- icon -->
<script src="https://kit.fontawesome.com/ae515d5c73.js" crossorigin="anonymous"></script>
<title>Insert title here</title>
<style type="text/css">
	#div_content {
		margin: 0 auto;
		margin-top: 50px;
		margin-bottom: 150px;
		width: 800px;
	}
		#div_title {
			color: #f25555;
		}
		#div_info {
			margin-bottom: 5px;
		}
			#div_info div {
				display: inline-block;
				margin-right: 5px;
			}
			#div_info #div_ctgry {
				color: #f25555;
				font-weight: bold;
			}
			#div_info #div_name {
				font-weight: bold;
			}
		#div_button {
			color: #90949c;
		}
			#div_button div {
				display: inline-block;
			}
				#div_button div a {
					color: #90949c;
				}
			#kubun {
				font-size: 11px;
			    color: #dcdece;
			}
		.div_line {
			margin: 0px;
			margin-top: 20px;
			margin-bottom: 30px;
			min-width: 1px;
		    width: 800px;
		    height: 1px;
		    flex: 1 1 0%;
		    border-bottom: 1px solid rgb(221, 223, 226);
		}
		#board_content {
			width: 800px;
			min-height: 200px;
			margin-bottom: 30px;
		}
			#board_content div:first-child {
				margin-bottom: 30px;
			}
				#board_content img {
					max-width: 100%;
				}
		#div_etc div {
			display: inline-block;
			margin-top: 15px;
			margin-right: 10px;
		}
			#div_etc div .fa-heart {
				margin-right: 2px;
				color: #f25555;
			}
			#div_etc div .fa-comment-dots {
				margin-right: 2px;
				color: #909090;
			}
			#div_etc div span {
				color: #909090;
			}
		/* 댓글 */
		.board_comment {
			width: 800px;
		}
			.board_comment .comment_cnt {
				margin-top: 50px;
			}
				.board_comment .comment_cnt span:nth-child(1),
				.board_comment .comment_cnt span:nth-child(3) {
					font-size: 12pt;
					font-weight: bold;
				}
				.board_comment .comment_cnt span:nth-child(2) {
					font-size: 12pt;
					font-weight: bold;
					color: #f25555;
				}
			.board_comment .comment_level_space {
				margin-left: 50px;
			}
				.board_comment .comment_top {
					width: 800px;
					height: 30px;
				}
					.board_comment .comment_top div {
						float: left;
						margin-right: 5px;
					}
					.board_comment .comment_top div:nth-child(1) {
						font-weight: bold;
					}
					.board_comment .comment_top div:nth-child(2) {
						font-weight: bold;
						color: #909090;
					}
					.board_comment .comment_top div:nth-child(3) {
						margin-left: 10px;
					}
						.comment_top a {
							color: #f25555;
						}
				.board_comment .comment_middle {
					margin-bottom: 10px;
					clear: left;
					width: 800px;
				}
					.board_comment .comment_middle div {
						color: #777;
					}
					.board_comment .comment_middle div span:nth-child(1) {
						font-weight: bold;
						color: var(--color-black);
					}
				.board_comment .comment_bottom {
					width: 800px;
					height: 30px;
				}
					.board_comment .comment_bottom a {
						color: #f25555;
					}
			.div_line_comment {
				margin: 0px;
				margin-top: 5px;
				margin-bottom: 5px;
				min-width: 1px;
			    width: 800px;
			    height: 1px;
			    flex: 1 1 0%;
			    border-bottom: 1px solid rgb(221, 223, 226);
			}
		
		/* 댓글 남기기 */
		.write_comment {
			width: 800px;
		}
			#div_textarea {
				margin-top: 15px;
			}
				.inputBox_comment{
					margin-bottom: 15px;
					padding: 7px 7px 1px 7px;
					width: 785px;
					height: 100px;
				    border-radius: 4px;
				    border: 1px solid rgb(221, 221, 221);
				}
				#div_textarea button {
					float: right;
					width: 120px;
					height: 35px;
					color: var(--color-white);
					background: #f25555;
					border: none;
				}
</style>
</head>
<script>

	/* init window */
	$(document).ready(function(){
		var hlk_useYn = document.getElementsByName("hlk_useYn")[0];		// 로그인한 회원의 좋아요 여부
		// 좋아요한 이력이 있는 경우 하트 icon 변경
		if(hlk_useYn.value == 1) {
			if($('.fa-heart').hasClass('fa-regular')) {
				$('.fa-heart').removeClass('fa-regular');
				$('.fa-heart').addClass('fa-solid');
			}
		}
	});
	
	/* 하트 클릭 시 */
	function fn_chgHeart() {
		
		var mem_no = document.getElementsByName("mem_no")[0];		// 로그인한 mem_no
		if(mem_no.value == 0) {
			alert("로그인 후 이용가능합니다.");
			return;
		}
		
		var hlk_useYn = 0;
		
		if($('.fa-heart').hasClass('fa-regular')){
			hlk_useYn = 1;
			$('.fa-heart').removeClass('fa-regular');
			$('.fa-heart').addClass('fa-solid');
		}
		else {
			hlk_useYn = 0;
			$('.fa-heart').removeClass('fa-solid');
			$('.fa-heart').addClass('fa-regular');
		}
		
		var hlk_kubun = "shb";										// 좋아요 카테고리 
		var hlk_no = document.getElementsByName("shb_no")[0].value;	// 게시판  No
		var hlk_useYn = hlk_useYn;									// 좋아요 여부
		
		fn_callAjaxHeart(hlk_kubun, hlk_no, hlk_useYn); 
	}
	
	/* 하트 클릭 시 ajax로 처리 */
	function fn_callAjaxHeart(hlk_kubun, hlk_no, hlk_useYn) {
		
		$.ajax({
			url: "HCAM_heartChange.jsp",
			type:'POST',
			dataType: "text",
			async:false,
			data: "hlk_kubun=" + hlk_kubun +
				  "&hlk_no=" + hlk_no +
				  "&hlk_useYn=" + hlk_useYn,
			success: function(result) {
				$(".heart_cnt").html(result);
			},
			error: function(request, error) {
				alert(request.status + " / " + request.responseText + " / " + error);
			}
		});
		
	}
	
	/* 게시글 삭제 */
	function fn_deleteBoard(shb_no, fileName) {
		var result = confirm("정말 삭제하시겠습니끼?");
		if(result == true) {
			location.href = "shareBoardDelete.ho?shb_no=" + shb_no + "&fileName=" + fileName;
		}
	}
	
	/* 댓글 남기기 */
	function fn_writeComment() {
		var mem_no = document.getElementsByName("mem_no")[0];		// 로그인한 mem_no
		var shb_no = document.getElementsByName("shb_no")[0];		// 게시판  No
		var comment = document.getElementsByName("comment")[0];		// 댓글 내용
		
		if(mem_no.value == "0") {
			alert("로그인 후 이용가능합니다.");
		}
		else {
			if(comment.value == "") {
				alert("내용을 입력해주세요");
			}
			else {
				fn_callAjaxComment("shareCommentWrite.ho", mem_no.value, shb_no.value, comment.value, 0);
			}
		}
	}
	
	/* 댓글 삭제 */
	function fn_deleteComment(shb_no, sbc_no) {
		var result = confirm("정말 삭제하시겠습니끼?");
		if(result == true) {
			fn_callAjaxComment("shareCommentDelete.ho", 0, shb_no, "", sbc_no);
		}
	}
	
	/* 댓글 작성 or 삭제하는 경우 ajax로 처리 */
	function fn_callAjaxComment(url_param, mem_no, shb_no, comment, sbc_no) {
		// 수정: mem_no, shb_no, comment / 삭제: sbc_no
		$.ajax({
			url: url_param,
			type:'POST',
			dataType: "text",
			async:false,
			data: "mem_no=" + mem_no +
				  "&shb_no=" + shb_no +
				  "&comment=" + comment +
				  "&sbc_no=" + sbc_no,
			success: function(result) {
				$(".comment_section").html(result);
			},
			error: function(request, error) {
				alert(request.status + " / " + request.responseText + " / " + error);
			}
		});
		
	}
	
	/* 대댓글 팝업 오픈 */
	function fn_openPopup(kubun, sbc_no, shb_no, sbc_RE_GRP, sbc_RE_LEV, sbc_RE_SEQ) {
		
		var url = "";
		// 댓글 새로 작성
		if(kubun == "insert") {
			url = "shareCommentPopup.ho?kubun=" + kubun + "&sbc_no=" + sbc_no + "&shb_no=" + shb_no + "&sbc_RE_GRP=" + sbc_RE_GRP + "&sbc_RE_LEV=" + sbc_RE_LEV + "&sbc_RE_SEQ=" + sbc_RE_SEQ;
		}
		else {	// 댓글 수정
			url = "shareCommentPopup.ho?kubun=" + kubun + "&sbc_no=" + sbc_no;
		}
		
		var title = "popupOpener";
		var status = "toolbar=no,directories=no,scrollbars=no,resizable=no,status=no,menubar=no,width=450,height=430,top=100,left=500";
		window.open(url, title, "width=450, height=430, top=100, left=500");
		
	}
	
</script>
<body>
	<!-- header -->
	<jsp:include page="HCAM_header.jsp"/>
	
	<input type="hidden" name="mem_no" value="<%=mem_no%>">			<!-- 로그인한 mem_no -->
	<input type="hidden" name="shb_no" value="<%=shb_no%>">			<!-- 게시판 No -->
	<input type="hidden" name="hlk_useYn" value="<%=hlk_useYn%>">	<!-- 로그인한 회원의 좋아요 여부 -->
	<div id="div_content">
		<div id="board_info">
			<div id="div_title"><h1><%=board.getShb_title()%></h1></div>
			<div id="div_info">
				<div id="div_ctgry"><%=commonDao.getCodeName(board.getShb_ctgry()) %></div>
				<div id="div_name"><span>by </span><%=commonDao.getCommonCode("sharingBoard", "shb_no", board.getShb_no()) %></div>
				<div><%=board.getShb_date()%></div>
			</div>
			<% if(mem_no == board.getMem_no()) { %>
					<div id="div_button">
						<div><a href="shareBoardUpdate01.ho?shb_no=<%=shb_no%>">수정</a></div>
						<div id="kubun">｜</div>
						<div><a onclick="fn_deleteBoard('<%=shb_no%>', '<%=fileName %>');">삭제</a></div>
					</div>
			<% } %>
			<div id="div_etc">
				<div>
					<!-- 하트 아이콘 -->
					<a onclick="fn_chgHeart();"><i class="fa-regular fa-heart fa-lg"></i></a>
					<span class="heart_cnt">
						<span><%=hlk_count%></span>
					</span>
				</div>
				<div>
					<!-- 대화상자 아이콘 -->
					<a><i class="fa-regular fa-comment-dots fa-lg"></i></a>
					<span><%=comments.size() %></span>
				</div>
			</div>
		</div>
		<div class="div_line"></div>
		<div id="board_content">
			<div>
				<img alt="" src="<%=filePath%>">
			</div>
			<div><%=boardContent%></div>
		</div>
		<div class="comment_section">
			<div class="board_comment">
				<div class="comment_cnt">
					<span>댓글</span>
					<span><%=comments.size() %></span>
					<span> 개</span>
				</div>
				<% for(int i=0; i<comments.size(); i++) {
					if(comments.get(i).getSbc_RE_LEV() != 1) {
						out.println("<div class='comment_level_space'>");
					}
					else {
						out.println("<div>");
						out.println("<div class='div_line_comment'></div>");
					}
				%>
						<div class="comment_top">
							<div><%=commonDao.getCommonCode("ShbComment", "sbc_no", comments.get(i).getSbc_no()) %></div>
							<div><%=comments.get(i).getSbc_date() %></div>
							<!-- 로그인한 회원 && 삭제되지 않은 댓글인 경우 -->
							<% if(comments.get(i).getMem_no() == mem_no && comments.get(i).getSbc_useYN() == 1) { %>
								<div>
									<a onclick="fn_openPopup('update', <%=comments.get(i).getSbc_no() %>);">수정</a>
									<a onclick="fn_deleteComment(<%=shb_no%>, <%=comments.get(i).getSbc_no() %>);">삭제</a>
								</div>
							<% } %>
						</div>
				<%
					// 댓글이 삭제된 경우
					if(comments.get(i).getSbc_useYN() == 0) {
				%>
						<div class="comment_middle">
							<div>댓글이 삭제되었습니다.</div>
						</div>
				<% 	} 
					else {
				%>
						<div class="comment_middle">
							<!-- 댓글의 댓글의 댓글인 경우 상위 댓글의 작성자명 표시 -->
							<% if(comments.get(i).getSbc_RE_LEV() >= 3) {%>
								<div>
									<span>@<%=commonDao.getCommonCode("ShbComment", "sbc_no", comments.get(i).getSbc_RE_SUPER()) %></span>
									<span><%=comments.get(i).getSbc_content() %></span> 
								</div>
							<% } else {%>
								<div><%=comments.get(i).getSbc_content() %></div>
							<% } %>
							
						</div>
						<div class="comment_bottom">
							<!-- 댓글의 댓글 버튼 -->
							<a onclick="fn_openPopup('insert', <%=comments.get(i).getSbc_no() %>, <%=comments.get(i).getShb_no() %>, <%=comments.get(i).getSbc_RE_GRP() %>, <%=comments.get(i).getSbc_RE_LEV() %>, <%=comments.get(i).getSbc_RE_SEQ() %>);">댓글</a>
						</div>
				<%
				    }
						out.println("</div>");
				   } 
				%>
			</div>
			<div class="write_comment">
				<div id="div_textarea">
					<textarea class="inputBox_comment" name="comment" placeholder="댓글을 입력해주세요."></textarea>
					<button onclick="fn_writeComment();">댓글 남기기</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- footer -->
	<jsp:include page="HCAM_footer.jsp"/>
	
	<%
		commonDao.dbClose();
		fileDao.dbClose();
	%>
</body>
</html>