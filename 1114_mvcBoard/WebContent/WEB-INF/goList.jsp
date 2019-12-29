<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
//	테이블에서 글을 삭제 또는 수정했으므로 삭제 또는 수정한 글이 있던 한 페이지 분량의 글을 얻어오는 페이지를 컨트롤러에 요청한다.
	int currentPage = Integer.parseInt(request.getParameter("currentPage"));
	response.sendRedirect("list.nhn?currentPage=" + currentPage);
%>

</body>
</html>