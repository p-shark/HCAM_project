<%@page import="vo.NoticeBoardDTO"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.TreeMap"%>
<%@page import="vo.PageInfo"%>
<%@page import="vo.CampingDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="dao.CommonDAO" id="commonDao"></jsp:useBean>
<jsp:useBean class="dao.NoticeDAO" id="noticeDao"></jsp:useBean>
<jsp:useBean class="dao.HcamFileDAO" id="fileDao"></jsp:useBean>
<%
	/* 코드별 공통코드 전체 조회 */
	TreeMap<String, String> commCodes = commonDao.getCodeAllByCode("CCD01");
	
	/* 페이징 조회 */
	PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
	int listCount=pageInfo.getListCount();
	int nowPage=pageInfo.getPage();
	int maxPage=pageInfo.getMaxPage();
	int startPage=pageInfo.getStartPage();
	int endPage=pageInfo.getEndPage();
	
	/* select box 의 option 값을 가져온 값 */
	String optionValue = (String) request.getAttribute("optionValue");
	ArrayList<CampingDTO> campingLists =(ArrayList<CampingDTO>)request.getAttribute("campingLists");
	
	/* 공지사항에 캠핑 공지사항 가져오기 */
	ArrayList<NoticeBoardDTO> noticeLists = (ArrayList<NoticeBoardDTO>)noticeDao.getAllnoticeLists(1, 6);
	
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
	<!-- js -->
	<script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="js/raphael_min.js"></script>
	<script type="text/javascript" src="js/raphael_path_s.korea.js"></script>
	<title></title>
	<style type="text/css">
		/* search_content (상단 검색바) */
		.search_content{
			background-color: rgb(0, 197, 133) !important;
		}
		.search_section li:nth-child(5) button{
			background-color: rgb(230, 239, 217) !important;
			color: rgb(40, 64, 12) !important;
		}
		
		/* footer */
		footer{
			margin-top: 0px;
		}
		
		/* section-camping main page 시작 */
		#total{
			margin: 0px auto;
			width: 100%;
		}
		#width_1200{
			margin: 0 auto;
			width: 1200px;
		}
		
		/* 왼쪽 위  */
		#total_left_top{
			position:relative;
			display: inline-block;
			vertical-align: top;
			width: 28.5%;
			height: 560px;
			text-align: center;
			border-right: 1px #e0e0e0 solid;
			text-align: center;
			padding-left: 20px;
		}
		#total_left_top div{
			margin-top: 10px;
		}
		#total_left_top div span{
			font-weight: bold;
			font-size: 1.7rem;
			color: #25a5f0;
			text-align: center;
		}
		
		/* map */
		#canvas {float:left; position:relative; width: 320px; height:400px; margin: 0}
		#south {width: 320px; height:400px; position: absolute; top: 0px; left: 0;}
		
		#canvas h2{ padding:0; margin:0; font-size:12px; }
		
		#seoul, #gygg, #incheon, #gangwon, #chungbuk, #chungnam, #daejeon, #sejong, #jeonbuk, #jeonnam, #gwangju, #gyeongbuk, #gyeongnam, #daegu, #busan, #ulsan, #jeju { display: none; position: absolute; height:16px; background-color:#000; color:#fff; padding:2px 5px; text-align:center;}
		
		#seoul{ left:80px; top:75px; }
		#gygg{ left:80px; top:45px; }
		#incheon{ left:60px; top:75px; }
		#gangwon{ left:150px; top:45px; }
		#chungbuk{ left:120px; top:145px; }
		#chungnam{ left:60px; top:165px; }
		#daejeon{ left:80px; top:165px; }
		#sejong{ left:70px; top:145px; }
		#jeonbuk{ left:60px; top:205px; }
		#jeonnam{ left:60px; top:260px; }
		#gwangju{ left:	60px; top:260px; }
		#gyeongbuk{ left:150px; top:165px; }
		#gyeongnam{ left:130px; top:240px; }
		#daegu{ left:170px; top:210px; }
		#busan{ left:190px; top:250px; }
		#ulsan{ left:200px; top:225px; }
		#jeju{ left:80px; top:340px; }
		
		#map_title{
			margin: 0 auto;
			width: 100%;
			height:80px;
		}
		#map_title_line1{
			width: 100%;
			height:35px;
		}
		#map_title_line1 div {
			display: inline-block;
			font-weight: bold;
			font-size: 20pt;
		}
		#map_title_line1 div:nth-child(2){
			margin-right: 90px;
			color: #25a5f0;
		}
		#map_title_line2{
			text-align: center;
			font-weight: bold;
			font-size: 12pt;
			margin-top: 10px;
			margin-right: 90px;
			clear: left;
		}
		#map{
			 width:200px;
			 height:400px;
		}
		
		/* 오른쪽 위  */
		#total_right_top{
			display: inline-block;
			vertical-align: top;
			width: 66.5%;
			height: 560px;
		}
		#selectBox_line{
			width: 100%;
			height: 66px;
		}
		#select_area{
			width: 80px;
			height: 44px;
			margin-top: 10px;
			margin-left: 10px;
			margin-right: 10px;
			float: left;
		}
		.select_box{
			width: 80px;
			height: 44px;
			border-radius: 5px;
		}
		.float_left{
			float: left;
		}
		
		/* 페이징 */
		#paging{
			width:720px;
			height: 66px;
			margin-top: 10px;
			margin-left: 10px;
		}
		.paging_outline{
			border: 1px #e0e0e0 solid;
			width: 40px;
			height: 40px;
			float: left;
			text-align: center;
			line-height: 40px;
			margin: 10px;
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
		
		.picContent_total{
			width: 100%;
			height: 470px;
			margin-left: 10px;
		}
		.picContent_area{
			float: left;
			margin-right: 10px;
			margin-bottom: 10px;
			width: 256px;
			height: 230px;
			font-weight: bold;
		}
		.pic_area{
			width: 256px;
			height: 180px;
			
		}
		.pic_area img{
			width: 256px;
			height: 180px;
			border-top-left-radius : 30px;
			border-top-right-radius : 30px;
		}
		.content_area{
			width: 256px;
			height: 50px;
			background-color: #AFC35A;
			border-bottom-left-radius : 30px;
			border-bottom-right-radius : 30px;
		}
		
		/* banner */
		#banner_total{
			width: 100%;
			height: 230px;
			background-color: rgb(230, 239, 217);
		}
		#banner_notice{
			float: left;
			width: 500px;
			height: 200px;
			margin-left: 30px;
			margin-top: 10px;
		}
			#banner_notice_line1{
				height: 30px;
				color: rgb(15, 56, 6);
				font-size: 16pt;
				font-weight: bold;
				border-bottom: 1px solid #8C8C8C;
			}
			#banner_notice_content{
				height: 30px;
				font-size: 10pt;
				margin-left: 30px;
			}
			#banner_notice_content div{
				margin-top:10px;
			}
			#banner_notice_line1 a{
				float: right;
			}
			#banner_notice_content a:hover{
			text-decoration:underline; 
			color: green; 
			cursor: pointer;
		}
		#banner_img{
			float: right;
			width: 650px;
			height: 200px;
			margin-right: 20px;
			margin-top: 15px;
		}
			#banner_img img:first-child{
				float: right;
				}
			#banner_img img:last-child{
				float: right;
				margin-left: 40px;
				margin-right: 10px;
			}
		
	</style>
