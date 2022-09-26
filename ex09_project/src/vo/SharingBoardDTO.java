package vo;

public class SharingBoardDTO {
	private int shb_no;
	private String shb_ctgry;
	private int mem_no;
	private String shb_title;
	private String shb_content;
	private int shb_cnt;
	private int shb_likeCnt;
	private String shb_date;
	private int commentCnt;
	
	public void setShb_no(int shb_no) {
		this.shb_no = shb_no;
	}
	public void setShb_ctgry(String shb_ctgry) {
		this.shb_ctgry = shb_ctgry;
	}
	public void setMem_no(int mem_no) {
		this.mem_no = mem_no;
	}
	public void setShb_title(String shb_title) {
		this.shb_title = shb_title;
	}
	public void setShb_content(String shb_content) {
		this.shb_content = shb_content;
	}
	public void setShb_cnt(int shb_cnt) {
		this.shb_cnt = shb_cnt;
	}
	public void setShb_likeCnt(int shb_likeCnt) {
		this.shb_likeCnt = shb_likeCnt;
	}
	public void setShb_date(String shb_date) {
		this.shb_date = shb_date;
	}
	public void setCommentCnt(int commentCnt) {
		this.commentCnt = commentCnt;
	}
	
	public int getShb_no() {
		return shb_no;
	}
	public String getShb_ctgry() {
		return shb_ctgry;
	}
	public int getMem_no() {
		return mem_no;
	}
	public String getShb_title() {
		return shb_title;
	}
	public String getShb_content() {
		return shb_content;
	}
	public int getShb_cnt() {
		return shb_cnt;
	}
	public int getShb_likeCnt() {
		return shb_likeCnt;
	}
	public String getShb_date() {
		return shb_date;
	}
	public int getCommentCnt() {
		return commentCnt;
	}
	
}
