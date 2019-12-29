package kr.koreait.service;

import org.apache.ibatis.session.SqlSession;

import kr.koreait.dao.FreeboardCommentDAO;
import kr.koreait.mybatis.MySession;
import kr.koreait.vo.FreeboardCommentList;
import kr.koreait.vo.FreeboardCommentVO;

public class FreeboardCommentService {

	private static FreeboardCommentService instance = new FreeboardCommentService();
	private FreeboardCommentService() { }
	public static FreeboardCommentService getInstance() { return instance; }

//	commentOK.jsp에서 댓글로 저장할 데이터가 저장된 객체를 넘겨받고 mapper를 얻어온 후 DAO 클래스의 댓글을 저장하는 insert sql 명령을
//	실행하는 메소드
	public boolean insertComment(FreeboardCommentVO vo) {
		System.out.println("FreeboardCommentService 클래스의 insertComment() 메소드 실행");
		SqlSession mapper = MySession.getSession();
		try {
			FreeboardCommentDAO.getInstance().insertComment(mapper, vo);
			mapper.commit();
			mapper.close();
			return true;		// 댓글이 정상적으로 테이블에 저장되었으면 true를 리턴시킨다.
		} catch(Exception e) {
			e.printStackTrace();
			mapper.close();
			return false;		// 댓글을 테이블에 저장하지 못했으면 false를 리턴시킨다.
		}
	}
	
//	selectByIdx.jsp에서 메인글의 글 번호를 mapper를 얻어온 후 DAO 클래스의 댓글 목록을 얻어오는 select sql 명령을 실행하는 메소드
	public FreeboardCommentList selectCommentList(int idx) {
		System.out.println("FreeboardCommentService 클래스의 selectCommentList() 메소드 실행");
		SqlSession mapper = MySession.getSession();
		FreeboardCommentList freeboardCommentList = new FreeboardCommentList();
		freeboardCommentList.setFreeboardCommentList(FreeboardCommentDAO.getInstance().selectCommentList(mapper, idx));
		mapper.close();
		return freeboardCommentList;
	}
	
//	list.jsp에서 호출되는 메인글의 글 번호를 넘겨받고 mapper를 얻어온 후 댓글의 개수를 얻어오는 DAO 클래스의 select sql 명령을 
//	실행하는 메소드를 호출하는 메소드
	public int commentCount(int idx) {
		System.out.println("FreeboardService 클래스의 selectNotice() 메소드 실행");
		SqlSession mapper = MySession.getSession();
		int commentCount = FreeboardCommentDAO.getInstance().commentCount(mapper, idx);
		mapper.close();
		return commentCount;
	}
	
//	commentOK.jsp에서 호출되는 삭제할 댓글이 저장된 객체를 mapper를 얻어온 후 댓글을 삭제하는 DAO 클래스의 delete sql 명령을 실행하는
//	메소드를 호출하는 메소드
	public boolean deleteComment(FreeboardCommentVO vo) {
		System.out.println("FreeboardService 클래스의 deleteComment() 메소드 실행");
		SqlSession mapper = MySession.getSession();
		FreeboardCommentDAO dao = FreeboardCommentDAO.getInstance();
//		삭제하기 위해 입력한 비밀번호와 삭제할 댓글의 비밀번호를 비교하기 위해 삭제할 댓글 한 건을 얻어온다.
		FreeboardCommentVO original = dao.selectCommentByIdx(mapper, vo.getIdx());
		if(vo.getPassword().trim().equals(original.getPassword().trim())) {
			dao.deleteComment(mapper, vo.getIdx());
			mapper.commit();
			mapper.close();
			return true;
		} else {
			mapper.close();
			return false;
		}
	}
	
//	commentOK.jsp에서 호출되는 수정할 댓글이 저장된 객체를 mapper를 얻어온 후 댓글을 수정하는 DAO 클래스의 update sql 명령을 실행하는
//	메소드를 호출하는 메소드
	public boolean updateComment(FreeboardCommentVO vo) {
		System.out.println("FreeboardService 클래스의 updateComment() 메소드 실행");
		SqlSession mapper = MySession.getSession();
		FreeboardCommentDAO dao = FreeboardCommentDAO.getInstance();
//		수정하기 위해 입력한 비밀번호와 수정할 댓글의 비밀번호를 비교하기 위해 수정할 댓글 한 건을 얻어온다.
		FreeboardCommentVO original = dao.selectCommentByIdx(mapper, vo.getIdx());
		if(vo.getPassword().trim().equals(original.getPassword().trim())) {
			dao.updateComment(mapper, vo);
			mapper.commit();
			mapper.close();
			return true;
		} else {
			mapper.close();
			return false;
		}
	}

}








