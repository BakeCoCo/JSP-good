<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 보기</title>

<script type="text/javascript">

	function setting(idx, mode, title, name, content) {
		frm = document.commentForm;			// 현재 문서의 댓글 작업 폼
		frm.idx.value = idx;				// 수정 또는 삭제할 댓글의 글 번호를 저장한다. 댓글 입력시는 0으로 처리한다.
		frm.mode.value = mode;				// 댓글 작업 모드 지정
		frm.commentBtn.value = title;		// submit 버튼에 표시될 텍스트 지정
		frm.name.value = name;				// 댓글 작성자 이름을 댓글 작업 폼의 text 객체에 넣어준다.
		
//		${comment.content}를 넘겨받으면 자바스크립트는 이스케이프 시퀀스(\r\n)가 포함된 데이터를 인수로 받을 수 없기 때문에 함수가
//		정상적으로 동작되지 않는다.
//		일반적으로 사용하지 않는 문자열로 변환되서 넘어온 인수를 textarea에 넣어주려면 다시 "\r\n"로 치환시키는 작업이 필요하다.

//		java나 jsp의 replace 메소드는 모든 내용을 일괄적으로 치환하지만 자바스크립트의 replace는 맨 앞의 한 개만 치환시킨다.
//		content로 넘어온 문자열의 모든 "<br/>"을 "\r\n"으로 치환한다.
		while(content.indexOf("<br/>") != -1) {		// content로 넘어온 문자열에 "<br/>"가 있는 동안 반복한다.
			content = content.replace("<br/>", "\r\n");
		}
		frm.content.value = content;
		
		if(mode == 1) {
			frm.name.focus();
		} else {
			frm.password.focus();
		}
	}

</script>

</head>
<body>

<table width="600" align="center" border="1" cellpadding="5" cellspacing="0">
	<tr><th colspan="4">게시글 보기</th></tr>
	<tr>
		<td width="80" align="center">글번호</td>
		<td width="320" align="center">작성자</td>
		<td width="120" align="center">작성일</td>
		<td width="80" align="center">조회수</td>
	</tr>
	<tr>
		<td align="center">${vo.idx}</td>
		<td align="center">
			<c:set var="name" value="${fn:replace(fn:trim(vo.name), '<', '&lt;')}"/>
			<c:set var="name" value="${fn:replace(name, '>', '&gt;')}"/>
			${name}
		</td>
		<td align="center">
			<jsp:useBean id="date" class="java.util.Date"/>
			<c:if test="${date.year == vo.writeDate.year && date.month == vo.writeDate.month && date.date == vo.writeDate.date}">
				<fmt:formatDate value="${vo.writeDate}" pattern="a h:mm"/>
			</c:if>
			<c:if test="${date.year != vo.writeDate.year || date.month != vo.writeDate.month || date.date != vo.writeDate.date}">
				<fmt:formatDate value="${vo.writeDate}" pattern="yyyy.MM.dd(E)"/>
			</c:if>
		</td>
		<td align="center">${vo.hit}</td>
	</tr>
	<tr>
		<td align="center">제목</td>
		<td colspan="3">
			<c:set var="subject" value="${fn:replace(fn:trim(vo.subject), '<', '&lt;')}"/>
			<c:set var="subject" value="${fn:replace(subject, '>', '&gt;')}"/>
			${subject}
		</td>
	</tr>
	<tr>
		<td align="center">내용</td>
		<td colspan="3">
			<c:set var="content" value="${fn:replace(fn:trim(vo.content), '<', '&lt;')}"/>
			<c:set var="content" value="${fn:replace(content, '>', '&gt;')}"/>
			<c:set var="content" value="${fn:replace(content, rn, '<br/>')}"/> <!-- 요거를 꼭 맨 마지막에 해야 한다. -->
			${content}
		</td>
	</tr>
	<tr>
		<td colspan="4" align="center">
			<input type="button" value="수정하기" 
					onclick="location.href='selectByIdx.jsp?idx=${vo.idx}&currentPage=${currentPage}&job=update'"/>
			<input type="button" value="삭제하기" 
					onclick="location.href='selectByIdx.jsp?idx=${vo.idx}&currentPage=${currentPage}&job=delete'"/>
			<!-- history.back()나 history.go(-1)을 사용하면 전 화면으로 돌아갈 때 변경된 조회수가 반영되지 않는다. -->
			<input type="button" value="돌아가기" onclick="location.href='list.jsp?currentPage=${currentPage}'"/>
		</td>
	</tr>