</head>
<script>
	/* 카테고리 별 검색 */
	var fn_selectByCtgry = function (value) {
		//var optionValue = $('.select_box option:selected').val(); 만약에 매개변수를 this.value로 넘겨서 value 로 받는 게 아니면 이렇게 적어줘야 한다.
		location.href="campingMain.co?optionValue=" + value;
	} 
	/* map */
	var sca = '01';
</script>
<body>
	<!-- header -->
	<jsp:include page="HCAM_header.jsp"/>
	<!-- header_dateLine -->
	<div class="search_content">
		<section class="search_section">
			<form name="top_searching">
				<ul>
					<li>
						<div class="search_sec_icon">
							<svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
								<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
							</svg>
						</div>
						<input class="search_sec_input" type="text" name="top_searching" placeholder="어디로 떠나시나요?">
					</li>
					<li>
						<div class="search_sec_icon">
							<svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-calendar-check" viewBox="0 0 16 16">
							  <path d="M10.854 7.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L7.5 9.793l2.646-2.647a.5.5 0 0 1 .708 0z"/>
							  <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4H1z"/>
							</svg>
						</div>
						<input class="search_sec_input" type="text" name="top_chkIn" placeholder="체크인일자">
	
					</li>
					<li>
						<div class="search_sec_icon">
							<svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-calendar-check" viewBox="0 0 16 16">
							  <path d="M10.854 7.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L7.5 9.793l2.646-2.647a.5.5 0 0 1 .708 0z"/>
							  <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4H1z"/>
							</svg>
						</div>
						<input class="search_sec_input" type="text" name="top_chkOut" placeholder="체크아웃">
					</li>
					<li>
						<div class="search_sec_icon">
							<svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-people" viewBox="0 0 16 16">
	  							<path d="M15 14s1 0 1-1-1-4-5-4-5 3-5 4 1 1 1 1h8zm-7.978-1A.261.261 0 0 1 7 12.996c.001-.264.167-1.03.76-1.72C8.312 10.629 9.282 10 11 10c1.717 0 2.687.63 3.24 1.276.593.69.758 1.457.76 1.72l-.008.002a.274.274 0 0 1-.014.002H7.022zM11 7a2 2 0 1 0 0-4 2 2 0 0 0 0 4zm3-2a3 3 0 1 1-6 0 3 3 0 0 1 6 0zM6.936 9.28a5.88 5.88 0 0 0-1.23-.247A7.35 7.35 0 0 0 5 9c-4 0-5 3-5 4 0 .667.333 1 1 1h4.216A2.238 2.238 0 0 1 5 13c0-1.01.377-2.042 1.09-2.904.243-.294.526-.569.846-.816zM4.92 10A5.493 5.493 0 0 0 4 13H1c0-.26.164-1.03.76-1.724.545-.636 1.492-1.256 3.16-1.275zM1.5 5.5a3 3 0 1 1 6 0 3 3 0 0 1-6 0zm3-2a2 2 0 1 0 0 4 2 2 0 0 0 0-4z"/>
							</svg>
						</div>
						<input class="search_sec_input" type="text" name="top_people" placeholder="인원수">
					</li>
					<li>
						<button type="button">검색하기</button>
					</li>
				</ul>
			</form>
		</section>
	</div>
	
	<!-- section -->
	<section id="total">
		<div id="width_1200">
			<div id="total_left_top">
				<div id=map_title>
					<div id="map_title_line1">
						<div>Camping</div>
						<div>Map</div>
					</div>
					<div id="map_title_line2">대한민국 캠핑 지도</div>
				</div>
				<div id="map">
					<div id="canvas">
						<div id="south"></div>
						<div id="seoul"><h2>서울특별시</h2></div>
						<div id="gygg"><h2>경기도</h2></div>
						<div id="incheon"><h2>인천광역시</h2></div>
						<div id="gangwon"><h2>강원도</h2></div>
						<div id="chungbuk"><h2>충청북도</h2></div>
						<div id="chungnam"><h2>충청남도</h2></div>
						<div id="daejeon"><h2>대전광역시</h2></div>
						<div id="sejong"><h2>세종특별자치시</h2></div>
						<div id="gwangju"><h2>광주광역시</h2></div>
						<div id="jeonbuk"><h2>전라북도</h2></div>
						<div id="jeonnam"><h2>전라남도</h2></div>
						<div id="gyeongbuk"><h2>경상북도</h2></div>
						<div id="gyeongnam"><h2>경상남도</h2></div>
						<div id="daegu"><h2>대구광역시</h2></div>
						<div id="busan"><h2>부산광역시</h2></div>
						<div id="ulsan"><h2>울산광역시</h2></div>
						<div id="jeju"><h2>제주특별자치도</h2></div>
					</div>
				</div>
			</div>
			<div id="total_right_top">
				<div id="selectBox_line">
					<div id="select_area">
						<select name="category" class="select_box" onchange="fn_selectByCtgry(this.value)">
							<option value="">전체</option>
							<% 
								for(Map.Entry<String, String> code : commCodes.entrySet()) { 
									if(code.getKey().equals(optionValue)) {
										out.println("<option value='" + code.getKey() + "' selected>" + code.getValue() + "</option>");
									}
									else {
										out.println("<option value='" + code.getKey() + "'>" + code.getValue() + "</option>");
									}
								}
							%>
						</select>
					</div>
					<div id="paging">
						<%if(nowPage<=1){ %>
						<div class="float_left"><input disabled type="button" id="bt_pre"/></div>&nbsp;
						<%}else{ %>
						<div class="float_left"><a href="campingMain.co?page=<%=nowPage-1 %>&optionValue=<%=optionValue %>"><input type="button" id="bt_pre"/></a></div>&nbsp;
						<%} %>
						
						<%for(int a=startPage;a<=endPage;a++){
								if(a==nowPage){%>
						<div class="paging_outline" style="background-color: rgb(230, 239, 217)"><font><%=a %></font></div>
						<%}else{ %>
						<a href="campingMain.co?page=<%=a %>&optionValue=<%=optionValue %>"><div class="paging_outline"><font><%=a %></font></div>
						</a>&nbsp;
						<%} %>
						<%} %>
				
						<%if(nowPage>=maxPage){ %>
						<div class="float_left"><input disabled type="button" id="bt_next"/></div>
						<%}else{ %>
						<div class="float_left"><a href="campingMain.co?page=<%=nowPage+1 %>&optionValue=<%=optionValue %>"><input type="button" id="bt_next"/></a></div>
						<%} %>
					</div>
				</div>
				<div class="picContent_total">
					 <% for(int i=0; i<campingLists.size(); i++){ %>
					<div class="picContent_area">
						<%
							String filePath = fileDao.getFilePath("cmp", campingLists.get(i).getCmp_no());
							if("".equals(filePath)) {
						%>
								<div class="pic_area">
									<img alt="" src="image/camping/camping1.jpg">
								</div>
						<%		
							}
							else{
								out.println("<div class='pic_area'>");
								out.println("<img src='" + filePath + "'>");
								out.println("</div>");
							} %>
						
						<div class="content_area">
							&nbsp;&nbsp;<%=campingLists.get(i).getCmp_name() %><br>
							&nbsp;&nbsp;<svg xmlns="http://www.w3.org/2000/svg" width="13" height="13" fill="currentColor" class="bi bi-geo-alt-fill" viewBox="0 0 16 16" color="">
										  <path d="M8 16s6-5.686 6-10A6 6 0 0 0 2 6c0 4.314 6 10 6 10zm0-7a3 3 0 1 1 0-6 3 3 0 0 1 0 6z"/>
										</svg><%=commonDao.getCodeName(campingLists.get(i).getCmp_location()) %>
						</div>
					</div>
					<%} %>
				</div>
			</div>
		</div>
		
		<!-- banner -->
		<div id="banner_total">
			<div id="width_1200">
				<div id="banner_notice">
					<div id="banner_notice_line1">
						<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-exclamation-circle" viewBox="0 0 16 16">
						  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
						  <path d="M7.002 11a1 1 0 1 1 2 0 1 1 0 0 1-2 0zM7.1 4.995a.905.905 0 1 1 1.8 0l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 4.995z"/>
						</svg>&nbsp;공지사항
						<a href="noticeMain.co">
							<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-plus-circle" viewBox="0 0 16 16" color="rgb(15, 56, 6)">
							  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
							  <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
							</svg>
						</a>
					</div>
					<div id="banner_notice_content">
					<% for(int i=0; i<noticeLists.size(); i++) {
						if(("CTG01002").equals(noticeLists.get(i).getNtc_ctgry())){%>
						<div><a href="noticeMain.co"><%=noticeLists.get(i).getNtc_title() %></a></div>
						<%} %>
					<%} %>
					</div>
				</div>
				<div id="banner_img">
					<a href="https://vacation.visitkorea.or.kr/travel/worker/renewal/workerMain.do" target="_blank"><img src="	https://www.gocamping.or.kr/upload/layout/94/0324gBPwsdCxJKQCmC3Lz5xj.jpg" style="width: 250px; height: 200px;" alt="휴가비 지원받으세요"/></a>
					<a href="download_file/KOREA_TOURISM_ORGANIZATION_GOCAMPING_CAMP_LIST.xlsx" download><img src="https://www.gocamping.or.kr/upload/layout/41/9594YwMksXvUzqFxsJBpghvw.jpg"  style="width: 250px; height: 200px;" alt="HCAM 에서 인증한 전국 캠핑장리스트, 캠핑장 리스트 다운받기"/></a>
				</div>
			</div>
		</div>
	</section>	
	
	<!-- footer -->
	<jsp:include page="HCAM_footer.jsp"/>
	
	<%
		commonDao.dbClose();
		fileDao.dbClose();
	%>

</body>
</html>