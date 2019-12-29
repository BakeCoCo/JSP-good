<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	String uploadPath = application.getRealPath("./upload");
	int size = 10 * 1024 * 1024;
	String name = "";
	String subject = "";
	String filename1 = "";
	String filename2 = "";
	try {
		MultipartRequest multi = new MultipartRequest(
			request,
			uploadPath,
			size,
			"UTF-8",
			new DefaultFileRenamePolicy()
		);
		name = multi.getParameter("name");
		subject = multi.getParameter("subject");
		Enumeration files = multi.getFileNames();
// 		while(files.hasMoreElements()){} 여러개일 경우 이명령으로 반복 처리를 해야한다.
		
		String file2 = (String) files.nextElement();
		filename2 = multi.getFilesystemName(file2);
		
		String file1 = (String) files.nextElement();
		filename1 = multi.getFilesystemName(file1);
		
//		out.println(filename1 + "<br/>");
//		out.println(filename2 + "<br/>");
		
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
<html>
<body>
<form name="filecheck" action="fileCheck.jsp" method="post">
	<input type="hidden" name="name" value="<%=name%>">
	<input type="hidden" name="subject" value="<%=subject%>">
	<input type="hidden" name="filename1" value="<%=filename1%>">
	<input type="hidden" name="filename2" value="<%=filename2%>">
</form>
<!-- javascript를 이용해 하이퍼 링크를 클릭하면 폼의 내용을 action 페이지로 전송한다. -->
<a href="#" onclick="javascript:filecheck.submit()">업로드 확인 및 다운로드 페이지 이동</a>
</body>
</html>









