<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = (String) session.getAttribute("id");

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
		var url = "HCAM_memberLogout.jsp";
		var title = "popupOpener";
		var status = "toolbar=no,directories=no,scrollbars=no,resizable=no,status=no,menubar=no,width=500,height=300,top=100,left=500";
		window.open(url, title, "width=500, height=380, top=100, left=500");
	}
</script>
<body>
	<header>
		<nav id="header_nav">
			<div id="header_left">
				<ul>
					<div><li><a href="HCAM_main.jsp"><img id="logo" src="image/logo/logo4.png"></a></li></div>
					<div><li><a href="hotelMain.ho">호텔</a></li></div>
					<div><li><a href="campingMain.co">캠핑</a></li></div>
					<div><li><a href="">액티비티</a></li></div>
					<div><li><a href="view/HCAM_marketMain.jsp">마켓</a></li></div>
					<div><li><a href="shareBoard.ho">여행리뷰</a></li></div>
					<div><li><a href="">이벤트/쿠폰</a></li></div>
					<div><li><a href="noticeMain.co">고객센터</a></li></div>
					<div><li><a href="sang.do?command=sawon">렌터카</a></li></div>
					
				</ul>
			</div>
			<div id="header_right">
				<ul>
					<% if(id != null) { %>
						<!-- <li id="btn_mypage">$&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</li> -->
						<li id="comment"><div>${id} 님 환영합니다.</div></li>
						<li class="btn_mypage"><button>마이페이지</button></li>
						<li class="btn_mypage" onclick="fn_logout();"><button>로그아웃</button></li>
					<% }else { %>
						<li id="btn_mgr"><button>매니저</button></li>
						<li id="btn_login"><button onclick="location.href='HCAM_memberLogin.jsp'">로그인</button></li>
						<li id="btn_join"><button onclick="location.href='HCAM_memberJoin.jsp'">회원가입</button></li>
					<% } %>
				</ul>
			</div>
		</nav>
	</header>
</body>
</html>