<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myInfo.jsp에서 전송된 데이터 확인하기</title>
</head>
<body>

myInfoOK.jsp 입니다.<br/>
<!-- myInfo.jsp에서 넘어오는 데이터를 받는다. -->
<%
//	form에 입력된 데이터가 post 방식으로 전송될 때 한글이 깨지는 현상을 방지한다.
//	최초의 getParameter() 메소드가 실행되기 전에 아래의 내용을 코딩하면 한글이 깨지는 현상을 방지할 수 있다.
	request.setCharacterEncoding("UTF-8");

//	tomcat server 7.0 이전 버전에서는 get 방식을 사용할 때도 한글이 깨진다.
//	get 방식을 사용하는데 한글이 깨질 경우 Servers 폴더의 server.xml 파일을 열고 64번 줄의 Connector 태그에 URIEncoding="UTF-8"
//	속성을 추가하면 get 방식을 사용할 때 한글이 깨지지 않는다. => 서버를 설치하고 딱 1번만 하면 된다.

//	request.getParameter("name속성") : 이전 페이지에서 넘어오는 데이터를 받는다. => 넘어오는 데이터는 무조건 문자열로 넘어온다.
	String name = request.getParameter("name");
	out.println("이름 : " + name + "<br/>");
	String id = request.getParameter("id");
	out.println("아이디 : " + id + "<br/>");
	String password = request.getParameter("password");
	out.println("비밀번호 : " + password + "<br/>");
	
	int age = 0;
	try {
		age = Integer.parseInt(request.getParameter("age"));
		out.println(name + "님은 " + age + "살 입니다.<br/>");
		out.println(name + "님은 내년에 " + (age + 1) + "살 입니다.<br/>");
	} catch (Exception e) {
//		out.println("잘못된 나이가 입력되었습니다.<br/>");
		out.println("<script>");
		out.println("alert('잘못된 나이가 입력되었습니다')");
		out.println("</script>");
	}
	
	boolean gender = Boolean.parseBoolean(request.getParameter("gender"));
	out.println(name + "님은 " + (gender ? "남자" : "여자") + " 입니다.<br/>");

//	checkbox는 여러 항목을 선택할 수 있는데 getParameter() 메소드를 이용해서 받으면 맨 처음에 선택한 값 한 개만 받아온다.
//	checkbox에서 넘어오는 데이터를 받을 때는 넘어오는 항목이 여러개일 수 있기 때문에 getParameterValues() 메소드로 받아서 배열에
//	저장해서 처리해야 한다.
//	String hobbies = request.getParameter("hobbies");
	String[] hobbies = request.getParameterValues("hobbies");
	out.println(name + "님의 취미는 ");
	try {
		for(int i = 0; i < hobbies.length; i++) {
			if(i > 0) {
				out.println(", ");
			}
			out.println(hobbies[i]);
		}
	} catch (Exception e) {
		out.println("글세요... 저는 공부밖에 안해서 ");
	}
	out.println(" 입니다.<br/>");
	
	String travel = request.getParameter("travel");
	out.println(name + "님은 " + travel + "에 가고 싶어 합니다.<br/>");
	
	String content = request.getParameter("content");
//	태그 사용 가능, 줄바꿈 불가능
//	out.println(name + "님이 남긴말 " + content + "<br/>");
//	태그 사용 불가능, 줄바꿈 불가능
//	out.println(name + "님이 남긴말 " + content.replace("<", "&lt;").replace(">", "&gt;") + "<br/>");
//	태그 사용 가능, 줄바꿈 가능
//	out.println(name + "님이 남긴말 " + content.replace("\r\n", "<br/>") + "<br/>");
//	태그 사용 불가능, 줄바꿈 가능
	out.println(name + "님이 남긴말<br/>" + content.replace("<", "&lt;").replace(">", "&gt;").replace("\r\n", "<br/>") + "<br/>");
%>

</body>
</html>











