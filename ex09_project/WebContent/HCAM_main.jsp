<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.TreeMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="dao.CommonDAO" id="commonDao"></jsp:useBean>
<%
	//session.removeAttribute("id");

	//현재일자, 다음날일자 구하기
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	Calendar cal = Calendar.getInstance();
	String today = sdf.format(cal.getTime());
	cal.add(Calendar.DATE, 1);
	String tomorrow = sdf.format(cal.getTime());

	/* 코드별 공통코드 전체 조회 */
	TreeMap<String, String> commCodes = commonDao.getCodeAllByCode("CCD02");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- jquery -->
	<script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script>
	<!-- slide -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
	<script type="text/javascript" src="${pageContext.request.contextPath}/slick/slick.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/slick/slick.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/slick/slick.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/slick/slick-theme.css"/>
    <!-- icon -->
	<script src="https://kit.fontawesome.com/ae515d5c73.js" crossorigin="anonymous"></script>
    <!-- css -->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
	<!-- Air datepicker -->
	<link href="js/datepicker/css/datepicker.min.css" rel="stylesheet" type="text/css" media="all">
	<script src="js/datepicker/js/datepicker.js"></script>		<!-- Air datepicker js -->
	<script src="js/datepicker/js/datepicker.ko.js"></script>	<!-- 달력 한글 추가를 위해 커스텀 -->
	<title></title>
	<style type="text/css">
		/* 상단 content */
		#top_content {
			width: 100%;
			height: 50px;
			color: #FFFFFF;
			background-color: #20274D;
			text-align: center;
			line-height: 50px;
		}
		
		/* search_content (상단 검색바) */
		.search_content {
			display: none;
			position: fixed;
		}

		/* body_content header,nav,footer 제외한 전체 */
		#body_content {

		}
			/* 검색BOX 상단 image */
			#main_image {
				position: absolute;
				width: 100%;
				height: 420px;
				background-image: url(image/main_bg.png);
				background-repeat: no-repeat;
				background-size: cover;
			}
			/* 검색BOX */
			#main_section {
				position: relative;
				margin: 0 auto;
				width: 1200px;
				height: 740px;
			}
				/* TextBox */
				#main_title p {
					margin: 0;
					padding: 0;
					padding-top: 10px;
					font-size: 14pt;
					color: white;
					text-align: center;
				}
				#main_title p:first-child {
					padding-top: 60px;
					font-size: 20pt;
					font-weight: bold;
				}
				#main_title p:last-child {
					padding-top: 20px;
					padding-bottom: 20px;
				}
				/* iconBox */
				#div_icon {
					position: absolute;
					margin: 0 auto;
					margin-top: 30px;
					width: 1064px;
					height: 108px;
					left: 5.5%;
					background-color: white;
					border-radius: 5px;
					box-shadow: 0px 0px 10px #606060;
					text-align: center;
				}
					#div_icon ul {
						display: inline-block;
					}
						#div_icon ul li {
							float: left;
							width: 220px;
							height: 108px;
						}	
							#div_icon ul li button {
								margin-top: 10px;
								height: 98px;
								background: inherit;
								border:none;
							}
							#div_icon ul li:nth-child(1) button {
								margin-top: 14px;
								height: 94px;
								color: var(--color-blue);
								border-bottom: 4px solid var(--color-blue);
							}
								#div_icon button div:last-child{
									padding-top: 5px;
								}
									#div_icon .icon_image {
										margin: 0 auto;
										width: 40px;
										height: 40px;
									}
									#div_icon .icon_text {
										font-weight: bold;
									}
									
				/* 검색조건Box */
				.main_div_searching {
					margin: 0 auto;
					width: 1124px;
					height: 430px;
				}
				.main_div_searching:nth-child(5) {
					
				}
					#div_search {
						margin: 0 auto;
						margin-top: 100px;
						padding-top: 70px;
						width: 1124px;
						height: 380px;
						background-color: #F8F7F9;
						border-radius: 20px;
						box-shadow: 0px 0px 10px #606060;
						text-align: center;
					}
					.main_div_searching:nth-child(3) #div_search {	/* 호텔 searchBox */
						height: 300px;
					}
					.main_div_searching:nth-child(4) #div_search {	/* 캠핑 searchBox */
						height: 420px;
					}
					.main_div_searching:nth-child(5) #div_search {	/* 액티비티 searchBox */
						height: 210px;
					}
					
					/* main search 중 호텔 국가, 지역 */
					#search_top {
						clear: left;
						margin: 0 auto;
						margin-top: 10px;
						width: 1000px;
						height: 65px;
					}
						/* main search 중 호텔 국가 */
						#search_hotel_nation {
							display: inline-block;
							margin-right: 7px;
							width: 493px;
							height: 65px;
							background-color: white;
							border: 1px solid #DDDFE2;
							border-radius: 10px;
						}
							.search_hotel_icon {
								margin-top: 17px;
								margin-left: 10px;
								float: left;
								width: 30px;
								height: 30px;
							}
							.search_hotel_select {
								float: left;
								margin-top: 20px;
								margin-left: 15px;
								width: 400px;
								height: 20px;
								border: none;
								border-radius: 5px;
								font-size: 12pt;
							}
							.search_hotel_select:focus {
								outline: none;
							}
						/* main search 중 호텔 국가 */
						#search_hotel_location {
							display: inline-block;
							width: 493px;
							height: 65px;
							background-color: white;
							border: 1px solid #DDDFE2;
							border-radius: 10px;
						}
						
						
						/* 캠핑 종류 */
						#camping_kind {
							margin-top: -10px;
							display: inline-block;
						}
							#camping_kind #camping_kind_sec {
								width: 1000px;
								height: 65px;
								border-radius: 10px;
							}
								#camping_kind #camping_kind_sec div {
									display: inline-block;
									margin-right: 100px;
								}
								#camping_kind #camping_kind_sec div:last-child {
									margin-right: 0px;
								}
									#camping_kind #camping_kind_sec div input {
										display:none;
									}
									#camping_kind #camping_kind_sec div label {
										cursor: pointer;
									}
									#camping_kind #camping_kind_sec div input:checked + label {
										filter: invert(55%) sepia(89%) saturate(2542%) hue-rotate(197deg) brightness(98%) contrast(98%);
									}
										#camping_kind #camping_kind_sec div label img {
											width: 40px;
											height: 40px;
										}

						/* 장소: 검색어 */
						#search_sec {
							clear: left;
							margin: 0 auto;
							margin-top: 10px;
							width: 1000px;
							height: 65px;
							background-color: white;
							border: 1px solid #DDDFE2;
							border-radius: 10px;
						}
							/* main icon,input */
							.search_main_icon {
								margin-top: 18px;
								margin-left: 10px;
								float: left;
								width: 30px;
								height: 30px;
							}
							.search_main_input {
								float: left;
								margin-top: 23px;
								margin-left: 5px;
								height: 20px;
								border: none;
								border-radius: 5px;
								font-size: 12pt;
							}
							.search_main_input:focus {
								outline: none;
							}
							.search_main_date {
								float: left;
								margin-left: 15px;
								padding: 23px 0 17px 0;
								width: 270px;
								/* height: 62px; */
								border: none;
								border-radius: 5px;
								font-size: 12pt;
							}
							.search_main_date:focus {
								outline: none;
							}
								#main_place_input {
									width: 900px;
								}
						#search_middle {
							display: inline-block;
							margin-top: 15px;
						}
							/* 체크인일자 */
							#checkIn_sec {
								clear: left;
								float: left;
								width: 330px;
								height: 65px;
								border-right: 1px solid #DDDFE2;
								background-color: white;
								border: 1px solid #DDDFE2;
								border-radius: 10px 0 0 10px;
							}
								#main_chkIn_input {
									width: 250px;
								}
							/* 체크아웃일자 */
							#chechOut_sec {
								float: left;
								width: 330px;
								height: 65px;
								background-color: white;
								border: 1px solid #DDDFE2;
								border-radius: 0 10px 10px 0;
							}
								#main_chkOut_input {
									width: 250px;
								}
							/* 인원수 */
							#people_sec {
								float: left;
								margin-left: 10px;
								width: 327px;
								height: 65px;
								background-color: white;
								border: 1px solid #DDDFE2;
								border-radius: 10px;
							}
								#main_people_input {
									width: 250px;
								}
						#search_last {
							display: inline-block;
							margin-top: 10px;
						}
							/* 체크박스 */
							#search_last #checkBox_sec {
								clear: left;
								width: 1000px;
								height: 65px;
								background-color: white;
								border: 1px solid #DDDFE2;
								border-radius: 10px;
							}
								#search_last #checkBox_sec div {
									display: inline-block;
									margin-top: 21px;
									margin-right: 30px;
								}
								#search_last #checkBox_sec div:last-child {
									margin-right: 0px;
								}
					/* 검색 버튼 */
					#div_btn_search {
						margin-top: -35px;
						position: absolute;
						width: 490px;
						height: 75px;
						left: 30%;
						
					}
						#div_btn_search input {
							width: 490px;
							height: 75px;
							font-size: 13pt;
							color: #FFFFFF;
							background-color: #5392F9;
							border-radius: 5px;
							border: none;
							border-radius: 5px;
							box-shadow: 0px 0px 3px #606060;
							cursor: pointer;
						}
		/* 화살표 */
		#arrow_down {
			height: 150px;
		}
			#arrow_down div:first-child {
				margin: 0 auto;
				text-align: center;
				height: 50px;
				width: 300px;
			}
				#arrow_down div:first-child h1 {
					margin: 0;
					padding: 0;
				}
					.arrow {
						margin: 0 auto;
						bottom: 0;
						width: 40px;
						height: 60px;
						/*change with size of arrow to make sit on bottom */
						/*   background-image: url(); */
						/*   background-size: contain; */
					}
						.arrow i {
							margin-top: 10px;
							display: block;
							color: black;
						}
					.bounce {
						-moz-animation: bounce 2s infinite;
						-webkit-animation: bounce 2s infinite;
						animation: bounce 2s infinite;
					}
		/* bounce 효과*/
		@-moz-keyframes bounce {
			0%, 20%, 50%, 80%, 100% {
			-moz-transform: translateY(0);
			transform: translateY(0);
			}
			40% {
				-moz-transform: translateY(-30px);
				transform: translateY(-30px);
			}
			60% {
				-moz-transform: translateY(-15px);
				transform: translateY(-15px);
			}
		}
		@-webkit-keyframes bounce {
			0%, 20%, 50%, 80%, 100% {
				-webkit-transform: translateY(0);
				transform: translateY(0);
			}
			40% {
				-webkit-transform: translateY(-30px);
				transform: translateY(-30px);
			}
			60% {
				-webkit-transform: translateY(-15px);
				transform: translateY(-15px);
			}
		}
		@keyframes bounce {
			0%, 20%, 50%, 80%, 100% {
				-moz-transform: translateY(0);
				-ms-transform: translateY(0);
				-webkit-transform: translateY(0);
				transform: translateY(0);
			}
			40% {
				-moz-transform: translateY(-30px);
				-ms-transform: translateY(-30px);
				-webkit-transform: translateY(-30px);
				transform: translateY(-30px);
			}
			60% {
				-moz-transform: translateY(-15px);
				-ms-transform: translateY(-15px);
				-webkit-transform: translateY(-15px);
				transform: translateY(-15px);
				}
		}	

		/* Slider */
		.slick-slide {
		    margin: 0px 20px;
		}
		.container {
			margin-top: 50px;
		}
		.container p {
			margin-bottom: 30px;
		  	font-size: 15pt;
			font-weight: bold;
			text-align: center;
		}
		.slick-slide img {
		    width: 100%;
		}
		.slick-slider
		{
		    position: relative;
		    display: block;
		    box-sizing: border-box;
		    -webkit-user-select: none;
		    -moz-user-select: none;
		    -ms-user-select: none;
		            user-select: none;
		    -webkit-touch-callout: none;
		    -khtml-user-select: none;
		    -ms-touch-action: pan-y;
		        touch-action: pan-y;
		    -webkit-tap-highlight-color: transparent;
		}
		.slick-list
		{
		    position: relative;
		    display: block;
		    overflow: hidden;
		    margin: 0;
		    padding: 0;
		}
		.slick-list:focus
		{
		    outline: none;
		}
		.slick-list.dragging
		{
		    cursor: pointer;
		    cursor: hand;
		}
		.slick-slider .slick-track,
		.slick-slider .slick-list
		{
		    -webkit-transform: translate3d(0, 0, 0);
		       -moz-transform: translate3d(0, 0, 0);
		        -ms-transform: translate3d(0, 0, 0);
		         -o-transform: translate3d(0, 0, 0);
		            transform: translate3d(0, 0, 0);
		}
		.slick-track
		{
		    position: relative;
		    top: 0;
		    left: 0;
		    display: block;
		}
		.slick-track:before,
		.slick-track:after
		{
		    display: table;
		    content: '';
		}
		.slick-track:after
		{
		    clear: both;
		}
		.slick-loading .slick-track
		{
		    visibility: hidden;
		}
		.slick-slide
		{
		    display: none;
		    float: left;
		    height: 100%;
		    min-height: 1px;
		}
		[dir='rtl'] .slick-slide
		{
		    float: right;
		}
		.slick-slide img
		{
		    display: block;
		}
		.slick-slide.slick-loading img
		{
		    display: none;
		}
		.slick-slide.dragging img
		{
		    pointer-events: none;
		}
		.slick-initialized .slick-slide
		{
		    display: block;
		}
		.slick-loading .slick-slide
		{
		    visibility: hidden;
		}
		.slick-vertical .slick-slide
		{
		    display: block;
		    height: auto;
		    border: 1px solid transparent;
		}
		.slick-arrow {
	        z-index: 10;
	        width: 50px;
	        height: 50px;
	        background: rgba($bk, 0.2);
	        border-radius: 50%;
	        transition: background 0.5s;
	        &:hover {
	            background: rgba($pt, 0.9);

	            &::before {
	                color: rgba($bk, 0.5);
	            }
	        }
	        &::before {
	            font-family: 'Line Awesome Free';
	            font-weight: 900;
	            font-size: 49px;
	            transition: all 0.5s;
	        }
	    }
	    .slick-prev {
	        left: 30px;

	        &::before {
	            content: "\f137";
	        }
	    }
	    .slick-next {
	        right: 30px;

	        &::before {
	            content: "\f138";
	        }
	    }
	    .slide img {
	    	border-radius: 100px;
	    }

		/* Container */
		#container{
			margin: 0 auto;
			margin-top: 50px;
			width: 100%;
			height: 1300px;
		}
		/*collabo 시작*/
		#div_collabo_total{
			margin: 0 auto;
			margin-top: 200px;
			margin-bottom: 100px;
			width: 100%;
			height: 550px;
		}
		/*collabo 왼쪽*/
		#div_collabo_left{
			width: 30%;
			height: 550px;
			float: left;
			position: relative;
		}
			#div_collabo_left_top{
				width: 100%;
				height: 497px;
				border-top: 3px solid #997f6a;
			}
				#div_collabo_left_top_div{
					width: 100%;
					height: 100px;
					position: relative;
				}
					#div_collabo_left_top_head{
						width: 54.5%;
						height: 100%;
						bottom: 53px;
						padding-left: 10px;
						right: 0;
						position: absolute;
						background-color: #FFFFFF;
					}
						#div_collabo_title{
							margin-top: -5.5px;
							font-size: 24pt;
							font-weight: 600;
							color: #997f6a;
						}
					#div_collabo_left_top_body{
						width: 100%;
						height: 400px;
					}
						#div_brown{
							width: 80%;
							height: 400px;
							bottom: 0;
							background-color: #b39579;
							position: absolute;
						}
							#div_brown_content{
								width: 100%;
								height: 150px;
								color: white;
								font-size: 12pt;
								padding-left: 40px;
								padding-top: 110px;
							}
							#div_collabo_left_pic{
								width: 50%;
								float: right;
								padding-top: 130px;
								position: relative;
							}
								#div_collabo_left_pic img{
									width: 100%;
									height: 200px;
									overflow: hidden;
								}
			#div_collabo_left_bottom{
				width: 100%;
				height: 70px;
				position: relative;
				background-color: white;
			}
		/*collabo 중간*/
		#div_collabo_center{
			width: 33%;
			height: 550px;
			float: left;
			padding-left: 1%;
			padding-right: 1%;
			position: relative;
		}
			#div_collabo_center_top{
				width: 100%;
				height: 500px;
			}
				#div_collabo_center_top img{
					width: 100%;
					height: 500px;
					overflow: hidden;
				}
				#div_collabo_center_top img:hover{
					opacity: 0.5;
					transition-duration: 0.3s;
				}

			#div_collabo_center_bottom{
				width: 100%;
				height: 50px;
				position: absolute;
			}
				#div_collabo_center_bottom span{
					line-height: 55px;
				}
				#div_collabo_center_bottom span:first-child{
					font-weight: bold;
					font-size: 13pt;
				}
				#div_collabo_center_bottom span:last-child{
					font-size: 10pt;
					color: #000;
				}
		/*collabo 오른쪽*/
		#div_collabo_right{
			width: 37%;
			height: 550px;
			float: left;
		}
			#div_collabo_right_top{
				width: 100%;
				height: 500px;
				margin: 0 auto;
				background-color: #b39579;
			}
				#div_collabo_right_top_video{
					width: 100%;
					padding-top: 50px;					
					overflow: hidden;
				}
			#div_collabo_right_bottom{
				/* width: 100%; */
				height: 50px;
				position: absolute;
			}
				#div_collabo_right_bottom span{
					line-height: 55px;
				}
				#div_collabo_right_bottom span:first-child{
					font-weight: bold;
					font-size: 13pt;
				}
				#div_collabo_right_bottom span:last-child{
					font-size: 10pt;
					color: #000;
				}

		/*hcam 시작*/
		#section_hcam_total{
			width: 100%;
			height: 550px;
			clear: left;
		}
		/*hcam 사진*/
			#section_hcam_imgcontent_total{
				margin: 0 auto;
				width: 1700px;
				height: 600px;
			}
			#section_hcam_title{
				width: 400px;
				height: 10px;
				padding: 20px;
			}
			#section_hcam_title div{
				font-size: 20pt;
			}
			.section_hcam_imgcontent{
				margin-right: 20px;
				width: 400px;
				height: 550px;
				padding: 10px;
				float: left;
			}
				.section_hcam_img{
					width: 400px;
					height: 450px;
					float: left;
					overflow: hidden;
					position: absolute;
				}
					.section_hcam_img img{
						width: 400px;
						transition: all 0.4s linear;
					}
					.section_hcam_img:hover img{
						transform: scale(1.2);
					}

		/*hcam 글*/
		.section_hcam_content{
			width: 300px;
			height: 170px;
			float: left;
			font-size: 10pt;
			position: relative;
			margin-top: 360px;
			background-color: white;
		}
		.section_hcam_content_name{
			width: 300px;
			height: 20px;
			font-size: 10pt;
			padding: 5px;
			margin-top: 10px;
			color: #b39579;
		}
		.section_hcam_content_sort{
			width: 300px;
			height: 20px;
			font-size: 12pt;
			padding: 5px;
			font-weight: bold;
		}
		.section_hcam_content_txt{
			width: 300px;
			height: 40px;
			font-size: 11pt;
			padding: 5px;
		}
		.section_hcam_content_rsv{
			width: 300px;
			height: 20px;
			font-size: 9pt;
			padding-left: 5px;
			color: #999;
		}
		.section_hcam_content_stay{
			width: 300px;
			height: 20px;
			font-size: 9pt;
			padding-left: 5px;
			color: #999;
		}

		/* Top 버튼 */
		#myBtn {
		  display: none;
		  position: fixed;
		  bottom: 20px;
		  right: 30px;
		  z-index: 99;
		  font-size: 18px;
		  border: none;
		  outline: none;
		  background-color: #5392F9;
		  color: white;
		  cursor: pointer;
		  padding: 15px;
		  border-radius: 4px;
		}		
		#myBtn:hover {
		  background-color: #555;
		}

		.div_hidden {
			display: none;
		}
		
	</style>
