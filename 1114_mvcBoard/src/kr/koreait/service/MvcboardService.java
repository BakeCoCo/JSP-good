package kr.koreait.service;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import kr.koreait.dao.MvcboardDAO;
import kr.koreait.mybatis.MySession;
import kr.koreait.vo.MvcboardList;
import kr.koreait.vo.MvcboardVO;

public class MvcboardService {

	private static MvcboardService instance = new MvcboardService();
	private MvcboardService() { }
	public static MvcboardService getInstance() { return instance; }
	
//	insertOK.nhn으로 요청이 들어오면 컨트롤러에서 실행되는 메소드로 저장할 메인글이 저장된 request 객체를 넘겨받고 mapper를 얻어오는
//	메소드
	public void insert(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("MvcboardService 클래스의 insert() 메소드 실행");
//		System.out.println("이름 : " + request.getParameter("name"));
//		System.out.println("제목 : " + request.getParameter("subject"));
//		System.out.println("내용 : " + request.getParameter("content"));
		SqlSession mapper = MySession.getSession();
//		request 객체로 넘어온 insert.jsp에서 폼에 입력한 데이터를 받아서 MvcboardVO 클래스 객체에 저장한다.
		String name = request.getParameter("name");
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		MvcboardVO vo = new MvcboardVO(name, subject, content);
//		MvcboardVO vo = new MvcboardVO();
//		vo.setName(name);
//		vo.setSubject(subject);
//		vo.setContent(content);
//		System.out.println(vo);
//		DAO 클래스의 insert.jsp에서 입력한 데이터를 저장하는 insert sql 명령을 실행하는 메소드를 실행한다.
		MvcboardDAO.getInstance().insert(mapper, vo);
		mapper.commit();
		mapper.close();
	}
	
//	list.nhn으로 요청이 들어오면 컨트롤러에서 실행되는 메소드로 mapper를 얻어오고 브라우저에 출력할 한 페이지 분량의 글과 페이지
//	작업에 사용할 8개의 변수를 기억하는 클래스의 객체를 만들어서 request 영역에 저장하는 메소드
	public void selectList(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("MvcboardService 클래스의 selectList() 메소드 실행");
		SqlSession mapper = MySession.getSession();
		MvcboardDAO dao = MvcboardDAO.getInstance();
		
//		list.nhn이 요청될 때 넘어오는 브라우저에 표시할 페이지 번호를 받는다.
//		브라우저에 표시할 페이지 번호가 정상적으로 넘어왔으면 넘어온 페이지 번호로, 정상적으로 넘어오지 않았으면 1로 브라우저에 
//		표시할 페이지 번호를 설정한다.
		int currentPage = 1;
		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		} catch(Exception e) { }
//		한 페이지에 표시할 글의 개수를 정한다.
		int pageSize = 10;
//		테이블에 저장된 전체 글의 개수를 얻어온다.
		int totalCount = dao.selectCount(mapper);
//		System.out.println(totalCount);
//		한 페이지 분량의 글과 페이지 작업에 사용할 8개의 변수를 초기화 시키는 클래스(MvcboardList)의 객체를 만든다.
		MvcboardList mvcboardList = new MvcboardList(pageSize, totalCount, currentPage);
//		한 페이지 분량의 글을 얻어오기 위해 시작 인덱스 번호와 끝 인덱스 번호를 기억하는 HashMap 객체를 만들고 값을 넣어준다.
		HashMap<String, Integer> hmap = new HashMap<String, Integer>();
		hmap.put("startNo", mvcboardList.getStartNo());
		hmap.put("endNo", mvcboardList.getEndNo());
//		한 페이지 분량의 글을 얻어와서 MvcboardList 클래스의 한 페잊 분량의 글을 기억하는 mvcboardList ArrayList에 넣어준다.
		mvcboardList.setMvcboardList(dao.selectList(mapper, hmap));
//		System.out.println(mvcboardList);
//		한 페이지 분량의 글 목록과 페이지 작업에 사용할 8개의 변수가 저장된 객체를 request 영역에 넣어준다.
		request.setAttribute("mvcboardList", mvcboardList);
		mapper.close();
	}
	
//	increment.nhn으로 요청이 들어오면 컨트롤러에서 실행되는 메소드로 mapper를 얻어오고 조회수를 증가시키는 메소드
	public void increment(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("MvcboardService 클래스의 increment() 메소드 실행");
		SqlSession mapper = MySession.getSession();
//		request 객체에 저장되서 넘어오는 조회수를 증가시킬 글번호를 받는다.
		int idx = Integer.parseInt(request.getParameter("idx"));
//		조회수를 증가시키는 메소드를 호출한다.
		MvcboardDAO.getInstance().increment(mapper, idx);
		mapper.commit();
		mapper.close();
	}
	
