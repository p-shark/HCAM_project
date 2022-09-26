package vo;

import java.sql.Date;

public class QuestionBoardDTO {
	private int qbd_no;
	private String qbd_ctgry;
	private int mem_no;
	private String qbd_title;
	private String qbd_content;
	private String qbd_date;
	private String ansState;
	
	public int getQbd_no() {
		return qbd_no;
	}
	public void setQbd_no(int qbd_no) {
		this.qbd_no = qbd_no;
	}
	public String getQbd_ctgry() {
		return qbd_ctgry;
	}
	public void setQbd_ctgry(String qbd_ctgry) {
		this.qbd_ctgry = qbd_ctgry;
	}
	public int getMem_no() {
		return mem_no;
	}
	public void setMem_no(int mem_no) {
		this.mem_no = mem_no;
	}
	public String getQbd_title() {
		return qbd_title;
	}
	public void setQbd_title(String qbd_title) {
		this.qbd_title = qbd_title;
	}
	public String getQbd_content() {
		return qbd_content;
	}
	public void setQbd_content(String qbd_content) {
		this.qbd_content = qbd_content;
	}
	public String getQbd_date() {
		return qbd_date;
	}
	public void setQbd_date(String qbd_date) {
		this.qbd_date = qbd_date;
	}
	public String getAnsState() {
		return ansState;
	}
	public void setAnsState(String ansState) {
		this.ansState = ansState;
	}
}
