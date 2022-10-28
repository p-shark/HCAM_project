<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="model.MgrpageModel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String mgr_no = request.getParameter("mgr_no"); 
	String date_kubun = request.getParameter("date_kubun"); 

	Map<String, String> param_graph = new HashMap<String, String>();
	param_graph.put("mgr_no", mgr_no);
	param_graph.put("date_kubun", date_kubun);
	
	//System.out.println("date_kubun >>> " + date_kubun);

	MgrpageModel model = MgrpageModel.instance();

	/* 일/주/월 별 호텔,렌터카 예약 건수 */
	ArrayList<Map<String, String>> peroidBooking = (ArrayList<Map<String, String>>) model.selectPeroidBooking(param_graph);
	
	JSONArray jsnArr = new JSONArray();			// 보낼 json 데이터
	JSONArray colNameArray = new JSONArray(); 	// 컬럼 타이틀 설정

	// 컬럼 타이틀
	if("day".equals(date_kubun)) {
		colNameArray.add(peroidBooking.get(0).get("booking_month"));
	}
	else {
		colNameArray.add(peroidBooking.get(0).get("booking_year"));
	}
	colNameArray.add("hotel");
	colNameArray.add("car");

	jsnArr.add(colNameArray);
	
	// 데이터 set
	for(int i=0; i<peroidBooking.size(); i++) {
		JSONArray paramArr = new JSONArray();
		
		paramArr.add(peroidBooking.get(i).get("booking_md"));
		paramArr.add(peroidBooking.get(i).get("htl_cnt"));
		paramArr.add(peroidBooking.get(i).get("car_cnt"));
		
		jsnArr.add(paramArr);
	}
	
	//System.out.println(jsnArr);
%>
<%=jsnArr %>