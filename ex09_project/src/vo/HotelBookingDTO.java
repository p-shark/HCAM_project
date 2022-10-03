package vo;

public class HotelBookingDTO {
	private int htb_no;
	private int htl_no;
	private int hrm_no;
	private int mem_no;
	private String htb_rlpName;
	private String htb_rlpEmail;
	private String htb_rlpNation;
	private String htb_rlpPhone;
	private String htb_chkIn;
	private String htb_chkOut;
	private int htb_stayTerm;		// 머무는 기간
	private int htb_brkfCnt;		// 조식 주문 총 수량
	private int htb_brkfPrice;		// 조식 총 합계
	private int htb_rlpRoomPrice;	// 1박당 실제 결제한 객실 가격 (추후, 이 가격 * 기간(2박) 해서 금액 보여줘야함)
	private int htb_totalPrice;		// 총 합계
	private String htb_date;
	
	public void setHtb_no(int htb_no) {
		this.htb_no = htb_no;
	}
	public void setHtl_no(int htl_no) {
		this.htl_no = htl_no;
	}
	public void setHrm_no(int hrm_no) {
		this.hrm_no = hrm_no;
	}
	public void setMem_no(int mem_no) {
		this.mem_no = mem_no;
	}
	public void setHtb_rlpName(String htb_rlpName) {
		this.htb_rlpName = htb_rlpName;
	}
	public void setHtb_rlpEmail(String htb_rlpEmail) {
		this.htb_rlpEmail = htb_rlpEmail;
	}
	public void setHtb_rlpNation(String htb_rlpNation) {
		this.htb_rlpNation = htb_rlpNation;
	}
	public void setHtb_rlpPhone(String htb_rlpPhone) {
		this.htb_rlpPhone = htb_rlpPhone;
	}
	public void setHtb_chkIn(String htb_chkIn) {
		this.htb_chkIn = htb_chkIn;
	}
	public void setHtb_chkOut(String htb_chkOut) {
		this.htb_chkOut = htb_chkOut;
	}
	public void setHtb_stayTerm(int htb_stayTerm) {
		this.htb_stayTerm = htb_stayTerm;
	}
	public void setHtb_brkfCnt(int htb_brkfCnt) {
		this.htb_brkfCnt = htb_brkfCnt;
	}
	public void setHtb_brkfPrice(int htb_brkfPrice) {
		this.htb_brkfPrice = htb_brkfPrice;
	}
	public void setHtb_rlpRoomPrice(int htb_rlpRoomPrice) {
		this.htb_rlpRoomPrice = htb_rlpRoomPrice;
	}
	public void setHtb_totalPrice(int htb_totalPrice) {
		this.htb_totalPrice = htb_totalPrice;
	}
	public void setHtb_date(String htb_date) {
		this.htb_date = htb_date;
	}
	
	public int getHtb_no() {
		return htb_no;
	}
	public int getHtl_no() {
		return htl_no;
	}
	public int getHrm_no() {
		return hrm_no;
	}
	public int getMem_no() {
		return mem_no;
	}
	public String getHtb_rlpName() {
		return htb_rlpName;
	}
	public String getHtb_rlpEmail() {
		return htb_rlpEmail;
	}
	public String getHtb_rlpNation() {
		return htb_rlpNation;
	}
	public String getHtb_rlpPhone() {
		return htb_rlpPhone;
	}
	public String getHtb_chkIn() {
		return htb_chkIn;
	}
	public String getHtb_chkOut() {
		return htb_chkOut;
	}
	public int getHtb_stayTerm() {
		return htb_stayTerm;
	}
	public int getHtb_brkfCnt() {
		return htb_brkfCnt;
	}
	public int getHtb_brkfPrice() {
		return htb_brkfPrice;
	}
	public int getHtb_rlpRoomPrice() {
		return htb_rlpRoomPrice;
	}
	public int getHtb_totalPrice() {
		return htb_totalPrice;
	}
	public String getHtb_date() {
		return htb_date;
	}
	
}
