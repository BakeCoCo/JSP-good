package kr.koreait.service;

import java.sql.SQLException;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.koreait.dao.GuestbookDAO;
import kr.koreait.ibatis.MyAppSqlConfig;
import kr.koreait.vo.GuestbookVO;

public class UpdateService {

	private static UpdateService instance = new UpdateService();
	private UpdateService() { }
	public static UpdateService getInstance() { return instance; }

//	update.jsp에서 호출되는 수정할 글 번호를 입력받고 mapper를 얻어온 후 GuestbookDAO 클래스의 글 한 건을 수정하는 메소드를 호출하는
//	메소드
	public void update(GuestbookVO vo) {
		System.out.println("UpdateService 클래스의 update() 메소드 실행");
		SqlMapClient mapper = MyAppSqlConfig.getSqlMapInstance();
		try {
			GuestbookDAO.getInstance().update(mapper, vo);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
}




