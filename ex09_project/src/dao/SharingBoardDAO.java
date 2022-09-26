package dao;

import static db.JdbcUtil.close;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import vo.HcamFileDTO;
import vo.SharingBoardDTO;
import vo.ShbCommentDTO;

public class SharingBoardDAO {
	
	Connection conn = null;
	
	private static SharingBoardDAO shareBoardDAO;
	
	private SharingBoardDAO() {}
	
	public static SharingBoardDAO getInstance() {
		if(shareBoardDAO == null) {
			shareBoardDAO = new SharingBoardDAO();
		}
		
		return shareBoardDAO;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public void dbClose() {
		try {
			conn.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	/* 게시판 전체 정보 */
	public ArrayList<SharingBoardDTO> getBoardAll(int pageNo, int limit) {
		Statement stmt = null;
		ResultSet rs = null;
		
		ArrayList<SharingBoardDTO> boards = new ArrayList<SharingBoardDTO>();
		int startrow=(pageNo-1)*8; 
		
		try {
			stmt = conn.createStatement();
			
			String sql = "select shb.*, "
					   + "(select count(*) from ShbComment where shb_no = shb.shb_no) as comment_cnt "
					   + "from sharingBoard shb order by shb_no desc limit " + startrow + ",8";
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				SharingBoardDTO board = new SharingBoardDTO();
				
				board.setShb_no(rs.getInt("shb_no"));
				board.setShb_ctgry(rs.getString("shb_ctgry"));
				board.setMem_no(rs.getInt("mem_no"));
				board.setShb_title(rs.getString("shb_title"));
				board.setShb_content(rs.getString("shb_content"));
				board.setShb_cnt(rs.getInt("shb_cnt"));
				board.setShb_likeCnt(rs.getInt("shb_likeCnt"));
				board.setShb_date(rs.getString("shb_date"));
				board.setCommentCnt(rs.getInt("comment_cnt"));
				
				boards.add(board);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			close(rs);
			close(stmt);
		}
		
		return boards;
	}
	
	/* 카테고리 별 게시글 조회 */
	public ArrayList<SharingBoardDTO> getBoardByCtgry(String category, int pageNo, int limit) {
		
		Statement stmt = null;
		ResultSet rs = null;
		
		ArrayList<SharingBoardDTO> boards = new ArrayList<SharingBoardDTO>();
		int startrow=(pageNo-1)*8; 
		
		try {
			stmt = conn.createStatement();
			
			String sql = "select shb.*, "
					   + "(select count(*) from ShbComment where shb_no = shb.shb_no) as comment_cnt "
					   + "from sharingBoard shb where shb_ctgry = '" + category
					   + "' order by shb_date desc limit " + startrow + ",8";
					
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				SharingBoardDTO board = new SharingBoardDTO();
				
				board.setShb_no(rs.getInt("shb_no"));
				board.setShb_ctgry(rs.getString("shb_ctgry"));
				board.setMem_no(rs.getInt("mem_no"));
				board.setShb_title(rs.getString("shb_title"));
				board.setShb_content(rs.getString("shb_content"));
				board.setShb_cnt(rs.getInt("shb_cnt"));
				board.setShb_likeCnt(rs.getInt("shb_likeCnt"));
				board.setShb_date(rs.getString("shb_date"));
				board.setCommentCnt(rs.getInt("comment_cnt"));
				
				boards.add(board);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			close(rs);
			close(stmt);
		}
		
		return boards;
	}
	
	/* 검색어에 의한 게시글 조회 */
	public ArrayList<SharingBoardDTO> getBoardBySearching(String searching, int pageNo, int limit) {
		
		Statement stmt = null;
		ResultSet rs = null;
		
		ArrayList<SharingBoardDTO> boards = new ArrayList<SharingBoardDTO>();
		int startrow=(pageNo-1)*8; 
		
		try {
			stmt = conn.createStatement();
			
			String sql = "select * from sharingBoard where shb_title like '%" + searching + "%' or shb_content like '%" + searching + "%' order by shb_date desc limit " + startrow + ",8";
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				SharingBoardDTO board = new SharingBoardDTO();
				
				board.setShb_no(rs.getInt("shb_no"));
				board.setShb_ctgry(rs.getString("shb_ctgry"));
				board.setMem_no(rs.getInt("mem_no"));
				board.setShb_title(rs.getString("shb_title"));
				board.setShb_content(rs.getString("shb_content"));
				board.setShb_cnt(rs.getInt("shb_cnt"));
				board.setShb_likeCnt(rs.getInt("shb_likeCnt"));
				board.setShb_date(rs.getString("shb_date"));
				
				boards.add(board);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			close(rs);
			close(stmt);
		}
		
		return boards;
	}
	
	/* 게시글 등록 */
	public void insertBoard(SharingBoardDTO board, HcamFileDTO hcamFile) {
		
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.createStatement();
			
			// 1.sharingBoard 테이블 insert
			String sharingBoard_sql = String.format("insert into sharingBoard(shb_ctgry, mem_no, shb_title, shb_content) " + 
									"values('%s', %d, '%s', '%s'); ", board.getShb_ctgry(), board.getMem_no(), board.getShb_title(), board.getShb_content());
			stmt.execute(sharingBoard_sql);
			
			// 2.sharingBoard 테이블 insert 후 shb_no 반환
			rs = stmt.executeQuery("select max(shb_no) as max_shbNo from sharingBoard;");
			int max_shbNo = 0;
			if(rs.next()) {
				max_shbNo = rs.getInt("max_shbNo");
			}
			
			// 3.hcamFile 테이블 insert
			String hcamFile_sql = String.format("insert into hcamFile(hfl_kubun, kubun_no, hfl_path, hfl_name) " + 
								"values('%s', %d, '%s', '%s'); ", hcamFile.getHfl_kubun(), max_shbNo, hcamFile.getHfl_path(), hcamFile.getHfl_name());
			stmt.execute(hcamFile_sql);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			close(rs);
			close(stmt);
		}
	}
	
	/* 게시글 수정 */
	public void changeBoard(SharingBoardDTO board, HcamFileDTO hcamFile) {
		
		Statement stmt = null;
		
		try {
			stmt = conn.createStatement();
			
			// 1.sharingBoard 테이블 update
			String sql = String.format("update sharingBoard set shb_ctgry = '%s', shb_title = '%s', shb_content = '%s' where shb_no = %d;"
						, board.getShb_ctgry(), board.getShb_title(), board.getShb_content(), board.getShb_no());
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
			e.printStackTrace();
		} finally{
			close(stmt);
		}
	}
	
	/* 게시글 삭제 */
	public void deleteBoard(int shb_no) {
		
		Statement stmt = null;
		
		try {
			stmt = conn.createStatement();
			
			// 1. 댓글 테이블 삭제
			String sbc_sql = "delete from ShbComment where shb_no = " + shb_no;
			stmt.executeUpdate(sbc_sql);
			
			// 2. 게시판 테이블 삭제
			String shb_sql = "delete from sharingBoard where shb_no = " + shb_no;
			stmt.executeUpdate(shb_sql);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			close(stmt);
		}
	}
	
	/* 게시글 조회 */
	public SharingBoardDTO getBoardByShbNo(int shb_no) {
		
		Statement stmt = null;
		ResultSet rs = null;
		
		SharingBoardDTO board = new SharingBoardDTO();
		
		try {
			stmt = conn.createStatement();
			
			String sql = "select shb.*, date_format(shb_date, '%Y-%m-%d %H:%i') as shb_fmDate from sharingBoard shb where shb_no = '" + shb_no + "';";
			rs = stmt.executeQuery(sql);
			
			if(rs.next()) {
				board.setShb_no(rs.getInt("shb_no"));
				board.setShb_ctgry(rs.getString("shb_ctgry"));
				board.setMem_no(rs.getInt("mem_no"));
				board.setShb_title(rs.getString("shb_title"));
				board.setShb_content(rs.getString("shb_content"));
				board.setShb_cnt(rs.getInt("shb_cnt"));
				board.setShb_likeCnt(rs.getInt("shb_likeCnt"));
				board.setShb_date(rs.getString("shb_fmDate"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			close(rs);
			close(stmt);
		}
		
		return board;
	}
	
	/* 게시글의 댓글 전체 조회 */
	public ArrayList<ShbCommentDTO> getCommentByShbno(int shb_no) {
		
		Statement stmt = null;
		ResultSet rs = null;
		
		ArrayList<ShbCommentDTO> comments = new ArrayList<ShbCommentDTO>();
		
		try {
			stmt = conn.createStatement();
			
			String sql = "select sbc.*, date_format(sbc_date, '%Y-%m-%d %H:%i') as sbc_fmDate from shbComment sbc where shb_no = " + shb_no + " order by sbc_RE_GRP asc, sbc_RE_SEQ asc;";
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				ShbCommentDTO comment = new ShbCommentDTO();
				
				comment.setShb_no(rs.getInt("shb_no"));
				comment.setSbc_no(rs.getInt("sbc_no"));
				comment.setMem_no(rs.getInt("mem_no"));
				comment.setSbc_RE_GRP(rs.getInt("sbc_RE_GRP"));
				comment.setSbc_RE_LEV(rs.getInt("sbc_RE_LEV"));
				comment.setSbc_RE_SEQ(rs.getInt("sbc_RE_SEQ"));
				comment.setSbc_RE_SUPER(rs.getInt("sbc_RE_SUPER"));
				comment.setSbc_content(rs.getString("sbc_content"));
				comment.setSbc_useYN(rs.getInt("sbc_useYN"));
				comment.setSbc_date(rs.getString("sbc_fmDate"));
				
				comments.add(comment);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			close(rs);
			close(stmt);
		}
		
		return comments;
	}
	
	/* 게시글의 댓글 content 조회 */
	public String getCommentBySbcno(int sbc_no) {
		
		Statement stmt = null;
		ResultSet rs = null;
		
		String sbc_content = "";
		
		try {
			stmt = conn.createStatement();
			
			String sql = "select sbc_content from ShbComment where sbc_no = " + sbc_no;
			rs = stmt.executeQuery(sql);
			
			
			if(rs.next()) {
				sbc_content = rs.getString("sbc_content");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			close(rs);
			close(stmt);
		}
		
		return sbc_content;
	}
	
	/* 게시글의 댓글 작성 */
	public void insertComment(int shb_no, int mem_no, String sbc_content) {
		
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.createStatement();
			
			// 1.ShbComment 그룹번호 max+1 select
			rs = stmt.executeQuery("select ifnull(max(sbc_RE_GRP)+1,1) as max_GRP from ShbComment where shb_no = " + shb_no + ";");
			int max_GRP = 1;
			if(rs.next()) {
				max_GRP = rs.getInt("max_GRP");
			}
			
			// 2.ShbComment insert
			// 대댓글이 아닌 댓글은 sbc_RE_GRP 컬럼은 1로 고정, sbc_RE_LEV 컬럼도 1로 고정
			// insert into ShbComment(sbc_no, shb_no, mem_no, sbc_RE_GRP, sbc_RE_LEV, sbc_RE_SEQ, sbc_content) -- 댓글pk, 게시글No, 댓글사람, 댓글그룹번호, 댓글 level 혹은 depth, 대댓글No, 댓글 내용
			// values(1, 3, 1, 1, 1, 1, '1');
			String comment_sql = String.format("insert into ShbComment(shb_no, mem_no, sbc_RE_GRP, sbc_RE_LEV, sbc_RE_SEQ, sbc_content) values(%d, %d, %d, %d, %d, '%s')"
								,shb_no, mem_no, max_GRP, 1, 1, sbc_content);
			stmt.execute(comment_sql);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			close(rs);
			close(stmt);
		}
	}
	
	/* 게시글의 댓글에 댓글(대댓글) 작성 */
	public void insertReComment(ShbCommentDTO comment) {
		
		Statement stmt = null;
		ResultSet rs = null;
		
		int shb_no = comment.getShb_no();
		int sbc_RE_GRP = comment.getSbc_RE_GRP();
		// 대댓글은 기존
		int sbc_RE_LEV = comment.getSbc_RE_LEV() + 1;
		
		try {
			stmt = conn.createStatement();
			
			// 1.ShbComment 대댓글No max+1 select
			rs = stmt.executeQuery("select ifnull(max(sbc_RE_SEQ)+1,1) as max_SEQ from shbComment where shb_no = " + shb_no + " and sbc_RE_GRP = " + sbc_RE_GRP + ";");
			int max_SEQ = 1;
			if(rs.next()) {
				max_SEQ = rs.getInt("max_SEQ");
			}
			
			// 2.ShbComment 대댓글 insert
			// insert into ShbComment(sbc_no, shb_no, mem_no, sbc_RE_GRP, sbc_RE_LEV, sbc_RE_SEQ, sbc_content) -- 댓글pk, 게시글No, 댓글사람, 댓글그룹번호, 댓글 level 혹은 depth, 대댓글No, 댓글 내용
			// values(1, 3, 1, 1, 1, 1, '1');
			String comment_sql = String.format("insert into ShbComment(shb_no, mem_no, sbc_RE_GRP, sbc_RE_LEV, sbc_RE_SEQ, sbc_RE_SUPER, sbc_content) values(%d, %d, %d, %d, %d, %d, '%s')"
								,shb_no, comment.getMem_no(), sbc_RE_GRP, sbc_RE_LEV, max_SEQ, comment.getSbc_no(), comment.getSbc_content());
			stmt.execute(comment_sql);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			close(rs);
			close(stmt);
		}
	}
	
	/* 게시글의 댓글 수정 */
	public void updateComment(ShbCommentDTO comment) {
		
		Statement stmt = null;
		
		try {
			stmt = conn.createStatement();
			
			// 1.sharingBoard 테이블 update
			String sql = String.format("update ShbComment set sbc_content = '%s' where sbc_no = %d;"
						,comment.getSbc_content(), comment.getSbc_no());
			stmt.executeUpdate(sql);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			close(stmt);
		}
	}
	
	/* 게시글의 댓글 삭제 */
	public void deleteComment(int sbc_no) {
		
		Statement stmt = null;
		
		try {
			stmt = conn.createStatement();
			
			// 1.sharingBoard 테이블 update
			String sql = String.format("update ShbComment set sbc_useYN = %d where sbc_no = %d;", 0, sbc_no);
			stmt.executeUpdate(sql);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			close(stmt);
		}
	}
}
