<%@page import="kr.koreait.dbcpTest.DBUtil"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>commonsDBCP</title>
</head>
<body>

<%
//	lib 폴더에 commons-dbcp-1.4.jar, commons-pool-1.5.7.jar 파일을 복사해 넣는다. => commonsDBCP 드라이버 클래스
//	src 폴더에 pool.jocl 파일을 작성한다. => pool.jocl 파일을 복사해 넣는다. => 데이터베이스 연결정보

	Connection conn = null;
	try {
		Class.forName("com.mysql.jdbc.Driver");						// mysql 드라이버 클래스를 읽어온다.
		Class.forName("org.apache.commons.dbcp.PoolingDriver");		// commons DBCP 드라이버 클래스를 읽어온다.
		String url = "jdbc:apache:commons:dbcp:/pool";				// 데이터베이스 연결 정보가 설정된 파일의 경로와 파일 이름
		conn = DriverManager.getConnection(url);					// 데이터베이스에 연결한다.
		
		out.println("연결 성공 : " + conn + ".<br/>");
		
	} catch(ClassNotFoundException e) {
		out.println("드라이버 클래스가 없거나 로드할 수 없습니다.<br/>");
	} catch(MySQLSyntaxErrorException e) {
		out.println("데이터베이스가 없습니다.<br/>");
	} catch(SQLException e) {
		out.println("데이터베이스 연결 정보가 올바르지 않습니다.<br/>");
	} finally {
		DBUtil.close(conn);
	}
%>

</body>
</html>















