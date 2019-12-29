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
//	수정한 카테고리 이름을 수정 완료 메시지에 표시하기 위해 수정할 카테고리 한 건을 테이블에서 얻어온다.
	CategoryVO original = service.selectByIdx(vo.getIdx());

//	수정 버튼이 클릭되면 해당 카테고리를 수정한다.
	service.update(vo);

//	카테고리 수정 후 수정 완료 메시지를 출력하고 카테고리 목록을 출력하는 페이지로 이동한다.
//	response.sendRedirect("list.jsp");
	out.println("<script>");
	out.println("alert('" + original.getCategory() + " 카테고리를 " + vo.getCategory() + " 카테고리로 수정완료!!!')");
	out.println("location.href='list.jsp'");
	out.println("</script>");
%>

</body>
</html>





