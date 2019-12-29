<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="kr.koreait.vo.GuestbookVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.koreait.vo.GuestbookList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>방명록 보기</title>

<style type="text/css">
	.button {
	  background-color: #4CAF50; /* Green */
	  border: none;
	  color: white;
	  padding: 6px 10px;
	  text-align: center;
	  text-decoration: none;
	  display: inline-block;
	  font-size: 14px;
	  margin: 2px 1px;
	  /* -webkit-transition-duration: 0.4s; */ /* Safari */
	  /* transition-duration: 0.4s; */
	  cursor: pointer;
	}
	
	.button1 {
	  background-color: white; 
	  color: black; 
	  border: 2px solid white;
	}
	
	.button1:hover {
	  background-color: white;
	  color: black;
	  border: 2px solid red;
	}
	
	.button2 {
	  background-color: white; 
	  color: black; 
	  border: 2px solid red;
	  cursor: wait;
	}
</style>

</head>
<body>

<%
	request.setCharacterEncoding("UTF-8");
//	list.jsp에서 한 페이지 분량의 글 목록과 페이지 작업에 사용할 8개의 변수를 초기화시켜서 request 영역에 저장한 GuestbookList 클래스
//	객체를 받는다. => request 영역에 저장된 내용은 Object 타입으로 받아오기 때문에 반드시 형변환을 시켜야 한다.
	GuestbookList guestbookList = (GuestbookList) request.getAttribute("guestbookList");
//	out.println(guestbookList + "<br/>");

//	브라우저에 출력할 한 페이지 분량의 글 목록(guestbookList.getGuestbookList())만 꺼내서 별도의 ArrayList에 저장시켜 사용한다.
	ArrayList<GuestbookVO> view = guestbookList.getGuestbookList();
//	for(GuestbookVO vo : view) {
//		out.println(vo + "<br/>");
//	}
%>

<table width="1000" align="center" border="1" cellpadding="5" cellspacing="0">
	<tr><th>방명록 보기</th></tr>
	<tr>
		<td align="right">
			<%=guestbookList.getTotalCount()%>개(<%=guestbookList.getCurrentPage()%> / <%=guestbookList.getTotalPage()%>) Page
		</td>
	</tr>
	<tr>
		<td>
<%
	if(view.size() == 0) {
		out.println("<marquee>테이블에 저장된 글이 없습니다.</marquee>");
	} else {
		
		Date date = new Date();
		SimpleDateFormat sdf1 = new SimpleDateFormat("HH:mm");
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy.MM.dd(E)");
		
//		테이블에 브라우저에 출력할 글이 있으므로 브라우저에 출력할 글이 저장된 ArrayList의 크기 만큼 반복하며 글을 출력한다.
		for(GuestbookVO vo : view) {
%>
			<table width="99%" align="center" border="0" cellpadding="5" cellspacing="0" 
<%
		if(vo.getIdx() % 2 == 1) {
			out.println("bgcolor='yellow'");
		} else {
			out.println("bgcolor='pink'");
		}
%>
			>
				<tr>
					<td>
						<%=vo.getIdx()%>. <%=vo.getName().replace("<", "&lt;").replace(">", "&gt;")%>
						(<%=vo.getIp()%>)님이 
<%
		if(date.getYear() == vo.getWriteDate().getYear() && date.getMonth() == vo.getWriteDate().getMonth() &&
				date.getDate() == vo.getWriteDate().getDate()) {
			out.println(sdf1.format(vo.getWriteDate()));
		} else {
			out.println(sdf2.format(vo.getWriteDate()));
		}
%>
						에 남긴글<br/>
						<%=vo.getMemo().replace("<", "&lt;").replace(">", "&gt;").replace("\r\n", "<br/>")%>
					</td>
				</tr>
			</table>
<%		
		}
	}
%>		
		</td>
	</tr>
	
	<!-- 페이지 이동 버튼 -->
	<tr>
		<td align="center">
<%
	if(guestbookList.getStartPage() > 1) {
%>
		<input type="button" value="start page" onclick="location.href='?currentPage=1'" title="첫 페이지 이동합니다."/>
		<input type="button" value="-10 page" onclick="location.href='?currentPage=<%=guestbookList.getStartPage() - 1%>'" 
				title="이전 10 페이지로 이동합니다."/>
<%
	} else {
%>
		<input type="button" value="start page" disabled="disabled" title="이미 첫 페이지 입니다."/>
		<input type="button" value="-10 page" disabled="disabled" title="이전 10 페이지가 없습니다."/>
<%
	}

	if(guestbookList.getCurrentPage() > 1) {
%>
		<input type="button" value="-1 page" onclick="location.href='?currentPage=<%=guestbookList.getCurrentPage() - 1%>'" 
				title="이전 페이지로 이동합니다."/>
<%
	} else {
%>
		<input type="button" value="-1 page" disabled="disabled" title="이전 페이지가 없습니다."/>
<%
	}

	for(int i = guestbookList.getStartPage(); i <= guestbookList.getEndPage(); i++) {
		if(guestbookList.getCurrentPage() == i) {
%>
			<input class="button button2" type="button" value="<%=i%>" disabled="disabled"/>
<%
		} else {
%>
			<input class="button button1" type="button" value="<%=i%>" onclick="location.href='?currentPage=<%=i%>'"/>
<%
		}
	}

	if(guestbookList.getCurrentPage() < guestbookList.getTotalPage()) {
%>
		<input type="button" value="+1 page" onclick="location.href='?currentPage=<%=guestbookList.getCurrentPage() + 1%>'" 
				title="다음 페이지로 이동합니다."/>
		
<%
	} else {
%>
		<input type="button" value="+1 page" disabled="disabled" title="다음 페이지가 없습니다."/>
<%
	}

	if(guestbookList.getEndPage() < guestbookList.getTotalPage()) {
%>
		<input type="button" value="+10 page" onclick="location.href='?currentPage=<%=guestbookList.getEndPage() + 1%>'" 
				title="다음 10 페이지로 이동합니다."/>
		<input type="button" value="end page" onclick="location.href='?currentPage=<%=guestbookList.getTotalPage()%>'" title="마지막 페이지로 이동합니다."/>
<%
	} else {
%>
		<input type="button" value="+10 page" disabled="disabled" title="다음 10 페이지가 없습니다."/>
		<input type="button" value="end page" disabled="disabled" title="이미 마지막 페이지 입니다."/>
<%
	}
%>
		</td>
	</tr>
	
	<!-- 방명록 쓰기 페이지로 이동하는 버튼 -->
	<tr>
		<td align="right">
			<input type="button" value="글쓰기" onclick="location.href='insert.jsp'"/>
		</td>
	</tr>
	
</table>

</body>
</html>










