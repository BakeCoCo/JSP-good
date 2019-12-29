<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!-- html 주석 -->
<%-- jsp 주석 --%>
<%--
	<%@ ~ %> : 디렉티브, 대부분 자동으로 입력된다. 설정에 관련된 정보를 적는다.
	<%! ~ %> : 선언부, 프로그램에서 사용할 변수나 메소드를 정의한다. => java 파일로 뽑아내서 처리한다.
	<% ~ %>  : 스크립트 릿, 일반적인 jsp 코드를 적는다. => jstl로 대체해서 사용한다.
	<%= ~ %> : 표현식, 변수에 저장된 데이터나 연산 결과를 출력한다. => EL(${ ~ })로 대체해서 사용한다.
--%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정보입력</title>
</head>
<body>

<!--
	html은 spacebar를 여러 번 눌러도 한 칸 밖에 띄어지지 않고 enter를 여러 번 눌러도 줄이 바뀌지 않는다.
	2칸 이상 띄우려면 &nbsp;를 띄울 칸의 개수 만큼 입력하고 줄을 변경하려면 <br> 태그를 사용해야 한다.
	
	현재 페이지에 입력한 데이터를 특정 페이지로 전송하려면 전송할 데이터를 입력하는 코드를 <form> ~ </form> 태그 내부에 작성한다.
	action 속성에는 전송(submit) 버튼이 클릭되면 form에 입력한 데이터가 전송될 페이지 이름을 적는다.
	=> "?"만 쓰면 현재 페이지를 의미한다. 
	method 속성에는 action 페이지로 데이터가 전송될 때 전송되는 정보가 url 창에 표시되는 여부를 지정한다.
	=> get이 기본값이며 전송되는 데이터가 url 창에 표시되고 post로 변경하면 전송되는 정보가 url 창에 표시되지 않는다.
-->

<form action="myInfoOK.jsp" method="post">
	이&nbsp;&nbsp;름 : <input type="text" name="name"/><br/>
	아이디 : <input type="text" name="id"/><br/>
	<!-- type="password"일 경우 한글을 타이핑해서 입력할 수 없다. -->
	비밀번호 : <input type="password" name="password"/><br/>
	나이 : <input type="text" name="age"/><br/>
	
	<!--
		radio와 checkbox는 같은 그룹끼리 반드시 같은 이름의 name 속성을 지정해야 한다.
		radio와 checkbox는 컨트롤 자체를 브라우저에 표시하는 기능밖에 없기 때문에 다음 페이지로 넘겨줄 데이터를 value 속성으로
		넣어줘야 한다.
	-->
	성별 : <input type="radio" name="gender" value="true">남자
		   <input type="radio" name="gender" value="false" checked="checked">여자<br/>
	취미 : <input type="checkbox" name="hobbies" value="늦잠자기">늦잠자기
		   <input type="checkbox" name="hobbies" value="지각하기" checked="checked">지각하기
		   <input type="checkbox" name="hobbies" value="게임하기">게임하기<br/>
	
	<!-- 콤보 상자 만들기 -->
	가고 싶은 여행지는?
	<select name="travel">
		<option>괌</option>
		<option>코타키나발루</option>
		<option>다낭</option>
		<option>나트랑</option>
		<option>보라카이</option>
		<option selected="selected">팔라완</option>
		<option>대만</option>
	</select><br/>
	
	<!--
		textarea는 별도로 value 속성을 가지지 않지만 <textarea> ~ </textarea> 사이에 입력한 데이터를 value로 인식한다.
		<textarea>와 </textarea> 사이에는 칸을 띄우거나 줄을 변경하지 않는다.
	-->
	<textarea rows="10" cols="50" name="content"></textarea><br/>
	
	<input type="submit" value="회원가입"/> <!-- 전송 버튼 -->
	<input type="reset" value="다시쓰기"/> <!-- 전송 버튼 -->
</form>

</body>
</html>



















