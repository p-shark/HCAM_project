package vo;

public class HotelRoomDTO {
	private int hrm_no;
	private int htl_no;
	private String hrm_name;
	private String hrm_view;
	private String hrm_bed;
	private int hrm_price;
	private int hrm_maxpers;
	private int booking_cnt;
	
	public void setHrm_no(int hrm_no) {
		this.hrm_no = hrm_no;
	}
	public void setHtl_no(int htl_no) {
		this.htl_no = htl_no;
	}
	public void setHrm_name(String hrm_name) {
		this.hrm_name = hrm_name;
	}
	public void setHrm_view(String hrm_view) {
		this.hrm_view = hrm_view;
	}
	public void setHrm_bed(String hrm_bed) {
		this.hrm_bed = hrm_bed;
	}
	public void setHrm_price(int hrm_price) {
		this.hrm_price = hrm_price;
	}
	public void setHrm_maxpers(int hrm_maxpers) {
		this.hrm_maxpers = hrm_maxpers;
	}
	public void setBooking_cnt(int booking_cnt) {
		this.booking_cnt = booking_cnt;
	}
	
	public int getHrm_no() {
		return hrm_no;
	}
	public int getHtl_no() {
		return htl_no;
	}
	public String getHrm_name() {
		return hrm_name;
	}
	public String getHrm_view() {
		return hrm_view;
	}
	public String getHrm_bed() {
		return hrm_bed;
	}
	public int getHrm_price() {
		return hrm_price;
	}
	public int getHrm_maxpers() {
		return hrm_maxpers;
	}
	public int getBooking_cnt() {
		return booking_cnt;
	}
	
}
