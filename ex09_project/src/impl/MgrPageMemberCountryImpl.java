package impl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.CommandInter;

public class MgrPageMemberCountryImpl implements CommandInter{

	static MgrPageMemberCountryImpl impl = new MgrPageMemberCountryImpl();

	public static MgrPageMemberCountryImpl instance(){
		return impl;
	}
	
	public String showData(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		return "HCAM_mgrpageMemCountry.jsp";
	}
}