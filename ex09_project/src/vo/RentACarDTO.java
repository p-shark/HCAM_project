package vo;

public class RentACarDTO {
	private int rac_no;				// 렌터카 No
	private int mgr_no;				// 매니저 No
	private int hfl_no;				// 파일 No
	private String rac_kubun;		// 차량 구분
	private String rac_name;		// 차량 이름
	private String rac_number;		// 차량 번호
	private String rac_fuel;		// 차량 연료
	private int rac_price;			// 차량 요금
	
	public void setRac_no(int rac_no) {
		this.rac_no = rac_no;
	}
	public void setMgr_no(int mgr_no) {
		this.mgr_no = mgr_no;
	}
	public void setHfl_no(int hfl_no) {
		this.hfl_no = hfl_no;
	}
	public void setRac_kubun(String rac_kubun) {
		this.rac_kubun = rac_kubun;
	}
	public void setRac_name(String rac_name) {
		this.rac_name = rac_name;
	}
	public void setRac_number(String rac_number) {
		this.rac_number = rac_number;
	}
	public void setRac_fuel(String rac_fuel) {
		this.rac_fuel = rac_fuel;
	}
	public void setRac_price(int rac_price) {
		this.rac_price = rac_price;
	}
	
	public int getRac_no() {
		return rac_no;
	}
	public int getMgr_no() {
		return mgr_no;
	}
	public int getHfl_no() {
		return hfl_no;
	}
	public String getRac_kubun() {
		return rac_kubun;
	}
	public String getRac_name() {
		return rac_name;
	}
	public String getRac_number() {
		return rac_number;
	}
	public String getRac_fuel() {
		return rac_fuel;
	}
	public int getRac_price() {
		return rac_price;
	}
	
}
