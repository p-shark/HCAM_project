package vo;

public class RentACarDTO {
	private int car_no;
	private int mgr_no;
	private String car_location;
	private String car_branch;
    private String car_kubun;		// 세단, 카리브올레, 스포츠카, 오토바이
    private String car_name;
    private String car_number;
    private String car_fuelKubun;	// 가솔린, 디젤, 전기차
    private int car_optBackCamera;
    private int car_optNavi;
    private int car_optSmartkey;
	private int car_price;
	private String car_threeGLTF;
	private String car_threeFov;
	private String car_threeFar;
	private String car_threeX;
	private String car_threeY;
	private String car_threeZ;
	private int booking_cnt;	// db 테이블에는 없고, 파라미터 전달용
	
	public void setCar_no(int car_no) {
		this.car_no = car_no;
	}
	public void setMgr_no(int mgr_no) {
		this.mgr_no = mgr_no;
	}
	public void setCar_location(String car_location) {
		this.car_location = car_location;
	}
	public void setCar_branch(String car_branch) {
		this.car_branch = car_branch;
	}
	public void setCar_kubun(String car_kubun) {
		this.car_kubun = car_kubun;
	}
	public void setCar_name(String car_name) {
		this.car_name = car_name;
	}
	public void setCar_number(String car_number) {
		this.car_number = car_number;
	}
	public void setCar_fuelKubun(String car_fuelKubun) {
		this.car_fuelKubun = car_fuelKubun;
	}
	public void setCar_optBackCamera(int car_optBackCamera) {
		this.car_optBackCamera = car_optBackCamera;
	}
	public void setCar_optNavi(int car_optNavi) {
		this.car_optNavi = car_optNavi;
	}
	public void setCar_optSmartkey(int car_optSmartkey) {
		this.car_optSmartkey = car_optSmartkey;
	}
	public void setCar_price(int car_price) {
		this.car_price = car_price;
	}
	public void setCar_threeFov(String car_threeFov) {
		this.car_threeFov = car_threeFov;
	}
	public void setCar_threeFar(String car_threeFar) {
		this.car_threeFar = car_threeFar;
	}
	public void setCar_threeX(String car_threeX) {
		this.car_threeX = car_threeX;
	}
	public void setCar_threeY(String car_threeY) {
		this.car_threeY = car_threeY;
	}
	public void setCar_threeZ(String car_threeZ) {
		this.car_threeZ = car_threeZ;
	}
	public void setBooking_cnt(int booking_cnt) {
		this.booking_cnt = booking_cnt;
	}
	public void setCar_threeGLTF(String car_threeGLTF) {
		this.car_threeGLTF = car_threeGLTF;
	}
	
	public int getCar_no() {
		return car_no;
	}
	public int getMgr_no() {
		return mgr_no;
	}
	public String getCar_location() {
		return car_location;
	}
	public String getCar_branch() {
		return car_branch;
	}
	public String getCar_kubun() {
		return car_kubun;
	}
	public String getCar_name() {
		return car_name;
	}
	public String getCar_number() {
		return car_number;
	}
	public String getCar_fuelKubun() {
		return car_fuelKubun;
	}
	public int getCar_optBackCamera() {
		return car_optBackCamera;
	}
	public int getCar_optNavi() {
		return car_optNavi;
	}
	public int getCar_optSmartkey() {
		return car_optSmartkey;
	}
	public int getCar_price() {
		return car_price;
	}
	public String getCar_threeFov() {
		return car_threeFov;
	}
	public String getCar_threeFar() {
		return car_threeFar;
	}
	public String getCar_threeX() {
		return car_threeX;
	}
	public String getCar_threeY() {
		return car_threeY;
	}
	public String getCar_threeZ() {
		return car_threeZ;
	}
	public int getBooking_cnt() {
		return booking_cnt;
	}
	public String getCar_threeGLTF() {
		return car_threeGLTF;
	}
	
}
