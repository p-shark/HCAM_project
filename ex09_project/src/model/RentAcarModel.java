package model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import org.apache.ibatis.session.SqlSessionFactory;

import config.SqlMapConfig;
import vo.HcamMemDTO;
import vo.PntHistoryDTO;
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
}



