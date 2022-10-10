<%@page import="vo.RentACarDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int booking_cnt = (Integer) request.getAttribute("booking_cnt");

	/* 렌터카 전체 select */
	ArrayList<RentACarDTO> car = (ArrayList<RentACarDTO>) request.getAttribute("car");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
<!-- jquery -->
<script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script>
<title>Insert title here</title>
<style type="text/css">
	@font-face {
	    font-family: 'Pretendard-Regular';
	    src: url('https://cdn.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
	    font-weight: 100;
	    font-style: normal;
	}
	#div_title {
		width: 100%;
		height: 50px;
		text-align: center;
		line-height: 45px;
		color: var(--color-white);
		background-color: #20274D;
	}
		
	#div_content {
		margin-bottom: 30px;
		width: 800px;
		height: 1px;
	}
		#div_content #div_background {
			margin-top: 50px;
			width: 800px;
			height: 1px;
			text-align: center;
		}
			#div_background img {
				filter: invert(100%) sepia(0%) saturate(0%) hue-rotate(21deg) brightness(111%) contrast(101%);
			}
	#div_selectBtn {
		margin: 0 auto;
		width: 800px;
	}
		#div_selectBtn a {
			float: right;
			margin-right: 60px;
			padding: 20px 60px;;
			border-radius: 10px;
			color: var(--color-white);
			background-color: var(--color-blue);
			font-size: 14pt;
			font-family: 'Pretendard-Regular';
		}
</style>
</head>
<script type="text/javascript">
	/* 차량 선택 시 opener에 돌려주기 */
	function fn_selectCar() {
		var car_no = $("input[name=car_no]").val();
		
		opener.location.href = "javascript:fn_chgCheckDisplay(" + car_no + ");";
		window.close();
	}
</script>
<body>
	<input type="hidden" name="car_no" id="car_no" value="<%=car.get(0).getCar_no() %>">
	<input type="hidden" name="threeGLTF" id="threeGLTF" value="<%=car.get(0).getCar_threeGLTF() %>">
	<input type="hidden" name="threeFov" id="threeFov" value="<%=car.get(0).getCar_threeFov() %>">
	<input type="hidden" name="threeFar" id="threeFar" value="<%=car.get(0).getCar_threeFar() %>">
	<input type="hidden" name="threeX" id="threeX" value="<%=car.get(0).getCar_threeX() %>">
	<input type="hidden" name="threeY" id="threeY" value="<%=car.get(0).getCar_threeY() %>">
	<input type="hidden" name="threeZ" id="threeZ" value="<%=car.get(0).getCar_threeZ() %>">
	
	<div id="div_title">렌트 전 차량을 360도 회전하여 살펴보세요</div>
	<div id="div_content">
		<div id="div_background">
			<img alt="" src="image/car/bg_around_view.png">
		</div>
	</div>
	<canvas id="canvas" width="800px" height="500px"></canvas>
	<% if(booking_cnt == 0) { %>
		<div id="div_selectBtn">
			<a onclick="fn_selectCar();">선택</a>
		</div>
	<% } %>

	<!-- CDN import -->
	<script type="importmap">
		{
	  		"imports": {
	      	"three": "https://unpkg.com/three@0.138.3/build/three.module.js",
	      	"GLTFLoader":
	      	"https://unpkg.com/three@0.141.0/examples/jsm/loaders/GLTFLoader.js",
			"OrbitControls":
			"https://unpkg.com/three@0.141.0/examples/jsm/controls/OrbitControls.js"
	    	}
	  	}
	</script>
	
	<script type="module">
		import {GLTFLoader} from 'GLTFLoader';
		import {OrbitControls} from 'OrbitControls';
		import * as THREE from 'three';

		let scene = new THREE.Scene();

		let renderer = new THREE.WebGLRenderer({
			canvas : document.querySelector('#canvas'),
			antialias : true
		});

		renderer.outputEncoding = THREE.sRGBEncoding;

		var threeGLTF = document.getElementById("threeGLTF").value;
		var threeFov = parseInt(document.getElementById("threeFov").value);
		var threeFar = parseInt(document.getElementById("threeFar").value);
		var threeX = parseInt(document.getElementById("threeX").value);
		var threeY = parseInt(document.getElementById("threeY").value);
		var threeZ = parseInt(document.getElementById("threeZ").value);

		const fov = threeFov;
		const apect = 1920/1080;
		const near = 1;
		const far = threeFar;
		const x = threeX;
		const y = threeY;
		const z = threeZ;

		let camera = new THREE.PerspectiveCamera(fov, apect, near, far);
		camera.position.set(x,y,z);

		let light = new THREE.DirectionalLight(0x666666, 10);
		scene.add(light);

		scene.background = new THREE.Color('white');

		const controls = new OrbitControls(camera, renderer.domElement);

		controls.maxPolarAngle = Math.PI / 2;

		let loader = new GLTFLoader();
		loader.load(threeGLTF, function(gltf) {
			scene.add(gltf.scene);
			
			function animate() {
				requestAnimationFrame(animate)
				renderer.render(scene, camera);
			}

			animate()
		});

	</script>
</body>
</html>