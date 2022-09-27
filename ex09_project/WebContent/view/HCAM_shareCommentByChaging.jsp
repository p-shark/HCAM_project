<%@page import="vo.ShbCommentDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.SharingBoardDTO"%>
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
	
	int shb_no = (Integer) request.getAttribute("shb_no");
	
	/* 게시글의 댓글 조회 */
	ArrayList<ShbCommentDTO> comments = (ArrayList<ShbCommentDTO>) request.getAttribute("comments");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
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
	
	<%
		commonDao.dbClose();
	%>
</body>
</html>