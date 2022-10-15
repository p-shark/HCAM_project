package model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import org.apache.ibatis.session.SqlSessionFactory;

import config.SqlMapConfig;
import vo.HcamMemDTO;
import vo.PntHistoryDTO;
import vo.RacBookingDTO;
import vo.RentACarDTO;

public class RentAcarModel {

	static RentAcarModel model = new RentAcarModel();

	public static RentAcarModel instance(){
		return model;
	}
	
	private SqlSessionFactory factory = SqlMapConfig.getSqlSession();
	
	/* 렌터카 전체 select */
	public List<RentACarDTO> selectRentAcar(Map<String, String> param_car){
		List<RentACarDTO> list = null;
		SqlSession sqlSession = factory.openSession();
		list = sqlSession.selectList("carSelectBysearch", param_car);
		sqlSession.close();
		return list;
	}
	
	/* 렌터카 select */
	public List<RentACarDTO> getRentAcar(int car_no){
		List<RentACarDTO> list = null;
		SqlSession sqlSession = factory.openSession();
		list = sqlSession.selectList("carEach", car_no);
		sqlSession.close();
		return list;
	}
	
	/* 뒤로가기 눌렀다가 다시 올때 예약 못하게 막음 */
	public String checkBooking(RacBookingDTO racBooking){
		String cbk_no = "";
		SqlSession sqlSession = factory.openSession();
		cbk_no = sqlSession.selectOne("carCheckBooking", racBooking);
		sqlSession.close();
		return cbk_no;
	}
	
	/* 렌터카 예약 */
	public void insertBooking(RacBookingDTO racBooking) {
		SqlSession sqlSession = factory.openSession();
		int result = sqlSession.insert("carInsertBooking", racBooking);
		if(result > 0) {
			sqlSession.commit();
		}
		else {
			sqlSession.rollback();
		}
		sqlSession.close();
	}
	
	/* 렌터카 예약정보 */
	public RacBookingDTO getRacBooking(int cbk_no){
		RacBookingDTO racBooking = new RacBookingDTO();
		SqlSession sqlSession = factory.openSession();
		racBooking = sqlSession.selectOne("carBookingInfo", cbk_no);
		sqlSession.close();
		return racBooking;
	}
}



