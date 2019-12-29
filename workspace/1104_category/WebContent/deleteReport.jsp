<%@page import="kr.koreait.vo.CategoryVO"%>
<%@page import="kr.koreait.service.CategoryService"%>
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

<jsp:useBean id="vo" class="kr.koreait.vo.CategoryVO">
	<jsp:setProperty property="*" name="vo"/>
</jsp:useBean>

<%
	CategoryService service = CategoryService.getInstance();
//	삭제한 카테고리 이름을 신고 메시지를 표시하기 위해 삭제할 카테고리 한 건을 테이블에서 얻어온다.
	CategoryVO original = service.selectByIdx(vo.getIdx());

//	신고 버튼이 클릭되면 deleteReport 필드의 값을 1증가 시킨다.
	service.deleteReport(vo.getIdx());

//	카테고리 신고 후 신고 메시지를 출력하고 카테고리 목록을 출력하는 페이지로 이동한다.
//	response.sendRedirect("list.jsp");
	out.println("<script>");
	out.println("alert('" + original.getCategory() + " 카테고리 신고완료!!!')");
	out.println("location.href='list.jsp'");
	out.println("</script>");
%>

</body>
</html>





