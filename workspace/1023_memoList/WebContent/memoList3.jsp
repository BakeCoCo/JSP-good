<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.koreait.memoList.DBUtil"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>출첵 게시판</title>

<style type="text/css">
	a:link { color: gray; text-decoration: none; }
	a:visited { color: gray; text-decoration: none; }
	a:hover { color: red; text-decoration: none; }
	a:active { color: lime; text-decoration: none; }
	
	span { background: black; color: white; }
	
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

<form action="memoInsert.jsp" method="post">
<table width="800" align="center" border="1" cellpadding="5" cellspacing="0">
	<tr>
		<th colspan="3">조금 덜 허접해 보이는 출첵 게시판 Ver 0.59</th>
	</tr>
	<tr>
		<td width="80" align="center">이름</td>
		<td width="80" align="center">비밀번호</td>
		<td width="640" align="center">메모</td>
	</tr>
	<tr>
		<td align="center">
			<input type="text" name="name" size="7"/>
		</td>
		<td align="center">
			<input type="password" name="password" size="7"/>
		</td>
		<td align="center">
			<input type="text" name="memo" size="73"/>
			<input type="submit" value="저장"/>
		</td>
	</tr>
</table>
</form>

<hr size="3" color="black"/>

<%
	int pageSize = 10;
	int totalCount = 0;
	int totalPage = 0;
	int currentPage = 1;
	int startNo = 0;
//	int endNo = 0;
	int startPage = 0;			// 페이지 이동 하이퍼링크 또는 버튼의 시작 페이지 번호
	int endPage = 0;			// 페이지 이동 하이퍼링크 또는 버튼의 마지막 페이지 번호

	Connection conn = DBUtil.getMysqlConnection();
	
	String sql = "select count(*) from memoList";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
	rs.next();
	totalCount = rs.getInt(1);
	totalPage = (totalCount - 1) / pageSize + 1;
	try {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
		currentPage = currentPage > totalPage ? totalPage : currentPage;
	} catch(NumberFormatException e) { }
	
	startNo = (currentPage - 1) * pageSize;
//	endNo = startNo + pageSize - 1;
//	endNo = endNo > totalCount ? totalCount : endNo;

	sql = "select * from memoList order by idx desc limit ?, ?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, startNo);
	pstmt.setInt(2, pageSize);
	rs = pstmt.executeQuery();
%>	
	
<table width="1100" align="center" border="1" cellpadding="5" cellspacing="0">
	<tr>
		<td width="80" align="center">글번호</td>
		<td width="80" align="center">이름</td>
		<td width="640" align="center">메모</td>
		<td width="100" align="center">작성일</td>
		<td width="100" align="center">ip</td>
		<td width="100" align="center">&nbsp</td>
	</tr>
	
	<tr>
		<td colspan="6" align="right">
			테이블에 저장된 전체 글의 개수 : <%=totalCount%>개(<%=currentPage%> / <%=totalPage%>)Page
		</td>
	</tr>
	
<%
	if(rs.next()) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd(E)");
		do {
%>
	<tr>
		<td><%=rs.getInt("idx")%></td>
		<td><%=rs.getString("name")%></td>
		<td><%=rs.getString("memo")%></td>
		<td><%=sdf.format(rs.getTimestamp("writeDate"))%></td>
		<td><%=rs.getString("ip")%></td>
		<td>
			<input type="button" value="수정" onclick=""/>
			<input type="button" value="삭제" onclick=""/>
		</td>
	</tr>
<%
		} while(rs.next());
	} else {
%>
	<tr>
		<td colspan="6">
			<marquee>테이블에 저장된 글이 없습니다.</marquee>
		</td>
	</tr>
<%
	}
%>

	<tr>
		<td colspan="6" align="center">
<%
//	페이지 이동 하이퍼링크 또는 버튼의 시작 페이지 번호와 마지막 페이지 번호를 계산한다.
	startPage = (currentPage - 1) / 10 * 10 + 1;
	endPage = startPage + 9;
//	페이지 이동 하이퍼링크 또는 버튼의 마지막 페이지 번호가 전체 페이지 수 보다 커지면 존재하지 않는 페이지 번호가 표시되므로 마지막 
//	페이지 번호를 전체 페이지 수로 변경한다.
	endPage = endPage > totalPage ? totalPage : endPage;

//	이전 10 페이지로 이동하는 버튼과 이전 페이지로 이동하는 버튼을 추가한다.
//	startPage가 1 보다 크다면 이전 10 페이지가 있다.
	if(startPage > 1) {
%>
		<input type="button" value="start page" onclick="location.href='?currentPage=1'" title="첫 페이지 이동합니다."/>
		<input type="button" value="-10 page" onclick="location.href='?currentPage=<%=startPage - 1%>'" 
				title="이전 10 페이지로 이동합니다."/>
<%
	} else {
%>
		<input type="button" value="start page" disabled="disabled" title="이미 첫 페이지 입니다."/>
		<input type="button" value="-10 page" disabled="disabled" title="이전 10 페이지가 없습니다."/>
<%
	}

//	이전 페이지로 이동하는 버튼을 추가한다.
//	currentPage가 1 보다 크다면 이전 페이지가 있다.
	if(currentPage > 1) {
%>
		<input type="button" value="-1 page" onclick="location.href='?currentPage=<%=currentPage - 1%>'" 
				title="이전 페이지로 이동합니다."/>
<%
	} else {
%>
		<input type="button" value="-1 page" disabled="disabled" title="이전 페이지가 없습니다."/>
<%
	}
	
//	10 페이지 단위로 페이지 이동 하이퍼링크 또는 버튼을 출력한다.
	for(int i = startPage; i <= endPage; i++) {
		if(currentPage == i) {
%>
			<%-- <span>[<%=i%>]</span> --%>
			<input class="button button2" type="button" value="<%=i%>" disabled="disabled"/>
<%
		} else {
%>
			<%-- <a href="?currentPage=<%=i%>">[<%=i%>]</a> --%>
			<input class="button button1" type="button" value="<%=i%>" onclick="location.href='?currentPage=<%=i%>'"/>
<%
		}
	}

//	다음 페이지로 이동하는 버튼을 추가한다.
//	currentPage가 totalPage 보다 작다면 다음 페이지가 있다.
	if(currentPage < totalPage) {
%>
		<input type="button" value="+1 page" onclick="location.href='?currentPage=<%=currentPage + 1%>'" 
				title="다음 페이지로 이동합니다."/>
		
<%
	} else {
%>
		<input type="button" value="+1 page" disabled="disabled" title="다음 페이지가 없습니다."/>
<%
	}

//	다음 10 페이지로 이동하는 버튼을 출력한다.
//	endPage가 totalPage 보다 작으면 다음 10 페이지가 있다.
	if(endPage < totalPage) {
%>
		<input type="button" value="+10 page" onclick="location.href='?currentPage=<%=endPage + 1%>'" 
				title="다음 10 페이지로 이동합니다."/>
		<input type="button" value="end page" onclick="location.href='?currentPage=<%=totalPage%>'" title="마지막 페이지로 이동합니다."/>
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
</table>
	
<%
	DBUtil.close(rs);
	DBUtil.close(pstmt);
	DBUtil.close(conn);
%>

</body>
</html>











