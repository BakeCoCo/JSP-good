package kr.koreait.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.koreait.vo.GuestbookVO;
import kr.koreait.vo.Param;

public class GuestbookDAO {

	private static GuestbookDAO instance = new GuestbookDAO();
	private GuestbookDAO() { }
	public static GuestbookDAO getInstance() { return instance; }
	
//	InsertService 클래스에서 mapper와 테이블에 저장할 데이터가 저장된 객체를 넘겨받고 guestbook.xml 파일의 insert sql 명령을 실행하는
//	메소드
	public void insert(SqlMapClient mapper, GuestbookVO vo) throws SQLException {
//		System.out.println(vo);
		System.out.println("GuestbookDAO 클래스의 insert() 메소드 실행");
//		insert("실행할 sql 명령의 id"[, sql 명령으로 전달할 데이터]) => delete(), update(), queryForObject(), queryForList() 모두 같다.
		mapper.insert("insert", vo);
	}
	
//	SelectService 클래스에서 호출되는 mapper를 넘겨받고 테이블에 저장된 전체 글의 개수를 얻어오는 guestbook.xml 파일의 select sql 
//	명령을 실행하는 메소드
	public int selectCount(SqlMapClient mapper) throws SQLException {
		System.out.println("GuestbookDAO 클래스의 selectCount() 메소드 실행");
//		queryForObject() : select sql 명령의 실행 결과가 1건일 경우 사용한다. => 리턴 타입이 Object 타입이다
//		queryForList() : select sql 명령의 실행 결과가 여러건일 경우 사용한다. => 리턴 타입이 List 타입이다.
//		queryForObject()나 queryForList() 메소드는 실행하고 난 후 반드시 메소드의 리턴 타입으로 형변환을 시켜야 한다.
//		queryForObject()는 selectOne()로 queryForList()는 selectList()로 mybatis 에서 메소드 이름이 변경된다.
		return (int) mapper.queryForObject("selectCount");
	}
	
//	SelectService 클래스에서 호출되는 mapper와 한 페이지 분량의 글의 시작 인덱스와 끝 인덱스가 저장된 HashMap 객체를 넘겨받고 테이블에
//	저장된 전체 글 중에서 한 페이지 분량의 글을 얻어오는 guestbook.xml 파일의 select sql 명령을 실행하는 메소드
	public ArrayList<GuestbookVO> selectList(SqlMapClient mapper, HashMap<String, Integer> hmap) throws SQLException {
		System.out.println("GuestbookDAO 클래스의 selectList() 메소드 실행");
		return (ArrayList<GuestbookVO>) mapper.queryForList("selectList", hmap);
	}
	
//	SelectService 클래스에서 호출되는 mapper와 수정 또는 삭제할 글 번호를 넘겨받고 테이블에 저장된 글 한 건을 얻어오는 guestbook.xml 
//	파일의 select sql 명령을 실행하는 메소드
	public GuestbookVO selectByIdx(SqlMapClient mapper, int idx) throws SQLException {
		System.out.println("GuestbookDAO 클래스의 selectByIdx() 메소드 실행");
		return (GuestbookVO) mapper.queryForObject("selectByIdx", idx);
	}
	
//	DeleteService 클래스에서 호출되는 mapper와 삭제할 글 번호를 넘겨받고 테이블에 저장된 글 한 건을 삭제하는 guestbook.xml 파일의
//	delete sql 명령을 실행하는 메소드
	public void delete(SqlMapClient mapper, int idx) throws SQLException {
		System.out.println("GuestbookDAO 클래스의 delete() 메소드 실행");
		mapper.delete("delete", idx);
	}
	
//	UpdateService 클래스에서 호출되는 mapper와 수정할 데이터가 저장된 객체를 넘겨받고 테이블에 저장된 글 한 건을 수정하는 
//	guestbook.xml 파일의 update sql 명령을 실행하는 메소드
	public void update(SqlMapClient mapper, GuestbookVO vo) throws SQLException {
		System.out.println("GuestbookDAO 클래스의 update() 메소드 실행");
		mapper.update("update", vo);
	}

//	SelectService 클래스에서 호출되는 mapper와 검색어(내용)를 넘겨받고 테이블에 저장된 전체 글 중에서 memo에 검색어를 포함하는 글의
//	개수를 얻어오는 guestbook.xml 파일의 select sql 명령을 실행하는 메소드
	public int selectCountMemo(SqlMapClient mapper, String item) throws SQLException {
		System.out.println("GuestbookDAO 클래스의 selectCountMemo() 메소드 실행");
		return (int) mapper.queryForObject("selectCountMemo", item);
	}
	
//	SelectService 클래스에서 호출되는 mapper와 startNo, endNo, 검색어(내용)를 넘겨받고 테이블에 저장된 전체 글 중에서 memo에 검색어를
//	포함하는 글 중에서 한 페이지 분량의 글을 얻어오는 guestbook.xml 파일의 select sql 명령을 실행하는 메소드
	public ArrayList<GuestbookVO> selectListMemo(SqlMapClient mapper, Param param) throws SQLException {
		System.out.println("GuestbookDAO 클래스의 selectListMemo() 메소드 실행");
		return (ArrayList<GuestbookVO>) mapper.queryForList("selectListMemo", param);
	}
	
//	SelectService 클래스에서 호출되는 mapper와 검색어(이름)를 넘겨받고 테이블에 저장된 전체 글 중에서 name에 검색어를 포함하는 글의
//	개수를 얻어오는 guestbook.xml 파일의 select sql 명령을 실행하는 메소드
	public int selectCountName(SqlMapClient mapper, String item) throws SQLException {
		System.out.println("GuestbookDAO 클래스의 selectCountName() 메소드 실행");
		return (int) mapper.queryForObject("selectCountName", item);
	}
	
//	SelectService 클래스에서 호출되는 mapper와 startNo, endNo, 검색어(이름)를 넘겨받고 테이블에 저장된 전체 글 중에서 name에 검색어를
//	포함하는 글 중에서 한 페이지 분량의 글을 얻어오는 guestbook.xml 파일의 select sql 명령을 실행하는 메소드
	public ArrayList<GuestbookVO> selectListName(SqlMapClient mapper, Param param) throws SQLException {
		System.out.println("GuestbookDAO 클래스의 selectListName() 메소드 실행");
		return (ArrayList<GuestbookVO>) mapper.queryForList("selectListName", param);
	}
	
//	SelectService 클래스에서 호출되는 mapper와 검색어(이름+내용)를 넘겨받고 테이블에 저장된 전체 글 중에서 name과 memo에 검색어를 
//	포함하는 글의 개수를 얻어오는 guestbook.xml 파일의 select sql 명령을 실행하는 메소드
	public int selectCountNameMemo(SqlMapClient mapper, String item) throws SQLException {
		System.out.println("GuestbookDAO 클래스의 selectCountNameMemo() 메소드 실행");
		return (int) mapper.queryForObject("selectCountNameMemo", item);
	}

//	SelectService 클래스에서 호출되는 mapper와 startNo, endNo, 검색어(이름+내용)를 넘겨받고 테이블에 저장된 전체 글 중에서 name과
//	memo에 검색어를 포함하는 글 중에서 한 페이지 분량의 글을 얻어오는 guestbook.xml 파일의 select sql 명령을 실행하는 메소드
	public ArrayList<GuestbookVO> selectListNameMemo(SqlMapClient mapper, Param param) throws SQLException {
		System.out.println("GuestbookDAO 클래스의 selectListNameMemo() 메소드 실행");
		return (ArrayList<GuestbookVO>) mapper.queryForList("selectListNameMemo", param);
	}
	
//	SelectService 클래스에서 호출되는 mapper, 카테고리, 검색어를 넘겨받고 테이블에 저장된 전체 글 중에서 카테고리에 따른 검색어를 
//	포함하는 글의 개수를 얻어오는 guestbook.xml 파일의 select sql 명령을 실행하는 메소드
	public int selectCountMulti(SqlMapClient mapper, Param param) throws SQLException {
		System.out.println("GuestbookDAO 클래스의 selectCountMulti() 메소드 실행");
		return (int) mapper.queryForObject("selectCountMulti", param);
	}
	
//	SelectService 클래스에서 호출되는 mapper와 startNo, endNo, 카테고리, 검색어를 넘겨받고 테이블에 저장된 전체 글 중에서 카테고리에
//	따른 검색어를 검색어를 포함하는 글 중에서 한 페이지 분량의 글을 얻어오는 guestbook.xml 파일의 select sql 명령을 실행하는 메소드
	public ArrayList<GuestbookVO> selectListMulti(SqlMapClient mapper, Param param) throws SQLException {
		System.out.println("GuestbookDAO 클래스의 selectCountMulti() 메소드 실행");
		return (ArrayList<GuestbookVO>) mapper.queryForList("selectListMulti", param);
	}
	
}






