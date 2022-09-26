package vo;

public class ShbCommentDTO {
	private int sbc_no;				// 댓글pk
	private int shb_no;				// 게시글번호
	private int mem_no;				// 댓글사람
	private int sbc_RE_GRP;			// 댓글그룹번호
	private int sbc_RE_LEV;			// 댓글 level 혹은 depth
	private int sbc_RE_SEQ;			// sbc_RE_SEQ
	private int sbc_RE_SUPER;		// 상위 댓글No
	private String sbc_content;		// 댓글 내용
	private int sbc_useYN;			// 사용여부(1:존재/0:삭제)
	private String sbc_date;		// 작성일
	
	public void setSbc_no(int sbc_no) {
		this.sbc_no = sbc_no;
	}
	public void setShb_no(int shb_no) {
		this.shb_no = shb_no;
	}
	public void setMem_no(int mem_no) {
		this.mem_no = mem_no;
	}
	public void setSbc_RE_GRP(int sbc_RE_GRP) {
		this.sbc_RE_GRP = sbc_RE_GRP;
	}
	public void setSbc_RE_LEV(int sbc_RE_LEV) {
		this.sbc_RE_LEV = sbc_RE_LEV;
	}
	public void setSbc_RE_SEQ(int sbc_RE_SEQ) {
		this.sbc_RE_SEQ = sbc_RE_SEQ;
	}
	public void setSbc_RE_SUPER(int sbc_RE_SUPER) {
		this.sbc_RE_SUPER = sbc_RE_SUPER;
	}
	public void setSbc_content(String sbc_content) {
		this.sbc_content = sbc_content;
	}
	public void setSbc_useYN(int sbc_useYN) {
		this.sbc_useYN = sbc_useYN;
	}
	public void setSbc_date(String sbc_date) {
		this.sbc_date = sbc_date;
	}
	
	public int getSbc_no() {
		return sbc_no;
	}
	public int getShb_no() {
		return shb_no;
	}
	public int getMem_no() {
		return mem_no;
	}
	public int getSbc_RE_GRP() {
		return sbc_RE_GRP;
	}
	public int getSbc_RE_LEV() {
		return sbc_RE_LEV;
	}
	public int getSbc_RE_SEQ() {
		return sbc_RE_SEQ;
	}
	public int getSbc_RE_SUPER() {
		return sbc_RE_SUPER;
	}
	public String getSbc_content() {
		return sbc_content;
	}
	public int getSbc_useYN() {
		return sbc_useYN;
	}
	public String getSbc_date() {
		return sbc_date;
	}
	
}
