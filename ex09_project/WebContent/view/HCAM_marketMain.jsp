<%@page import="java.util.Map"%>
<%@page import="java.util.TreeMap"%>
<%@page import="vo.PageInfo"%>
<%@page import="vo.CampingDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="dao.CommonDAO" id="commonDao"></jsp:useBean>
<%
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	 <!-- css -->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
	<!-- jquery -->
	<script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script>
	<title></title>
	<style type="text/css">
/* search_line (상단 검색바) */
.search_line {
	display: block;
	position: relative;
  	z-index: 99;
  	width: 100%;
	height: 70px;
	top: 0px;
	background-color: #FFF;
}
	.search_section_line {
		margin: 0 auto;
		width: 1200px;
		height: 50px;
		text-align: center;
	}
		.search_section_line ul {
			display: inline-block;
		}
			.search_section_line li {
				float: left;
				margin-top: 10px;
				height: 50px;
			}
			#line_ctg{
				float: left;
			}
			#line_ctg span svg:first-child{
				
				width: 30px;
			    height: 30px;
			    margin-top: 5px;
			    background-color: blue;
			}
			#line_ctg span:nth-child(2){
				width: 30px;
			    height: 30px;
				font-size: 16px;
			    font-weight: 500;
			    line-height: 20px;
			    letter-spacing: -0.3px;
			    color: rgb(51, 51, 51);
			    background-color: red;
			}
			/* 장소: 검색어 */
			.search_section_line li:nth-child(1) {
				width: 100px;
				font-size: 15pt;
				margin-right: 10px;				
				margin-top: 20px;
			}
			/* 장소: 검색어 */
			.search_section_line li:nth-child(2) {
				width: 555px;
				border: 1px solid #5f0080;
				border-radius: 5px;
				background-color: white;
				
			}
				/* search_section_line icon, input */
				.search_section_line_icon {
					margin-top: 15px;
					margin-left: 10px;
					float: left;
					width: 20px;
					height: 20px;
				}
				.search_section_line_input {
					float: left;
					margin-top: 15px;
					margin-left: 5px;
					height: 20px;
					border: none;
					border-radius: 5px;
					font-size: 12pt;
				}
				 .search_section_line_input:focus {
					outline: none;
				} 
				.search_section_line li:nth-child(2) input {
					width: 290px;
				}
				/* 검색하기 버튼 */
				.search_section_line li:nth-child(3) {
					margin-left: 10px;
					margin-right: 50px;
					width: 170px;
					border-radius: 5px;
				}
					.search_section_line li:nth-child(3) button {
						width: 170px;
						height: 50px;
						border: 1px solid #5f0080;
						border-radius: 5px;
						background-color: #FFF;
						color: black;
						cursor: pointer;
					}
			}
			/* 오른쪽 찜,마이페이지,장바구니  */
			.search_section_line li:nth-child(4){
				width: 200px;
			}
			.search_section_line li:nth-child(4) div{
				float: left;
				margin-left: 30px;
			}
			.search_section_line li div svg{
				background-color: #FFF;
			}
			
		/* footer */
		footer{
			background-color: #d9dbe9;
		}
		
		/* banner  */
		.fade-in-box{
			width: 100%;
			height: 230px;
			background-color: #5f0080;
			text-align: center;
		}
		.fade-in-box div{
			display: inline-block;
		}
		.fade-in-box div:first-child{
			font-family: Verdana, Geneva, Arial, cursive;
			margin-right: 50px;
			font-weight: bold;
			font-size: 20pt;
			vertical-align: top;
			color: white;
		}
		.fade-in-box div:last-child{
			font-family: Verdana, Geneva, Arial, Sans-serif;
			font-weight: bold;
			font-size: 17pt;
			color: white;
		}
		.box {
			padding: 10px;
			text-align: center;
			color: #ffff;
			opacity: 0;
		}
		.box-1 {
			width: 300px;
			height: 200px;
		}
		.box-2 {
			width: 300px;
			height: 200px;
		}
		.box-3 {
			margin-left: 50px;
			width: 300px;
			height: 200px;
		}
		
		/* section-market main page 시작 */
		#total{
			margin: 0px auto;
			width: 100%;
			height: 730px;
		}
		#width_1200{
			margin: 0 auto;
			width: 1200px;
		}
		
	</style>
