package kr.koreait.dbcpTest;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

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
	
//	commons DBCP를 이용해서 mysql에 연결하는 메소드
	public static Connection getCommonsDBCPConnection() {
		Connection conn = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");						// mysql 드라이버 클래스를 읽어온다.
			Class.forName("org.apache.commons.dbcp.PoolingDriver");		// commons DBCP 드라이버 클래스를 읽어온다.
			String url = "jdbc:apache:commons:dbcp:/pool";				// 데이터베이스 연결 정보가 설정된 파일의 경로와 파일 이름
			conn = DriverManager.getConnection(url);					// 데이터베이스에 연결한다.
		} catch(ClassNotFoundException e) {
			System.out.println("드라이버 클래스가 없거나 로드할 수 없습니다.<br/>");
		} catch(MySQLSyntaxErrorException e) {
			System.out.println("데이터베이스가 없습니다.<br/>");
		} catch(SQLException e) {
			System.out.println("데이터베이스 연결 정보가 올바르지 않습니다.<br/>");
		}
		return conn;
	}
	
//	tomcat DBCP를 이용해서 mysql에 연결하는 메소드
	public static Connection getTomcatDBCPConnection() {
		Connection conn = null;
		try {
			Context initContext = new InitialContext();
			DataSource dataSource = (DataSource) initContext.lookup("java:/comp/env/jdbc/TestDB");
			conn = dataSource.getConnection();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
	
}












