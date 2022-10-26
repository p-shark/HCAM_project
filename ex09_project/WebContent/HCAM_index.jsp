<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
 	<script src="https://kit.fontawesome.com/ae515d5c73.js" crossorigin="anonymous"></script>
	<title></title>
	<style type="text/css">
		body {
			font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
			margin: 0;
			padding: 0;
			font-size: 10pt;
		}
		ul {
			margin: 0;
			padding: 0;	
			list-style-type: none;
		}

		/* header */
		#index_header {
			margin-top: 10px;
			height: 90px;
			text-align: center;
		}
			#index_header div {
				display: inline-block;
				line-height: 90px;
			}
			/* 메인페이지 버튼 */
			#btn_main {
				position: absolute;
				margin-top: 25px;
				height: 3em;
		  		width: 11em;
				right: 8%;
			}
				#btn_main a {
					position: absolute;
					top: 0;
					left: 0;
					right: 0;
					bottom: 0;
					margin: auto;
					text-decoration: none;
					cursor: pointer;
					border: 1px solid #EE3769;
					border-radius: 8px;
					height: 2.8em;
					width: 10em;
					padding: 0;
					outline: none;
					overflow: hidden;
					color: #EE3769;
					transition: color 0.3s 0.1s ease-out;
					text-align: center;
					line-height: 300%;
				}
				#btn_main a::before {
					position: absolute;
					top: 0;
					left: 0;
					right: 0;
					bottom: 0;
					margin: auto;
					content: "";
					border-radius: 50%;
					display: block;
					width: 20em;
					height: 20em;
					line-height: 20em;
					left: -5em;
					text-align: center;
					transition: box-shadow 0.5s ease-out;
					z-index: -1;
				}
				#btn_main a:hover {
					color: white;
				}
				#btn_main a:hover::before {
					box-shadow: inset 0 0 0 10em #ee3769;
				}

		/* navigation */
		nav {
			position: relative;
			margin-top: 10px;
			width: 100%;
			height: 25px;
		}
			#nav_div {
				display: inline-block;
				height: 20px;
				text-align: center;
			}
				#nav_ul {
					position: absolute;
					display: inline-block;
					width: 100%;
					text-align: center;
				}
					#nav_ul div{
						float: left;
						width: 25%;
						height: 20px;
					}
						#nav_ul div li{
							letter-spacing: 0.5px;
							font-size: 15pt;
							line-height: 20px;
						}
		/* Navigation Image 내 text */
		#panel_inner {
			position: absolute;
			display: block;
			margin-top: 240px;
			width: 100%;
			height: 100px;
			z-index: 2;
		}
			#panel_inner_div {
				display: inline-block;
				height: 20px;
				text-align: center;
			}
				#panel_inner_div ul {
					position: absolute;
					display: inline-block;
					width: 100%;
					text-align: center;
				}
					#panel_inner_div ul div{
						float: left;
						width: 25%;
						height: 20px;
					}
						#panel_inner_div ul div li{
							letter-spacing: 0.5px;
							font-size: 15pt;
							line-height: 20px;
							color: white;
						}
							/*#panel_inner_div ul div li div {
								width: 100%;
							}
							#panel_inner_div ul div li div:nth-child(1){
								margin-bottom: 40px;
								font-weight: thin;
								font-size: 40pt;
							}
							#panel_inner_div ul div li div:nth-child(2){
								font-size: 12pt;
							}
							#panel_inner_div ul div li div:nth-child(3){
								font-size: 12pt;
							}*/


							#panel_inner_div ul div li span {
								font-size: 12pt;
							}
							#panel_inner_div ul div li span:nth-child(1){
								display: inline-block;
								margin-bottom: 30pt;
								font-weight: thin;
								font-size: 40pt;
							}
							

		/* Navigation Image */
		.panels {
			overflow: hidden;
			display: flex;
			position: relative;
			z-index: 1;
		}
		.panel {
			flex: 1;
			cursor: pointer;
			background-position: center;
			background-size: cover;
		}
		.panel__content {
			width: 100%;
			height: 102%;
			overflow: hidden;
			cursor: pointer;
			background: inherit;
		}
		.panel:before,
		.panel__content:before {
			content: ' ';
			display: block;
			width: 100%;
			height: 100%;
		}
		.panel:before {
			background: rgba(255, 255, 255, 0.3);
			position: relative;
			z-index: 99;
			opacity: 0;
			transition: opacity 0.3s linear;
		}
		/* The non-CSS Var hover state */
		.panel:hover:before,
		.panel:focus:before {
			opacity: 1;
		}

		.panel:hover .panel__content,
		.panel:focus .panel__content {
			position: absolute;
			top: -1%;
			left: 0;
			z-index: 98;
		}
		/* If CSS Vars are supported... */
		@supports ( (--panel-support: 0) ) {
		.panel {
			--i: 0;
			--percent: calc( ((var(--i) - 1) / var(--items)) * 100 );
			background-color: 
		}
		  /* 
		  A simple LESS loop to set up the CSS vars.

		  Output will be something like
		  .panels--1 { --items: 1; }
		  .panth:nth-child(1) { --i: 1; }
		  .panels--2 { --items: 2; }
		  .panth:nth-child(2) { --i: 2; }

		  ..up to the total number provided.
		  */
		.panel:nth-last-child(n + 1),
		.panel:nth-last-child(n + 1) ~ .panel {
			--items: 1;
		}
		.panel:nth-child( 1) {
			--i: 1;
		}
		.panel:nth-last-child(n + 2),
		.panel:nth-last-child(n + 2) ~ .panel {
			--items: 2;
		}
		.panel:nth-child( 2) {
			--i: 2;
		}
		.panel:nth-last-child(n + 3),
		.panel:nth-last-child(n + 3) ~ .panel {
			--items: 3;
		}
		.panel:nth-child( 3) {
			--i: 3;
		}
		.panel:nth-last-child(n + 4),
		.panel:nth-last-child(n + 4) ~ .panel {
			--items: 4;
		}
		.panel:nth-child( 4) {
			--i: 4;
		}
		.panel__content {
			position: absolute;
			top: -1%;
			left: 0%;
			z-index: auto;
			transform: translateX(calc( var(--percent) * 1% ));
		}

		.panel__content:before {
			background: inherit;
			transform: translateX(-50%) translateX(calc(100% / var(--items) * 0.5 ));
		}
		.panel__content,
		.panel__content:before {
			transition: transform 0.4s cubic-bezier(0.44, 0, 0, 1);
		}

		  /* When there's an active hover on the container. This will apply to all panels in the container, unless overridden */
		.panels:hover .panel__content {
			z-index: auto;
			transform: translateX(0%);
		}
		/* Panels after the hovered panel */
			.panel:hover ~ .panel .panel__content {
			transform: translateX(100%);
		}
		/* The active panel */
		.panel:hover .panel__content,
		.panel:focus .panel__content {
			transform: translateX(0%);
		}
		.panel:hover .panel__content:before,
		.panel:focus .panel__content:before {
			transform: translateX(0%) scale(1);		/* 원래 scale(1); 이거 였는데 1로 바꾸니까 zoom-in 안 됨 */
		}
		.panel:focus .panel__content,
		.panel:focus .panel__content:before {
			transition: none !important;
		}
		/* 
		//////////////////////////////////////
		STYLISTIC CHOICES
		///////////////////////////javascript:void(0)///////// 
		*/
		.panels {
			/*box-shadow: 0 0 10rem rgba(0, 0, 0, 0.6);*/
			height: 87vh;			/* zoom-in, 이미지 크기 변경 */
			margin: 0.8vh auto;
			min-height: 300px;
			max-height: 900px;		/* zoom-in, 이미지 크기 변경 */
		}
		body > .panels:first-child {
			margin: 15vh auto;
			height: 85vh;			/* zoom-in, 이미지 크기 변경 */
		}
		/* Set up the background images */
		.panel:nth-child(4) {
			background-image: url(image/index_main4-1.jpg);
		/*background-image: url( 'https://unsplash.it/1000/1000/?image=342' );*/
		}
		.panel:nth-child(3) {
			background-image: url(image/index_main3-1.jpg);
		/*background-image: url( 'https://unsplash.it/1000/1000/?image=786' );*/
		}
		.panel:nth-child(2) {
			background-image: url(image/index_main2-1.jpg);
		/*background-image: url( 'https://unsplash.it/1000/1000/?image=883' );*/
		}
		.panel:nth-child(1) {
			background-image: url(image/index_main1-1.jpg);
		/*background-image: url( 'https://unsplash.it/1000/1000/?image=760' );*/
		}

		/* 화살표 */
		#arrow_down {
			margin-top: 45px;
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
							margin-top: -5px;
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

	</style>
</head>
<body>
	<header id="index_header">
		<div id="logo">
			<h1 style="margin: 0; letter-spacing: 5px;"><font>HCAM</font></h1>
			<!-- <h1 style="margin: 0;">HCAM</h1> -->
		</div>
		<div id="btn_main">
			<a href="HCAM_main.jsp" title="Chris Ota Dribbble"><!-- <i class="fa fa-dribbble"></i> --> 메인페이지</a>
		</div>
	</header>
	<div id="panel_inner">
		<div id="panel_inner_div">
			<ul>
				<a href="HCAM_hotel_page.html">
					<div>
						<li>
							<span>Hotel</span><br>
							<span>고객을 위한</span><br>
							<span>최상의 휴식공간</span>
						</li>
					</div>
				</a>
				<a href="HCAM_camping_page.html">
					<div>
						<li>
							<span>Camping</span><br>
							<span>가족, 친구와 함께</span><br>
							<span>떠나는 힐링여행</span>
						</li>
					</div>
				</a>
				<a href="">
					<div>
						<li>
							<span>Activity</span><br>
							<span>호텔 고객을 위한</span><br>
							<span>다양한 즐길거리</span>
						</li>
					</div>
				</a>
				<a href="">
					<div>
						<li>
							<span>Market</span><br>
							<span>캠핑 고객을 위한</span><br>
							<span>편리한 배송서비스</span>
						</li>
					</div>
				</a>
			</ul>
		</div>
	</div>
	<div class="panels">
		<a href="HCAM_hotel_page.html" class="panel">		<!-- 기존 -->
			<div class="panel__content"></div>				<!-- hover,focus 시 -->
		</a>
		<a href="HCAM_camping_page.html" class="panel">
			<div class="panel__content"></div>
		</a>
		<a href="javascript:void(0)" class="panel">
			<div class="panel__content"></div>
		</a>
		<a href="javascript:void(0)" class="panel">
			<div class="panel__content"></div>
		</a>
	</div>
	<!-- <div id="arrow_down">
		<div>
			<h1>See what's below.</h1>
		</div>
		<div class="arrow bounce">
			<i class="fa fa-angle-down fa-5x" aria-hidden="true"></i>
		</div>
	</div> -->
</body>
</html>