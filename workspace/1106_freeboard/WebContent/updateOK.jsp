<%@page import="kr.koreait.dao.FreeboardDAO"%>
<%@page import="kr.koreait.service.FreeboardService"%>
<%@page import="kr.koreait.vo.FreeboardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
//	한글 깨짐 방지하고 update.jsp에서 넘어오는 데이터를 받는다.
	request.setCharacterEncoding("UTF-8");
	int currentPage = Integer.parseInt(request.getParameter("currentPage"));
%>
<jsp:useBean id="vo" class="kr.koreait.vo.FreeboardVO">
	<jsp:setProperty property="*" name="vo"/>
</jsp:useBean>
<%
	FreeboardService service = FreeboardService.getInstance();
//	수정할 글의 비밀번호와 수정하기 위해 입력한 비밀번호를 비교하기 위해 수정할 글 한 건을 얻어온다.
	FreeboardVO original = service.selectByIdx(vo.getIdx());
//	수정할 글의 비밀번호와 수정하기 위해 입력한 비밀번호를 비교해서 같으면 글을 수정한 후 목록으로 돌아가고 같지 않으면 비밀번호가
//	올바르지 않다는 메시지를 보여준 후 목록으로 돌아간다.
	out.println("<script>");
	if(vo.getPassword().trim().equals(original.getPassword().trim())) {
		out.println("alert('" + vo.getIdx() + "번 글 수정완료!!!')");
		if(vo.getNotice().trim().equals("on")) {
			vo.setNotice("notice");
		}
		service.update(vo);
	} else {
		out.println("alert('비밀번호가 올바르지 않습니다.')");
	}
	out.println("location.href='list.jsp?currentPage=" + currentPage + "'");
	out.println("</script>");
%>

</body>
</html>













