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
//	페이지 작업에 사용할 8개의 변수를 선언한다. => 계산에 의한 값을 가져야 하는 변수는 0으로 초기화 시킨다.
	int pageSize = 10;			// 한 페이지에 표시할 글의 개수
	int totalCount = 0;			// 테이블에 저장된 전체 글의 개수
	int totalPage = 0;			// 테이블에 저장된 전체 글의 개수를 한 페이지에 표시할 글의 개수로 나눈 전체 페이지 개수
	int currentPage = 1;		// 현재 브라우저에 표시되는 페이지 번호
//	select 명령 실행결과 인덱스 값은 mysql은 0부터 시작하고 oracle은 1부터 시작한다.
	int startNo = 0;			// 현재 브라우저에 표시되는 페이지 시작 글의 인덱스
	int endNo = 0;				// 현재 브라우저에 표시되는 페이지 마지막 글의 인덱스, oracle에서 사용한다.
	int startPage = 0;			// 페이지 이동 하이퍼링크 또는 버튼의 시작 페이지 번호
	int endPage = 0;			// 페이지 이동 하이퍼링크 또는 버튼의 마지막 페이지 번호

	Connection conn = DBUtil.getMysqlConnection();
	
//	===============================================================================================================================

//	totalCount에 테이블에 저장된 전체 글의 개수를 얻어와 저장시킨다.
	String sql = "select count(*) from memoList";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
//	테이블에 저장된 글이 있으면 저장된 글의 개수를 얻어올 것이고 저장된 글이 하나도 없으면 0을 얻어올 것이므로 if로 비교할 필요없다.
	rs.next();
	totalCount = rs.getInt(1);
//	out.println("totalCount : " + totalCount + "<br/>");

//	totalPage에 전체 페이지 개수를 계산해서 저장한다.
	totalPage = (totalCount - 1) / pageSize + 1;
//	out.println("totalPage : " + totalPage + "<br/>");

//	===============================================================================================================================

//	이전 페이지에서 넘어오는 화면에 표시할 페이지 번호를 받는다.
//	게시판(memoList2.jsp)이 최초로 실행되거나 memoList.jsp에서 호출될 때 넘어오는 currentPage가 없으므로 null 이다.
//	null에 parseInt() 메소드를 실행하면 NumberFormatException이 발생되므로 반드시 예외 처리를 해야한다.
//	정상적으로 currentPage가 넘어오면 숫자로 바꿔 저장하지만 그렇치 않으면 parseInt() 메소드를 실행하지 않고 catch 블록으로 넘어가기
//	때문에 currentPage는 초기값인 1이 유지된다.
	try {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
//		현재 화면에 표시되는 페이지 번호는 전체 페이지 개수 보다 클 수 없으므로 화면에 표시할 페이지 번호가 전체 페이지 개수보다 큰
//		값이 넘어올 경우 전체 페이지 개수로 수정한다.
		currentPage = currentPage > totalPage ? totalPage : currentPage;
	} catch(NumberFormatException e) { }
	
//	===============================================================================================================================

//	startNo에 현재 화면에 표시될 페이지 시작 글의 인덱스 번호를 계산한다.
//	mysql은 select sql 명령을 실행했을 때 맨 처음 나오는 글의 인덱스 번호가 0이다. => oracle은 인덱스가 1부터 시작된다.
	startNo = (currentPage - 1) * pageSize;			// oracle은 결과에 1을 더한다.
//	mysql은 limit를 사용하면 되기 때문에 endNo를 계산할 필요 없지만 oracle은 limit가 없기 때문에 endNo를 계산해야 한다.
	endNo = startNo + pageSize - 1;
//	마지막 페이지에 표시되는 글의 개수는 반드시 화면에 표시할 글의 개수 만큼 표시되지 않는다.
//	한 페이지에 표시할 마지막 글의 인덱스 번호는 전체 글의 개수 보다 커지면 안되므로 마지막 글의 인덱스 번호가 전체 글의 개수 보다
//	커지면 전체 글의 개수로 마지막 글의 인덱스 번호를 수정한다.
	endNo = endNo > totalCount ? totalCount : endNo;

//	===============================================================================================================================

//	브라우저에 표시할 한 페이지 분량의 글을 limit를 이용해서 얻어온다.
	sql = "select * from memoList order by idx desc limit ?, ?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, startNo);
	pstmt.setInt(2, pageSize);
	rs = pstmt.executeQuery();
%>	
	
<table width="1000" align="center" border="1" cellpadding="5" cellspacing="0">
	<tr>
		<td width="80" align="center">글번호</td>
		<td width="80" align="center">이름</td>
		<td width="640" align="center">메모</td>
		<td width="100" align="center">작성일</td>
		<td width="100" align="center">ip</td>
	</tr>
	
	<tr>
		<td colspan="5" align="right">
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
	</tr>
<%
		} while(rs.next());
	} else {
%>
	<tr>
		<td colspan="5">
			<marquee>테이블에 저장된 글이 없습니다.</marquee>
		</td>
	</tr>
<%
	}
%>

	<!-- 1페이지 부터 마지막 페이지 까지 이동할 수 있는 하이퍼링크 또는 버튼을 만든다. -->
	<tr>
		<td colspan="5" align="center">
<%
	for(int i = 1; i <= totalPage; i++) {
		if(currentPage == i) {
%>
			<%-- <span>[<%=i%>]</span> --%>
			<%-- <input type="button" value="<%=i%>" disabled="disabled"/> --%>
			<button disabled="disabled"><%=i%></button>
<%
		} else {
%>
			<%-- <a href="?currentPage=<%=i%>">[<%=i%>]</a> --%>
			<%-- <input type="button" value="<%=i%>" onclick="location.href='?currentPage=<%=i%>'"/> --%>
			<button onclick="location.href='?currentPage=<%=i%>'"><%=i%></button>
<%
		}
	}
%>
		</td>
	</tr>
	
	<tr>
		<td colspan="5" align="center">
<%
	for(int i = 1; i <= totalPage; i++) {
		if(currentPage == i) {
			/* out.println("<span>[" + i + "]</span>"); */
			out.println("<input type='button' value='" + i + "' disabled='disabled'/>");
		} else {
			/* out.println("<a href='?currentPage=" + i + "'>[" + i + "]</a>"); */
			out.println("<input type='button' value='" + i + "' onclick='location.href=\"?currentPage=" + i + "\"'/>");
		}
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











