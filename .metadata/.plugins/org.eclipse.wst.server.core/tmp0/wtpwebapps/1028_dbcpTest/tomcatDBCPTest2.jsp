<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="kr.koreait.dbcpTest.DBUtil"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>tomcatDBCP</title>
</head>
<body>

<%
//	lib 폴더에 tomcat-dbcp.jar 파일을 복사한다. => tomcat DBCP 드라이버 클래스
//	META-INF 폴더에 context.xml 파일을 만든다. => context.xml 파일을 복사해 넣는다. => 데이터베이스 연결정보
//	web.xml 파일에 아래의 내용을 코딩한다.
//	<resource-ref>
//		<description>tomcat DBCP mysql connection</description>
//		<res-ref-name>jdbc/TestDB</res-ref-name>
//		<res-type>javax.sql.DataSource</res-type>
//		<res-auth>Container</res-auth>
//	</resource-ref>

	Connection conn = DBUtil.getTomcatDBCPConnection();
	out.println("연결 성공 : " + conn + ".<br/>");
	DBUtil.close(conn);
%>

</body>
</html>












