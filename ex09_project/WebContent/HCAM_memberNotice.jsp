<%@page import="java.util.TreeMap"%>
<%@page import="vo.NoticeBoardDTO"%>
<%@page import="vo.PageInfo"%>
<%@page import="vo.NoticeBoardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="dao.NoticeDAO" id="noticeDao"></jsp:useBean>
<jsp:useBean class="dao.CommonDAO" id="commonDao"></jsp:useBean>
<%
	//한글 깨짐 방지
	request.setCharacterEncoding("UTF-8");

	//페이징
	ArrayList<NoticeBoardDTO> noticeLists = (ArrayList<NoticeBoardDTO>)request.getAttribute("noticeLists");
	PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
	
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
	<link rel="stylesheet" type="text/css" href="css/common.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	<title>공지사항</title>
	<style type="text/css">
		section{
			position: relative;
			width: 100%;
			padding: 40px 40px 0px 30px;
			min-height: 540px;
			padding-bottom: 265px;
			border: 1px soild black;
		}
		#total_left{
			display: inline-block;
			vertical-align: top;
			width: 19%;
		}
		#total_center{
			display: inline-block;
			vertical-align: top;
			width: 60%;
		}
		#total_right{
			display: inline-block;
			vertical-align: top;
			width: 19%;
		}
		#total_left ul{
			width: 200px;
			border: 1px solid rgb(242, 242, 242);
		}
		.total_title{
			padding: 5px 0px 35px 1px;
			font-weight: 500;
			font-size: 28px;
		    line-height: 35px;
		    color: rgb(51, 51, 51);
		    letter-spacing: -1px;
		}
		.sub_title{
			height: 10px;
			border-bottom: 1px solid rgb(242, 242, 242);
			width: 160px;
			height: 20px;
			line-height: 22px;
			padding: 14px 20px 16px;
			font-size: 14px;
			color: rgb(102, 102, 102);
		}
		.sub_title:last-child{
			border-bottom: none;
		}
		.arrow{
			background-image: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI2IiBoZWlnaHQ9IjExIiB2aWV3Qm94PSIwIDAgNiAxMSI+CiAgICA8cGF0aCBmaWxsPSIjOTk5IiBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGQ9Ik0xIDExTDYgNS41IDEgMCAwIDEuMSA0IDUuNSAwIDkuOXoiLz4KPC9zdmc+Cg==);
			display: inline-block;
		    width: 6px;
		    height: 11px;
		    margin-left: 80px;
		}
		
		table{
    		border-bottom: 1px solid rgb(51, 51, 51);
			border-collapse: collapse;
   			border-spacing: 0;
		}
		#table_head{
			width: 100%;
		}
		#title_head{
			width: 820px;
			border-bottom: 1px solid rgb(51, 51, 51);
    		border-top: 2px solid rgb(51, 51, 51);
    		vertical-align: middle;
		}
		#title_head th{
			padding: 10px 5px 10px 5px;
		}
		#title_head th:first-child{
			width: 100px;
		}
		#title_head th:nth-child(2){
			width: 700px;
		}
		#title_head th:nth-child(n+3){
			width: 150px;
		}
		table tr td{
			text-align: center;
			font-size: 10pt;
			border-bottom: 1px solid rgb(242, 242, 242);
		}
		table tr:last-child{
			border-bottom: 2px solid rgb(51, 51, 51);
		}
		#center_footer{
			position: relative;
			width: 100%;
			height: 50px;
		}
		#bt_ask{
			position: absolute;
			right: 0px;
			bottom: 0px;
			width: 120px;
			height: 42px;
		    color: rgb(255, 255, 255);
		    background-color:#5392F9;
		    cursor: pointer;
		    border: 0px none;
		}
		
		/* 페이징 */
		#center_preNext{
			width: 100%;
			height: 65px;
			margin-top: 10px;
			text-align: center;
		}
		
		#paging{
			display: inline-block;
			width: 500px;
			height: 65px;
			text-align: center;
		}
		#paging div{
			display: inline-block;
		}
		.paging_outline{
			vertical-align: top;
			border: 1px #e0e0e0 solid;
			width: 40px;
			height: 40px;
			text-align: center;
			line-height: 40px;
			margin: 11px 5px 0px 5px;
			border-radius: 5px;
		}
		.paging_outline font{
			 font-size: 15pt;
			 color: gray;
		}
		#bt_pre{
		    width: 44px;
		    height: 44px;
		    cursor: pointer;
		    border-radius: 5px;
		    margin-top: 10px;
		    background-image: url(https://res.kurly.com/kurly/ico/2021/paging-prev-activated.svg);
		}
		#bt_next{
			width: 44px;
		    height: 44px;
		    cursor: pointer;
		    border-radius: 5px;
		    background-image: url(https://res.kurly.com/kurly/ico/2021/paging-next-activated.svg);
		}
		#bt_pre:disabled{
			width: 44px;
		    height: 44px;
		    background-image: url(https://res.kurly.com/kurly/ico/2021/paging-prev-disabled.svg);
		    cursor: default;
		    border-radius: 5px;
		}
		#bt_next:disabled{
		    background-image: url(https://res.kurly.com/kurly/ico/2021/paging-next-disabled.svg);
		    cursor: default;
		    border-radius: 5px;
		}
		.notice_title{
			padding: 20px 0px 20px 20px;
			text-align: left;
		 	cursor: pointer;	
		 	font-size: 11pt;
		}
		.notice_title a:hover{
			text-decoration: underline;
		}
		.content{
		 	text-align: left;
		 	padding: 0px 0px 20px 20px;
		    background-color: #f5f5f5;
		    font-size: 14px;
		    text-align: left;
		    font-size: 11pt;
		}
		
	</style>
