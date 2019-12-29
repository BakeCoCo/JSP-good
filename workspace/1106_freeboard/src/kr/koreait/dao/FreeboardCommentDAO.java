package kr.koreait.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;

import kr.koreait.vo.FreeboardCommentVO;

public class FreeboardCommentDAO {

	private static FreeboardCommentDAO instance = new FreeboardCommentDAO();
	private FreeboardCommentDAO() { }
	public static FreeboardCommentDAO getInstance() { return instance; }
	
//	FreeboardCommentService 클래스에서 mapper와 댓글 데이터가 저장된 객체를 넘겨받고 freeboardcomment.xml 파일의 insert sql 명령을
//	실행하는 메소드
	public void insertComment(SqlSession mapper, FreeboardCommentVO vo) throws Exception {
		System.out.println("FreeboardCommentDAO 클래스의 insert() 메소드 실행");
		mapper.insert("insertComment", vo);
	}
	
//	FreeboardCommentService 클래스에서 mapper와 메인글의 글 번호를 넘겨받고 freeboardcomment.xml 파일의 select sql 명령을 실행하는 
//	메소드
	public ArrayList<FreeboardCommentVO> selectCommentList(SqlSession mapper, int idx) {
		System.out.println("FreeboardCommentDAO 클래스의 selectCommentList() 메소드 실행");
		return (ArrayList<FreeboardCommentVO>) mapper.selectList("selectCommentList", idx);
	}
	
//	FreeboardCommentService 클래스에서 mapper와 메인글의 글 번호를 넘겨받고 댓글의 개수를 얻어오는 freeboard.xml 파일의 select sql 명령을 
//	실행하는 메소드
	public int commentCount(SqlSession mapper, int idx) {
		System.out.println("FreeboardCommentService 클래스의 commentCount() 메소드 실행");
		return (int) mapper.selectOne("commentCount", idx);
	}
	
//	FreeboardCommentService 클래스에서 mapper와 댓글의 글 번호를 넘겨받고 댓글 한 건을 얻어오는 freeboard.xml 파일의 select sql 명령을 
//	실행하는 메소드
	public FreeboardCommentVO selectCommentByIdx(SqlSession mapper, int idx) {
		System.out.println("FreeboardCommentService 클래스의 selectCommentByIdx() 메소드 실행");
		return (FreeboardCommentVO) mapper.selectOne("selectCommentByIdx", idx);
	}
	
//	FreeboardCommentService 클래스에서 mapper와 삭제할 댓글의 글 번호를 넘겨받고 댓글 한 건을 삭제하는 freeboard.xml 파일의 delete sql
//	명령을 실행하는 메소드
	public void deleteComment(SqlSession mapper, int idx) {
		System.out.println("FreeboardCommentService 클래스의 deleteComment() 메소드 실행");
		mapper.delete("deleteComment", idx);
	}
	
//	FreeboardCommentService 클래스에서 mapper와 수정할 댓글이 저장된 객체를 넘겨받고 댓글 한 건을 삭제하는 freeboard.xml 파일의 
//	delete sql 명령을 실행하는 메소드
	public void updateComment(SqlSession mapper, FreeboardCommentVO vo) {
		System.out.println("FreeboardCommentService 클래스의 updateComment() 메소드 실행");
		mapper.update("updateComment", vo);
	}

}
