package model;

import java.util.List;



import org.apache.ibatis.session.SqlSession;

import org.apache.ibatis.session.SqlSessionFactory;

import config.SqlMapConfig;
import vo.HcamMemDTO;

public class SawonModel {

	static SawonModel model = new SawonModel();

	public static SawonModel instance(){
		return model;
	}
	
	private SqlSessionFactory factory = SqlMapConfig.getSqlSession();
	
	public List<HcamMemDTO> selectSawon(){
		List<HcamMemDTO> list = null;
		SqlSession sqlSession = factory.openSession();
		list = sqlSession.selectList("selSa");
		sqlSession.close();
		return list;
	}
	
	public void insertSawon(HcamMemDTO sawon) {
		SqlSession sqlSession = factory.openSession();
		sqlSession.insert("insSa", sawon);
		sqlSession.commit();
		sqlSession.close();
	}
	
}



