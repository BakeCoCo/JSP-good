<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
//	조회수를 증가시킨 글 한 건을 브라우저에 표시해야 하므로 조회수를 증가시킨 글 번호를 받는다.
	int idx = Integer.parseInt(request.getParameter("idx"));
//	조회수가 증가된 글을 보는 화면에서 글 목록으로 돌아갈 때 필요한 돌아갈 페이지 번호를 받는다.
	int currentPage = Integer.parseInt(request.getParameter("currentPage"));
//	response.sendRedirect("list.nhn?currentPage=" + currentPage);
//	조회수를 증가시켰으므로 조회수를 증가시킨 글 한 건을 얻어오는 요청을 한다.
	response.sendRedirect("contentView.nhn?idx=" + idx + "&currentPage=" + currentPage);
%>

</body>
</html>