<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
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
	String memg_kubun = "";
	if(session.getAttribute("memg_kubun") != null) {
		memg_kubun = String.valueOf(session.getAttribute("memg_kubun"));
	}
	String mem_name = "";
	if(session.getAttribute("mem_name") != null) {
		mem_name = String.valueOf(session.getAttribute("mem_name"));
	}

	//현재일자, 다음날일자 구하기
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	Calendar cal = Calendar.getInstance();
	String today = sdf.format(cal.getTime());
	cal.add(Calendar.DATE, 1);
	String tomorrow = sdf.format(cal.getTime());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
	/* 로그아웃 */
	function fn_logout() {
		var url = "${pageContext.request.contextPath}/view/HCAM_memberLogout.jsp";
		var title = "popupOpener";
		var status = "toolbar=no,directories=no,scrollbars=no,resizable=no,status=no,menubar=no,width=500,height=300,top=100,left=500";
		window.open(url, title, "width=500, height=380, top=100, left=500");
	}
	
	/* 렌터카 */
	function fn_chkRentAcar() {
		alert("메인 검색박스를 이용하세요");		// 렌터카는 메인검색박스로만 검색 가능
	}
</script>
<body>
	<header>
		<nav id="header_nav">
			<div id="header_left">
				<ul>
					<div id="goMain"><li><a href="${pageContext.request.contextPath}/HCAM_main.jsp"><img id="logo" src="${pageContext.request.contextPath}/image/logo/logo4.png"></a></li></div>
					<div id="goHotel"><li><a href="hotelMain.ho">호텔</a></li></div>
					<div id="goCamping"><li><a href="campingMain.co">캠핑</a></li></div>
					<!-- <div id="goActivity"><li><a href="">액티비티</a></li></div> -->
					<div id="goCar"><li><a onclick="fn_chkRentAcar();">렌터카</a></li></div>
					<div id="goMarket"><li><a href="${pageContext.request.contextPath}/HCAM_marketMain.jsp">마켓</a></li></div>
					<div id="goShareBoard"><li><a href="shareBoard.ho">여행리뷰</a></li></div>
					<!-- <div id="goEvent"><li><a href="">이벤트/쿠폰</a></li></div> -->
					<div id="goNotice"><li><a href="noticeMain.co">고객센터</a></li></div>
				</ul>
			</div>
			<div id="header_right">
				<ul>
					<% if(id != null) { %>
						<!-- <li id="btn_mypage">$&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</li> -->
						<li id="comment"><div>${mem_name} 님 환영합니다.</div></li>
						
						<% if("mem".equals(memg_kubun)) { %>
							<li class="btn_mypage"><a onclick="location.href='mypage.do?command=mypageMain'">마이페이지</a></li>
						<% }else { %>
							<li class="btn_mypage"><a onclick="">데이터분석차트</a></li>
						<% } %>
						<li class="btn_mypage" onclick="fn_logout();"><a>로그아웃</a></li>
					<% }else { %>
						<li id="btn_mgr"><a onclick="location.href='${pageContext.request.contextPath}/view/HCAM_memberLogin.jsp?kubun=mgr'">매니저</a></li>
						<li id="btn_login"><a onclick="location.href='${pageContext.request.contextPath}/view/HCAM_memberLogin.jsp?kubun=mem'">로그인</a></li>
						<li id="btn_join"><a onclick="location.href='${pageContext.request.contextPath}/view/HCAM_memberJoin.jsp'">회원가입</a></li>
					<% } %>
				</ul>
			</div>
		</nav>
	</header>
</body>
</html>