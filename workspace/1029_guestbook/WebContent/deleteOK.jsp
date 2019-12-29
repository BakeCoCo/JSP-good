<%@page import="kr.koreait.service.DeleteService"%>
<%@page import="kr.koreait.service.SelectService"%>
<%@page import="kr.koreait.vo.GuestbookVO"%>
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
//	delete.jsp에서 넘어오는 데이터를 받는다. => VO 클래스의 멤버는 useBean으로 받고 나머지는 별도로 받는다.
	int currentPage = Integer.parseInt(request.getParameter("currentPage"));
%>

<jsp:useBean id="vo" class="kr.koreait.vo.GuestbookVO">
	<jsp:setProperty property="*" name="vo"/>
</jsp:useBean>

<%
//	삭제할 글의 비밀번호와 삭제하기 위해 입력한 비밀번호를 비교하기 위해 삭제할 글을 테이블에서 얻어온다.
	GuestbookVO original = SelectService.getInstance().selectByIdx(vo.getIdx());

//	삭제할 글의 비밀번호와 삭제하기 위해 입력한 비밀번호가 같으면 글을 삭제한다.
//	oracle은 char로 선언한 문자 필드의 데이터를 얻어오면 필드의 자리수 보다 입력된 글자수가 적을 경우 남는 자리가 모두 공백으로 리턴
//	되므로 반드시 trim() 메소드를 사용해 불필요한 빈 칸을 없앤 후 처리해야 한다.
//	out.println("삭제할 글의 비밀번호 글자수 : " + original.getPassword().trim().length() + "<br/>");
//	out.println("삭제하기 위해 입력한 비밀번호의 글자수 : " + vo.getPassword().trim().length() + "<br/>");
	out.println("<script>");
	if(original.getPassword().trim().equals(vo.getPassword().trim())) {
//		비밀번호가 일치하므로 글을 삭제한다.
		DeleteService.getInstance().delete(vo.getIdx());
		out.println("alert('" + vo.getIdx() + "번 글 삭제완료')");
	} else {
//		비밀번호가 일치하지 않기 때문에 메시지를 출력하고 작업하던 페이지로 돌려보낸다.
		out.println("alert('비밀번호가 올바르지 않습니다.')");
	}
	out.println("location.href='list.jsp?currentPage=" + currentPage + "'");
	out.println("</script>");
%>
</body>
</html>












