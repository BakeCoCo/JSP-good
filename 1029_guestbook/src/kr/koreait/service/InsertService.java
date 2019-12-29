package kr.koreait.service;

import java.sql.SQLException;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.koreait.dao.GuestbookDAO;
import kr.koreait.ibatis.MyAppSqlConfig;
import kr.koreait.vo.GuestbookVO;

//	InsertService 클래스는 insert sql 명령이 실행되기 전에 실행해야 할 작업이 있으면 실행하는 클래스
public class InsertService {

//	singleton 패턴은 프로그램에서 한 순간에 단 한 개의 객체만 필요한 경우 만들어 사용한다.
//	singleton 패턴 코딩방법
//	1. 자기 자신의 객체를 기본 생성자를 사용해서 정적 멤버로 선언한다.
	private static InsertService instance = new InsertService();
//	2. 클래스 외부에서 객체를 생성할 수 없도록 기본 생성자의 접근 권한을 private으로 변경한다.
	private InsertService() { }
//	3. 자기 자신의 객체를 리턴하는 정적 메소드를 만든다.
	public static InsertService getInstance() { return instance; }
	
//	insertOK.jsp에서 넘어오는 테이블에 저장할 데이터가 저장된 객체를 넘겨받고 mapper를 얻어오는 메소드
	public void insert(GuestbookVO vo) {
//		System.out.println(vo);
		System.out.println("InsertService 클래스의 insert() 메소드 실행");
		
//		mapper를 얻어온다.
//		mapper에는 데이터베이스에 연결하는 Connection과 데이터베이스에 연결한 후 실행해야 할 sql 명령이 저장되어 있다.
		SqlMapClient mapper = MyAppSqlConfig.getSqlMapInstance();
		
//		dao 클래스의 sql 명령을 실행하는 메소드를 실행하기 전에 필요한 작업이 있으면 실행한다.
		
//		실제 sql 명령을 실행하는 GuestbookDAO 클래스의 메소드를 호출한다.
		try {
			GuestbookDAO.getInstance().insert(mapper, vo);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
}








