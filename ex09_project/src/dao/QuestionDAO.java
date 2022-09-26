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
import vo.QuestionBoardDTO;

public class QuestionDAO {
	
	Connection conn = null;
	Statement stmt = null;
	private static QuestionDAO questionDAO;
	
	public QuestionDAO() {
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
			stmt.close();
		}catch(Exception e) {
			e.printStackTrace();
		}

	}
	
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
	
	public ArrayList<QuestionBoardDTO> selectQuestionLists(int page, int limit){
		
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
	
	/* 질문사항 전체 조회 */
	public ArrayList<QuestionBoardDTO> getSelectAll() {
		ArrayList<QuestionBoardDTO> lists = new ArrayList<QuestionBoardDTO>();
		
		try {
			
			String sql = "select qbd_no,qbd_ctgry,mem_no,qbd_title,qbd_content,date_format(qbd_date, '%Y-%m-%d %H:%i') as qbd_date,(select a.abd_no from AnswerBoard a where a.qbd_no = q.qbd_no) as ansState from QuestionBoard q order by qbd_date desc;";
			ResultSet rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				QuestionBoardDTO list = new QuestionBoardDTO();
				
				list.setQbd_no(Integer.parseInt(rs.getString("qbd_no")));
				list.setQbd_ctgry(rs.getString("qbd_ctgry"));
				list.setMem_no(Integer.parseInt(rs.getString("mem_no")));
				list.setQbd_title(rs.getString("qbd_title"));
				list.setQbd_content(rs.getString("qbd_content"));
				list.setQbd_date(rs.getString("qbd_date"));
				
				String ansState = rs.getString("ansState");
				if(ansState == null) {
					list.setAnsState("미답변");
				}
				else {
					list.setAnsState("답변완료");
				}
				
				
				
				//System.out.println(subject.toString());
				
				lists.add(list);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return lists;
	}
	
	/* 답변사항 전체 조회 */
	public ArrayList<AnswerBoardDTO> getSelectAllAns() {
		ArrayList<AnswerBoardDTO> listsAns = new ArrayList<AnswerBoardDTO>();
		try {
			
			String sql = "select abd_no,qbd_no,abd_content,date_format(abd_date, '%Y-%m-%d %H:%i') as abd_date from AnswerBoard order by abd_date desc;";
			ResultSet rs = stmt.executeQuery(sql);
			
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
		}
		
		return listsAns;
	}
	
	/* 질문사항 등록 */
	public void insertList(QuestionBoardDTO list) {
		try {
			
			String sql = String.format("insert into questionboard(qbd_ctgry, mem_no, qbd_title, qbd_content) values('%s', %d, '%s', '%s');",
					list.getQbd_ctgry(), list.getMem_no(), list.getQbd_title(), list.getQbd_content());
			stmt.execute(sql);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/* 문의사항 조회 */
	public QuestionBoardDTO getListByQbdNo(int qbd_no) {
		
		QuestionBoardDTO list = new QuestionBoardDTO();
		try {
			String sql = "select * from questionboard where qbd_no = " + qbd_no + ";";
			ResultSet rs = stmt.executeQuery(sql);
			
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
		}
		
		return list;
	}
	/* 문의사항 수정 */
	public void changeList(QuestionBoardDTO list) {
		
		try {
			
			String sql = String.format("update questionboard set qbd_ctgry = '%s', qbd_title = '%s', qbd_content = '%s' where qbd_no = %d;"
						, list.getQbd_ctgry(), list.getQbd_title(), list.getQbd_content(), list.getQbd_no());
			stmt.executeUpdate(sql);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/* 문의사항 삭제 */
	public void deleteQestionList(int qbd_no) {
		
		try {
			
			String sql = String.format("delete from questionboard where qbd_no = %d;", qbd_no);
			stmt.executeUpdate(sql);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/* 답변사항 삭제 */
	public void deleteAnswerList(int qbd_no) {
		
		try {
			
			String sql = String.format("delete from AnswerBoard where qbd_no = %d;", qbd_no);
			stmt.executeUpdate(sql);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
