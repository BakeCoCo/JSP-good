<%@page import="java.text.DecimalFormat"%>
<%@page import="kr.koreait.onlinepoll.PollRead"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- 지정된 시간이 경과되면 특정 웹 사이트로 이동하기 -->
<!-- <meta http-equiv="refresh" content="5, url='https://www.naver.com/'"/> -->
<!-- 지정된 시간이 경과되면 현재 페이지 새로고침 하기 -->
<meta http-equiv="refresh" content="5, url=?"/>

<title>결과보기</title>
</head>
<body>

<%
//	투표 결과를 웹 브라우저에 출력하기 위해서 텍스트 파일의 데이터를 읽어오고 투표 항목의 개수를 계산한다.
	String filename = application.getRealPath("/") + "poll.txt";
	ArrayList<String> poll = PollRead.pollRead(filename);
	int itemCount = (poll.size() - 1) / 2;

//	득표율을 계산하기 위해 총 투표수를 계산한다.
	int sum = 0;
	for(int i = itemCount + 1; i < poll.size(); i++) {
		sum += Integer.parseInt(poll.get(i));
	}
//	out.println("총 투표수 : " + sum + "<br/>");

//	숫자 데이터 출력 서식을 지정한다.
	DecimalFormat df1 = new DecimalFormat("#,##0표");
	DecimalFormat df2 = new DecimalFormat("0.0%");
%>

<table width="500" border="1" align="center" cellpadding="5" cellspacing="0">
	<tr height="50">
		<th colspan="2">
			<%=poll.get(0)%>
		</th>
	</tr>
	<!-- 전체 투표수를 출력한다. -->
	<tr height="35">
		<td align="right" colspan="2">
			전체 투표수 : <%=df1.format(sum)%>
		</td>
	</tr>
	<!-- 투표 항목의 개수 만큼 반복하며 투표 항목, 득표수, 득표율, 막대 그래프를 출력한다. -->
<%
	for(int i = 1; i <= itemCount; i++) {
		int pyo = Integer.parseInt(poll.get(i + itemCount)); /* 득표수 */
		double per = (double) pyo / sum; /* 득표율 */
%>
	<tr height="35">
		<td width="180">
			<%=poll.get(i)%>(<%=df1.format(pyo)%>) <!-- 투표 항목과 득표수 출력 -->
			<%-- <%=poll.get(i)%>(<%=df2.format(per)%>) --%> <!-- 투표 항목과 득표율 출력 -->
		</td>
		<td width="320">
			<hr size="10" color="red" width="<%=320 * per%>" align="left"/>
		</td>
	</tr>
<%
	}
%>
	<tr height="35">
		<td align="center" colspan="2">
			<input type="button" value="투표하기로 가기" onclick="location.href='pollRead.jsp'"/>
		</td>
	</tr>
</table>

</body>
</html>



















