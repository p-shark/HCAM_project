<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="dao.CommonDAO" id="commonDao"></jsp:useBean>
<jsp:useBean class="vo.HcamLikeDTO" id="hcamLike"></jsp:useBean>
<%
	//로그인한 회원정보
	String id = (String) session.getAttribute("id");
	// 세션에 저장된 mem_no 값 가져오기 
	int mem_no = 0;
	if(session.getAttribute("mem_no") != null) {
		mem_no = Integer.parseInt(String.valueOf(session.getAttribute("mem_no")));
	}
	
	String hlk_kubun = request.getParameter("hlk_kubun");
	int hlk_no = Integer.parseInt(request.getParameter("hlk_no"));
	int hlk_useYn = Integer.parseInt(request.getParameter("hlk_useYn"));
	
	hcamLike.setMem_no(mem_no);
	hcamLike.setHlk_kubun(hlk_kubun);	// 좋아요 카테고리 
	hcamLike.setKubun_no(hlk_no);		// No
	hcamLike.setHlk_useYn(hlk_useYn);	// 좋아요 여부
	
	/* 호텔,캠핑,여행리뷰 각 좋아요 insert 혹은 update */
	commonDao.insUpdLikeYn(hcamLike);
	
	/* 좋아요 총 개수 */
	int hlk_count = commonDao.getLikeCount(hlk_kubun, hlk_no);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<span><%=hlk_count%></span>
	
	<%
		commonDao.dbClose();
	%>
</body>
</html>