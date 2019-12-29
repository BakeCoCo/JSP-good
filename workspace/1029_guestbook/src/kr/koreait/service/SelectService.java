package kr.koreait.service;

import java.sql.SQLException;
import java.util.HashMap;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.koreait.dao.GuestbookDAO;
import kr.koreait.ibatis.MyAppSqlConfig;
import kr.koreait.vo.GuestbookList;
import kr.koreait.vo.GuestbookVO;
import kr.koreait.vo.Param;

//	SelectService 클래스는 select sql 명령이 실행되기 전에 실행해야 할 작업이 있으면 실행하는 클래스
public class SelectService {

	private static SelectService instance = new SelectService();
	private SelectService() { }
	public static SelectService getInstance() { return instance; }
	
//	list.jsp에서 호출되는 화면에 표시할 페이지 번호를 넘겨받고 mapper를 얻어온 후 GuestbookDAO 클래스의 한 페이지 분량의 글을 얻어오는
//	메소드를 호출하는 메소드
	public GuestbookList selectList(int currentPage) {
		System.out.println("SelectService 클래스의 selectList() 메소드 실행");
		SqlMapClient mapper = MyAppSqlConfig.getSqlMapInstance();
//		한 페이지 분량의 글과 페이지 작업에 사용할 8개의 변수가 저장될 객체를 선언한다.
		GuestbookList guestbookList = null;
		GuestbookDAO dao = GuestbookDAO.getInstance();
		
		try {
//			한 페이지에 표시할 글의 개수를 정한다.
			int pageSize = 10;
//			테이블에 저장된 전체 글의 개수를 얻어온다.
			int totalCount = dao.selectCount(mapper);
//			System.out.println(totalCount);
//			pageSize, totalCount, currentPage를 GuestbookList 클래스 생성자의 인수로 넘겨서 한 페이지 분량의 글과 페이지 작업에 사용할
//			8개의 변수를 초기화 시키는 클래스 객체를 생성한다.
			guestbookList = new GuestbookList(pageSize, totalCount, currentPage);
			
//			ibatis의 parameterClass에는 데이터 타입을 반드시 1개만 적어야 한다.
			HashMap<String, Integer> hmap = new HashMap<String, Integer>();
			hmap.put("startNo", guestbookList.getStartNo());
			hmap.put("endNo", guestbookList.getEndNo());
//			mysql은 아래와 같이 endNo 대신 pageSize를 HashMap에 저장해서 넘겨야 한다.
//			hmap.put("pageSize", guestbookList.getPageSize());
			
//			한 페이지 분량(startNo ~ endNo)의 글 목록을 테이블에서 얻어와서 guestbookList 객체의 ArrayList guestbookList에 저장한다.
			guestbookList.setGuestbookList(dao.selectList(mapper, hmap));
//			System.out.println(guestbookList);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return guestbookList;
	}

//	selectByIdx.jsp에서 호출되는 수정 또는 삭제할 글 번호를 넘겨받고 mapper를 얻어온 후 GuestbookDAO 클래스의 글 한 건을 얻어오는
//	메소드를 호출하는 메소드
	public GuestbookVO selectByIdx(int idx) {
		System.out.println("SelectService 클래스의 selectByIdx() 메소드 실행");
		SqlMapClient mapper = MyAppSqlConfig.getSqlMapInstance();
		GuestbookVO vo = null;
		try {
			vo = GuestbookDAO.getInstance().selectByIdx(mapper, idx);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return vo;
	}
	
//	list.jsp에서 호출되는 화면에 표시할 페이지 번호와 검색어(내용)를 넘겨받고 mapper를 얻어온 후 GuestbookDAO 클래스의 한 페이지 
//	분량의 글을 얻어오는 메소드를 호출하는 메소드
	public GuestbookList selectListMemo(int currentPage, String item) {
		System.out.println("SelectService 클래스의 selectListMemo() 메소드 실행");
		SqlMapClient mapper = MyAppSqlConfig.getSqlMapInstance();
		GuestbookList guestbookList = null;
		GuestbookDAO dao = GuestbookDAO.getInstance();
		try {
			int pageSize = 10;
//			테이블에 저장된 전체 글 중에서 memo에 검색어를 포함한 글의 개수를 얻어온다.
			int totalCount = dao.selectCountMemo(mapper, item);
//			System.out.println(totalCount);
			guestbookList = new GuestbookList(pageSize, totalCount, currentPage);
//			memo 필드에 검색어를 포함하는 한 페이지 분량의 글을 얻어온다.
//			startNo, endNo와 item은 자료형이 다르기 때문에 HashMap 객체를 사용할 수 없고 별도의 클래스(Param)를 만들어 처리한다.
			Param param = new Param();
			param.setStartNo(guestbookList.getStartNo());
			param.setEndNo(guestbookList.getEndNo());
			param.setItem(item);
			guestbookList.setGuestbookList(dao.selectListMemo(mapper, param));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return guestbookList;
	}

//	list.jsp에서 호출되는 화면에 표시할 페이지 번호와 검색어(이름)를 넘겨받고 mapper를 얻어온 후 GuestbookDAO 클래스의 한 페이지 
//	분량의 글을 얻어오는 메소드를 호출하는 메소드
	public GuestbookList selectListName(int currentPage, String item) {
		System.out.println("SelectService 클래스의 selectListName() 메소드 실행");
		SqlMapClient mapper = MyAppSqlConfig.getSqlMapInstance();
		GuestbookList guestbookList = null;
		GuestbookDAO dao = GuestbookDAO.getInstance();
		try {
			int pageSize = 10;
//			테이블에 저장된 전체 글 중에서 name에 검색어를 포함한 글의 개수를 얻어온다.
			int totalCount = dao.selectCountName(mapper, item);
//			System.out.println(totalCount);
			guestbookList = new GuestbookList(pageSize, totalCount, currentPage);
			Param param = new Param();
			param.setStartNo(guestbookList.getStartNo());
			param.setEndNo(guestbookList.getEndNo());
			param.setItem(item);
			guestbookList.setGuestbookList(dao.selectListName(mapper, param));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return guestbookList;
	}
	
//	list.jsp에서 호출되는 화면에 표시할 페이지 번호와 검색어(이름+내용)를 넘겨받고 mapper를 얻어온 후 GuestbookDAO 클래스의 한 페이지
//	분량의 글을 얻어오는 메소드를 호출하는 메소드
	public GuestbookList selectListNameMemo(int currentPage, String item) {
		System.out.println("SelectService 클래스의 selectListNameMemo() 메소드 실행");
		SqlMapClient mapper = MyAppSqlConfig.getSqlMapInstance();
		GuestbookList guestbookList = null;
		GuestbookDAO dao = GuestbookDAO.getInstance();
		try {
			int pageSize = 10;
//			테이블에 저장된 전체 글 중에서 name과 memo에 검색어를 포함한 글의 개수를 얻어온다.
			int totalCount = dao.selectCountNameMemo(mapper, item);
//			System.out.println(totalCount);
			guestbookList = new GuestbookList(pageSize, totalCount, currentPage);
			Param param = new Param();
			param.setStartNo(guestbookList.getStartNo());
			param.setEndNo(guestbookList.getEndNo());
			param.setItem(item);
			guestbookList.setGuestbookList(dao.selectListNameMemo(mapper, param));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return guestbookList;
	}

	
//	list.jsp에서 호출되는 화면에 표시할 페이지 번호, 카테고리, 검색어를 넘겨받고 mapper를 얻어온 후 GuestbookDAO 클래스의 한 페이지
//	분량의 글을 얻어오는 메소드를 호출하는 메소드
	public GuestbookList selectListMulti(int currentPage, String category, String item) {
		System.out.println("SelectService 클래스의 selectListMulti() 메소드 실행");
		SqlMapClient mapper = MyAppSqlConfig.getSqlMapInstance();
		GuestbookList guestbookList = null;
		GuestbookDAO dao = GuestbookDAO.getInstance();
		try {
			int pageSize = 10;
			
			Param param = new Param();
			param.setCategory(category);
			param.setItem(item);
			
//			테이블에 저장된 전체 글 중에서 카테고리에 따른 검색어를 포함한 글의 개수를 얻어온다.
			int totalCount = dao.selectCountMulti(mapper, param);
//			System.out.println(totalCount);
			guestbookList = new GuestbookList(pageSize, totalCount, currentPage);
			
			param.setStartNo(guestbookList.getStartNo());
			param.setEndNo(guestbookList.getEndNo());
			
			guestbookList.setGuestbookList(dao.selectListMulti(mapper, param));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return guestbookList;
	}

}

