</head>
<body>
	<!-- header -->
	<jsp:include page="HCAM_header.jsp"/>
	<!-- section -->
	<section>
		<form action="HCAM_membernoticeWrite01.jsp">
			<div id="total_left">
				<div class="total_title">고객센터</div>
				<ul>
					<div class="sub_title">
						<li>
							<a href="noticeMain.co">공지사항<span class="arrow"></span>
							</a>
						</li>
					</div>
					<div class="sub_title">
						<li>
							<a href="questionMain.co">문의사항<span class="arrow"></span>
							</a>
						</li>
					</div>
				</ul>
			</div>
			<div id="total_center">
				<div class="total_title">공지사항</div>
					<div id="table_head">
						<table>
							<tr id="title_head">
								<th>분류</th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
							</tr>
							<% for(int i=0; i<noticeLists.size(); i++){ %>
								<tr>
									<td><%=commonDao.getCodeName(noticeLists.get(i).getNtc_ctgry()) %></td>
									<td class="notice_title"><a href="HCAM_memberNoticeDetail.jsp?ntc_no=<%=noticeLists.get(i).getNtc_no() %>"><%=noticeLists.get(i).getNtc_title() %></a></td>
									<td>HCAM</td>
									<td><%=noticeLists.get(i).getNtc_date() %></td>
								</tr>
							<%} %>
						</table>	
					</div>
					<div id="center_preNext">
						<div id="paging">
							<%if(nowPage<=1){ %>
							<div><input disabled type="button" id="bt_pre"/></div>
							<%}else{ %>
							<div><a href="noticeMain.co?page=<%=nowPage-1 %>"><input type="button" id="bt_pre"/></a></div>
							<%} %>
							<%for(int a=startPage;a<=endPage;a++){
								if(a==nowPage){%>
									<div class="paging_outline" style="background-color: rgb(230, 239, 217)"><font><%=a %></font></div>
							<%}else{ %>
									<div class="paging_outline"><a href="noticeMain.co?page=<%=a %>"><font><%=a %></font></a></div>
								<%} %>
							<%} %>
					
							<%if(nowPage>=maxPage){ %>
								<div><input disabled type="button" id="bt_next"/></div>
							<%}else{ %>
								<div><a href="noticeMain.co?page=<%=nowPage+1 %>"><input type="button" id="bt_next"/></a></div>
							<%} %>
					</div>
				</div>
			</div>
			<div id="total_right">
			</div>
			
		</form>
	</section>
	
	<!-- footer -->
	<jsp:include page="HCAM_footer.jsp"/>
	
	<%
		commonDao.dbClose();
	%>
</body>
</html>