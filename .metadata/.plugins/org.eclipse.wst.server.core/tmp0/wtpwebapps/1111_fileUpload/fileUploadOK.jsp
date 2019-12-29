<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
//	enctype이 multipart/form-data로 설정된 폼에서 넘어오는 데이터를 받으려면 일반적인 request로 받을 수 없고 multipart를 지원하는
//	객체로 받아야 한다.
	MultipartRequest mr = new MultipartRequest(
		request, 							// 요청 객체
		application.getRealPath("/upload"),	// 업로드 되는 파일이 실제 저장될 경로
		10 * 1024 * 1024,					// 업로드 되는 파일의 크기 => 바이트 단위로 지정한다.
		"UTF-8",							// 인코딩 방식
		new DefaultFileRenamePolicy() 		// 업로드 되는 파일과 이름이 같은 파일이 존재할 경우 파일의 이름을 자동으로 변경해주는 객체
	);

//	업로드 하는 원본 파일의 이름을 얻어온다.
	File file = mr.getFile("file");			// 파일 업로드 후 파일 객체를 얻어온다. => 실제 업로드된 파일 이름을 얻어온다.
	String oldFileName = mr.getOriginalFileName("file");
%>
파일 업로드 완료!!!<br/>
실제로 디스크에 업로드(저장)된 파일 이름 : <%=file.getName()%><br/>
디스크에 업로드 하는 원본 파일 이름 : <%=oldFileName%><br/>
<a href="fileUploadForm.jsp">돌아가기</a>
</body>
</html>
















