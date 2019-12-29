<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유 게시판 글 쓰기</title>
</head>
<body>

<form action="insertOK.jsp" method="post">
<table width="600" align="center" border="1" cellpadding="5" cellspacing="0">
	<tr><th colspan="3">자유 게시판 글 쓰기</th></tr>
	<tr>
		<td width="100">
			<label for="name">이름</label>
		</td>
		<td width="430">
			<input id="name" type="text" name="name"/>
		</td>
		<td width="70">
			공지 <input type="checkbox" name="notice" value="notice"/>
		</td>
	</tr>
	<tr>
		<td width="100">
			<label for="password">비밀번호</label>
		</td>
		<td width="500" colspan="2">
			<input id="password" type="password" name="password"/>
		</td>
	</tr>
	<tr>
		<td>
			<label for="subject">제목</label>
		</td>
		<td colspan="2">
			<input id="subject" type="text" name="subject" size="63"/>
		</td>
	</tr>
	<tr>
		<td>
			<label for="content">내용</label>
		</td>
		<td colspan="2">
			<textarea id="content" rows="10" cols="65" name="content"></textarea>
		</td>
	</tr>
	<tr>
		<td colspan="3" align="center">
			<fieldset>
				<legend>눌러보삼</legend>
				<input type="submit" value="저장하기"/>
				<input type="reset" value="다시쓰기"/>
				<input type="button" value="돌아가기" onclick="history.back()"/>
			</fieldset>
		</td>
	</tr>
</table>

<!-- hidden으로 접속자 ip 주소를 폼에 가지고 insertOK.jsp로 넘어가게 한다. -->
<input type="hidden" name="ip" value="${pageContext.request.remoteAddr}">

</form>

</body>
</html>







