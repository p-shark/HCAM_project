package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Comparator;
import java.util.TreeMap;

import db.DBInfo;
import vo.HcamLikeDTO;
import vo.PntHistoryDTO;

public class CommonDAO {
	Connection conn = null;
	Statement stmt = null; 
	ResultSet rs = null;
	
	public CommonDAO() {
		// TODO Auto-generated constructor stub
		try {
			
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(DBInfo.URL, DBInfo.ROOT, DBInfo.PASSWORD);
			
			stmt = conn.createStatement();
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void dbClose() {
		try {
			stmt.close();
			conn.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	/* 회원 이름 조회 */
	public String getLoginMember(int mem_no) {
		
		String mem_name = "";
		try {
			
			String sql = String.format("select mem_name from hcamMem where mem_no = '%s';", mem_no);
			rs = stmt.executeQuery(sql);
			
			if(rs.next()) {
				mem_name = rs.getString("mem_name");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return mem_name;
	}
	
	
	/* 테이블의 회원 이름 조회 */
	public String getCommonCode(String tableName, String column, int no) {
		
		String mem_name = "";
		try {
			
			String sql = String.format("select (select mem_name from hcamMem where mem_no = t.mem_no) as mem_name from %s t where %s = %d;"
						, tableName, column, no);
			rs = stmt.executeQuery(sql);
			
			if(rs.next()) {
				mem_name = rs.getString("mem_name");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return mem_name;
	}
	
	/* 코드별 공통코드 전체 조회 */
	public TreeMap<String, String> getCodeAllByCode(String code) {
		
		// 요소를 추가할 때 Comparator를 사용하여 key를 정렬하며 그 순서대로 저장
		Comparator<String> comparator = (s1, s2) -> s1.compareTo(s2);
		TreeMap<String, String> CommonCodes = new TreeMap<String, String>(comparator);
		try {
			
			String sql = "select * from CommonCode where ccd_code like '" + code + "%' order by ccd_code;";
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				String ccd_code = rs.getString("ccd_code"); 
				String ccd_name = rs.getString("ccd_name");
				
				CommonCodes.put(ccd_code, ccd_name);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return CommonCodes;
	}
	
	/* 코드별 공통코드 개별 조회 */
	public String getCodeName(String code) {
		
		String code_name = "";
		try {
			
			String sql = "select ccd_name from CommonCode where ccd_code = '" + code + "';";
			rs = stmt.executeQuery(sql);
			
			if(rs.next()) {
				code_name = rs.getString("ccd_name");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return code_name;
	}
	
	/* 코드별 하위코드 전체 조회 */
	public TreeMap<String, String> getCodeByTopCode(String topCode) {
		
		// 요소를 추가할 때 Comparator를 사용하여 key를 정렬하며 그 순서대로 저장
		Comparator<String> comparator = (s1, s2) -> s1.compareTo(s2);
		TreeMap<String, String> CommonCodes = new TreeMap<String, String>(comparator);
		try {
			
			String sql = "select * from CommonCode where ccd_topCode = '" + topCode + "' order by ccd_code;";
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				String ccd_code = rs.getString("ccd_code"); 
				String ccd_name = rs.getString("ccd_name");
				
				CommonCodes.put(ccd_code, ccd_name);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return CommonCodes;
	}

	/* 페이지 처리를 위한 전체 count */
	public int getListCount(String tableName) {
		int listCount = 0;
		
		try {
			
			String sql = "select count(*) as cnt from " + tableName;
			rs = stmt.executeQuery(sql);
			
			if(rs.next()) {
				listCount = rs.getInt("cnt");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return listCount;
	}
	
	/* 페이지 처리를 위한 where 조건 count */
	public int getListWhereCount(String tableName, String column, String columnValue) {
		int listCount = 0;
		
		try {
			
			String sql = String.format("select count(*) as cnt from %s where %s = '%s';", tableName, column, columnValue);
			rs = stmt.executeQuery(sql);
			
			if(rs.next()) {
				listCount = rs.getInt("cnt");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return listCount;
	}
	
	/* 페이지 처리를 위한 where 조건 count */
	public int getListLikeCount(String tableName, String column01, String column02, String columnValue01, String columnValue02) {
		int listCount = 0;
		
		try {
			
			String sql = "select count(*) as cnt from " + tableName + " where " + column01 + " like '%" + columnValue01
					   + "' or " + column02 + " like '%" + columnValue02 + "';";
			rs = stmt.executeQuery(sql);
			
			if(rs.next()) {
				listCount = rs.getInt("cnt");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return listCount;
	}
	
	/* 회원 별 호텔,캠핑,여행리뷰 각 좋아요 여부 */
	public int getLikeYn(String kubun, int mem_no, int no) {
		int hlk_useYn = 0;
		
		try {
			
			String sql = String.format("select hlk_useYn from hcamLike where hlk_kubun = '%s' and mem_no = %d and kubun_no = %d;", kubun, mem_no, no);
			rs = stmt.executeQuery(sql);
			
			if(rs.next()) {
				hlk_useYn = rs.getInt("hlk_useYn");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return hlk_useYn;
	}
	
	/* 호텔,캠핑,여행리뷰 각 좋아요 insert 혹은 update */
	public void insUpdLikeYn(HcamLikeDTO hcamLike) {
		
		try {
			// 1.로그인한 회원의 좋아요 데이터가 있는지 확인 (없으면 insert, 있으면 update)
			String likecnt_sql = String.format("select count(*) as cnt from hcamLike where mem_no = %d and hlk_kubun = '%s' and kubun_no = %d;"
							   , hcamLike.getMem_no(), hcamLike.getHlk_kubun(), hcamLike.getKubun_no());
			rs = stmt.executeQuery(likecnt_sql);
			
			int cnt = 0;
			if(rs.next()) {
				cnt = rs.getInt("cnt");
			}
			
			// 2.(없으면 insert, 있으면 update)
			String like_sql = "";
			if(cnt == 0) {
				like_sql = String.format("insert into hcamLike(mem_no, hlk_kubun, kubun_no, hlk_useYn) values (%d, '%s', %d, %d);"
						 , hcamLike.getMem_no(), hcamLike.getHlk_kubun(), hcamLike.getKubun_no(), hcamLike.getHlk_useYn());
				stmt.execute(like_sql);
			}
			else {
				like_sql = String.format("update hcamLike set hlk_useYn = %d where mem_no = %d and hlk_kubun = '%s' and kubun_no = %d;"
						 , hcamLike.getHlk_useYn(), hcamLike.getMem_no(), hcamLike.getHlk_kubun(), hcamLike.getKubun_no());
				stmt.executeUpdate(like_sql);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		
	}
	
	/* 좋아요 총 개수 */
	public int getLikeCount(String kubun, int no) {
		int count = 0;
		
		try {
			
			String sql = String.format("select count(*) as cnt from hcamLike where hlk_kubun = '%s' and kubun_no = %d and hlk_useYn = 1", kubun, no);
			rs = stmt.executeQuery(sql);
			
			if(rs.next()) {
				count = rs.getInt("cnt");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return count;
	}
	
	/* 포인트 잔액 조회 */
	public int getPnt_balance(int pnt_no) {
		
		int pnt_balance = 0;
		
		try {
			// 1.포인트 번호 조회
			String point_sql = "select pnt_balance from hcamPoint where pnt_no = " + pnt_no;
			rs = stmt.executeQuery(point_sql);
			
			if(rs.next()) {
				pnt_balance = rs.getInt("pnt_balance");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		
		return pnt_balance;
		
	}
	
	/* 포인트 충전/적립/사용 */
	public void updatePoint(PntHistoryDTO pntHistory) {
		
		// 연산기호 PNT01001: 충전 / PNT01002: 적립 / PNT01003: 사용
		String operSymbol = "";
		if("PNT01003".equals(pntHistory.getPhs_kind())) operSymbol = "-";
		else operSymbol = "+";
		
		try {
			
			// 1.포인트 히스토리 추가
			String pntHistory_sql = String.format("insert into pntHistory(pnt_no, phs_kubun, phs_kubunNo, "
								  + "phs_kind, phs_historyAmt, phs_comment) values(%d, '%s', %d, '%s', %d, '%s');"
								    , pntHistory.getPnt_no(), pntHistory.getPhs_kubun(), pntHistory.getPhs_kubunNo()
								    , pntHistory.getPhs_kind(), pntHistory.getPhs_historyAmt(), pntHistory.getPhs_comment());
			stmt.execute(pntHistory_sql);
			
			// 2. 포인트 잔액 변경
			String hcamPoint_sql = String.format("update hcamPoint set pnt_balance = pnt_balance %s %d where pnt_no = %d"
							   , operSymbol, pntHistory.getPhs_historyAmt(), pntHistory.getPnt_no());
			stmt.executeUpdate(hcamPoint_sql);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	}
	
	/* 예약,주문 취소로 인한 포인트 복구 */
	public void setBackPoint(String phs_kubun, int phs_kubunNo) {
		
		PntHistoryDTO pntHistory = new PntHistoryDTO();
		int resultAmt = 0;	// 포인트 최종 합산 금액
		
		try {
			
			// 1.이전 포인트 정보 조회
			String beforePnt_sql = String.format("select * from pntHistory where phs_kubun = '%s' and phs_kubunNo = %d;"
								, phs_kubun, phs_kubunNo);
			rs = stmt.executeQuery(beforePnt_sql);
			
			while(rs.next()) {
				
				pntHistory.setPhs_no(rs.getInt("phs_no"));
				pntHistory.setPnt_no(rs.getInt("pnt_no"));
				pntHistory.setPhs_kind(rs.getString("phs_kind"));
				pntHistory.setPhs_historyAmt(rs.getInt("phs_historyAmt"));
				
				// 연산기호 PNT01004: 적립 취소 / PNT01005: 사용 취소
				String phs_kind = "";
				if(pntHistory.getPhs_kind().equals("PNT01002")) {
					phs_kind = "PNT01004";
					resultAmt -= pntHistory.getPhs_historyAmt(); 
				}	
				else if(pntHistory.getPhs_kind().equals("PNT01003")) {
					phs_kind = "PNT01005";
					resultAmt += pntHistory.getPhs_historyAmt();
				}

				Statement stmt02 = conn.createStatement();
				Statement stmt03 = conn.createStatement();
				
				// 2.이전 포인트 히스토리 phs_kind, pntHistory 빈값으로 변경
				String beforePhs_sql = String.format("update pntHistory set phs_kubunNo = 0 where phs_no = %d "
										, pntHistory.getPhs_no());
				stmt02.execute(beforePhs_sql);
				
				// 3.포인트 히스토리 추가
				String pntHistory_sql = String.format("insert into pntHistory(pnt_no, phs_kind, phs_historyAmt, phs_comment) "
									  + "values(%d, '%s', %d, '%s');"
									    , pntHistory.getPnt_no(), phs_kind, pntHistory.getPhs_historyAmt(), "포인트 이용내역 취소");
				stmt03.execute(pntHistory_sql);
				
			}
			
			// 4.포인트 잔액 변경
			String hcamPoint_sql = String.format("update hcamPoint set pnt_balance = pnt_balance + %d where pnt_no = %d"
							   , resultAmt, pntHistory.getPnt_no());
			stmt.executeUpdate(hcamPoint_sql);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	}
	
	
}
