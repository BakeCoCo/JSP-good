<%@page import="java.util.ArrayList"%>
<%@page import="kr.koreait.vo.CategoryVO"%>
<%@page import="kr.koreait.service.CategoryService"%>
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
%>

<jsp:useBean id="vo" class="kr.koreait.vo.CategoryVO">
	<jsp:setProperty property="*" name="vo"/>
</jsp:useBean>

<%
	CategoryService service = CategoryService.getInstance();
//	삭제한 카테고리 이름을 삭제 완료 메시지에 표시하기 위해 삭제할 카테고리 한 건을 테이블에서 얻어온다.
	CategoryVO original = service.selectByIdx(vo.getIdx());

//	1. 삭제 버튼이 클릭되면 해당 카테고리를 삭제한다.
//	service.delete(vo.getIdx());

//	2. 삭제 버튼이 클릭되면 해당 카테고리 자체를 "삭제된 카테고리 입니다."로 수정한다.
//	service.deleteCategory(vo.getIdx());

//	3. 삭제 버튼이 클릭되면 deleteCheck 필드를 "yes"로 수정한다.
//	service.deleteCheck(vo.getIdx());

//	4. 삭제 버튼이 클릭되면 삭제된 카테고리의 모든 서브 카테고리도 일괄적으로 삭제한다.
//	삭제할 카테고리와 삭제할 카테고리의 모든 서브 카테고리 목록을 얻어와 ArrayList에 저장한다.
	ArrayList<CategoryVO> deleteList = service.deleteList(vo);
	for(int i = 0; i < deleteList.size(); i++) {
//		out.println(deleteList.get(i) + "<br/>");
		service.delete(deleteList.get(i).getIdx());
		try {
//			삭제할 카테고리의 seq(deleteList.get(i).getSeq())에 1을 더한 값이 다음에 삭제하려는 seq(deleteList.get(i + 1).getSeq())와
//			같으면 다음에 삭제할 서브 카테고리가 있는 것이므로 계속 반복하며 카테고리를 삭제하고 같지 않다면 다음에 삭제할 카테고리가
//			없는 것이므로 반복을 탈출한다.
			if(deleteList.get(i).getSeq() + 1 != deleteList.get(i + 1).getSeq()) {
				break;
			}
//			삭제할 카테고리 목록의 마지막 카테고리 다음의 카테고리가 없으면 위의 if 명령을 실행하다 ArrayList의 index 값이 ArrayList의
//			범위를 벗어나 IndexOutOfBoundsException이 발생되므로 예외 처리를 해준다.
		} catch(IndexOutOfBoundsException e) { }
	}
	
//	삭제 작업이 실행된 카테고리 그룹(ref)의 seq를 0부터 1씩 증가하게 다시 부여하는 메소드를 실행한다.
	service.reSeq(original.getRef());

//	카테고리 삭제 후 삭제 완료 메시지를 출력하고 카테고리 목록을 출력하는 페이지로 이동한다.
//	response.sendRedirect("list.jsp");
	out.println("<script>");
//	out.println("alert('" + vo.getIdx() + "번 카테고리 삭제완료!!!')");
//	out.println("alert('" + original.getCategory() + " 카테고리 삭제완료!!!')");
	out.println("alert('" + original.getCategory() + " 카테고리와 모든 서브 카테고리 삭제완료!!!')");
	out.println("location.href='list.jsp'");
	out.println("</script>");
%>

</body>
</html>





