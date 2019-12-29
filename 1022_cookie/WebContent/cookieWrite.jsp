<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쿠키 쓰기</title>
</head>
<body>

<%
//	쿠키는 서버가 클라이언트에 남기는(보내는) 작은 정보 조각을 말한다.
//	쿠키를 만들때는 한 번에 한 개씩 만들고 읽어올 때는 한꺼번에 모두 읽어온다.
//	new Cookie("쿠키 이름", 쿠키 내용)
	Cookie cookie = new Cookie("id", "hong");	// 쿠키를 만든다.
	response.addCookie(cookie);					// 쿠키를 클라이언트로 보낸다.
	
//	Cookie cookie2 = new Cookie("name", "아롱이");		// 한글 인코딩 문제로 쿠키를 addCookie할 때 에러가 발생된다.
//	쿠키 내용으로 한글을 사용하려면 UTF-8로 반드시 인코딩 작업을 해야한다.
	Cookie cookie2 = new Cookie("name", URLEncoder.encode("아롱이", "UTF-8"));

//	setMaxAge() : 인수로 지정된 시간(초) 만큼 쿠키가 클라이언트에 유지되는 시간을 지정한다.
	cookie2.setMaxAge(10);

	response.addCookie(cookie2);
%>
쿠키 저장 완료!!<br/>

</body>
</html>
















