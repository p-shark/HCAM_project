package vo;

public class RacBookingDTO {
	private int cbk_no;
	private int car_no;
	private int mem_no;
    private String cbk_rlpName;
    private String cbk_rlpEmail;
    private String cbk_rlpNation;
    private String cbk_rlpPhone;
    private String cbk_chkInDate;
    private String cbk_chkOutDate;
    private String cbk_chkInTime;
    private String cbk_chkOutTime;
	private double cbk_rentTerm;		// 대여 기간
	private int cbk_rlpCarPrice;		// 1일당 실제 결제한 렌터카 가격 (추후, 이 가격 * 기간(2박) 해서 금액 보여줘야함)
	private int cbk_totalPrice;			// 총 합계
	private String cbk_date;
	
	public void setCbk_no(int cbk_no) {
		this.cbk_no = cbk_no;
	}
	public void setCar_no(int car_no) {
		this.car_no = car_no;
	}
	public void setMem_no(int mem_no) {
		this.mem_no = mem_no;
	}
	public void setCbk_rlpName(String cbk_rlpName) {
		this.cbk_rlpName = cbk_rlpName;
	}
	public void setCbk_rlpEmail(String cbk_rlpEmail) {
		this.cbk_rlpEmail = cbk_rlpEmail;
	}
	public void setCbk_rlpNation(String cbk_rlpNation) {
		this.cbk_rlpNation = cbk_rlpNation;
	}
	public void setCbk_rlpPhone(String cbk_rlpPhone) {
		this.cbk_rlpPhone = cbk_rlpPhone;
	}
	public void setCbk_chkInDate(String cbk_chkInDate) {
		this.cbk_chkInDate = cbk_chkInDate;
	}
	public void setCbk_chkOutDate(String cbk_chkOutDate) {
		this.cbk_chkOutDate = cbk_chkOutDate;
	}
	public void setCbk_chkInTime(String cbk_chkInTime) {
		this.cbk_chkInTime = cbk_chkInTime;
	}
	public void setCbk_chkOutTime(String cbk_chkOutTime) {
		this.cbk_chkOutTime = cbk_chkOutTime;
	}
	public void setCbk_rentTerm(double cbk_rentTerm) {
		this.cbk_rentTerm = cbk_rentTerm;
	}
	public void setCbk_rlpCarPrice(int cbk_rlpCarPrice) {
		this.cbk_rlpCarPrice = cbk_rlpCarPrice;
	}
	public void setCbk_totalPrice(int cbk_totalPrice) {
		this.cbk_totalPrice = cbk_totalPrice;
	}
	public void setCbk_date(String cbk_date) {
		this.cbk_date = cbk_date;
	}
	
	public int getCbk_no() {
		return cbk_no;
	}
	public int getCar_no() {
		return car_no;
	}
	public int getMem_no() {
		return mem_no;
	}
	public String getCbk_rlpName() {
		return cbk_rlpName;
	}
	public String getCbk_rlpEmail() {
		return cbk_rlpEmail;
	}
	public String getCbk_rlpNation() {
		return cbk_rlpNation;
	}
	public String getCbk_rlpPhone() {
		return cbk_rlpPhone;
	}
	public String getCbk_chkInDate() {
		return cbk_chkInDate;
	}
	public String getCbk_chkOutDate() {
		return cbk_chkOutDate;
	}
	public String getCbk_chkInTime() {
		return cbk_chkInTime;
	}
	public String getCbk_chkOutTime() {
		return cbk_chkOutTime;
	}
	public double getCbk_rentTerm() {
		return cbk_rentTerm;
	}
	public int getCbk_rlpCarPrice() {
		return cbk_rlpCarPrice;
	}
	public int getCbk_totalPrice() {
		return cbk_totalPrice;
	}
	public String getCbk_date() {
		return cbk_date;
	}
	
}