</head>
<body>
	<!-- header -->
	<jsp:include page="../include/HCAM_header.jsp"/>
	<!-- header_dateLine -->
	<div class="search_line">
		<section class="search_section_line">
			<form name="top_searching_line_form">
				<ul>
					<li>
						<div id="line_ctg">
							<span>
								<svg xmlns="http://www.w3.org/2000/svg" width="25" height="20" fill="currentColor" class="bi bi-list" viewBox="0 0 16 16">
  									<path fill-rule="evenodd" d="M2.5 12a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5zm0-4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5zm0-4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5z"/>
								</svg>
							</span>
							<span>카테고리</span>
						</div>
					</li>
					<li>
						<div class="search_section_line_icon">
							<svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16" style="background-color:white">
								<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
							</svg>
						</div>
						<input class="search_section_line_input" type="text" name="top_searching_line_form" placeholder="검색어를 입력해주세요">
					</li>
					<li>
						<button type="button">검색하기</button>
					</li>
					<li>
						<div>
							<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor" class="bi bi-bag-heart" viewBox="0 0 16 16">
							  <path fill-rule="evenodd" d="M10.5 3.5a2.5 2.5 0 0 0-5 0V4h5v-.5Zm1 0V4H15v10a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V4h3.5v-.5a3.5 3.5 0 1 1 7 0ZM14 14V5H2v9a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1ZM8 7.993c1.664-1.711 5.825 1.283 0 5.132-5.825-3.85-1.664-6.843 0-5.132Z"/>
							</svg>
						</div>
						<div>
							<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
							  <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z"/>
							</svg>
						</div>
						<div>
							<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor" class="bi bi-cart2" viewBox="0 0 16 16">
							  <path d="M0 2.5A.5.5 0 0 1 .5 2H2a.5.5 0 0 1 .485.379L2.89 4H14.5a.5.5 0 0 1 .485.621l-1.5 6A.5.5 0 0 1 13 11H4a.5.5 0 0 1-.485-.379L1.61 3H.5a.5.5 0 0 1-.5-.5zM3.14 5l1.25 5h8.22l1.25-5H3.14zM5 13a1 1 0 1 0 0 2 1 1 0 0 0 0-2zm-2 1a2 2 0 1 1 4 0 2 2 0 0 1-4 0zm9-1a1 1 0 1 0 0 2 1 1 0 0 0 0-2zm-2 1a2 2 0 1 1 4 0 2 2 0 0 1-4 0z"/>
							</svg>
						</div>
					</li>
				</ul>
			</form>
		</section>
	</div>
	
	<!-- section -->
	<section id="total">
		<div>
			<form action="">
				<div class="fade-in-box">
					<div>&nbsp;&nbsp;&nbsp;Shopping with<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;HCAM's Market</div>			
					<div><img class="box box-1" alt="fruit" src="../image/market/fruits.png"/></div>
					<div><img class="box box-2" alt="meat" src="../image/market/meat.png"/></div>
					<div><img class="box box-3" alt="campingItems" src="../image/market/campingItems.png"/></div>
					<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;with HCAM's Camping item</div>
				</div>
			</form>
		</div>
	</section>	
	
	<!-- footer -->
	<jsp:include page="../include/HCAM_footer.jsp"/>
	
	<%
		commonDao.dbClose();
	%>
	
	<!-- js banner 나타내기 효과 -->
	<script type="text/javascript">
		$( document ).ready( function() {
			    var Delay = 600;
			    $( '.box-1' ).animate( {
			      opacity: '1'
			    }, Delay, function() {
			      $( '.box-2' ).animate( {
			        opacity: '1'
			      }, Delay, function() {
			        $( '.box-3' ).animate( {
			          opacity: '1'
			        }, Delay );
			      });
			    });
			});
	</script>
</body>
</html>