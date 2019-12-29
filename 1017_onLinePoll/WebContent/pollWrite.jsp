<%@page import="kr.koreait.onlinepoll.PollWrite"%>
<%@page import="kr.koreait.onlinepoll.PollRead"%>
<%@page import="java.util.ArrayList"%>
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
//	pollRead.jsp에서 넘어오는 투표 데이터를 받는다.
	String temp = request.getParameter("poll");
//	out.println(temp + "<br/>");

//	투표 데이터가 넘어왔나(null 이나 공백이 아닌가) 검사한다. => 반드시 null 검사를 먼저한다.
	if(temp != null && temp.trim().length() > 0) {
		
//		넘어온 투표 데이터가 숫자인가 검사한다.
		try {
			int result = Integer.parseInt(temp);
			
//			넘어온 투표 데이터가 숫자일 경우 정상적인 투표 범위의 데이터인가 검사하기 위해서 텍스트 파일을 읽어서 투표 항목의 개수를
//			계산한다.
			String filename = application.getRealPath("/") + "poll.txt";
			ArrayList<String> poll = PollRead.pollRead(filename);
			int itemCount = (poll.size() - 1) / 2;
			
//			넘어온 투표 데이터가 정상적인 투표 범위의 데이터인가 검사한다.
			if(result >= 1 && result <= itemCount) {
				
//				여기까지 왔다는 것은 정상적인 투표 데이터가 넘어왔다는 것이므로 투표한 항목의 득표수를 증가시킨다.
//				득표수를 1증가 시킬 위치를 계산한다.
				int index = result + itemCount;
//				득표수를 1증가 시킨다. => ArrayList의 index 번째 데이터를 1증가 시킨다.
				result = Integer.parseInt(poll.get(index)) + 1;
//				증가된 득표수를 다시 ArrayList에 넣어준다.
				poll.set(index, result + "");

//				ArrayList의 데이터를 텍스트 파일에 저장하는 메소드를 실행한다.
				PollWrite.pollWrite(filename, poll);

//				투표 결과 보기 페이지로 넘겨준다.
				response.sendRedirect("pollResult.jsp");
				
			} else {
//				넘어온 투표 데이터가 정상적인 투표 범위의 숫자가 아니므로 오류 메시지를 출력하고 pollRead.jsp로 돌려보낸다.
				out.println("<script>");
				out.println("alert('투표 데이터가 정상 투표 범위가 아닙니다.')");
				out.println("location.href='pollRead.jsp'");
				out.println("</script>");
			}
		} catch (Exception e) {
//			투표 데이터가 숫자가 아니므로 오류 메시지를 출력하고 pollRead.jsp로 돌려보낸다.
			out.println("<script>");
			out.println("alert('투표 데이터가 숫자가 아닙니다.')");
			out.println("location.href='pollRead.jsp'");
			out.println("</script>");
		}
	} else {
//		투표 데이터가 넘어오지 않았으므로 오류 메시지를 출력하고 pollRead.jsp로 돌려보낸다.

//		jsp는 서버용 스크립트 언어이고 javascript는 클라이언트용 스크립트 언어이다.
//		하나의 jsp 파일에 서버용 스크립트와 클라이언트용 스크립트가 모두 사용된 경우 모든 서버용 스크립트가 먼저 실행되고 난 후
//		클라이언트용 스크립트가 실행된다. => 코딩 순서와 관계 없다.
		out.println("<script>");
		out.println("alert('투표하세요~~~~~ 콱~~~~~')");
		out.println("location.href='pollRead.jsp'");
		out.println("</script>");
		
//		response.sendRedirect() : 인수로 지정된 페이지로 이동한다.
//		response.sendRedirect("pollRead.jsp");
	}
%>

</body>
</html>


















