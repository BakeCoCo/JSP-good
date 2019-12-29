package kr.koreait.memoList;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException;

public class DBUtil {

//	mysql에 연결하는 Connection을 리턴하는 메소드
	public static Connection getMysqlConnection() {
		Connection conn = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/javaam?useUnicode=true&characterEncoding=UTF-8";
			String user = "root";
			String password = "0000";
			conn = DriverManager.getConnection(url, user, password);
		} catch(ClassNotFoundException e) {
			System.out.println("드라이버 클래스가 없거나 로드할 수 없습니다.<br/>");
		} catch(MySQLSyntaxErrorException e) {
			System.out.println("mysql에 데이터베이스가 없습니다.<br/>");
		} catch(SQLException e) {
			System.out.println("데이터베이스 연결 정보가 올바르지 않습니다.<br/>");
		}
		return conn;
	}
	
//	데이터베이스 작업에 사용한 객체를 닫는 메소드
	public static void close(Connection conn) {
		if(conn != null) { try { conn.close(); } catch(SQLException e) { e.printStackTrace(); } }
	}
	public static void close(Statement stmt) {
		if(stmt != null) { try { stmt.close(); } catch(SQLException e) { e.printStackTrace(); } }
	}
	public static void close(PreparedStatement pstmt) {
		if(pstmt != null) { try { pstmt.close(); } catch(SQLException e) { e.printStackTrace(); } }
	}
	public static void close(ResultSet rs) {
		if(rs != null) { try { rs.close(); } catch(SQLException e) { e.printStackTrace(); } }
	}
	
}












