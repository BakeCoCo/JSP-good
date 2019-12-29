<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>			<!-- jstl 제어문, 대입문 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>		<!-- jstl 서식 -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>	<!-- jstl 함수 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정할 글 보기</title>
</head>
<body>

<!-- 수정할 글을 화면에 표시하고 비밀번호를 입력받아 실제 글을 수정하는 페이지로 넘겨준다. -->

<fmt:requestEncoding value="UTF-8"/>

<form action="updateOK.jsp" method="post">

<!-- 수정할 글 번호와 수정 후 돌아갈 페이지 번호를 form에 hidden으로 저장해서 수정하는 페이지로 넘겨줘야 한다. -->
<input type="hidden" name="idx" value="${vo.idx}"/>
<input type="hidden" name="currentPage" value="${currentPage}"/>

<table width="600" align="center" border="1" cellpadding="5" cellspacing="0">
	<tr><th colspan="2">수정할 글 보기</th></tr>
	<tr>
		<td width="100">이름</td>
		<td width="500">
			<%--
			<c:set var="name" value="${vo.name}"/>
			<c:set var="name" value="${fn:replace(name, '<', '&lt;')}"/>
			<c:set var="name" value="${fn:replace(name, '>', '&gt;')}"/>
			${name}
 			--%>
	 		<input type="hidden" name="name" value="${vo.name}"/>
	 		<input type="text" value="${vo.name}" disabled="disabled"/>
 		</td>
	</tr>
	<tr>
		<td>내용</td>
		<td>
			<%--
			<c:set var="memo" value="${vo.memo}"/>
			<c:set var="memo" value="${fn:replace(memo, '<', '&lt;')}"/>
			<c:set var="memo" value="${fn:replace(memo, '>', '&gt;')}"/>
			<c:set var="memo" value="${fn:replace(memo, rn, '<br/>')}"/>
			${memo}
			--%>
			<textarea rows="10" cols="65" name="memo">${vo.memo}</textarea>
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<label>비밀번호 <input type="password" name="password"/></label>
			<input type="submit" value="수정하기"/>
			<input type="reset" value="다시쓰기"/>
			<input type="button" value="돌아가기" onclick="history.back()"/>
		</td>
	</tr>
	
</table>

</form>

</body>
</html>
















