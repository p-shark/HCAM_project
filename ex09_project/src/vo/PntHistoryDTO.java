package vo;

public class PntHistoryDTO {
	private int phs_no;
	private int pnt_no;
    private String phs_kubun;		// 포인트 적립구분(PNT01 / 충전,적립,사용 etc)
    private int phs_historyAmt;		// 포인트 이용금액
    private String phs_comment;		// 포인트 이용 상세내역(마켓 구매, 호텔 예약 etc)
    private String phs_date;
    
	public void setPhs_no(int phs_no) {
		this.phs_no = phs_no;
	}
	public void setPnt_no(int pnt_no) {
		this.pnt_no = pnt_no;
	}
	public void setPhs_kubun(String phs_kubun) {
		this.phs_kubun = phs_kubun;
	}
	public void setPhs_historyAmt(int phs_historyAmt) {
		this.phs_historyAmt = phs_historyAmt;
	}
	public void setPhs_comment(String phs_comment) {
		this.phs_comment = phs_comment;
	}
	public void setPhs_date(String phs_date) {
		this.phs_date = phs_date;
	}
	
	public int getPhs_no() {
		return phs_no;
	}
	public int getPnt_no() {
		return pnt_no;
	}
	public String getPhs_kubun() {
		return phs_kubun;
	}
	public int getPhs_historyAmt() {
		return phs_historyAmt;
	}
	public String getPhs_comment() {
		return phs_comment;
	}
	public String getPhs_date() {
		return phs_date;
	}
    
}
