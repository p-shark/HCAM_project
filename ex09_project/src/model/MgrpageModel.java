package model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import org.apache.ibatis.session.SqlSessionFactory;

import config.SqlMapConfig;
import vo.HcamMemDTO;
import vo.PntHistoryDTO;

public class MgrpageModel {

	static MgrpageModel model = new MgrpageModel();

	public static MgrpageModel instance(){
		return model;
	}
	
	private SqlSessionFactory factory = SqlMapConfig.getSqlSession();
	
	/* 일/주/월 별 호텔,렌터카 예약 건수 */
	public List<Map<String, String>> selectPeroidBooking(Map<String, String> param_graph){
		List<Map<String, String>> list = null;
		SqlSession sqlSession = factory.openSession();
		list = sqlSession.selectList("mgrPagePeroidBooking", param_graph);
		sqlSession.close();
		return list;
	}
	
	/* 회원의 연령대 */
	public List<Map<String, String>> selectMemberAgeData(){
		List<Map<String, String>> list = null;
		SqlSession sqlSession = factory.openSession();
		list = sqlSession.selectList("mgrpageMemberAgeData");
		sqlSession.close();
		return list;
	}
	
	/* 회원의 성별 */
	public List<Map<String, String>> selectMemberGenderData(){
		List<Map<String, String>> list = null;
		SqlSession sqlSession = factory.openSession();
		list = sqlSession.selectList("mgrpageMemberGenderData");
		sqlSession.close();
		return list;
	}
	
	/* 등록된 호텔, 렌터카를 예약한 회원의 지역별 분포  */
	public List<Map<String, String>> selectMemberCountry(int mgr_no){
		List<Map<String, String>> list = null;
		SqlSession sqlSession = factory.openSession();
		list = sqlSession.selectList("mgrpagememberCountry", mgr_no);
		sqlSession.close();
		return list;
	}
	
}



