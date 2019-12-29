<%@page import="my.mybatis.MySession"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="my.dao.MemoDao"%>
<%@page import="my.model.Memo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	Memo m = new Memo();
	m.setName("쥔장");
	m.setPassword("1234");
	m.setMemo("잘써라\n하하하하\n잘될까?");
	
	if(MemoDao.getInstance().insert(m) == 0) {
		out.println("실패~~~");
	} else {
		out.println("성공~~~");
	}
	
	out.println(MemoDao.getInstance().getCount() + "개<br/>");
	out.println(MemoDao.getInstance().selectByIdx(3));
	out.println("<hr/>");
	out.println(MemoDao.getInstance().selectByIdx(4));
%>	
</body>
</html>