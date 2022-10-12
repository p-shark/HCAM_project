package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

import impl.MarketImpl;
import impl.MyPageBookingImpl;
import impl.MyPageMainImpl;
import impl.MyPageMemberImpl;
import impl.MyPagePointImpl;
import impl.RentAcarBookingImpl;
import impl.RentAcarBookingSuccessImpl;
import impl.RentAcarImpl;
import impl.RentAcarPopupImpl;
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
				inter = RentAcarImpl.instance();
				viewName = inter.showData(request, response);
				viewName = "view/"+viewName;
				request.getRequestDispatcher(viewName).forward(request, response);
			}
			else if(command.equals("carDetailPopup")){
				inter = RentAcarPopupImpl.instance();
				viewName = inter.showData(request, response);
				viewName = "view/"+viewName;
				request.getRequestDispatcher(viewName).forward(request, response);
			}
			else if(command.equals("carBooking")){
				inter = RentAcarBookingImpl.instance();
				viewName = inter.showData(request, response);
				viewName = "view/"+viewName;
				request.getRequestDispatcher(viewName).forward(request, response);
			}
			else if(command.equals("carBookingSuccess")){
				inter = RentAcarBookingSuccessImpl.instance();
				viewName = inter.showData(request, response);
				viewName = "view/"+viewName;
				request.getRequestDispatcher(viewName).forward(request, response);
			}
			else if(command.equals("MarketMain")){
				inter = MarketImpl.instance();
				viewName = inter.showData(request, response);
				viewName = "view/"+viewName;
				request.getRequestDispatcher(viewName).forward(request, response);
			}
			else if(command.equals("mypageMain")) {
				/*
				// 이걸로 쓰면 안 됨! view가 엉망으로 얽혀서 페이지 못 찾아감
				viewName = "view/HCAM_mypageMain.jsp";
				response.sendRedirect(viewName);
				*/
				inter = MyPageMainImpl.instance();
				viewName = inter.showData(request, response);
				viewName = "view/"+viewName;
				request.getRequestDispatcher(viewName).forward(request, response);
			}
			else if(command.equals("mpBooking")){
				inter = MyPageBookingImpl.instance();
				viewName = inter.showData(request, response);
				viewName = "view/"+viewName;
				request.getRequestDispatcher(viewName).forward(request, response);
			}
			else if(command.equals("mpPoint")){
				inter = MyPagePointImpl.instance();
				viewName = inter.showData(request, response);
				viewName = "view/"+viewName;
				request.getRequestDispatcher(viewName).forward(request, response);
			}
			else if(command.equals("mpMember")){
				inter = MyPageMemberImpl.instance();
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



