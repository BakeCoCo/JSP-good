<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인/로그아웃</title>
</head>
<body>

<%
	request.setCharacterEncoding("UTF-8");
//	로그인 버튼이 클릭되면 넘어오는 데이터(id, password)를 받는다.
	String id = "";
	String pw = "";
	try {
		id = request.getParameter("id").trim();
		pw = request.getParameter("password").trim();
	} catch(Exception e) { }
	
//	id가 hong 이고 pw가 123456 이면 로그인 처리한다.
	out.println("<script>");
	if(id.equals("hong") && pw.equals("123456")) {
//		로그인 되었으므로 로그인 정보를 session에 저장한다.
		session.setAttribute("id", id);
		session.setAttribute("name", "관리자");
		session.setAttribute("login", "yes");		// 로그인 정보
		out.println("alert('" + session.getAttribute("name") + "님 어서오세요~~~~~')");
	} else if(id.length() + pw.length() != 0) {
		out.println("alert('아이디 또는 비밀번호가 올바르지 않습니다.')");
	}
	out.println("</script>");
	
//	로그아웃 버튼이 클릭되면 넘어오는 데이터(logout)를 받는다.
	String logout = request.getParameter("logout");

//	로그아웃 정보가 넘어왔으면 로그아웃 처리를 한다.
	if(logout != null && logout.equals("yes")) {
		out.println("<script>");
		out.println("alert('" + session.getAttribute("name") + "님 안녕히가세요~~~~~')");
		out.println("</script>");
//		로그아웃 되었으므로 session에서 로그인 정보를 제거한다.
		session.removeAttribute("id");
		session.removeAttribute("name");
		session.removeAttribute("login");
	}
	
//	session에서 로그인 정보를 읽어와 로그인 상태, 로그아웃 상태의 화면을 브라우저에 표시한다.
	String login = (String) session.getAttribute("login");
	if(login != null && login.equals("yes")) {
%>
		로그인 성공<br/>
		<%=session.getAttribute("name")%>님 안녕하세요<br/>
		${name}님 안녕하세요<br/>
		<input type="button" value="로그아웃" onclick="location.href='?logout=yes'"/>
<%
	} else {
%>
		<form action="?" method="post">
			id <input type="text" name="id"/><br/>
			pw <input type="password" name="password"/><br/>
			<input type="submit" value="로그인"/>
		</form>
<%
	}
%>


</body>
</html>













