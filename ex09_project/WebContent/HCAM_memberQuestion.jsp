<%@page import="java.util.TreeMap"%>
<%@page import="vo.PageInfo"%>
<%@page import="vo.AnswerBoardDTO"%>
<%@page import="vo.QuestionBoardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="dao.QuestionDAO" id="conn"></jsp:useBean>
<jsp:useBean class="dao.CommonDAO" id="commonDao"></jsp:useBean>
<jsp:useBean class="dao.HcamFileDAO" id="fileDao"></jsp:useBean>
<%
	//로그인한 id
	String id = (String) session.getAttribute("id");
	//세션에 저장된 mem_no 값 가져오기
	int mem_no = 0;
	if(session.getAttribute("mem_no") != null){
		mem_no = Integer.parseInt(String.valueOf(session.getAttribute("mem_no")));
	}
	//한글 깨짐 방지
	request.setCharacterEncoding("UTF-8");

	ArrayList<QuestionBoardDTO> lists = (ArrayList<QuestionBoardDTO>)request.getAttribute("questionLists");
	ArrayList<AnswerBoardDTO> listsAns = (ArrayList<AnswerBoardDTO>)request.getAttribute("answerLists");
	
	// 페이징
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
	<title>문의사항</title>
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
		/*table td:first-child{
			padding: 117px 0px;
		    font-size: 16px;
		    font-weight: 500;
		    color: rgb(51, 51, 51);
		    text-align: center;
		}
		 table tr td{
			height: 180px;
		} */
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
		    margin-top: 10px;
		    cursor: pointer;
		    border-radius: 5px;
		    background-image: url(https://res.kurly.com/kurly/ico/2021/paging-prev-activated.svg);
		}
		#bt_next{
			width: 44px;
		    height: 44px;
		    margin-top: 10px;
		    cursor: pointer;
		    border-radius: 5px;
		    background-image: url(https://res.kurly.com/kurly/ico/2021/paging-next-activated.svg);
		}
		#bt_pre:disabled{
			width: 44px;
		    height: 44px;
		    margin-top: 10px;
		    background-image: url(https://res.kurly.com/kurly/ico/2021/paging-prev-disabled.svg);
		    cursor: default;
		    border-radius: 5px;
		}
		#bt_next:disabled{
		    background-image: url(https://res.kurly.com/kurly/ico/2021/paging-next-disabled.svg);
		    cursor: default;
		    border-radius: 5px;
		}
		
		.qna_background{
			background-color: #f5f5f5;
			padding: 15px;
		}
		.question_title{
			padding: 20px 0px 20px 20px;
			text-align: left;
		 	cursor: pointer;	
		 	font-size: 11pt;
		}
		.question_title a:hover{
			text-decoration: underline;
		}
		.content{
		 	padding-left: 20px;
		 	padding-right: 20px;
		    background-color: #f5f5f5;
		    text-align: left;
		    font-size: 11pt;
		}
		.content div{
			margin-top: 30px;
		}
		.content div img{
			width: 150px;
			height: 150px;
		}
		#td_mfdel {
			vertical-align: top;
			padding-top: 20px;
		}
		#td_mfdel a{
			color: red;
			font-size: 9pt;
		}
		
	</style>
</head>
<script>
	$(document).ready(function(){
		$(".hidden").hide();
	});
	
	function fn_show(qbd_no){
		if($(".show"+qbd_no).hasClass('hidden')){
			$(".show"+qbd_no).removeClass('hidden');
			$(".show"+qbd_no).show();
		}
		else{
			$(".show"+qbd_no).addClass('hidden');	
			$(".show"+qbd_no).hide();
		}
	}
	
	function fn_delete(qbd_no){
		if (confirm("삭제하시겠습니까?") == true){    //확인
			 location.href="memberQuestionDelete.co?qbd_no="+qbd_no;

		 }else{   //취소
		     return false;
		 }
	}
