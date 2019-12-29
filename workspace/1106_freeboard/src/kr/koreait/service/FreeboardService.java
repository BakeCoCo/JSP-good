package kr.koreait.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;

import kr.koreait.dao.FreeboardCommentDAO;
import kr.koreait.dao.FreeboardDAO;
import kr.koreait.mybatis.MySession;
import kr.koreait.vo.FreeboardList;
import kr.koreait.vo.FreeboardVO;

public class FreeboardService {

	private static FreeboardService instance = new FreeboardService();
	private FreeboardService() { }
	public static FreeboardService getInstance() { return instance; }
	
//	insertOK.jsp에서 테이블에 저장할 메인글이 저장된 객체를 넘겨받고 mapper를 얻어온 후 메인글을 저장하는 DAO 클래스의 insert sql
//	명령을 실행하는 메소드를 호출하는 메소드
	public void insert(FreeboardVO vo) {
		System.out.println("FreeboardService 클래스의 insert() 메소드 실행");
		SqlSession mapper = MySession.getSession();
		FreeboardDAO.getInstance().insert(mapper, vo);
		mapper.commit();
		mapper.close();
	}
	
//	list.jsp에서 브라우저에 표시할 페이지 번호를 넘겨받고 mapper를 얻어온 후 메인글 한 페이지 분량을 얻어오는 DAO 클래스의 select sql
//	명령을 실행하는 메소드를 호출하는 메소드
	public FreeboardList selectList(int currentPage) {
		System.out.println("FreeboardService 클래스의 selectList() 메소드 실행");
		SqlSession mapper = MySession.getSession();
		FreeboardDAO dao = FreeboardDAO.getInstance();
		int pageSize = 10;
		int totalCount = dao.selectCount(mapper);
//		System.out.println(totalCount);
		FreeboardList freeboardList = new FreeboardList(pageSize, totalCount, currentPage);
		HashMap<String, Integer> hmap = new HashMap<String, Integer>();
		hmap.put("startNo", freeboardList.getStartNo());
		hmap.put("endNo", freeboardList.getEndNo());
		freeboardList.setFreeboardList(dao.selectList(mapper, hmap));
		mapper.close();
		return freeboardList;
	}
	
//	increment.jsp에서 조회수를 증가시킬 글 번호를 넘겨받고 mapper를 얻어온 후 메인글의 조회수를 증가시키는 DAO 클래스의 update sql
//	명령을 실행하는 메소드를 호출하는 메소드
	public void increment(int idx) {
		System.out.println("FreeboardService 클래스의 increment() 메소드 실행");
		SqlSession mapper = MySession.getSession();
		FreeboardDAO.getInstance().increment(mapper, idx);
		mapper.commit();
		mapper.close();
	}
	
//	selectByIdx.jsp에서 메인글의 글 번호를 넘겨받고 mapper를 얻어온 후 메인글 한 건을 얻어오는 DAO 클래스의 select sql 명령을 실행하는
//	메소드를 호출하는 메소드
	public FreeboardVO selectByIdx(int idx) {
		System.out.println("FreeboardService 클래스의 selectByIdx() 메소드 실행");
		SqlSession mapper = MySession.getSession();
		FreeboardVO vo = FreeboardDAO.getInstance().selectByIdx(mapper, idx);
		mapper.close();
		return vo;
	}
	
//	deleteOK.jsp에서 삭제할 메인글의 글 번호를 넘겨받고 mapper를 얻어온 후 메인글 한 건을 삭제하는 DAO 클래스의 delete sql 명령을 
//	실행하는 메소드를 호출하는 메소드
	public void delete(int idx) {
		System.out.println("FreeboardService 클래스의 delete() 메소드 실행");
		SqlSession mapper = MySession.getSession();
		FreeboardDAO.getInstance().delete(mapper, idx);
		mapper.commit();
		mapper.close();
	}
	
//	updateOK.jsp에서 삭제할 메인글이 저장된 객체를 넘겨받고 mapper를 얻어온 후 메인글 한 건을 수정하는 DAO 클래스의 update sql 명령을 
//	실행하는 메소드를 호출하는 메소드
	public void update(FreeboardVO vo) {
		System.out.println("FreeboardService 클래스의 update() 메소드 실행");
		SqlSession mapper = MySession.getSession();
		FreeboardDAO.getInstance().update(mapper, vo);
		mapper.commit();
		mapper.close();
	}
	
//	list.jsp에서 호출되는 mapper를 얻어온 후 공지글 전체를 얻어오는 DAO 클래스의 select sql 명령을 실행하는 메소드를 호출하는 메소드
	public ArrayList<FreeboardVO> selectNotice() {
		System.out.println("FreeboardService 클래스의 selectNotice() 메소드 실행");
		SqlSession mapper = MySession.getSession();
		ArrayList<FreeboardVO> notice = FreeboardDAO.getInstance().selectNotice(mapper);
		mapper.close();
		return notice;
	}
	
}








