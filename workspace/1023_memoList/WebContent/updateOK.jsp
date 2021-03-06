<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.koreait.memoList.DBUtil"%>
<%@page import="java.sql.Connection"%>
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
//	memoDelete.jsp에서 넘어오는 수정할 글번호(idx), 수정 후 돌아갈 페이지 번호(currentPage), 수정하기 위해 입력한 비밀번호(password), 
//	수정할 내용(name, memo)을 받는다.
	int idx = Integer.parseInt(request.getParameter("idx"));
	int currentPage = Integer.parseInt(request.getParameter("currentPage"));
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String memo = request.getParameter("memo");
	
//	수정하기 위해 입력한 비밀번호(password)와 수정할 글의 비밀번호(rs.getString("password"))를 비교하기 위해 수정할 글 한 건을 얻어온다.
	Connection conn = DBUtil.getMysqlConnection();
	String sql = "select * from memoList where idx = ?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, idx);
	ResultSet rs = pstmt.executeQuery();
	rs.next();
	
//	수정하기 위해 입력한 비밀번호와 수정할 글의 비밀번호를 비교한다.
	out.println("<script>");
	if(password.trim().equals(rs.getString("password").trim())) {
//		비밀번호가 일치하므로 글을 수정한다.
		sql = "update memoList set name = ?, memo = ? where idx = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, name);
		pstmt.setString(2, memo);
		pstmt.setInt(3, idx);
		pstmt.executeUpdate();
		out.println("alert('" + idx + "번 글 수정완료')");
	} else {
//		비밀번호가 일치하지 않기 때문에 에러 메시지를 출력한다.
		out.println("alert('비밀번호가 올바르지 않습니다.')");
	}
	DBUtil.close(conn);
	out.println("location.href='memoList4.jsp?currentPage=" + currentPage + "'");
	out.println("</script>");
%>

</body>
</html>









