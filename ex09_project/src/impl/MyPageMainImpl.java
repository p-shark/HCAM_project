package impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

import controller.CommandInter;
import model.MypageModel;

public class MyPageMainImpl implements CommandInter{

	static MyPageMainImpl impl = new MyPageMainImpl();

	public static MyPageMainImpl instance(){
		return impl;
	}
	
	public String showData(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		return "HCAM_mypageMain.jsp";
	}
}