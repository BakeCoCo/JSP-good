<%@page import="kr.koreait.service.InsertService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	request.setCharacterEncoding("UTF-8");
%>
<!-- insert.jsp에서 넘어오는 데이터를 받는다. -->
<!-- 넘어오는 데이터가 VO 클래스에 멤버로 존재하면 useBean으로 받고 존재하지 않으면 별도로 받아서 VO 클래스 객체에 저장한다. -->
<jsp:useBean id="vo" class="kr.koreait.vo.GuestbookVO">
	<jsp:setProperty property="*" name="vo"/>
</jsp:useBean>
<%
	vo.setIp(request.getRemoteAddr());
//	out.println(vo + "<br/>");

//	Service 클래스 : sql 명령을 실행하기 전에 mapper를 얻어오거나 처리해야 할 작업을 실행한다.
//	mapper : 데이터베이스에 연결하는 Connection과 데이터베이스에 연결한 후 실행해야 할 sql 명령이 저장되어있다.
//	DAO(Data Access Object) : sql 명령만 실행한다.

//	테이블에 저장할 데이터가 저장된 객체(vo)를 service 클래스로 넘기고 데이터를 테이블에 저장하는 dao 클래스로 넘겨주기 전에 처리할
//	작업을 실행한다.
//	insert.jsp에서 넘겨받은 데이터를 테이블에 저장하는 메소드를 실행한다.
	InsertService.getInstance().insert(vo);

//	테이블에 글 1건을 저장한 후 브라우저에 출력할 한 페이지 분량의 글을 얻어오는 페이지로 넘겨준다.
	response.sendRedirect("list.jsp");
%>


</body>
</html>


















