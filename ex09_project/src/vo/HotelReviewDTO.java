package vo;

public class HotelReviewDTO {
	private int hrv_no;
	private int htl_no;
	private int mem_no;
	private int hrv_clSco;
	private int hrv_loSco;
	private int hrv_svcSco;
	private int hrv_conSco;
    private double hrv_totalSco;
	private String hrv_content;
	private String hrv_date;
	
	public void setHrv_no(int hrv_no) {
		this.hrv_no = hrv_no;
	}
	public void setHtl_no(int htl_no) {
		this.htl_no = htl_no;
	}
	public void setMem_no(int mem_no) {
		this.mem_no = mem_no;
	}
	public void setHrv_clSco(int hrv_clSco) {
		this.hrv_clSco = hrv_clSco;
	}
	public void setHrv_loSco(int hrv_loSco) {
		this.hrv_loSco = hrv_loSco;
	}
	public void setHrv_svcSco(int hrv_svcSco) {
		this.hrv_svcSco = hrv_svcSco;
	}
	public void setHrv_conSco(int hrv_conSco) {
		this.hrv_conSco = hrv_conSco;
	}
	public void setHrv_totalSco(double hrv_totalSco) {
		this.hrv_totalSco = hrv_totalSco;
	}
	public void setHrv_content(String hrv_content) {
		this.hrv_content = hrv_content;
	}
	public void setHrv_date(String hrv_date) {
		this.hrv_date = hrv_date;
	}
	
	public int getHrv_no() {
		return hrv_no;
	}
	public int getHtl_no() {
		return htl_no;
	}
	public int getMem_no() {
		return mem_no;
	}
	public int getHrv_clSco() {
		return hrv_clSco;
	}
	public int getHrv_loSco() {
		return hrv_loSco;
	}
	public int getHrv_svcSco() {
		return hrv_svcSco;
	}
	public int getHrv_conSco() {
		return hrv_conSco;
	}
	public double getHrv_totalSco() {
		return hrv_totalSco;
	}
	public String getHrv_content() {
		return hrv_content;
	}
	public String getHrv_date() {
		return hrv_date;
	}
	
}
