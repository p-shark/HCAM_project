package service;

import static db.JdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;

import dao.CommonDAO;
import dao.HotelDAO;
import dao.SharingBoardDAO;
import vo.HcamFileDTO;
import vo.SharingBoardDTO;
import vo.ShbCommentDTO;

public class ShareBoardService {
	
	/* 게시판 전체 정보 */
	public ArrayList<SharingBoardDTO> getBoardAll(int pageNo, int limit) {
		
		ArrayList<SharingBoardDTO> boards = null;
		
		// db connection
		Connection conn = getConnection();
		
		SharingBoardDAO boardDAO = SharingBoardDAO.getInstance();
		boardDAO.setConnection(conn);
		
		/* 게시판 전체 정보 */
		boards = boardDAO.getBoardAll(pageNo, limit);
		
		close(conn);
		
		return boards;
	}
	
	/* 카테고리 별 게시글 조회 */
	public ArrayList<SharingBoardDTO> getBoardByCtgry(String category, int pageNo, int limit) {
		
		ArrayList<SharingBoardDTO> boards = null;
		
		// db connection
		Connection conn = getConnection();
		
		SharingBoardDAO boardDAO = SharingBoardDAO.getInstance();
		boardDAO.setConnection(conn);
		
		/* 카테고리 별 게시글 조회 */
		boards = boardDAO.getBoardByCtgry(category, pageNo, limit);
		
		close(conn);
		
		return boards;
	}
	
	/* 검색어에 의한 게시글 조회 */
	public ArrayList<SharingBoardDTO> getBoardBySearching(String searching, int pageNo, int limit) {
		ArrayList<SharingBoardDTO> boards = null;
		
		// db connection
		Connection conn = getConnection();
		
		SharingBoardDAO boardDAO = SharingBoardDAO.getInstance();
		boardDAO.setConnection(conn);
		
		/* 검색어에 의한 게시글 조회 */
		boards = boardDAO.getBoardBySearching(searching, pageNo, limit);
		
		close(conn);
		
		return boards;
	}
	
	/* 게시글 등록 */
	public void insertBoard(SharingBoardDTO board, HcamFileDTO hcamFile) {
		// db connection
		Connection conn = getConnection();
		
		SharingBoardDAO boardDAO = SharingBoardDAO.getInstance();
		boardDAO.setConnection(conn);
		
		/* 게시글 등록 */
		boardDAO.insertBoard(board, hcamFile);
		
		commit(conn);
		
		close(conn);
	}
	
	/* 게시글 수정 */
	public void changeBoard(SharingBoardDTO board, HcamFileDTO hcamFile) {
		// db connection
		Connection conn = getConnection();
		
		SharingBoardDAO boardDAO = SharingBoardDAO.getInstance();
		boardDAO.setConnection(conn);
		
		/* 게시글 수정 */
		boardDAO.changeBoard(board, hcamFile);
		
		commit(conn);
		
		close(conn);
	}
	
	/* 게시글 삭제 */
	public void deleteBoard(int shb_no) {
		// db connection
		Connection conn = getConnection();
		
		SharingBoardDAO boardDAO = SharingBoardDAO.getInstance();
		boardDAO.setConnection(conn);
		
		/* 게시글 삭제 */
		boardDAO.deleteBoard(shb_no);
		
		commit(conn);
		
		close(conn);
	}
	
	/* 게시글 조회 */
	public SharingBoardDTO getBoardByShbNo(int shb_no) {
		SharingBoardDTO board = null;
		
		// db connection
		Connection conn = getConnection();
		
		SharingBoardDAO boardDAO = SharingBoardDAO.getInstance();
		boardDAO.setConnection(conn);
		
		/* 게시글 조회 */
		board = boardDAO.getBoardByShbNo(shb_no);
		
		close(conn);
		
		return board;
	}
	
	/* 게시글의 댓글 전체 조회 */
	public ArrayList<ShbCommentDTO> getCommentByShbno(int shb_no) {
		ArrayList<ShbCommentDTO> comments = null;
		
		// db connection
		Connection conn = getConnection();
		
		SharingBoardDAO boardDAO = SharingBoardDAO.getInstance();
		boardDAO.setConnection(conn);
		
		/* 게시글의 댓글 전체 조회 */
		comments = boardDAO.getCommentByShbno(shb_no);
		
		close(conn);
		
		return comments;
	}
	
	/* 게시글의 댓글 content 조회 */
	public String getCommentBySbcno(int sbc_no) {
		String comment = null;
		
		// db connection
		Connection conn = getConnection();
		
		SharingBoardDAO boardDAO = SharingBoardDAO.getInstance();
		boardDAO.setConnection(conn);
		
		/* 게시글의 댓글 content 조회 */
		comment = boardDAO.getCommentBySbcno(sbc_no);
		
		close(conn);
		
		return comment;
	}
	
	/* 게시글의 댓글 작성 */
	public void insertComment(int shb_no, int mem_no, String sbc_content) {
		// db connection
		Connection conn = getConnection();
		
		SharingBoardDAO boardDAO = SharingBoardDAO.getInstance();
		boardDAO.setConnection(conn);
		
		/* 게시글의 댓글 작성 */
		boardDAO.insertComment(shb_no, mem_no, sbc_content);
		
		commit(conn);
		
		close(conn);
	}
	
	/* 게시글의 댓글에 댓글(대댓글) 작성 */
	public void insertReComment(ShbCommentDTO comment) {
		// db connection
		Connection conn = getConnection();
		
		SharingBoardDAO boardDAO = SharingBoardDAO.getInstance();
		boardDAO.setConnection(conn);
		
		/* 게시글의 댓글에 댓글(대댓글) 작성 */
		boardDAO.insertReComment(comment);
		
		commit(conn);
		
		close(conn);		
	}
	
	/* 게시글의 댓글 수정 */
	public void updateComment(ShbCommentDTO comment) {
		// db connection
		Connection conn = getConnection();
		
		SharingBoardDAO boardDAO = SharingBoardDAO.getInstance();
		boardDAO.setConnection(conn);
		
		/* 게시글의 댓글 수정 */
		boardDAO.updateComment(comment);
		
		commit(conn);
		
		close(conn);	
	}
	
	/* 게시글의 댓글 삭제 */
	public void deleteComment(int sbc_no) {
		// db connection
		Connection conn = getConnection();
		
		SharingBoardDAO boardDAO = SharingBoardDAO.getInstance();
		boardDAO.setConnection(conn);
		
		/* 게시글의 댓글 삭제 */
		boardDAO.deleteComment(sbc_no);
		
		commit(conn);
		
		close(conn);	
	}
}
