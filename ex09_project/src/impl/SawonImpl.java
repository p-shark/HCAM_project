package impl;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

import controller.CommandInter;
import model.SawonModel;
import vo.HcamMemDTO;

public class SawonImpl implements CommandInter{

	static SawonImpl impl = new SawonImpl();

	public static SawonImpl instance(){
		return impl;
	}
	
	public String showData(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SawonModel model = SawonModel.instance();
		ArrayList<HcamMemDTO> list = (ArrayList<HcamMemDTO>) model.selectSawon();
		request.setAttribute("data", list);
		return "sawon_list.jsp";
	}
}