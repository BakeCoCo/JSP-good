<%@page import="kr.koreait.onlinepoll.PollRead"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>투표하기</title>
</head>
<body>

<%
//	투표 항목이 저장된 텍스트 파일의 데이터를 읽어서 웹 브라우저에 출력한다.
//	application.getRealPath("/") : 현재 실행중인 웹 프로그램이 구동되는 웹 서버의 실제 경로를 얻어온다.
//	out.println(application.getRealPath("/") + "poll.txt<br/>");
//	읽어들일 텍스트 파일이 위치한 웹 서버상의 실제 경로와 파일 이름을 지정한다.
	String filename = application.getRealPath("/") + "poll.txt";
//	텍스트 파일의 데이터를 읽어오는 메소드를 실행해서 리턴되는 결과를 ArrayList에 저장한다.
	ArrayList<String> poll = PollRead.pollRead(filename);
//	읽어들인 텍스트 파일의 데이터 전체를 출력한다.
//	for(String str : poll) {
//		out.println(str + "<br/>");
//	}
//	투표 항목의 개수를 계산한다.
	int itemCount = (poll.size() - 1) / 2;
//	out.println(itemCount + "<br/>");
%>

<form action="pollWrite.jsp" method="post">
<!-- cellpadding : 셀과 셀 내부에 입력한 데이터와의 간격을 지정한다. 안여백 -->
<!-- cellspacing : 셀과 셀 사이의 간격을 지정한다. -->
<table width="500" border="1" align="center" cellpadding="5" cellspacing="0">
	<!-- 투표 제목을 출력한다. -->
	<tr height="50">
		<th>
			<%=poll.get(0)%>
		</th>
	</tr>
	<!-- 투표 항목의 개수 만큼 반복하며 라디오 버튼과 투표 항목을 출력한다. -->
<%
	for(int i = 1; i <= itemCount; i++) {
%>
	<tr height="35">
		<td>
			<input type="radio" name="poll" value="<%=i%>"/>
			<%=poll.get(i)%>
		</td>
	</tr>
<%
	}
%>
	<!-- 투표하기 버튼과 결과보기 버튼을 만든다. -->
	<tr height="35">
		<td align="center">
			<input type="submit" value="투표하기"/>
			<input type="button" value="결과보기" onclick="location.href='pollResult.jsp'"/>
		</td>
	</tr>
</table>
</form>

</body>
</html>
















