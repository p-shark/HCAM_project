package vo;

public class AnswerBoardDTO {
	private int abd_no;
	private int qbd_no;
	private String abd_content;
	private String abd_date;
	public int getAbd_no() {
		return abd_no;
	}
	public void setAbd_no(int abd_no) {
		this.abd_no = abd_no;
	}
	public int getQbd_no() {
		return qbd_no;
	}
	public void setQbd_no(int qbd_no) {
		this.qbd_no = qbd_no;
	}
	public String getAbd_content() {
		return abd_content;
	}
	public void setAbd_content(String abd_content) {
		this.abd_content = abd_content;
	}
	public String getAbd_date() {
		return abd_date;
	}
	public void setAbd_date(String abd_date) {
		this.abd_date = abd_date;
	}
}
