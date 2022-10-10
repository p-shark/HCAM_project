package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.HotelBookingAction;
import action.HotelBookingSuccessAction;
import action.HotelListTotalAction;
import action.HotelMainBySearchingAction;
import action.HotelRoomListAction;
import action.PointDepositAction;
import action.ShareBoardByCtgryAction;
import action.ShareBoardDeleteAction;
import action.ShareBoardDetailAction;
import action.ShareBoardTotalAction;
import action.ShareBoardUpdate01Action;
import action.ShareBoardUpdate02Action;
import action.ShareBoardWriteAction;
import action.ShareCommentDeleteAction;
import action.ShareCommentPopupAction;
import action.ShareCommentPopupSaveAction;
import action.ShareCommentWriteAction;
import vo.ActionForward;

/**
 * Servlet implementation class HaFrontController
 */
@WebServlet("*.ho")
public class HaFrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public HaFrontController() {
        super();
    }
    
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		String RequestURI=request.getRequestURI();
		String contextPath=request.getContextPath();
		String command=RequestURI.substring(contextPath.length());
		ActionForward forward=null;
		Action action=null;
		System.out.println("command >>>> " + command);
		// path가 .jsp로 넘어오지 않고 .ho로 넘어오는 경우 command값에 /view가 같이 넘어와서 제거해줘야함 
		command = command.replace("/view", "");
		
		/*if(command.equals("/hotelMain.ho")){
			forward=new ActionForward();
			forward.setPath("/test02.jsp");
		}*/
		if(command.equals("/hotelMain.ho")){
			action = new HotelListTotalAction();
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		else if(command.equals("/hotelMainBySearching.ho")) {
			action = new HotelMainBySearchingAction();
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		else if(command.equals("/hotelRoom.ho")){
			action = new HotelRoomListAction();
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		else if(command.equals("/hotelBooking.ho")){
			action = new HotelBookingAction();
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		else if(command.equals("/hotelBookingSuccess.ho")){
			action = new HotelBookingSuccessAction();
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		else if(command.equals("/shareBoard.ho")) {
			
			action = new ShareBoardTotalAction();
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		else if(command.equals("/shareBoardByCtgry.ho")) {
			action = new ShareBoardByCtgryAction();
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		else if(command.equals("/shareBoardDetail.ho")){
			action = new ShareBoardDetailAction();
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		else if(command.equals("/shareBoardWrite01.ho")){
			forward=new ActionForward();
			forward.setPath("/view/HCAM_shareBoardWrite.jsp");
		}
		else if(command.equals("/shareBoardWrite02.ho")){
			action = new ShareBoardWriteAction();
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		else if(command.equals("/shareBoardUpdate01.ho")){
			action = new ShareBoardUpdate01Action();
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		else if(command.equals("/shareBoardUpdate02.ho")){
			action = new ShareBoardUpdate02Action();
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		else if(command.equals("/shareBoardDelete.ho")){
			action = new ShareBoardDeleteAction();
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		else if(command.equals("/shareCommentWrite.ho")){
			action = new ShareCommentWriteAction();
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		else if(command.equals("/shareCommentPopup.ho")){
			action = new ShareCommentPopupAction();
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		else if(command.equals("/shareCommentPopupSave.ho")){
			action = new ShareCommentPopupSaveAction();
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		else if(command.equals("/shareCommentDelete.ho")){
			action = new ShareCommentDeleteAction();
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		else if(command.equals("/pointDeposit.ho")){
			action = new PointDepositAction();
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		if(forward != null){
			
			if(forward.isRedirect()){
				response.sendRedirect(forward.getPath());
			}else{
				RequestDispatcher dispatcher=
						request.getRequestDispatcher(forward.getPath());
				dispatcher.forward(request, response);
			}
		}
		
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request,response);
	}

}
