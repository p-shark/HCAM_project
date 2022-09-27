package impl;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

import controller.CommandInter;
import model.SawonModel;
import vo.HcamMemDTO;

public class MarketImpl implements CommandInter{

	static MarketImpl impl = new MarketImpl();

	public static MarketImpl instance(){
		return impl;
	}
	
	public String showData(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SawonModel model = SawonModel.instance();
		//ArrayList<HcamMemDTO> list = (ArrayList<HcamMemDTO>) model.selectSawon();
		//request.setAttribute("data", list);
		return "HCAM_marketMain.jsp";
	}
}