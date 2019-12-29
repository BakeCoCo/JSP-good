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
//	복구한 카테고리 이름을 복구 메시지를 표시하기 위해 복구할 카테고리 한 건을 테이블에서 얻어온다.
	CategoryVO original = service.selectByIdx(vo.getIdx());

//	북구 버튼이 클릭되면 deleteCheck 필드를 "no"로 수정한다.
	service.deleteRestore(vo.getIdx());

//	카테고리 복구 후 복구 메시지를 출력하고 카테고리 목록을 출력하는 페이지로 이동한다.
//	response.sendRedirect("list.jsp");
	out.println("<script>");
	if(original.getDeleteReport() >= 10) {
		out.println("alert('" + original.getCategory() + " 카테고리는 신고를 만땅 먹은 카테고리라 복구 할 수 없어욧!!!')");
	} else {
		out.println("alert('" + original.getCategory() + " 카테고리 복구완료!!!')");
	}
	out.println("location.href='list.jsp'");
	out.println("</script>");
%>

</body>
</html>





