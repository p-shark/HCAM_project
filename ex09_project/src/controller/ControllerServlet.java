package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

import impl.MarketImpl;
import impl.SawonImpl;

public class ControllerServlet extends HttpServlet{

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String command = request.getParameter("command");
		CommandInter inter = null;
		String viewName = "";
		
		try {
			if(command.equals("sawon")){
				inter = SawonImpl.instance();
				viewName = inter.showData(request, response);
				viewName = "view/"+viewName;
				request.getRequestDispatcher(viewName).forward(request, response);
			} 
			else if(command.equals("carMain")){
				viewName = "view/HCAM_rentACarMain.jsp";
				response.sendRedirect(viewName);
			}
			else if(command.equals("MarketMain")){
				inter = MarketImpl.instance();
				viewName = inter.showData(request, response);
				viewName = "view/"+viewName;
				request.getRequestDispatcher(viewName).forward(request, response);
			}
			else {
				viewName = "error.html";
				response.sendRedirect(viewName);
			}
		} catch (Exception e) {
			System.out.println(e);
		}
	}
}



