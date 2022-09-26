package vo;

public class HcamLikeDTO {
	private int hlk_no;
	private int mem_no;
	private String hlk_kubun;
	private int kubun_no;
	private int hlk_useYn;
	
	public void setHlk_no(int hlk_no) {
		this.hlk_no = hlk_no;
	}
	public void setMem_no(int mem_no) {
		this.mem_no = mem_no;
	}
	public void setHlk_kubun(String hlk_kubun) {
		this.hlk_kubun = hlk_kubun;
	}
	public void setKubun_no(int kubun_no) {
		this.kubun_no = kubun_no;
	}
	public void setHlk_useYn(int hlk_useYn) {
		this.hlk_useYn = hlk_useYn;
	}
	
	public int getHlk_no() {
		return hlk_no;
	}
	public int getMem_no() {
		return mem_no;
	}
	public String getHlk_kubun() {
		return hlk_kubun;
	}
	public int getKubun_no() {
		return kubun_no;
	}
	public int getHlk_useYn() {
		return hlk_useYn;
	}
	
}
