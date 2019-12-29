package kr.koreait.service;

import java.sql.SQLException;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.koreait.dao.GuestbookDAO;
import kr.koreait.ibatis.MyAppSqlConfig;

public class DeleteService {

	private static DeleteService instance = new DeleteService();
	private DeleteService() { }
	public static DeleteService getInstance() { return instance; }

//	delete.jsp에서 호출되는 삭제할 글 번호를 입력받고 mapper를 얻어온 후 GuestbookDAO 클래스의 글 한 건을 삭제하는 메소드를 호출하는
//	메소드
	public void delete(int idx) {
		System.out.println("DeleteService 클래스의 delete() 메소드 실행");
		SqlMapClient mapper = MyAppSqlConfig.getSqlMapInstance();
		try {
			GuestbookDAO.getInstance().delete(mapper, idx);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
}





