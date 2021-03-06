<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<!-- indirect 디렉티브를 사용해서 중복되는 jsp 코드 삽입하기 -->
<%@ include file="loginTest.jsp"%>

<hr/>

<!-- indirect 액션 태그를 이용해서 중복되는 jsp 코드 삽입하기 -->
<jsp:include page="loginTest.jsp"></jsp:include>
<!--
	html은 <tag> ~ </tag> 사이에 아무런 내용도 쓸 필요가 없으면 </tag>를 생략해도 된다.
	jsp 액션 태그는 xml 문법을 따르기 때문에 </tag>를 생략하면 에러가 발생된다.
	</tag>를 생략할 수 있는데 시작 태그의 ">" 앞에 "/"를 입력하면 된다. => <tag /> 방식으로 하면 된다.
-->
<jsp:include page="loginTest.jsp"/>

</body>
</html>










