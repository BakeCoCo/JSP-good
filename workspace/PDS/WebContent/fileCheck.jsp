<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String name = request.getParameter("name");
	String subject = request.getParameter("subject");
	String filename1 = request.getParameter("filename1");
	String filename2 = request.getParameter("filename2");
%>
<html>
<head>
<title>파일 업로드 확인 및 다운로드</title>
</head>
<body>
올린 사람 : <%=name%><br>
제목 : <%=subject%><br>

<%--
파일명1 :
<a href="<%=request.getContextPath()%>/upload/<%=filename1%>"><%=filename1%></a>
<br> 파일명2 :
<a href="<%=request.getContextPath()%>/upload/<%=filename2%>"><%=filename2%></a>
--%>
 
<p>다운로드<br/>
<br> 파일명1 :
<a href="download.jsp?filename=<%=filename1%>"><%=filename1%></a>
<br> 파일명2 :
<a href="download.jsp?filename=<%=filename2%>"><%=filename2%></a>
<p>
</body>
</html>






