<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="dao.CommonDAO" id="commonDao"></jsp:useBean>
<%
	//로그인한 회원정보
	int pnt_no = 0;
	if(session.getAttribute("pnt_no") != null) {
		pnt_no = Integer.parseInt(String.valueOf(session.getAttribute("pnt_no")));
	}

	String title = request.getParameter("title");
	String kubun = request.getParameter("kubun");

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
<title>Insert title here</title>
</head>
<script>
	$(document).ready(function() {
		
		var kubun = $("input[name='kubun']").val(); // 예약진행상태 구분
		
		if(kubun == 1) {
			$('.top_line01').addClass('top_lineGray');
			$('.top_line0201').addClass('top_lineGray');
			$('.top_line0202').addClass('top_lineGray');
			$('.top_line03').addClass('top_lineGray');
			
			$('.top_num01').addClass('top_numBlue');
			$('.top_num02').addClass('top_numGray');
			$('.top_num03').addClass('top_numGray');
			
			$('.top_comment01').addClass('top_Commentblue');
			$('.top_comment02').addClass('top_CommentGray');
			$('.top_comment03').addClass('top_CommentGray');
		}
		else if(kubun == 2) {
			$('.top_line01').addClass('top_lineBlue');
			$('.top_line0201').addClass('top_lineBlue');
			$('.top_line0202').addClass('top_lineGray');
			$('.top_line03').addClass('top_lineGray');
			
			$('.top_num01').addClass('top_numBlue');
			$('.top_num02').addClass('top_numBlue');
			$('.top_num03').addClass('top_numGray');
			
			$('.top_comment01').addClass('top_Commentblue');
			$('.top_comment02').addClass('top_Commentblue');
			$('.top_comment03').addClass('top_CommentGray');
		}
		else if(kubun == 3) {
			$('.top_line01').addClass('top_lineBlue');
			$('.top_line0201').addClass('top_lineBlue');
			$('.top_line0202').addClass('top_lineBlue');
			$('.top_line03').addClass('top_lineBlue');
			
			$('.top_num01').addClass('top_numBlue');
			$('.top_num02').addClass('top_numBlue');
			$('.top_num03').addClass('top_numBlue');
			
			$('.top_comment01').addClass('top_Commentblue');
			$('.top_comment02').addClass('top_Commentblue');
			$('.top_comment03').addClass('top_Commentblue');
		}
	});
</script>
<body>
<input type="hidden" name="kubun" value="<%=kubun %>">
	<div id="top_content">
		<div id="top_left">
			<div><%=title %> 예약</div>
		</div>
		<div id="top_middle">
			<ul>
				<li>
					<div class="top_number">
						<div class="top_line01"></div>
						<div class="top_num01">1</div>
					</div>
					<div class="top_comment">
						<div class="top_comment01">고객정보</div>
					</div>
				</li>
				<li>
					<div class="top_number">
						<div class="top_line0201"></div>
						<div class="top_line0202"></div>
						<div class="top_num02">2</div>
					</div>
					<div class="top_comment">
						<div class="top_comment02">결제 진행중</div>
					</div>
				</li>
				<li>
					<div class="top_number">
						<div class="top_line03"></div>
						<div class="top_num03">
							<span><i class="fa-solid fa-check"></i></span>
						</div>
					</div>
					<div class="top_comment">
						<div class="top_comment03">예약완료</div>
					</div>
				</li>
			</ul>
		</div>
		<div id="top_right">
			<div>
				<span>포인트잔액</span>
				<span><input type="text" name="fmt_pointBalance" value="<%=df.format(pnt_balance) %>"></span>
			</div>
		</div>
	</div>
	
	<%
		commonDao.dbClose();
	%>
</body>
</html>