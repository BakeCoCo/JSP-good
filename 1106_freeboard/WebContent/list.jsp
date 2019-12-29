<%@page import="kr.koreait.service.FreeboardCommentService"%>
<%@page import="kr.koreait.vo.FreeboardVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.koreait.service.FreeboardService"%>
<%@page import="kr.koreait.vo.FreeboardList"%>
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
//	이전 페이지에서 넘어오는 화면에 표시할 페이지 번호를 받는다.
	int currentPage = 1;
	try {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	} catch(NumberFormatException e) { }
	
	FreeboardService service = FreeboardService.getInstance();
//	공지글만 얻어온다.
	ArrayList<FreeboardVO> notice = service.selectNotice();
//	공지글에 대한 댓글의 개수를 얻어와 notice ArrayList의 commentCount에 저장한다.
	for(FreeboardVO vo : notice) {
		vo.setCommentCount(FreeboardCommentService.getInstance().commentCount(vo.getIdx()));
	}

//	한 페이지 분량의 메인글을 얻어온다.
	FreeboardList freeboardList = service.selectList(currentPage);
//	한 페이지 분량의 메인글에 대한 댓글의 갯수를 얻어와 FreeboardVO 클래스의 commentCount에 저장한다.
	for(FreeboardVO vo : freeboardList.getFreeboardList()) {
		vo.setCommentCount(FreeboardCommentService.getInstance().commentCount(vo.getIdx()));
	}

//	공지글 목록과 한 페이지 분량의 글 목록을 request 영역에 저장한 후 글 목록을 표시하는 페이지(listView.jsp)로 넘겨준다.
	request.setAttribute("notice", notice);
	request.setAttribute("freeboardList", freeboardList);
	pageContext.forward("listView.jsp");
%>
</body>
</html>