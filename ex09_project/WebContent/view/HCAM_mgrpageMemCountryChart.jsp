<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="model.MgrpageModel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int mgr_no = Integer.parseInt(request.getParameter("mgr_no")); 

	MgrpageModel model = MgrpageModel.instance();

	/* 등록된 호텔, 렌터카를 예약한 회원의 지역별 분포  */
	ArrayList<Map<String, String>> memCountry = (ArrayList<Map<String, String>>) model.selectMemberCountry(mgr_no);
	
	JSONArray jsnArr = new JSONArray();			// 보낼 json 데이터
	JSONArray colNameArray = new JSONArray(); 	// 컬럼 타이틀 설정

	// 컬럼 타이틀
	colNameArray.add("Country");
	colNameArray.add("Popularity");

	jsnArr.add(colNameArray);
	
	// 데이터 set
	for(int i=0; i<memCountry.size(); i++) {
		JSONArray paramArr = new JSONArray();
		
		paramArr.add(memCountry.get(i).get("mem_nation"));
		paramArr.add(memCountry.get(i).get("cnt"));
		
		jsnArr.add(paramArr);
	}
	
	//System.out.println(jsnArr);
%>
<%=jsnArr %>