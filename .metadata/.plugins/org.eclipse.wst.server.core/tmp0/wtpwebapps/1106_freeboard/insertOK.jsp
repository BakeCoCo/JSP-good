<%@page import="kr.koreait.service.FreeboardService"%>
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
<jsp:useBean id="vo" class="kr.koreait.vo.FreeboardVO">
	<jsp:setProperty property="*" name="vo"/>
</jsp:useBean>
<%
//	insert.jsp에서 넘어온 메인글을 테이블에 저장하는 메소드를 실행한다.
	FreeboardService.getInstance().insert(vo);
//	메인글 한 페이지 분량을 얻어오는 페이지(list.jsp)로 넘겨준다.
	response.sendRedirect("list.jsp");
%>
</body>
</html>