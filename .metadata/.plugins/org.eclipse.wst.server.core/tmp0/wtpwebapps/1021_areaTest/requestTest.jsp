<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
//	out.println("그냥 변수 : " + var + "<br/>");		// var라는 일반 변수를 선언하지 않았으므로 에러가 발생된다.
	out.println("areaTest.jsp의 pageContext 영역 변수 : " + pageContext.getAttribute("pageContextVar") + "<br/>");
	out.println("areaTest.jsp의 request 영역 변수 : " + request.getAttribute("requestVar") + "<br/>");
	out.println("areaTest.jsp의 session 영역 변수 : " + session.getAttribute("sessionVar") + "<br/>");
	out.println("areaTest.jsp의 application 영역 변수 : " + application.getAttribute("applicationVar") + "<br/>");
	out.println("=========================================================================================<br/>");
%>

<%--
	EL(Expression Language, 표현 언어) 내장 객체 => jsp의 <%= ~ %>(표현식)를 대신해서 간단한 출력에 사용된다.
	EL 사용법 => ${영역변수이름} 또는 ${영역이름.영역변수이름} => getter 메소드를 사용한 것과 같은 효과를 낸다.
	영역 변수에 저장된 내용을 jsp로 출력하면 저장된 데이터가 없을 때 null을 출력하지만 EL은 아무것도 출력하지 않는다.
	
	영역이름Scope 내장 객체는 영역 변수 이름을 key로 하고 저장되는 데이터를 value로 하는 Map<String, Object> 형태의 객체이다.
--%>

areaTest.jsp의 pageContext 영역 변수(jsp 표현식 사용) : <%=pageContext.getAttribute("pageContextVar")%><br/>
areaTest.jsp의 pageContext 영역 변수(EL 사용) : ${pageContextScope.pageContextVar}<br/>
areaTest.jsp의 request 영역 변수 : ${requestScope.requestVar}<br/>
areaTest.jsp의 session 영역 변수 : ${sessionScope.sessionVar}<br/>
areaTest.jsp의 application 영역 변수 : ${applicationScope.applicationVar}<br/>
=========================================================================================<br/>

areaTest.jsp의 pageContext 영역 변수 : ${pageContextVar}<br/>
areaTest.jsp의 request 영역 변수 : ${requestVar}<br/>
areaTest.jsp의 session 영역 변수 : ${sessionVar}<br/>
areaTest.jsp의 application 영역 변수 : ${applicationVar}<br/>
=========================================================================================<br/>

<!--
	위의 코드는 areaTest.jsp에서 sendRedirect() 또는 forward() 메소드를 실행하고 결과를 확인하고
	아래의 코드는 현재 페이지에서 실행하고 결과를 확인한다.
-->

<%
//	pageContext.setAttribute("var", "requestTest.jsp의 pageContext 영역 변수");
//	request.setAttribute("var", "requestTest.jsp의 request 영역 변수");
//	session.setAttribute("var", "requestTest.jsp의 session 영역 변수");
	application.setAttribute("var", "requestTest.jsp의 application 영역 변수");
%>

<!--
	영역 변수에 저장된 데이터를 출력하려 할 때 영역이름Scope 객체를 사용하지 않고 영역 변수 이름만 사용하면 EL은 pageContext =>
	request => session => application 영역을 순서대로 출력하려는 변수가 존재하는가 검사해서 출력할 변수가 존재하면 출력한다.
-->

${var}

</body>
</html>
