//	contentView.nhn으로 요청이 들어오면 컨트롤러에서 실행되는 메소드로 mapper를 얻어오고 조회수를 증가시킨 글 한 건을 얻어와서
//	request 영역에 저장하는 메소드
	public void selectByIdx(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("MvcboardService 클래스의 selectByIdx() 메소드 실행");
		SqlSession mapper = MySession.getSession();
//		request 객체로 넘어오는 얻어올 글 번호와 작업 후 돌아갈 페이지 번호를 받는다.
		int idx = Integer.parseInt(request.getParameter("idx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
//		조회수를 증가시킨 글(브라우저에 표시할 글) 한 건을 얻어와 MvcboardVO 클래스 객체에 저장한다.
		MvcboardVO vo = MvcboardDAO.getInstance().selectByIdx(mapper, idx);
//		System.out.println(vo);
//		브라우저에 표시할 글, 작업후 돌아갈 페이지 번호, "\r\n"을 request 영역에 저장한다.
		request.setAttribute("vo", vo);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("rn", "\r\n");
		mapper.close();
	}

//	delete.nhn으로 요청이 들어오면 컨트롤러에서 실행되는 메소드로 mapper를 얻어오고 글 한 건을 삭제하는 메소드
	public void delete(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("MvcboardService 클래스의 delete() 메소드 실행");
		SqlSession mapper = MySession.getSession();
//		request 객체로 넘어오는 삭제할 글 번호를 받아서 글 번호에 해당되는 글을 삭제하는 메소드를 호출한다.
		int idx = Integer.parseInt(request.getParameter("idx"));
		MvcboardDAO.getInstance().delete(mapper, idx);
		mapper.commit();
		mapper.close();
	}
	
//	update.nhn으로 요청이 들어오면 컨트롤러에서 실행되는 메소드로 mapper를 얻어오고 글 한 건을 수정하는 메소드
	public void update(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("MvcboardService 클래스의 update() 메소드 실행");
		SqlSession mapper = MySession.getSession();
//		request 객체로 넘어오는 수정할 글 번호와 수정할 데이터를 받아서 글 번호에 해당되는 글을 수정하는 메소드를 호출한다.
		int idx = Integer.parseInt(request.getParameter("idx"));
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		MvcboardVO vo = new MvcboardVO();
		vo.setIdx(idx);
		vo.setSubject(subject);
		vo.setContent(content);
		MvcboardDAO.getInstance().update(mapper, vo);
		mapper.commit();
		mapper.close();
	}
	
//	replyInsert.nhn으로 요청이 들어오면 컨트롤러에서 실행되는 메소드로 mapper를 얻어오고 조건에 만족하는 seq를 1씩 증가 시킨 후
//	답글을 저장하는 메소드
	public void replyInsert(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("MvcboardService 클래스의 update() 메소드 실행");
		SqlSession mapper = MySession.getSession();
		MvcboardDAO dao = MvcboardDAO.getInstance();
		
//		request 객체로 넘어오는 데이터를 받는다.
		int idx = Integer.parseInt(request.getParameter("idx"));
		int ref = Integer.parseInt(request.getParameter("ref"));
		int lev = Integer.parseInt(request.getParameter("lev"));
		int seq = Integer.parseInt(request.getParameter("seq"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		String name = request.getParameter("name");
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		
//		받은 데이터를 MvcboardVO 클래스에 저장한다.
//		답글은 메인글 보다 안쪽으로 들여쓰기를 해야하기 때문에 1커야 하고 질문글 바로 아래에 나와야 하기 때문에 lev과 seq는 1씩 
//		증가시켜 저장한다.
		MvcboardVO vo = new MvcboardVO();
		vo.setIdx(idx);
		vo.setRef(ref);
		vo.setLev(lev + 1);
		vo.setSeq(seq + 1);
		vo.setName(name);
		vo.setSubject(subject);
		vo.setContent(content);
		
//		같은 글 그룹(ref)에서 답글이 출력될 위치(seq) 이후의 모든 글의 출력될 위치를 1씩 증가시키는 메소드
		HashMap<String, Integer> hmap = new HashMap<String, Integer>();
		hmap.put("ref", vo.getRef());
		hmap.put("seq", vo.getSeq());
		dao.seqIncrement(mapper, hmap);

//		답글을 테이블에 저장한다.
		dao.replyInsert(mapper, vo);
		
		mapper.commit();
		mapper.close();
	}
	
}









