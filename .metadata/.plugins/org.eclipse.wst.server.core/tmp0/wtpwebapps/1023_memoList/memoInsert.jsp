<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="kr.koreait.memoList.DBUtil"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
//	한글 깨짐을 방지하고 memoList4.jsp에서 넘어오는 데이터와 접속자 ip 주소를 받는다.
	request.setCharacterEncoding("UTF-8");
	String name = request.getParameter("name");
	String password = request.getParameter("password");
	String memo = request.getParameter("memo");
	String ip = request.getRemoteAddr();
	
//	데이터베이스에 접속한다.
	Connection conn = DBUtil.getMysqlConnection();

	/*
//	Statement를 사용해 memoList4.jsp에서 넘겨받은 데이터와 ip 주소를 테이블에 저장한다.
//	sql 명령을 만든다.
	String sql = "insert into memoList (name, password, memo, ip) values ('" + name + "', '" + password + "', '" + memo + "', '" + 
		ip + "')";
//	out.println(sql + "<br/>");
//	Statement를 이용해 sql 명령을 실행할 준비한다.
	Statement stmt = conn.createStatement();
//	sql 명령을 실행한다.
//	executeUpdate() : 테이블이 갱신되는 sql 명령을 실행한다. => insert, delete, update
//	executeQuery() : 테이블이 갱신되지 않는 sql 명령을 실행한다. => select
	stmt.executeUpdate(sql);
	*/
	
//	PreparedStatement 사용해 memoList4.jsp에서 넘겨받은 데이터와 ip 주소를 테이블에 저장한다.
//	sql 명령을 만든다.
	String sql = "insert into memoList (name, password, memo, ip) values (?, ?, ?, ?)";
//	PreparedStatement 이용해 sql 명령을 임시로 실행한다.
	PreparedStatement pstmt = conn.prepareStatement(sql);
//	"?"에 데이터를 넣어준다.
	pstmt.setString(1, name);
	pstmt.setString(2, password);
	pstmt.setString(3, memo);
	pstmt.setString(4, ip);
//	sql 명령을 실행한다.
	pstmt.executeUpdate();

//	PreparedStatement

//	데이터베이스 작업에 사용한 객체를 닫는다.
//	DBUtil.close(stmt);
	DBUtil.close(pstmt);
	DBUtil.close(conn);
	
//	테이블에 저장된 데이터를 브라우저에 출력하기 위해서 memoList4.jsp로 넘겨준다.
	response.sendRedirect("memoList4.jsp");
%>

</body>
</html>















