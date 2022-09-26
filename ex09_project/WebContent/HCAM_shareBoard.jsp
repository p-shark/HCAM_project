<%@page import="java.util.Map"%>
<%@page import="vo.SharingBoardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.PageInfo"%>
<%@page import="java.util.TreeMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="dao.CommonDAO" id="commonDao"></jsp:useBean>
<jsp:useBean class="dao.HcamFileDAO" id="fileDao"></jsp:useBean>
<jsp:useBean class="vo.HcamLikeDTO" id="hcamLike"></jsp:useBean>
<%
	//로그인한 회원정보
	String id = (String) session.getAttribute("id");
	// 세션에 저장된 mem_no 값 가져오기 
	int mem_no = 0;
	if(session.getAttribute("mem_no") != null) {
		mem_no = Integer.parseInt(String.valueOf(session.getAttribute("mem_no")));
	}
	
	String category = (String) request.getAttribute("category");
	// 페이징 처리
	PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
	/* 게시판 정보 */
	ArrayList<SharingBoardDTO> boards = (ArrayList<SharingBoardDTO>) request.getAttribute("boards");
	
	/* 코드별 공통코드 전체 조회 */
	TreeMap<String, String> commCodes = commonDao.getCodeAllByCode("SHB01");
	
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
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- jquery -->
	<script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script>
	<!-- css -->
	<link rel="stylesheet" type="text/css" href="css/common.css">
	<link rel="stylesheet" type="text/css" href="css/shareBoard.css">
	<!-- icon -->
	<script src="https://kit.fontawesome.com/ae515d5c73.js" crossorigin="anonymous"></script>
</head>
<script>
	/* init window */
	$(document).ready(function(){
		//fn_selectByCtgry();
	});

	/* 카테고리 별 검색 */
	function fn_selectByCtgry(hlk_kubun, hlk_no, hlk_useYn) {
		var category = document.getElementsByName("category")[0];
		var mem_no = document.getElementsByName("mem_no")[0];		// 로그인한 mem_no
		
		$.ajax({
			url: "shareBoardByCtgry.ho",
			type:'POST',
			dataType: "text",
			async:false,
			data: "mem_no=" + mem_no.value +
				  "&category=" + category.value +
				  "&hlk_kubun=" + hlk_kubun + 
				  "&hlk_no=" + hlk_no + 
				  "&hlk_useYn=" + hlk_useYn,
			success: function(result) {
				$("#content_each").html(result);
			},
			error: function(request, error) {
				alert(request.status + " / " + request.responseText + " / " + error);
			}
		});
	}
	
	/* 검색어 별 검색 */
	function fn_selectBySearching() {
		var searching = document.getElementsByName("searching")[0];
		
		$.ajax({
			url: "HCAM_shareBoardBySearching.jsp",
			type:'POST',
			dataType: "text",
			async:false,
			data: "searching=" + searching.value,
			success: function(result) {
				$("#content_each").html(result);
			},
			error: function(request, error) {
				alert(request.status + " / " + request.responseText + " / " + error);
			}
		});
	}
	
	/* 하트 클릭 시 */
	function fn_chgHeart(hlk_no) {
		
		var mem_no = document.getElementsByName("mem_no")[0];		// 로그인한 mem_no
		if(mem_no.value == 0) {
			alert("로그인 후 이용가능합니다.");
			return;
		}
		
		var hlk_useYn = 0;
		
		// if($(".show"+qbd_no).hasClass('hidden')){
		
		if($('.no'+hlk_no).hasClass('fa-regular')){
			hlk_useYn = 1;
			$('.no'+hlk_no).removeClass('fa-regular');
			$('.no'+hlk_no).addClass('fa-solid');
		}
		else {
			hlk_useYn = 0;
			$('.no'+hlk_no).removeClass('fa-solid');
			$('.no'+hlk_no).addClass('fa-regular');
		}
		
		var hlk_kubun = "shb";		// 좋아요 카테고리 
		var hlk_no = hlk_no;		// 게시판  No
		var hlk_useYn = hlk_useYn;	// 좋아요 여부
		
		fn_selectByCtgry(hlk_kubun, hlk_no, hlk_useYn);
		
	}
</script>
<body>
	<!-- header -->
	<jsp:include page="HCAM_header.jsp"/>
	
	<input type="hidden" name="mem_no" value="<%=mem_no%>">			<!-- 로그인한 mem_no -->
	<div id="contentBox">
		<div id="content_title"><h1>Community</h1></div>
		<div id="content_btn">
			<div id="div_left">
				<select name="category" onchange="fn_selectByCtgry();">
					<option value="">전체</option>
						<% 
							for(Map.Entry<String, String> code : commCodes.entrySet()) { 
								if(code.getKey().equals(category)) {
									out.println("<option value='" + code.getKey() + "' selected>" + code.getValue() + "</option>");
								}
								else {
									out.println("<option value='" + code.getKey() + "'>" + code.getValue() + "</option>");
								}
							}
						%>
				</select>
			</div>
			<div id="div_right">
				<!-- <div class="div_seacrch">
					<input class="search_sec_input" type="text" name="searching" onkeypress="javascript:if(event.keyCode == 13) {fn_selectBySearching();}">
					<div class="search_sec_icon">
						<a onclick="fn_selectBySearching();">
							<svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
								<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
							</svg>
						</a>
					</div>
				</div> -->
				<% if(id != null) {%>
					<button id="btn_write" onclick="location.replace('shareBoardWrite01.ho')">글쓰기</button>
				<% } %>
			</div>
		</div>
		<div id="content_each">
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