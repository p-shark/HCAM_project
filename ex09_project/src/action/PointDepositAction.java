package action;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CommonDAO;
import vo.ActionForward;
import vo.PntHistoryDTO;

public class PointDepositAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		int pnt_no = Integer.parseInt(request.getParameter("pnt_no"));
		int phs_historyAmt = Integer.parseInt(request.getParameter("phs_historyAmt"));
		
		// 포인트 이용내역
		String phs_comment = "포인트 충전: " + phs_historyAmt;
		
		CommonDAO commonDao = new CommonDAO();
		
		PntHistoryDTO pntHistory = new PntHistoryDTO();
		
		/* 포인트 차감 */
		pntHistory.setPnt_no(pnt_no);
		pntHistory.setPhs_kind("PNT01001");
		pntHistory.setPhs_historyAmt(phs_historyAmt);
		pntHistory.setPhs_comment(phs_comment);
		
		/* 포인트 충전/적립/사용 */
		commonDao.updatePoint(pntHistory);
		
		commonDao.dbClose();
		
		ActionForward forward = null;
		return forward;
	}

}
