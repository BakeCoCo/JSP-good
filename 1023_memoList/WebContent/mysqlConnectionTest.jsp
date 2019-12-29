<%@page import="java.sql.SQLException"%>
<%@page import="com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mysql에 연결하기</title>
</head>
<body>

<%
	Connection conn = null;
	try {
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3306/javaam?useUnicode=true&characterEncoding=UTF-8";
		String user = "root";
		String password = "0000";
		conn = DriverManager.getConnection(url, user, password);
		
		out.println("연결성공 : " + conn + "<br/>");
		
	} catch(ClassNotFoundException e) {
		out.println("드라이버 클래스가 없거나 로드할 수 없습니다.<br/>");
	} catch(MySQLSyntaxErrorException e) {
		out.println("mysql에 데이터베이스가 없습니다.<br/>");
	} catch(SQLException e) {
		out.println("데이터베이스 연결 정보가 올바르지 않습니다.<br/>");
	} finally {
		if(conn != null) { try { conn.close(); } catch(SQLException e) { e.printStackTrace(); } }
	}
%>

</body>
</html>














