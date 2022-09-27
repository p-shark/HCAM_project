<%@page import="vo.SharingBoardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.PageInfo"%>
<%@page import="java.util.TreeMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="dao.CommonDAO" id="commonDao"></jsp:useBean>
<jsp:useBean class="dao.HcamFileDAO" id="fileDao"></jsp:useBean>
<%
	//로그인한 회원정보
	String id = (String) session.getAttribute("id");
	//세션에 저장된 mem_no 값 가져오기 
	int mem_no = 0;
	if(session.getAttribute("mem_no") != null) {
		mem_no = Integer.parseInt(String.valueOf(session.getAttribute("mem_no")));
	}
	
	String category = (String) request.getAttribute("category");
	// 페이징 처리
	PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
	/* 게시판 정보 */
	ArrayList<SharingBoardDTO> boards = (ArrayList<SharingBoardDTO>) request.getAttribute("boards");
	
	int pageNo = 1;
	
	// 페이징 처리를 위한 변수
	int listCount=pageInfo.getListCount();
	int nowPage=pageInfo.getPage();
	int maxPage=pageInfo.getMaxPage();
	int startPage=pageInfo.getStartPage();
	int endPage=pageInfo.getEndPage();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<ul>
		<% for(int i=0; i<boards.size(); i++) { %>
				<li>
					<div class="box"> 
						<div class="boxTop">
							<a href="shareBoardDetail.ho?shb_no=<%=boards.get(i).getShb_no() %>">
								<% if(fileDao.getFilePath("shb", boards.get(i).getShb_no()) != "") { %>
									<img src="<%=fileDao.getFilePath("shb", boards.get(i).getShb_no())%>">
								<% } else { %>
									<img src="image/index_hcam_hotel.jpg">
								<% } %>
							</a>
							<span class="span_best">best</span>
						</div>
						<div class="boxBottom">
							<div class="div_title">
								<p>
									<a href="shareBoardDetail.ho?shb_no=<%=boards.get(i).getShb_no() %>"><%=boards.get(i).getShb_title() %></a>
								</p>
							</div>
							<div class="div_line"></div>
							<div class="div_content"><%=boards.get(i).getShb_content() %></div>
							<div class="icon">
								<div class="icon_name">
									<div>by <%=commonDao.getCommonCode("sharingBoard", "shb_no", boards.get(i).getShb_no()) %></div>
									<% if(mem_no == boards.get(i).getMem_no()) { %>
										<div id="div_update">
											<a id="btn_update" onclick="location.href='shareBoardUpdate01.ho?shb_no=<%=boards.get(i).getShb_no()%>'">수정</a>
										</div>
									<% } %>
								</div>
								<div class="icon_left">
									<div>
										<!-- 하트 아이콘 -->
										<% 
											/* 회원 별 호텔,캠핑,여행리뷰 각 좋아요 여부 */
											int hlk_useYn = commonDao.getLikeYn("shb", mem_no, boards.get(i).getShb_no());
											if(hlk_useYn == 1) {
										%>
											<a onclick="fn_chgHeart(<%=boards.get(i).getShb_no() %>);">
												<i class="fa-solid fa-heart fa-lg no<%=boards.get(i).getShb_no() %>"></i>
											</a>
										<%	} else { %>
											<a onclick="fn_chgHeart(<%=boards.get(i).getShb_no() %>);">
												<i class="fa-regular fa-heart fa-lg no<%=boards.get(i).getShb_no() %>"></i>
											</a>
										<%	} %>
										<span><%=commonDao.getLikeCount("shb", boards.get(i).getShb_no()) %></span>
									</div>
									<div>
										<!-- 대화상자 아이콘 -->
										<a><i class="fa-regular fa-comment-dots fa-lg"></i></a>
										<span><%=boards.get(i).getCommentCnt() %></span>
									</div>
								</div>
							</div>
						</div>
					</div>
				</li> 
		<% } %>
	</ul>
	<section id="pageList">
		<%if(nowPage<=1){ %>
			[이전]&nbsp;
		<%}else{ %>
			<a href="shareBoard.ho?page=<%=nowPage-1 %>&category=<%=category %>">[이전]</a>&nbsp;
		<%} %>

		<%for(int a=startPage;a<=endPage;a++){
			if(a==nowPage){%>
				[<%=a %>]
			<%}else{ %>
				<a href="shareBoard.ho?page=<%=a %>&category=<%=category %>">[<%=a %>]
				</a>&nbsp;
			<%} %>
		<%} %>

		<%if(nowPage>=maxPage){ %>
			[다음]
		<%}else{ %>
			<a href="shareBoard.ho?page=<%=nowPage+1 %>&category=<%=category %>">[다음]</a>
		<%} %>
	</section>
	
	<%
		commonDao.dbClose();
		fileDao.dbClose();
	%>
</body>
</html>