</table>
<br/>

<!-- 여기부터 댓글 입력, 보기, 수정, 삭제에 사용하는 폼 -->
<form action="commentOK.jsp" method="post" name="commentForm">
<table width="600" align="center" border="1" cellpadding="5" cellspacing="0">

	<!-- 이 줄은 원래 보이면 안되는 줄, 모두 hidden으로 변경한다. -->
	<tr>
		<td bgcolor="yellow" colspan="4">
			<!-- 수정 또는 삭제할 댓글의 글번호를 넘겨준다. -->
			idx : <input type="text" name="idx" value="${vo.idx}" size="1">
			<!-- 현재 댓글이 어떤 메인글의 댓글인지 넘겨준다. -->
			ref : <input type="text" name="ref" value="${vo.idx}" size="1">
			<!-- 작업 mode : 1 => 댓글 저장, 2 => 댓글 수정, 3 => 댓글 삭제 -->
			mode : <input type="text" name="mode" value="1" size="1">
			currentPage : <input type="text" name="currentPage" value="${currentPage}" size="1">
			ip : <input type="text" name="ip" value="${pageContext.request.remoteAddr}" size="8">
		</td>
	</tr>
	
	<!-- 이 줄 부터 댓글 입력, 수정, 삭제 작업에 사용된다. -->
	<tr>
		<td width="100"><label for="name">이름</label></td>
		<td width="200"><input id="name" type="text" name="name"/></td>
		<td width="100"><label for="password">비밀번호</label></td>
		<td width="100"><input id="password" type="password" name="password"/></td>
	</tr>
	<tr>
		<td width="100"><label for="content">내용</label></td>
		<td width="500" colspan="3">
			<textarea id="content" rows="5" cols="65" name="content" style="resize : none"></textarea>
		</td>
	</tr>
	<tr>
		<td colspan="4" align="center">
			<input type="submit" value="댓글저장" name="commentBtn"/>
			<input type="button" value="다시쓰기" onclick="setting(0, 1, '댓글저장', '', '')"/>
		</td>
	</tr>

	<!-- 댓글이 한 개도 없는 경우 -->
	<c:if test="${freeboardCommentList.freeboardCommentList.size() == 0}">
	<tr>
		<td colspan="4">
			댓글이 한.개.도 없네요~~~~~ 인기가 꽝이에요.... 지태는 자고있어요~~~~~
		</td>
	</tr>
	</c:if>
	
	<!-- 댓글이 있는 경우 -->
	<c:if test="${freeboardCommentList.freeboardCommentList.size() != 0}">
	<c:forEach var="comment" items="${freeboardCommentList.freeboardCommentList}">
	<tr>
		<td colspan="4">
			${comment.idx}. 
			<c:set var="name" value="${fn:replace(fn:trim(comment.name), '<', '&lt;')}"/>
			<c:set var="name" value="${fn:replace(name, '>', '&gt;')}"/>
			${name}(${comment.ip})님이 
			<fmt:formatDate value="${comment.writeDate}" pattern="yyyy.MM.dd(E)"/>에 남긴글
			
			<c:set var="sq">'</c:set>
			<c:set var="dq">"</c:set>
			
			<c:set var="content" value="${fn:replace(fn:trim(comment.content), '<', '&lt;')}"/>
			<c:set var="content" value="${fn:replace(content, '>', '&gt;')}"/>
			<c:set var="content" value="${fn:replace(content, sq, '’')}"/>
			<c:set var="content" value="${fn:replace(content, dq, '”')}"/>
			<c:set var="content" value="${fn:replace(content, rn, '<br/>')}"/> <!-- 요거를 꼭 맨 마지막에 해야 한다. -->
			
			<!--
				자바스크립트 함수로 인수를 넘겨줄 때 이스케이프 시퀀스를 넘겨주면 자바스크립트의 함수가 작동되지 않기 때문에
				이스케피스 시퀀스를 replace 함수를 사용해서 일반적으로 잘 사용하지 않는 문자열로 변환시켜 넘겨줘야 한다.
			-->
			<input type="button" value="수정" onclick="setting(${comment.idx}, 2, '댓글수정', '${comment.name}', '${content}')"/>
			<input type="button" value="삭제" onclick="setting(${comment.idx}, 3, '댓글삭제', '${comment.name}', '${content}')"/>
			
			<br/>
			
			${content}
		</td>
	</tr>
	</c:forEach>
	</c:if>

</table>
</form>

</body>
</html>















