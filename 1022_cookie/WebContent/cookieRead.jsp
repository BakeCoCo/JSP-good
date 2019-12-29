<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쿠키 읽기</title>
</head>
<body>

<%
//	쿠키를 읽어올 때는 여러개를 한꺼번에 읽어오기 때문에 배열로 받는다.
	Cookie[] cookies = request.getCookies();
//	out.println(cookies + "<br/>");

//	JSESSIONID : jsp가 session에서 사용하는 시스템 쿠키로 동일한 사용자의 접근 여부를 판단한다.
	for(Cookie cookie : cookies) {
//		getName() : 쿠키 이름을 얻어온다.
//		out.println("쿠키 이름 : " + cookie.getName() + "<br/>");
//		getValue() : 쿠키에 저장된 내용을 얻어온다.
//		out.println("쿠키에 저장된 내용 : " + cookie.getValue() + "<br/>");

//		내용이 한글인 쿠키를 저장할 때는 에러가 발생되기 때문에 반드시 인코딩 과정을 거쳐 저장해야 하지만 읽어올 때는 그냥 읽어와도
//		에러가 발생되지 않는다. => 다만... 인코딩된 유니코드 자체를 읽어오기 때문에 읽을 수 없다.
//		out.println(cookie.getName()  +  " : " + cookie.getValue() + "<br/>");		// 한글을 유니코드로 읽어온다.
//		저장된 내용이 한글인 쿠키는 읽어올 때 디코딩 과정을 거쳐야 한글을 읽을 수 있다.
		out.println(cookie.getName()  +  " : " + URLDecoder.decode(cookie.getValue(), "UTF-8") + "<br/>");
	}
%>

</body>
</html>












