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

<!--
	넘어오는 데이터가 VO 클래스의 멤버로 존재하면 useBean 액션 태그를 이용해서 받으면 되고 존재하지 않으면 별도로 받는다.
	이 때, 넘어오는 데이터를 받는 코딩을 하지 않아도 useBean 액션 태그가 실행되면 자동으로 받는다.
	useBean 액션 태그의 id 속성에는 생성할 객체의 이름을 적는다.
	useBean 액션 태그의 class 속성에는 객체를 생성할 클래스의 이름을 풀 패키지 이름과 같이 적는다.
	MemberVO vo = new MemberVO();와 같은 기능을 실행한다.
-->
<jsp:useBean id="vo" class="kr.koreait.useBean.MemberVO"> <!-- VO 클래스의 객체가 생성된다. -->

	<!--
		setProperty 액션 태그의 property 속성에는 setter를 멤버 변수의 이름을 적는다.
		setProperty 액션 태그의 name 속성에는 setter가 작성된 클래스 객체의 이름을 적는다.
		아래의 2줄과 같은 기능이 실행된다.
		String id = request.getParameter("id");
		vo.setId(id);
	-->
	<%--
	<jsp:setProperty property="id" name="vo"/> <!-- setter를 실행한다. -->
	<jsp:setProperty property="name" name="vo"/>
	<jsp:setProperty property="password" name="vo"/>
	<jsp:setProperty property="age" name="vo"/>
	<jsp:setProperty property="gender" name="vo"/>
	<jsp:setProperty property="ip" name="vo"/>
 	--%>
 	
 	<!-- property 속성에 "*"을 입력하면 form의 name 속성에 지정된 이름과 같은 모든 setter가 자동으로 실행된다. -->
 	<jsp:setProperty property="*" name="vo"/>
 	
</jsp:useBean>

${vo}<br/>

<!-- Date date = new Date();와 같은 기능을 실행한다. -->
<jsp:useBean id="date" class="java.util.Date"/>
${date}<br/>

</body>
</html>

















