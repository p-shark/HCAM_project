package action;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CommonDAO;
import vo.ActionForward;

public class PointDepositAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		int pnt_no = Integer.parseInt(request.getParameter("pnt_no"));
		int phs_historyAmt = Integer.parseInt(request.getParameter("phs_historyAmt"));
		
		// 포인트 이용내역
		String phs_comment = "포인트 충전: " + phs_historyAmt;
		
		CommonDAO commonDao = new CommonDAO();
		
		/* 포인트 충전/적립/사용 */
		commonDao.updatePoint(pnt_no, "PNT01001", phs_historyAmt, phs_comment);
		
		commonDao.dbClose();
		
		ActionForward forward = null;
		return forward;
	}

}
