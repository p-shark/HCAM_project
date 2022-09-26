package vo;

import java.sql.Date;

public class NoticeBoardDTO {
	private int ntc_no;
	private String ntc_ctgry;
	private String ntc_title;
	private String ntc_content;
	private String ntc_date;
	
	public int getNtc_no() {
		return ntc_no;
	}
	public void setNtc_no(int ntc_no) {
		this.ntc_no = ntc_no;
	}
	public String getNtc_ctgry() {
		return ntc_ctgry;
	}
	public void setNtc_ctgry(String ntc_ctgry) {
		this.ntc_ctgry = ntc_ctgry;
	}
	public String getNtc_title() {
		return ntc_title;
	}
	public void setNtc_title(String ntc_title) {
		this.ntc_title = ntc_title;
	}
	public String getNtc_content() {
		return ntc_content;
	}
	public void setNtc_content(String ntc_content) {
		this.ntc_content = ntc_content;
	}
	public String getNtc_date() {
		return ntc_date;
	}
	public void setNtc_date(String ntc_date) {
		this.ntc_date = ntc_date;
	}
}

	