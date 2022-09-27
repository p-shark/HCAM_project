package dao;

import static db.JdbcUtil.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import db.DBInfo;
import vo.AnswerBoardDTO;
import vo.HcamFileDTO;
import vo.QuestionBoardDTO;

public class QuestionDAO {
	
	Connection conn = null;
	
	private static QuestionDAO questionDAO;
	
	public QuestionDAO() {}

	public static QuestionDAO getInstance() {
		if(questionDAO == null) {
			questionDAO = new QuestionDAO();
		}
		return questionDAO;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public void DBclose() {
		try {
			conn.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	/* 문의사항 전체 개수 */
	public int selectListsCount() {
		
		int listCount = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = conn.prepareStatement("select count(*) from questionboard;");
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				listCount = rs.getInt(1);
			}
		}catch(Exception ex) {
			ex.printStackTrace();

		}finally {
			close(rs);
			close(pstmt);
		}
		
		return listCount;
	}
	
	/* 문의사항 전체 정보 */
	public ArrayList<QuestionBoardDTO> getQuestionLists(int page, int limit){
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String question_list_sql="select qbd_no,qbd_ctgry,mem_no,qbd_title,qbd_content,date_format(qbd_date, '%Y-%m-%d %H:%i') as qbd_date, "
								+"(select a.abd_no from AnswerBoard a where a.qbd_no = q.qbd_no) as ansState "
								+"from QuestionBoard q order by qbd_date desc limit ?,6";
		
		ArrayList<QuestionBoardDTO> questionLists = new ArrayList<QuestionBoardDTO>();
		QuestionBoardDTO questionDTO = null;
		int startrow=(page-1)*6;
		
		try {
			pstmt = conn.prepareStatement(question_list_sql);
			pstmt.setInt(1, startrow);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				questionDTO = new QuestionBoardDTO();
				
				questionDTO.setQbd_no(rs.getInt("qbd_no"));
				questionDTO.setQbd_ctgry(rs.getString("qbd_ctgry"));
				questionDTO.setMem_no(rs.getInt("mem_no"));
				questionDTO.setQbd_title(rs.getString("qbd_title"));
				questionDTO.setQbd_content(rs.getString("qbd_content"));
				questionDTO.setQbd_date(rs.getString("qbd_date"));
				
				String ansState = rs.getString("ansState");
				if(ansState == null) {
					questionDTO.setAnsState("미답변");
				}
				else {
					questionDTO.setAnsState("답변완료");
				}
				
				questionLists.add(questionDTO);
				
			}
		}catch(Exception ex) {
				ex.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return questionLists;
	}
	
	/* 문의사항 등록 */
	public void insertList(QuestionBoardDTO list, HcamFileDTO hcamFile) {
		
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.createStatement();
			
			// 1.qestionBoard 테이블 insert
			String qestionBoard_sql = String.format("insert into questionBoard(qbd_ctgry, mem_no, qbd_title, qbd_content) " + 
									"values('%s', %d, '%s', '%s'); ", list.getQbd_ctgry(), list.getMem_no(), list.getQbd_title(), list.getQbd_content());
			stmt.execute(qestionBoard_sql);
			
			// 2.qestionBoard 테이블 insert 후 qbd_no 반환
			rs = stmt.executeQuery("select max(qbd_no) as max_qbdNo from questionBoard;");
			int max_qbdNo = 0;
			if(rs.next()) {
				max_qbdNo = rs.getInt("max_qbdNo");
			}
			
			// 3.hcamFile 테이블 insert
			String hcamFile_sql = String.format("insert into hcamFile(hfl_kubun, kubun_no, hfl_path, hfl_name) " + 
								"values('%s', %d, '%s', '%s'); ", hcamFile.getHfl_kubun(), max_qbdNo, hcamFile.getHfl_path(), hcamFile.getHfl_name());
			stmt.execute(hcamFile_sql);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
	}
	
	/* 문의사항 조회 */
	public QuestionBoardDTO getListByQbdNo(int qbd_no) {
		
		Statement stmt = null;
		ResultSet rs = null;
		
		QuestionBoardDTO list = new QuestionBoardDTO();
		try {
			stmt = conn.createStatement();
			
			String sql = "select * from questionboard where qbd_no = " + qbd_no + ";";
			rs = stmt.executeQuery(sql);
			
			if(rs.next()) {
				list.setQbd_no(rs.getInt("qbd_no"));
				list.setQbd_ctgry(rs.getString("qbd_ctgry"));
				list.setMem_no(rs.getInt("mem_no"));
				list.setQbd_title(rs.getString("qbd_title"));
				list.setQbd_content(rs.getString("qbd_content"));
				list.setQbd_date(rs.getString("qbd_date"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rs);
			close(stmt);
		}
		
		return list;
	}
	/* 문의사항 수정 */
	public void changeList(QuestionBoardDTO list, HcamFileDTO hcamFile) {
		
		Statement stmt = null;
		
		try {
			stmt = conn.createStatement();
			
			String sql = String.format("update questionboard set qbd_ctgry = '%s', qbd_title = '%s', qbd_content = '%s' where qbd_no = %d;"
						, list.getQbd_ctgry(), list.getQbd_title(), list.getQbd_content(), list.getQbd_no());
			stmt.executeUpdate(sql);
			
			// 서버에 파일을 새로 올린 경우 삭제 후 재생성
			if(hcamFile.getHfl_name() != null) {
				/*// 2.hcamFile 테이블 update
				String hcamFile_sql = String.format("update hcamFile set hfl_path = '%s', hfl_name = '%s' where hfl_kubun = '%s' and kubun_no = %d;"
									, hcamFile.getHfl_path(), hcamFile.getHfl_name(), hcamFile.getHfl_kubun(), hcamFile.getKubun_no());
				stmt.execute(hcamFile_sql);*/
				
				// 2.hcamFile 테이블 delete
				String file_del_sql = String.format("delete from hcamFile where hfl_kubun = '%s' and kubun_no = %d;"
							, hcamFile.getHfl_kubun(), hcamFile.getKubun_no());
				stmt.executeUpdate(file_del_sql);
				
				// 3.hcamFile 테이블 insert
				String file_rg_sql = String.format("insert into hcamFile(hfl_kubun, kubun_no, hfl_path, hfl_name) " + 
									"values('%s', %d, '%s', '%s'); ", hcamFile.getHfl_kubun(), hcamFile.getKubun_no(), hcamFile.getHfl_path(), hcamFile.getHfl_name());
				stmt.execute(file_rg_sql);
			}	
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(stmt);
		}
	}
	/* 문의사항 삭제 */
	public void deleteQestionList(int qbd_no) {
		
		Statement stmt = null;
		
		try {
			stmt = conn.createStatement();
			
			String sql = String.format("delete from questionboard where qbd_no = %d;", qbd_no);
			stmt.executeUpdate(sql);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(stmt);
		}
	}
	
	/* 답변사항 전체 조회 */
	public ArrayList<AnswerBoardDTO> getAllAns() {
		
		Statement stmt = null;
		ResultSet rs = null;
		
		ArrayList<AnswerBoardDTO> listsAns = new ArrayList<AnswerBoardDTO>();
		try {
			stmt = conn.createStatement();
			
			String sql = "select abd_no,qbd_no,abd_content,date_format(abd_date, '%Y-%m-%d %H:%i') as abd_date from AnswerBoard order by abd_date desc;";
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				AnswerBoardDTO listAns = new AnswerBoardDTO();
				
				listAns.setAbd_no(Integer.parseInt(rs.getString("abd_no")));
				listAns.setQbd_no(Integer.parseInt(rs.getString("qbd_no")));
				listAns.setAbd_content(rs.getString("abd_content"));
				listAns.setAbd_date(rs.getString("abd_date"));
				
				listsAns.add(listAns);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rs);
			close(stmt);
		}
		
		return listsAns;
	}
	/* 답변사항 삭제 */
	public void deleteAnswerList(int qbd_no) {
		
		Statement stmt = null;
		
		try {
			stmt = conn.createStatement();
			
			String sql = String.format("delete from AnswerBoard where qbd_no = %d;", qbd_no);
			stmt.executeUpdate(sql);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(stmt);
		}
	}
}
