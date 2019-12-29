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

	Connection conn = DBUtil.getCommonsDBCPConnection();
	out.println("연결 성공 : " + conn + ".<br/>");
	DBUtil.close(conn);
%>

</body>
</html>















