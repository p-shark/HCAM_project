package model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import org.apache.ibatis.session.SqlSessionFactory;

import config.SqlMapConfig;
import vo.HcamMemDTO;
import vo.PntHistoryDTO;

public class MypageModel {

	static MypageModel model = new MypageModel();

	public static MypageModel instance(){
		return model;
	}
	
	private SqlSessionFactory factory = SqlMapConfig.getSqlSession();
	
	/* 호텔 예약 정보 */
	public List<Map<String, String>> selectHtlBooking(int mem_no){
		List<Map<String, String>> list = null;
		SqlSession sqlSession = factory.openSession();
		list = sqlSession.selectList("myPageHtlBooking", mem_no);
		sqlSession.close();
		return list;
	}
	
	/* 포인트 정보 */
	public List<Map<String, String>> selectPointInfo(int pnt_no){
		List<Map<String, String>> list = null;
		SqlSession sqlSession = factory.openSession();
		list = sqlSession.selectList("myPagePointInfo", pnt_no);
		sqlSession.close();
		return list;
	}
	
	/* 포인트 히스토리 정보 */
	public List<PntHistoryDTO> selectPntHistoryInfo(int pnt_no){
		List<PntHistoryDTO> list = null;
		SqlSession sqlSession = factory.openSession();
		list = sqlSession.selectList("myPagePntHistory", pnt_no);
		sqlSession.close();
		return list;
	}
	
	/* 회원정보 */
	public List<HcamMemDTO> selectMemberInfo(int mem_no){
		List<HcamMemDTO> list = null;
		SqlSession sqlSession = factory.openSession();
		list = sqlSession.selectList("myPageMember", mem_no);
		sqlSession.close();
		return list;
	}
}



