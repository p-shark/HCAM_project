<%@page import="java.text.DecimalFormat"%>
<%@page import="vo.PntHistoryDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="dao.CommonDAO" id="commonDao"></jsp:useBean>
<%
	//로그인한 회원정보
	String id = (String) session.getAttribute("id");
	// 세션에 저장된 mem_no 값 가져오기 
	int mem_no = 0;
	if(session.getAttribute("mem_no") != null) {
		mem_no = Integer.parseInt(String.valueOf(session.getAttribute("mem_no")));
	}
	String mem_name = "";
	if(session.getAttribute("mem_name") != null) {
		mem_name = String.valueOf(session.getAttribute("mem_name"));
	}
	
	/* 포인트 정보 */
	ArrayList<Map<String, String>> pointInfo = (ArrayList<Map<String, String>>) request.getAttribute("pointInfo");
	/* 포인트 히스토리 정보 */
	ArrayList<PntHistoryDTO> pntHistory = (ArrayList<PntHistoryDTO>) request.getAttribute("pntHistory");
	
	// 금액 포맷
	DecimalFormat df = new DecimalFormat("#,###");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
	//포인트 충전 popup 호출 
	function fn_depositPoint() {
		
		var url = "${pageContext.request.contextPath}/view/HCAM_pointDeposit.jsp";
		var title = "popupOpener";
		var status = "toolbar=no,directories=no,scrollbars=no,resizable=no,status=no,menubar=no,width=470,height=500,top=260,left=715";
		window.open(url, title, "width=470, height=500, top=260, left=715");
		//var status = "toolbar=no,directories=no,scrollbars=no,resizable=no,status=no,menubar=no,width=470,height=500,top=100,left=500";
		//window.open(url, title, "width=470, height=500, top=100, left=500");
		
	}
	
</script>
<body>
	<div class="right_inner">
		<div class="right_top">
			<div class="inner_top_left">
				<div>HCAM</div>
			</div>
			<div class="inner_top_right">
				<div><%=mem_name %>님, VIP 등급이 되어보세요!</div>
				<div>2건의 숙박을 더 완료해 VIP 할인과 혜택을 누려보세요!</div>
			</div>
		</div>
		<div class="inner_single_content">
			<div class="div_point_title">
				<span><i class="fa-brands fa-product-hunt"></i></span>
				<span>내 HCAM Point</span>
				<span></span>
				<span>빠른 적립, 쉬운 사용, 간편한 여행경비 절약 방법</span>
			</div>
			<div class="div_point_content">
				<div class="div_point_top">
					<div class="point_image">
						<img alt="" src="image/agoda-gift-card-centered-thailand.png">
						<div></div>
					</div>
					<div class="point_balance">
						<div class="point_balance_text">
							<div class="point_balance_text_red">총 잔액 포인트: </div>
							<div class="point_balance_text_red">
								<span>₩</span>
								<span><%=pointInfo.get(0).get("pnt_balance") %></span>
							</div>
						</div>
						<div class="point_balance_text">
							<div>충전 포인트: </div>
							<div>
								<span>₩</span>
								<span><%=pointInfo.get(0).get("depo_pnt") %></span>
							</div>
						</div>
						<div class="point_balance_text">
							<div>사용 포인트: </div>
							<div>
								<span>₩</span>
								<span><%=String.valueOf(pointInfo.get(0).get("use_pnt")) %></span>
							</div>
						</div>
						<div class="point_balance_text">
							<div>적립 포인트: </div>
							<div>
								<span>₩</span>
								<span><%=String.valueOf(pointInfo.get(0).get("save_pnt")) %></span>
							</div>
						</div>
						<div class="point_balance_btn">
							<a onclick="fn_depositPoint();">포인트 충전하기</a>
						</div>
					</div>
				</div>
				<div class="div_line"></div>
				<div class="div_point_history">
					<div class="point_history_top">포인트 사용내역</div>
					<div class="point_history_title">
						<table>
							<tr class="point_history_title_top">
								<td>포인트 구분</td>
								<td>날짜</td>
								<td>포인트 상세내역</td>
								<td>포인트 금액</td>
							</tr>
							<% 
								for(int i=0; i<pntHistory.size(); i++) {
									String operSymbol = "";
									String classColor= "";
									if("PNT01001".equals(pntHistory.get(i).getPhs_kind()) 
									|| "PNT01002".equals(pntHistory.get(i).getPhs_kind())
									|| "PNT01005".equals(pntHistory.get(i).getPhs_kind())) {
										operSymbol = "+";
										classColor = "point_color_green";
									}
									else {
										operSymbol = "-";
										classColor = "point_color_red";
									}
							%>
								<tr>
									<td><%=commonDao.getCodeName(pntHistory.get(i).getPhs_kind()) %></td>
									<td><%=pntHistory.get(i).getPhs_date() %></td>
									<td><%=pntHistory.get(i).getPhs_comment() %></td>
									<td class="<%=classColor %>"><%=operSymbol %> <%=df.format(pntHistory.get(i).getPhs_historyAmt()) %></td>
								</tr>
							<% } %>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<%
		commonDao.dbClose();
	%>
</body>
</html>