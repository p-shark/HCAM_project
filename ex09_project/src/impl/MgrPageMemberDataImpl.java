package impl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.CommandInter;

public class MgrPageMemberDataImpl implements CommandInter{

	static MgrPageMemberDataImpl impl = new MgrPageMemberDataImpl();

	public static MgrPageMemberDataImpl instance(){
		return impl;
	}
	
	public String showData(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		return "HCAM_mgrpageMemData.jsp";
	}
}