</head>
<script>
	/* init window */
	$(document).ready(function(){
		//Tab Menu
		fn_tabMenu();

		//트래블 콜라보레이션 slide
		slideShow();

		// 인기여행지 slide
		slideshow2();
		
		// 날짜 체크
		var now_utc = Date.now() 	// 지금 날짜를 밀리초로
		var tomo_utc = new Date();	// 다음 날짜를 밀리초로
		tomo_utc.setDate(tomo_utc.getDate() + 1); 			// 1일 더하여 setting
		
		// getTimezoneOffset()은 현재 시간과의 차이를 분 단위로 반환
		var timeOff = new Date().getTimezoneOffset()*60000; // 분단위를 밀리초로 변환
		
		var today = new Date(now_utc-timeOff).toISOString().split("T")[0];
		var tomorrow = new Date(tomo_utc-timeOff).toISOString().split("T")[0];
		
		document.getElementById("top_chkIn").setAttribute("min", today);
		document.getElementById("top_chkOut").setAttribute("min", tomorrow);
		document.getElementById("main_htl_chkIn").setAttribute("min", today);
		document.getElementById("main_htl_chkOut").setAttribute("min", tomorrow);
		
	});
	
	/* 체크인, 체크아웃 일자 변경 시 체크 */
	function fn_chgDate(obj, kubun) {
		
		var oldValue = obj.value;
		
		var today = $("input[name='today']").val();
		var tomorrow = $("input[name='tomorrow']").val();
		
		if(kubun == 1) {
			if(oldValue < today) {
				alert("현재 일자 이전의 날짜는 선택할 수 없습니다.");
				obj.value = today;
			}
		}
		else {
			if(oldValue < tomorrow) {
				alert("다음날 일자 이전의 날짜는 선택할 수 없습니다.");
				obj.value = tomorrow;
			}
		}
	}

	/* Tab Menu */
	function fn_tabMenu() {
		$('#div_icon button').click(function() {
			var index = $('#div_icon button').index(this);			// 버튼 index
			$('.main_div_searching').addClass('div_hidden');	// 전부 hidden
			$('.main_div_searching:nth-child(' + (index+3) + ')').removeClass('div_hidden');	// 클릭된 index+3된 div는 show

			if(index == 1) {
				$('#main_section').css('height', 740+'px');
			}
			// 액티비티 버튼 클릭 시 section 크기 변경
			else if(index == 2) {
				$('#main_section').css('height', 600+'px');
			}
			else {
				$('#main_section').css('height', 770+'px');
			}
			
			// 버튼 클릭 시 css 변경
			for(var i=0; i<4; i++) {
				if(index != i) {
					$('#div_icon ul li:nth-child(' + (i+1) + ') button').css("color", "#333333");
					$('#div_icon ul li:nth-child(' + (i+1) + ') button').css("margin-top", "10px");
					$('#div_icon ul li:nth-child(' + (i+1) + ') button').css("height", "98px");
					$('#div_icon ul li:nth-child(' + (i+1) + ') button').css("border", "none");
				}
				else {
					$('#div_icon ul li:nth-child(' + (i+1) + ') button').css("color", "#5392F9");
					$('#div_icon ul li:nth-child(' + (i+1) + ') button').css("margin-top", "14px");
					$('#div_icon ul li:nth-child(' + (i+1) + ') button').css("height", "94px");
					$('#div_icon ul li:nth-child(' + (i+1) + ') button').css("border-bottom", "4px solid #5392F9");
				}
			}
			
			
		});
	}
	
	/* Top 국가 select박스 변경될 시 */
	function fn_chgSelectbox(NationCode) {
		if($('#select01 option:selected').val() == "") {
			//$('#select02').val("").prop("selected", true);
			$("#select02 option").remove();
			$("#select02").append("<option value=''>전체</option>");
		}
		else {
			$.ajax({
				url: "view/HCAM_mainSelectbox.jsp",
				type:'POST',
				dataType: "text",
				async:false,
				data: "topCode=" + NationCode.value +
				  	  "&kubun=top",
				success: function(result) {
					$(".li_select02").html(result);
				},
				error: function(request, error) {
					alert(request.status + " / " + request.responseText + " / " + error);
				}
			});
		}
	}
	
	/* main 국가 select박스 변경될 시 */
	function fn_chgHotelSelectbox(NationCode) {
		if($('#htl_select01 option:selected').val() == "") {
			//$('#select02').val("").prop("selected", true);
			$("#htl_select02 option").remove();
			$("#htl_select02").append("<option value=''>전체</option>");
		}
		else {
			$.ajax({
				url: "view/HCAM_mainSelectbox.jsp",
				type:'POST',
				dataType: "text",
				async:false,
				data: "topCode=" + NationCode.value +
				  	  "&kubun=main",
				success: function(result) {
					$("#search_hotel_location").html(result);
				},
				error: function(request, error) {
					alert(request.status + " / " + request.responseText + " / " + error);
				}
			});
		}
	}
	
	/* 상단 검색 바 */
	function fn_topSearching() {
		var result = false;
		
		var select01 = $('#select01 option:selected').val();
		var select02 = $('#select02 option:selected').val();
		var top_chkIn = $("#top_chkIn").val();
		var top_chkOut = $("#top_chkOut").val();
		
		// 날짜 체크
		if(top_chkIn > top_chkOut) {
			alert("체크아웃일자는 체크인일자 이후로 선택하세요");
		}
		else if(top_chkIn == "" || top_chkOut == "") {
			alert("날짜를 선택하세요");
		}
		else {
			result = true;
		}
		
		return result;
	}
	
	/* 호텔 메인 검색 */
	function fn_mainSearching() {
		var result = false;
		
		var select01 = $('#htl_select01 option:selected').val();
		var select02 = $('#htl_select02 option:selected').val();
		var htlMain_chkIn = $("#main_htl_chkIn").val();
		var htlMain_chkOut = $("#main_htl_chkOut").val();
		
		// 날짜 체크
		if(htlMain_chkIn >= htlMain_chkOut) {
			alert("체크아웃일자는 체크인일자 이후로 선택하세요");
		}
		else if(htlMain_chkIn == "" || htlMain_chkOut == "") {
			alert("날짜를 선택하세요");
		}
		else {
			result = true;
		}
		
		return result;
	}

    /* 트래블 콜라보레이션 slide */
    var index = 0;   //이미지에 접근하는 인덱스
    function slideShow() {
	    var i;
	    var x = document.getElementsByClassName("slide1");  //slide1에 대한 dom 참조
	    for (i = 0; i < x.length; i++) {
	       x[i].style.display = "none";   //처음에 전부 display를 none으로 한다.
	    }
	    index++;
	    if (index > x.length) {
	        index = 1;  //인덱스가 초과되면 1로 변경
	    }   
	    x[index-1].style.display = "block";  //해당 인덱스는 block으로
	    setTimeout(slideShow, 2000);   //함수를 4초마다 호출
	}

	/* 인기여행지 slide */
	function slideshow2() {
		/* 인기여행지 slide */
	    $('.customer-logos').slick({
	        slidesToShow: 6,
	        slidesToScroll: 1,
	        autoplay: true,
	        autoplaySpeed: 1500,
	        arrows: false,
	        prevArrow : "<button type='button' class='slick-prev'>Previous</button>",		// 이전 화살표 모양 설정
			nextArrow : "<button type='button' class='slick-next'>Next</button>",		// 다음 화살표 모양 설정
	        dots: false,
	        pauseOnHover: false,
	        arrows: true,
	        responsive: [{
	            breakpoint: 768,
	            settings: {
	                slidesToShow: 4
	            }
	        }, {
	            breakpoint: 520,
	            settings: {
	                slidesToShow: 3
	            }
	        }]

	        /*
	        rows: 1,             //몇 줄로 나타낼건지
			infinite: true,      //무한반복 (boolean) -default:true
			slidesToShow: 4,     //한번에 보여지는 갯수
			slidesToScroll: 4,   //한번에 넘겨지는 갯수
		    slidesPerRow: 1,     //보여질 행의 수 (한 줄, 두 줄 ... )
			autoplay: true,      //자동시작 (boolean) -default:false
			autoplaySpeed: 2000, //자동넘기기 시간(int, 1000ms = 1초)
		    dots: false,         //네비게이션버튼 (boolean) -default:false
		    appendDots: $('#dots'), //네비게이션버튼 변경 (선택자 혹은 $(element))
		    dotsClass: 'custom-dots', //네비게이션버튼 클래스 변경
		    variableWidth: true, //width의 크기가 다를때 (boolean) -default:false
			draggable: false,    //리스트 드래그 가능여부 (boolean) -default:true
		    arrows: true,        //화살표(넘기기버튼) 여부 (boolean) -default:true
		    pauseOnFocus: true,  //마우스 포커스 시 슬라이드 멈춤 -default:true
		    pauseOnHover: true,  //마우스 호버 시 슬라이드 멈춤 -default:true
		    pauseOnDotsHover: true,  //네이게이션버튼 호버 시 슬라이드 멈춤 -default:false
		    vertical: true,      //세로방향 여부 (boolean) -default:false
		    verticalSwiping: true,     //세로방향 스와이프 여부 (boolean) -default:false
		    accessibility: true, //접근성 여부 (boolean) -default:true
		    appendArrows: $('#arrows'), // 좌우 화살표 변경 (선택자 혹은 $(element))
		    prevArrow: $('#prevArrow'), // 좌 (이전) 화살표만 변경 (선택자 혹은 $(element))
		    nextArrow: $('#nextArrow'), // 우 (다음) 화살표만 변경 (선택자 혹은 $(element))
		    initialSlide: 1,     //처음 보여질 슬라이드 번호 -default: 0
		    centerMode: true,    //중앙에 슬라이드가 보여지는 모드 -default:false
		    centerPadding: '60px',  //중앙에 슬라이드가 보여지는 모드에서 padding값
		    fade: true,          //fade 효과 -default:false
		    speed: 2000,         //모션 시간 (1000 = 1초)
		    waitForAnimate: true, //애니메이션 중에는 동작을 제한함 -default:true
		    rtl: true,          //slider 방향을 오른쪽에서 왼쪽으로 변경 -default:false
		    responsive: [
		        {
		            breakpoint: 1024,   //width 1024 이상부터
		            settings: {
		                slidesToShow: 3,
		                slidesToScroll: 3
		            }
		        },
		        {
		            breakpoint: 480,   //width 480 이상부터
		            settings: {
		                slidesToShow: 2,
		                slidesToScroll: 2
		            }
		        }
		    ] //반응형, breakpoint: 반응형 구간, settings: 반응형 구간에 따른 설정 변경
		    */
	    });
	}
