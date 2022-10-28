<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="model.MgrpageModel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MgrpageModel model = MgrpageModel.instance();

	String kubun = request.getParameter("kubun");
	
	JSONArray jsnArr = new JSONArray();			// 보낼 json 데이터
	JSONArray colNameArray = new JSONArray(); 	// 컬럼 타이틀 설정
	
	ArrayList<Map<String, String>> memberData = new ArrayList<Map<String, String>>();
	
	if("age".equals(kubun)) {
		/* 회원의 연령대 */
		memberData = (ArrayList<Map<String, String>>) model.selectMemberAgeData();
	}
	else {
		/* 회원의 성별 */
		memberData = (ArrayList<Map<String, String>>) model.selectMemberGenderData();
	}
	
	// 데이터 set
	for(int i=0; i<memberData.size(); i++) {
		JSONArray paramArr = new JSONArray();
		
		paramArr.add(memberData.get(i).get("kubun"));
		paramArr.add(memberData.get(i).get("cnt"));
		
		jsnArr.add(paramArr);
	}
	
	//System.out.println(jsnArr);
%>
<%=jsnArr %>