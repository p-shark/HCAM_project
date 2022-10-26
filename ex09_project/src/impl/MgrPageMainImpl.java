package impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

import controller.CommandInter;
import model.MypageModel;

public class MgrPageMainImpl implements CommandInter{

	static MgrPageMainImpl impl = new MgrPageMainImpl();

	public static MgrPageMainImpl instance(){
		return impl;
	}
	
	public String showData(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		return "HCAM_mgrpageMain.jsp";
	}
}