</script>
<body>
	<!-- header -->
	<jsp:include page="include/HCAM_header.jsp"/>
	
	<input type="hidden" name="today" value="<%=today %>">			<!-- 현재일자 -->
	<input type="hidden" name="tomorrow" value="<%=tomorrow %>">	<!-- 다음날일자 -->
	<div id="top_content">
		<font>해외로 떠나시나요? 코로나 19 관련 여행 정보 및 제한 사항 업데이트를 확인하세요.</font>
	</div>
	<div class="search_content" id="search_content">
		<section class="search_section">
			<form name="top_searching" method="POST" action="hotelMain.ho" onsubmit="return fn_topSearching();">
				<ul>
					<li>
						<div class="search_sec_icon">
							<svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
								<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
							</svg>
						</div>
						<select class="search_sec_input" name="select01" id="select01" onchange="fn_chgSelectbox(this);">
							<option value="1">전체
							<% 
								for(Map.Entry<String, String> code : commCodes.entrySet()) { 
									out.println("<option value='" + code.getKey() + "'>" + code.getValue() + "</option>");
								}
							%>
						</select>
					</li>
					<li class="li_select02">
						<div class="search_sec_icon">
						</div>
						<select class="search_sec_input" name="select02" id="select02">
							<option value="1">전체
						</select>
					</li>
					<li>
						<div class="search_sec_icon">
							<svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-calendar-check" viewBox="0 0 16 16">
							  <path d="M10.854 7.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L7.5 9.793l2.646-2.647a.5.5 0 0 1 .708 0z"/>
							  <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4H1z"/>
							</svg>
						</div>
						<%-- <input class="search_sec_input" type="date" name="top_chkIn" id="top_chkIn" value="<%=today %>" onblur="fn_chgDate(this ,1);" placeholder="체크인일자"> --%>
						<input class="search_sec_input" type="text" name="top_chkIn" id="top_chkIn" value="<%=today %>" placeholder="체크인일자">
					</li>
					<li>
						<div class="search_sec_icon">
							<svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-calendar-check" viewBox="0 0 16 16">
							  <path d="M10.854 7.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L7.5 9.793l2.646-2.647a.5.5 0 0 1 .708 0z"/>
							  <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4H1z"/>
							</svg>
						</div>
						<%-- <input class="search_sec_input" type="date" name="top_chkOut" id="top_chkOut" value="<%=tomorrow %>" onblur="fn_chgDate(this ,2)" placeholder="체크아웃"> --%>
						<input class="search_sec_input" type="text" name="top_chkOut" id="top_chkOut" value="<%=tomorrow %>" placeholder="체크아웃">
					</li>
					<li>
						<input type="submit" value="검색하기">
					</li>
				</ul>
			</form>
		</section>
	</div>
	<div id="body_content">
		<button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>
		<div id="main_image"></div>
		<section id="main_section">
			<div id="main_title">
				<p>호텔, 캠핑, 액티비티, 마켓 등</p>
				<p>전 세계 200만개 이상의 다양한 숙소를 베스트 요금으로 예약하세요!</p>
			</div>
			<div id="div_icon">
				<ul>
					<li>
						<button>
							<div class="icon_image">
								<svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-building" viewBox="0 0 16 16">
	  								<path fill-rule="evenodd" d="M14.763.075A.5.5 0 0 1 15 .5v15a.5.5 0 0 1-.5.5h-3a.5.5 0 0 1-.5-.5V14h-1v1.5a.5.5 0 0 1-.5.5h-9a.5.5 0 0 1-.5-.5V10a.5.5 0 0 1 .342-.474L6 7.64V4.5a.5.5 0 0 1 .276-.447l8-4a.5.5 0 0 1 .487.022zM6 8.694 1 10.36V15h5V8.694zM7 15h2v-1.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 .5.5V15h2V1.309l-7 3.5V15z"/>
	  								<path d="M2 11h1v1H2v-1zm2 0h1v1H4v-1zm-2 2h1v1H2v-1zm2 0h1v1H4v-1zm4-4h1v1H8V9zm2 0h1v1h-1V9zm-2 2h1v1H8v-1zm2 0h1v1h-1v-1zm2-2h1v1h-1V9zm0 2h1v1h-1v-1zM8 7h1v1H8V7zm2 0h1v1h-1V7zm2 0h1v1h-1V7zM8 5h1v1H8V5zm2 0h1v1h-1V5zm2 0h1v1h-1V5zm0-2h1v1h-1V3z"/>
								</svg>
							</div>
							<div class="icon_text">호텔</div>
						</button>
					</li>
					<li>
						<button>
							<div class="icon_image">
								<svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-fire" viewBox="0 0 16 16">
	  								<path d="M8 16c3.314 0 6-2 6-5.5 0-1.5-.5-4-2.5-6 .25 1.5-1.25 2-1.25 2C11 4 9 .5 6 0c.357 2 .5 4-2 6-1.25 1-2 2.729-2 4.5C2 14 4.686 16 8 16Zm0-1c-1.657 0-3-1-3-2.75 0-.75.25-2 1.25-3C6.125 10 7 10.5 7 10.5c-.375-1.25.5-3.25 2-3.5-.179 1-.25 2 1 3 .625.5 1 1.364 1 2.25C11 14 9.657 15 8 15Z"/>
								</svg>
							</div>
							<div class="icon_text">캠핑</div>
						</button>
					</li>
					<li>
						<button>
							<div class="icon_image">
								<svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-joystick" viewBox="0 0 16 16">
	  								<path d="M10 2a2 2 0 0 1-1.5 1.937v5.087c.863.083 1.5.377 1.5.726 0 .414-.895.75-2 .75s-2-.336-2-.75c0-.35.637-.643 1.5-.726V3.937A2 2 0 1 1 10 2z"/>
	  								<path d="M0 9.665v1.717a1 1 0 0 0 .553.894l6.553 3.277a2 2 0 0 0 1.788 0l6.553-3.277a1 1 0 0 0 .553-.894V9.665c0-.1-.06-.19-.152-.23L9.5 6.715v.993l5.227 2.178a.125.125 0 0 1 .001.23l-5.94 2.546a2 2 0 0 1-1.576 0l-5.94-2.546a.125.125 0 0 1 .001-.23L6.5 7.708l-.013-.988L.152 9.435a.25.25 0 0 0-.152.23z"/>
								</svg>
							</div>
							<div class="icon_text">액티비티</div>
						</button>
					</li>
					<li>
						<button onclick="location.href='HCAM_index.html'">
							<div class="icon_image">
								<svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-cart3" viewBox="0 0 16 16">
	  								<path d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .49.598l-1 5a.5.5 0 0 1-.465.401l-9.397.472L4.415 11H13a.5.5 0 0 1 0 1H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5zM3.102 4l.84 4.479 9.144-.459L13.89 4H3.102zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2zm7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
								</svg>
							</div>
							<div class="icon_text">마켓</div>
						</button>
					</li>
				</ul>
			</div>
			<!-- class가 main_div_searching 인 div는 호텔/캠핑/액티비티/마켓 버튼 클릭 시 div 자체가 show, hidden으로 바뀜 -->
			<div class="main_div_searching">
				<form name="hotel_searching" method="POST" action="hotelMain.ho" onsubmit="return fn_mainSearching();">
					<div id="div_search">
						<div id="search_top">
							<div id="search_hotel_nation">
								<div class="search_hotel_icon">
									<svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
										<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
									</svg>
								</div>
								<select class="search_hotel_select" name="select01" id="htl_select01" onchange="fn_chgHotelSelectbox(this);">
									<option value="1">전체
									<% 
										for(Map.Entry<String, String> code : commCodes.entrySet()) { 
											out.println("<option value='" + code.getKey() + "'>" + code.getValue() + "</option>");
										}
									%>
								</select>
							</div>
							<div id="search_hotel_location" id="search_hotel_location">
								<div class="search_hotel_icon">
								</div>
								<select class="search_hotel_select" name="select02" id="htl_select02">
									<option value="1">전체
								</select>
							</div>
						</div>
						<div id="search_middle">
							<div id="checkIn_sec">
								<div class="search_main_icon">
									<svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-calendar-check" viewBox="0 0 16 16">
							  			<path d="M10.854 7.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L7.5 9.793l2.646-2.647a.5.5 0 0 1 .708 0z"/>
							 			 <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4H1z"/>
									</svg>
								</div>
								<%-- <input class="search_main_date" type="date" name="main_htl_chkIn" id="main_htl_chkIn" value="<%=today %>" onblur="fn_chgDate(this ,1);" placeholder="체크인일자"> --%>
								<input class="search_main_date" type="text" name="main_htl_chkIn" id="main_htl_chkIn" value="<%=today %>" placeholder="체크인일자">
							</div>
							<div id="chechOut_sec">
								<div class="search_main_icon">
									<svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-calendar-check" viewBox="0 0 16 16">
							  			<path d="M10.854 7.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L7.5 9.793l2.646-2.647a.5.5 0 0 1 .708 0z"/>
							 			 <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4H1z"/>
									</svg>
								</div>
								<%-- <input class="search_main_date" type="date" name="main_htl_chkOut" id="main_htl_chkOut" value="<%=tomorrow %>" onblur="fn_chgDate(this ,2);" placeholder="체크아웃"> --%>
								<input class="search_main_date" type="text" name="main_htl_chkOut" id="main_htl_chkOut" value="<%=tomorrow %>" placeholder="체크아웃">
							</div>
							<div id="people_sec">
								<div class="search_main_icon">
									<svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-people" viewBox="0 0 16 16">
	  									<path d="M15 14s1 0 1-1-1-4-5-4-5 3-5 4 1 1 1 1h8zm-7.978-1A.261.261 0 0 1 7 12.996c.001-.264.167-1.03.76-1.72C8.312 10.629 9.282 10 11 10c1.717 0 2.687.63 3.24 1.276.593.69.758 1.457.76 1.72l-.008.002a.274.274 0 0 1-.014.002H7.022zM11 7a2 2 0 1 0 0-4 2 2 0 0 0 0 4zm3-2a3 3 0 1 1-6 0 3 3 0 0 1 6 0zM6.936 9.28a5.88 5.88 0 0 0-1.23-.247A7.35 7.35 0 0 0 5 9c-4 0-5 3-5 4 0 .667.333 1 1 1h4.216A2.238 2.238 0 0 1 5 13c0-1.01.377-2.042 1.09-2.904.243-.294.526-.569.846-.816zM4.92 10A5.493 5.493 0 0 0 4 13H1c0-.26.164-1.03.76-1.724.545-.636 1.492-1.256 3.16-1.275zM1.5 5.5a3 3 0 1 1 6 0 3 3 0 0 1-6 0zm3-2a2 2 0 1 0 0 4 2 2 0 0 0 0-4z"/>
									</svg>
								</div>
								<input class="search_main_input" id="main_people_input" type="text" name="main_people" placeholder="인원수">
							</div>
						</div>
						<!-- <div id="search_last">
							<div id="checkBox_sec">
								<div>
									<input type="checkbox" name="bkft" id="bkft">
									<label for="bkft"><font>조식운영</font></label>
								</div>
								<div>
									<input type="checkbox" name="pool" id="pool">
									<label for="pool"><font>수영장</font></label>
								</div>
								<div>
									<input type="checkbox" name="park" id="park">
									<label for="park"><font>주차가능</font></label>
								</div>
								<div>
									<input type="checkbox" name="conv" id="conv">
									<label for="conv"><font>편의시설</font></label>
								</div>
								<div>
									<input type="checkbox" name="bagg" id="bagg">
									<label for="bagg"><font>수하물보관</font></label>
								</div>
							</div>
						</div> -->
					</div>
					<div id="div_btn_search">
						<input type="submit" value="검색하기">
					</div>
				</form>
			</div>
			<div class="main_div_searching div_hidden">
				<form name="camping_searching">
					<div id="div_search">
						<div id="camping_kind">
							<div id="camping_kind_sec">
								<div>
									<input type="checkbox" name="camping" id="camping">
									<label for="camping">
										<img src="image/icon/camping_icon.png"><br>
										<font>캠핑</font>
									</label>
								</div>
								<div>
									<input type="checkbox" name="caravan" id="caravan">
									<label for="caravan">
										<img src="image/icon/caravan_icon.png"><br>
										<font>카라반</font>
									</label>
								</div>
								<div>
									<input type="checkbox" name="glamping" id="glamping">
									<label for="glamping">
										<img src="image/icon/glamping_icon.png"><br>
										<font>글램핑</font>
									</label>
								</div>
								<!-- <div>
									<input type="checkbox" name="pension" id="pension">
									<label for="pension">
										<img src="image/icon/pension_icon.png"><br>
										<font>펜션</font>
									</label>
								</div> -->
								<div>
									<input type="checkbox" name="incar" id="incar">
									<label for="incar">
										<img src="image/icon/incar_icon.png"><br>
										<font>차박</font>
									</label>
								</div>
							</div>
						</div>
						<div id="search_sec">
							<div class="search_main_icon">
								<svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
									<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
								</svg>
							</div>
							<input class="search_main_input" id="main_place_input" type="text" name="main_place" placeholder="어디로 떠나시나요?">
						</div>
						<div id="search_middle">
							<div id="checkIn_sec">
								<div class="search_main_icon">
									<svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-calendar-check" viewBox="0 0 16 16">
							  			<path d="M10.854 7.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L7.5 9.793l2.646-2.647a.5.5 0 0 1 .708 0z"/>
							 			 <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4H1z"/>
									</svg>
								</div>
								<input class="search_main_input" id="main_chkIn_input" type="text" name="main_chkIn" placeholder="체크인일자">
							</div>
							<div id="chechOut_sec">
								<div class="search_main_icon">
									<svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-calendar-check" viewBox="0 0 16 16">
							  			<path d="M10.854 7.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L7.5 9.793l2.646-2.647a.5.5 0 0 1 .708 0z"/>
							 			 <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4H1z"/>
									</svg>
								</div>
								<input class="search_main_input" id="main_chkOut_input" type="text" name="main_chkOut" placeholder="체크아웃">
							</div>
							<div id="people_sec">
								<div class="search_main_icon">
									<svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-people" viewBox="0 0 16 16">
	  									<path d="M15 14s1 0 1-1-1-4-5-4-5 3-5 4 1 1 1 1h8zm-7.978-1A.261.261 0 0 1 7 12.996c.001-.264.167-1.03.76-1.72C8.312 10.629 9.282 10 11 10c1.717 0 2.687.63 3.24 1.276.593.69.758 1.457.76 1.72l-.008.002a.274.274 0 0 1-.014.002H7.022zM11 7a2 2 0 1 0 0-4 2 2 0 0 0 0 4zm3-2a3 3 0 1 1-6 0 3 3 0 0 1 6 0zM6.936 9.28a5.88 5.88 0 0 0-1.23-.247A7.35 7.35 0 0 0 5 9c-4 0-5 3-5 4 0 .667.333 1 1 1h4.216A2.238 2.238 0 0 1 5 13c0-1.01.377-2.042 1.09-2.904.243-.294.526-.569.846-.816zM4.92 10A5.493 5.493 0 0 0 4 13H1c0-.26.164-1.03.76-1.724.545-.636 1.492-1.256 3.16-1.275zM1.5 5.5a3 3 0 1 1 6 0 3 3 0 0 1-6 0zm3-2a2 2 0 1 0 0 4 2 2 0 0 0 0-4z"/>
									</svg>
								</div>
								<input class="search_main_input" id="main_people_input" type="text" name="main_people" placeholder="인원수">
							</div>
						</div>
						<div id="search_last">
							<div id="checkBox_sec">
								<div>
									<input type="checkbox" name="mkdv" id="mkdv">
									<label for="mkdv"><font>마켓배송</font></label>
								</div>
								<div>
									<input type="checkbox" name="swim" id="swim">
									<label for="swim"><font>수영장</font></label>
								</div>
								<!-- <div>
									<input type="checkbox" name="car" id="car">
									<label for="car"><font>카라반</font></label>
								</div> -->
								<div>
									<input type="checkbox" name="common" id="common">
									<label for="common"><font>공용시설</font></label>
								</div>
								<div>
									<input type="checkbox" name="conven" id="conven">
									<label for="conven"><font>편의시설</font></label>
								</div>
								<div>
									<input type="checkbox" name="dog" id="dog">
									<label for="dog"><font>애견동반</font></label>
								</div>
								<div>
									<input type="checkbox" name="cook" id="cook">
									<label for="cook"><font>취사가능</font></label>
								</div>
							</div>
						</div>
					</div>
					<div id="div_btn_search">
						<input type="submit" value="검색하기">
					</div>
				</form>
			</div>
			<div class="main_div_searching div_hidden">
				<form name="activity_searching">
					<div id="div_search">
						<div id="search_sec">
							<div class="search_main_icon">
								<svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
									<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
								</svg>
							</div>
							<input class="search_main_input" id="main_place_input" type="text" name="main_place" placeholder="도시명으로 검색">
						</div>
					</div>
					<div id="div_btn_search">
						<input type="submit" value="검색하기">
					</div>
				</form>
			</div>
		</section>
		<div id="arrow_down">
			<div>
				<h1>See what's below</h1>
			</div>
			<div class="arrow bounce">
				<i class="fa fa-angle-down fa-5x" aria-hidden="true"></i>
			</div>
		</div>
		<div class="container">
			<p>대한민국 인기여행지</p>
			<section class="customer-logos slider">
				<div class="slide"><img src="image/main_k_seoul.jpg"></div>
				<div class="slide"><img src="image/main_k_daegu.jpg"></div>
				<div class="slide"><img src="image/main_k_gangneung.jpg"></div>
				<div class="slide"><img src="image/main_k_gyeongju.jpg"></div>
				<div class="slide"><img src="image/main_k_incheon.jpg"></div>
				<div class="slide"><img src="image/main_k_jeju.jpg"></div>
				<div class="slide"><img src="image/main_k_busan.jpg"></div>
				<div class="slide"><img src="image/main_k_sokcho.jpg"></div>
				<div class="slide"><img src="image/main_k_yeosu.jpg"></div>
			</section>
		</div>
		<div class="container">
			<p>해외 인기여행지</p>
			<section class="customer-logos slider">
				<div class="slide"><img src="image/main_f_bali.jpg"></div>
				<div class="slide"><img src="image/main_f_bangkok.jpg"></div>
				<div class="slide"><img src="image/main_f_chiangmai.jpg"></div>
				<div class="slide"><img src="image/main_f_dalak.jpg"></div>
				<div class="slide"><img src="image/main_f_hanoi.jpg"></div>
				<div class="slide"><img src="image/main_f_puhquoc.jpg"></div>
				<div class="slide"><img src="image/main_f_jakarta.jpg"></div>
				<div class="slide"><img src="image/main_f_losangeles.jpg"></div>
				<div class="slide"><img src="image/main_f_singapore.jpg"></div>
			</section>
		</div>
	</div>
	<div id="container">
		<div id="div_collabo_total">
			<div id="div_collabo_left">
				<div id="div_collabo_left_top">
					<div id="div_collabo_left_top_div">
						<div id="div_collabo_left_top_head">
							<ul>
								<div><li><div><font size="6pt"><font color="blue">H</font><font color="orange">C</font><font color="purple">A</font><font color="green">M</font></font></div></li></div>
								<div id="div_collabo_title"><li>트래블 콜라보레이션</li></div>
								<div><li><font size="3pt"> 콜라보레이션 여행상품<br>호텔&액티비티와 캠핑&마켓</font></li></div>
								<!-- <div><li><a href="#" role="button" class="btn_prev"></a></li>
									<li><a a href="#" role="button" class="btn_next"></a></li></div> -->
							</ul>
						</div>
					</div>
					<div id="div_collabo_left_top_body">
						<div id="div_brown">
							<div id="div_brown_content"><font size="5pt"><b>맛있는 여행</b></font><br><br>
							캠핑을 무겁게 가지 마세요.<br>온라인 제휴 마켓에서 장보고<br>원하는 날짜, 시간에<br>캠핑장으로 배송완료!</div>
						</div>
						<div id="div_collabo_left_pic">
							<img class="slide1" src= "image/index_collabo_campingcooking1.jpg">
							<img class="slide1" src= "image/index_collabo_campingcooking2.jpg">
							<img class="slide1" src= "image/index_collabo_campingcooking3.jpg">
						</div>
					</div>
				</div>
				<div id="div_collabo_left_bottom">
				</div>
			</div>
			<div id="div_collabo_center" >
				<div id="div_collabo_center_top">
					<img  src="image/index_collabo_camping.jpg">
				</div>
				<div id="div_collabo_center_bottom">
					<span>캠핑 & 마켓</span>
					<span> 캠핑 떠나세요? 장 보셨나요? 마켓에서 장 보시면 캠핑장으로 배송완료!</span>
				</div>
			</div>
			<div id="div_collabo_right">
				<div id="div_collabo_right_top">
					<div id="div_collabo_right_top_video">
						<video muted autoplay loop height="400px">
							<source src="image/index_collabo_activity.mp4" type= "video/mp4"> 
						</video>
					</div>
				</div>
				<div id="div_collabo_right_bottom">
					<span>호텔 & 액티비티</span>
					<span> 여수 라마다를 예약하시면 호텔 24층 루프탑에서 즐기는 짚라인 할인까지!</span>
				</div>
			</div>
		</div>
		<div>
			<section id="section_hcam_total">
					<div id="section_hcam_imgcontent_total">
						<div id="section_hcam_title">
							<div><font color="blue">H</font><font color="orange">C</font><font color="purple">A</font><font color="green">M</font> 추천</div>
						</div>
						<div class="section_hcam_imgcontent">
							<div class="section_hcam_img">
								 <img src="image/index_hcam_hotel.jpg" width="400px" height="450px" alt="">
							</div>
							<div class="section_hcam_content">
								<ul>
									<div class="section_hcam_content_name">
										<li>여수 라마다호텔</li>
									</div>
									<div class="section_hcam_content_sort">
										<li>호텔</li>
									</div>
									<div class="section_hcam_content_txt">
										<li>수영장이 넓고 쾌적한 호텔</li>
									</div>
									<div class="section_hcam_content_rsv">
										<li>예약기간 : 2022.07.31 ~ 2022.09.30</li>
									</div>
									<div class="section_hcam_content_stay">
										<li>투숙기간 : 2022.08.01 ~2022.09.30</li>
									</div>
								</ul>
							</div>
						</div>
						<div class="section_hcam_imgcontent">
							<div class="section_hcam_img">
								 <img src="image/index_hcam_camping.jpg" width="400px" height="450px" alt="">
							</div>
							<div class="section_hcam_content">
								<ul>
									<div class="section_hcam_content_name">
										<li>홍천 더파크12 글램핑</li>
									</div>
									<div class="section_hcam_content_sort">
										<li>캠핑</li>
									</div>
									<div class="section_hcam_content_txt">
										<li>서울에서 가까운 캠핑장-강일IC에서 59km
									</div>
									<div class="section_hcam_content_rsv">
										<li>예약기간 : 2022.07.31 ~ 2022.08.31</li>
									</div>
									<div class="section_hcam_content_stay">
										<li>투숙기간 : 2022.08.01 ~2022.09.31</li>
									</div>
								</ul>
							</div>
						</div>
						<div class="section_hcam_imgcontent">
							<div class="section_hcam_img">
								 <img src="image/index_hcam_activity.jpg" width="400px" height="450px" alt="">
							</div>
							<div class="section_hcam_content">
								<ul>
									<div class="section_hcam_content_name">
										<li>영월 동강 가자래프팅</li>
									</div>
									<div class="section_hcam_content_sort">
										<li>엑티비티</li>
									</div>
									<div class="section_hcam_content_txt">
										<li>재방문률 70% 안전한 래프팅 친절한 강사진</li>
									</div>
									<div class="section_hcam_content_rsv">
										<li>예약기간 : 2022.07.31 ~ 2022.08.25</li>
									</div>
									<div class="section_hcam_content_stay">
										<li>할인기간 : 2022.08.01 ~2022.09.25</li>
									</div>
								</ul>
							</div>
						</div>
						<div class="section_hcam_imgcontent">
							<div class="section_hcam_img">
								 <img src="image/index_hcam_market.jpg" width="400px" height="450px" alt="">
							</div>
							<div class="section_hcam_content">
								<ul>
									<div class="section_hcam_content_name">
										<li>횡성축산농협 하나로마트</li>
									</div>
									<div class="section_hcam_content_sort">
										<li>마켓</li>
									</div>
									<div class="section_hcam_content_txt">
										<li>한우하면 횡성! 횡성에서 꼭 들르는 그곳!</li>
									</div>
									<div class="section_hcam_content_rsv">
										<li>예약기간 : 2022.07.31 ~ 2022.08.31</li>
									</div>
									<div class="section_hcam_content_stay">
										<li>할인기간 : 2022.08.01 ~2022.08.31</li>
									</div>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
	</div>
	
	<!-- footer -->
	<jsp:include page="include/HCAM_footer.jsp"/>
	
	<%
		commonDao.dbClose();
	%>

	<script type="text/javascript">
		//Get the button
		var mybutton = document.getElementById("myBtn");			// Top 버튼
		var searchCon = document.getElementById("search_content");	// Top Searching 버튼

		// When the user scrolls down 20px from the top of the document, show the button
		window.onscroll = function() {scrollFunction()};

		function scrollFunction() {
			if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
				mybutton.style.display = "block";
			} else {
				mybutton.style.display = "none";
			}

			if (document.body.scrollTop > 800 || document.documentElement.scrollTop > 800) {
				searchCon.style.display = "block";
			} else {
				searchCon.style.display = "none";
			}
		}

		// When the user clicks on the button, scroll to the top of the document
		function topFunction() {
		  document.body.scrollTop = 0;
		  document.documentElement.scrollTop = 0;
		}
		
		/* 달력 날짜 선택 */
		datePickerSet($("#top_chkIn"), $("#top_chkOut"), true); 			// 상단바 날짜 검색. 다중은 시작하는 달력 먼저, 끝달력 2번째
		datePickerSet($("#main_htl_chkIn"), $("#main_htl_chkOut"), true); 	// 호텔메인 날짜 검색. 다중은 시작하는 달력 먼저, 끝달력 2번째
		/*
		    * 달력 생성기
		    * @param sDate 파라미터만 넣으면 1개짜리 달력 생성
		    * @example   datePickerSet($("#datepicker"));
		    * 
		    * 
		    * @param sDate, 
		    * @param eDate 2개 넣으면 연결달력 생성되어 서로의 날짜를 넘어가지 않음
		    * @example   datePickerSet($("#datepicker1"), $("#datepicker2"));
		*/
		function datePickerSet(sDate, eDate, flag) {
	
		    //시작 ~ 종료 2개 짜리 달력 datepicker	
		    if (!isValidStr(sDate) && !isValidStr(eDate) && sDate.length > 0 && eDate.length > 0) {
		        var sDay = sDate.val();
		        var eDay = eDate.val();
	
		        if (flag && !isValidStr(sDay) && !isValidStr(eDay)) { //처음 입력 날짜 설정, update...			
		            var sdp = sDate.datepicker().data("datepicker");
		            sdp.selectDate(new Date(sDay.replace(/-/g, "/")));  //익스에서는 그냥 new Date하면 -을 인식못함 replace필요
	
		            var edp = eDate.datepicker().data("datepicker");
		            edp.selectDate(new Date(eDay.replace(/-/g, "/")));  //익스에서는 그냥 new Date하면 -을 인식못함 replace필요
		        }
	
		        /* 쟁구리가 고친곳임 (오늘일자 선택불가, 체크아웃일자는 체크인일자 다음날부터  선택가능하도록 고침) */
		        var now_utc = Date.now() 	// 지금 날짜를 밀리초로
				// getTimezoneOffset()은 현재 시간과의 차이를 분 단위로 반환
				var timeOff = new Date().getTimezoneOffset()*60000; // 분단위를 밀리초로 변환
				var today = new Date(now_utc-timeOff).toISOString().split("T")[0];
				// 체크아웃일자는 체크인일자 다음날로 선택가능하도록
		        var endDate = new Date(sDay.replace(/-/g, "/"));
		        endDate.setDate(endDate.getDate() + 1);
		        var fmt_endDate = new Date(endDate-timeOff).toISOString().split("T")[0];
				
				// 오늘일자 이전 선택 불가하도록
	            sDate.datepicker({
	            	minDate: new Date(today.replace(/-/g, "/"))
	            });
		        sDate.datepicker({
		            language: 'ko',
		            autoClose: true,
		            onSelect: function () {
		                datePickerSet(sDate, eDate);
		            }
		        });
	
		        //종료일자 세팅하기 날짜가 없는경우엔 제한을 걸지 않음
		        if (!isValidStr(sDay)) {
		            eDate.datepicker({
		                minDate: new Date(fmt_endDate.replace(/-/g, "/"))
		            });
		        }
		        eDate.datepicker({
		            language: 'ko',
		            autoClose: true,
		            onSelect: function () {
		                datePickerSet(sDate, eDate);
		            }
		        });
	
		        //한개짜리 달력 datepicker
		    } else if (!isValidStr(sDate)) {
		        var sDay = sDate.val();
		        if (flag && !isValidStr(sDay)) { //처음 입력 날짜 설정, update...			
		            var sdp = sDate.datepicker().data("datepicker");
		            sdp.selectDate(new Date(sDay.replace(/-/g, "/"))); //익스에서는 그냥 new Date하면 -을 인식못함 replace필요
		        }
	
		        sDate.datepicker({
		            language: 'ko',
		            autoClose: true
		        });
		    }
	
		    function isValidStr(str) {
		        if (str == null || str == undefined || str == "")
		            return true;
		        else
		            return false;
		    }
		}
	</script>
</body>
</html>