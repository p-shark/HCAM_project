package vo;

public class HcamFileDTO {
	private int hfl_no;
	private String hfl_kubun;
	private int kubun_no;
	private String hfl_path;
	private String hfl_name;
	private String hfl_newName;
	
	public void setHfl_no(int hfl_no) {
		this.hfl_no = hfl_no;
	}
	public void setHfl_kubun(String hfl_kubun) {
		this.hfl_kubun = hfl_kubun;
	}
	public void setKubun_no(int kubun_no) {
		this.kubun_no = kubun_no;
	}
	public void setHfl_path(String hfl_path) {
		this.hfl_path = hfl_path;
	}
	public void setHfl_name(String hfl_name) {
		this.hfl_name = hfl_name;
	}
	public void setHfl_newName(String hfl_newName) {
		this.hfl_newName = hfl_newName;
	}
	
	public int getHfl_no() {
		return hfl_no;
	}
	public String getHfl_kubun() {
		return hfl_kubun;
	}
	public int getKubun_no() {
		return kubun_no;
	}
	public String getHfl_path() {
		return hfl_path;
	}
	public String getHfl_name() {
		return hfl_name;
	}
	public String getHfl_newName() {
		return hfl_newName;
	}
}
