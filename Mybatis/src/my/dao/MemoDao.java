package my.dao;

import org.apache.ibatis.session.SqlSession;

import my.model.Memo;
import my.mybatis.MySession;

public class MemoDao {
	private static MemoDao instance = new MemoDao();
	private MemoDao(){};
	public static MemoDao getInstance(){
		return instance;
	}
	//=================================================
	public int insert(Memo m){
		SqlSession mapper = MySession.getSession();
		int cnt = mapper.insert("insertMemo", m);
		mapper.commit();
		mapper.close();
		return cnt;
	}
	public int getCount(){
		SqlSession session  = MySession.getSession();
		int cnt = (Integer)session.selectOne("getCount");
		session.close();
		return cnt;
	}
	public Memo selectByIdx(int idx){
		SqlSession session  = MySession.getSession();
		Memo m = (Memo)session.selectOne("selectByIdx",idx);
		session.close();
		return m;
	}
}