</script>
<body>
	<!-- header -->
	<jsp:include page="HCAM_header.jsp"/>
	<!-- section -->
	<section>
		<form action="memberQuestionWrite01.co">
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
				<div class="total_title">문의사항</div>
					<div id="table_head">
						<table>
							<tr id="title_head">
								<th>분류</th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>답변상태</th>
							</tr>
							<% for(int i=0; i<lists.size(); i++){ %>
									<tr>
										<td><%=commonDao.getCodeName(lists.get(i).getQbd_ctgry()) %></td>
										<td class="question_title"><a onclick="fn_show('<%=lists.get(i).getQbd_no() %>');"><%=lists.get(i).getQbd_title() %></a></td>
										<td><%=commonDao.getCommonCode("QuestionBoard", "qbd_no", lists.get(i).getQbd_no()) %></td>
										<td><%=lists.get(i).getQbd_date() %></td>
										<% if(("답변완료").equals(lists.get(i).getAnsState())){%>
												<td style="color:green; font-weight:bold"><%=lists.get(i).getAnsState() %></td>
											<%}else{%>
												<td style="color:red; font-weight:bold"><%=lists.get(i).getAnsState() %></td>
											<%}%>
									</tr>
									<tr class="hidden show<%=lists.get(i).getQbd_no() %>">
										<td class="qna_background"><svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-question-circle" viewBox="0 0 16 16">
										  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
										  <path d="M5.255 5.786a.237.237 0 0 0 .241.247h.825c.138 0 .248-.113.266-.25.09-.656.54-1.134 1.342-1.134.686 0 1.314.343 1.314 1.168 0 .635-.374.927-.965 1.371-.673.489-1.206 1.06-1.168 1.987l.003.217a.25.25 0 0 0 .25.246h.811a.25.25 0 0 0 .25-.25v-.105c0-.718.273-.927 1.01-1.486.609-.463 1.244-.977 1.244-2.056 0-1.511-1.276-2.241-2.673-2.241-1.267 0-2.655.59-2.75 2.286zm1.557 5.763c0 .533.425.927 1.01.927.609 0 1.028-.394 1.028-.927 0-.552-.42-.94-1.029-.94-.584 0-1.009.388-1.009.94z"/>
										</svg><br>문의</td>
										<td colspan="4" class="content" id="td_mfdel"><%=lists.get(i).getQbd_content() %><br>
										<div>
											<% if(fileDao.getFilePath("qbd", lists.get(i).getQbd_no()) != "") { %>
												<img src="<%=fileDao.getFilePath("qbd", lists.get(i).getQbd_no())%>">
											<% } %>
										</div>
										<% if(mem_no == lists.get(i).getMem_no() && ("미답변").equals(lists.get(i).getAnsState())){%>
												<br><br>
												<a onclick="location.href='memberQuestionUpdate01.co?qbd_no=<%=lists.get(i).getQbd_no()%>'">수정</a>&nbsp;
												<a onclick="fn_delete('<%=lists.get(i).getQbd_no()%>')">삭제</a>
										<%}%>	
										</td>
									</tr>
									<% for(int j=0; j<listsAns.size(); j++){%>
										<% if(lists.get(i).getQbd_no() == listsAns.get(j).getQbd_no()) { %>
											<tr class="hidden show<%=lists.get(i).getQbd_no() %>">
												<td class="qna_background"><svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-arrow-right-circle-fill" viewBox="0 0 16 16">
													  <path d="M8 0a8 8 0 1 1 0 16A8 8 0 0 1 8 0zM4.5 7.5a.5.5 0 0 0 0 1h5.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3a.5.5 0 0 0 0-.708l-3-3a.5.5 0 1 0-.708.708L10.293 7.5H4.5z"/>
													</svg><br>답변</td>
												<td colspan="4" class="content"><%=listsAns.get(j).getAbd_content() %><br><br><font size="2px">판매자&nbsp;<%=listsAns.get(j).getAbd_date() %></font></td>
											</tr>
										<%} %>
									<%} %>
							<%} %>
						</table>	
					</div>
			
					<% if(id != null){ %>
						<div id="center_footer"><input type="submit" id="bt_ask" value="문의하기"></div>
					<%} %>
				<div id="center_preNext">
					<div id="paging">
						<%if(nowPage<=1){ %>
						<div><input disabled type="button" id="bt_pre"/></div>&nbsp;
						<%}else{ %>
						<div><a href="questionMain.co?page=<%=nowPage-1 %>"><input type="button" id="bt_pre"/></a></div>&nbsp;
						<%} %>
						
						<%for(int a=startPage;a<=endPage;a++){
								if(a==nowPage){%>
						<div class="paging_outline" style="background-color: rgb(230, 239, 217)"><font><%=a %></font></div>
						<%}else{ %>
						<a href="questionMain.co?page=<%=a %>"><div class="paging_outline"><font><%=a %></font></div>
						</a>&nbsp;
						<%} %>
						<%} %>
				
						<%if(nowPage>=maxPage){ %>
						<div><input disabled type="button" id="bt_next"/></div>
						<%}else{ %>
						<div><a href="questionMain.co?page=<%=nowPage+1 %>"><input type="button" id="bt_next"/></a></div>
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
		fileDao.dbClose();
	%>
</body>
</html>