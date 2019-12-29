<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- jstl을 이용해 제어문, 대입문, 서식, 함수를 사용하기 위해 아래의 내용을 코딩한다. -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>			<!-- jstl 제어문, 대입문 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>		<!-- jstl 서식 -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>	<!-- jstl 함수 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>방명록 보기</title>

<style type="text/css">
	.button {
	  background-color: #4CAF50; /* Green */
	  border: none;
	  color: white;
	  padding: 6px 10px;
	  text-align: center;
	  text-decoration: none;
	  display: inline-block;
	  font-size: 14px;
	  margin: 2px 1px;
	  /* -webkit-transition-duration: 0.4s; */ /* Safari */
	  /* transition-duration: 0.4s; */
	  cursor: pointer;
	}
	
	.button1 {
	  background-color: white; 
	  color: black; 
	  border: 2px solid white;
	}
	
	.button1:hover {
	  background-color: white;
	  color: black;
	  border: 2px solid red;
	}
	
	.button2 {
	  background-color: white; 
	  color: black; 
	  border: 2px solid red;
	  cursor: wait;
	}
	
	span { color: red; font-weight: bold; }
</style>

</head>
<body>

<%--
	EL을 사용하면 request 영역에 저장된 데이터를 받는 처리 없이 바로 request 영역에 저장된 객체를 사용할 수 있다.
	GuestbookList guestbookList = (GuestbookList) request.getAttribute("guestbookList");
	out.println(guestbookList + "<br/>");
	위의 2줄을 EL을 사용하면 ${guestbookList}로 줄여서 사용할 수 있다.
	
	※ jstl 대입문 => c:set => 변수를 만들고 값을 대입한다.
	<c:set var="변수명" value="변수에 대입할 값"/>
	
	※ jstl if문 => c:if => else를 사용할 수 없다. => else 처리가 필요하면 조건을 반대로 해서 별도로 if를 만들어 사용해야 한다.
	<c:if test="${조건식}">
		조건이 참일 경우 실행할 문장
	</c:if>
	
	※ jstl 일반 for문 => 변수에 초기치를 넣고 반복을 시작하고 증가치 만큼 변수 값을 증가시키며 최총치 까지 반복한다.
	증가치는 생략할 수 있으며 생략이 1이 기본값이고 증가치에는 음수를 사용할 수 없다.
	<c:forEach var="변수명" begin="초기치" end="최종치" step="증가치">
		반복할 문장
	</c:forEach>
	
	※ jstl 향상된 for문 => items 속성에 지정된 배열이나 list 객체의 0번째 값을 변수에 저장하고 반복을 시작하며 마지막 값을 처리하고
	반복을 종료한다.
	<c:forEach var="변수명" items="${배열이나 list 객체}">
		반복할 문장
	</c:forEach>
	
	※ jstl 함수 사용하기 => ${fn:함수명(인수)}
	vo.getName().replace("<", "&lt;") => ${fn:replace(vo.name, "<", "&lt;")}
	
	※ jstl을 사용한 날짜 서식 변경하기 => 날짜 서식 지정 방법은 자바와 같다.
	<fmt:formatDate value="${날짜 데이터}" pattern="날짜 서식"/>
--%>

<!-- jstl을 사용하는 한글 깨짐 방지 -->
<!-- request.setCharacterEncoding("UTF-8")와 같은 기능이 실행된다. -->
<fmt:requestEncoding value="UTF-8"/>

<!-- 브라우저에 출력할 한 페이지 분량의 글 목록만 꺼내서 jstl 변수에 저장시킨다. -->
<!-- EL을 사용할 때 객체 이름 뒤에 "."을 찍고 멤버 변수 이름을 적어주면 그 멤버 변수의 getter가 실행된다. -->
<!-- ${guestbookList.guestbookList}는 guestbookList.getGuestbookList()를 실행한 것과 같은 기능이 실행된다. -->
<c:set var="view" value="${guestbookList.guestbookList}"/>

<table width="1000" align="center" border="1" cellpadding="5" cellspacing="0">
	<tr><th>방명록 보기</th></tr>
	
	<tr>
		<td align="right">
			${guestbookList.totalCount}개(${guestbookList.currentPage} / ${guestbookList.totalPage}) Page
		</td>
	</tr>
	
	<tr>
		<td>
		
			<!-- 테이블에 저장된 글이 없으면 브라우저에 저장된 글이 없다고 출력한다. -->
			<c:if test="${view.size() == 0}">
				<marquee>테이블에 저장된 글이 없습니다.</marquee>
			</c:if>
			
			<!-- 테이블에 저장된 글이 있으면 브라우저에 글 목록을 출력한다. -->
			<c:if test="${view.size() != 0}">
				
				<%--
				<c:forEach var="i" begin="0" end="${view.size() - 1}" step="1"> <!-- 일반 for -->
					${view.get(i)}<br/>
				</c:forEach>
				--%>
				
				<!-- useBean 액션 태그를 이용해서 오늘 날짜를 기억하는 Date 클래스 객체를 생성한다. -->
				<jsp:useBean id="date" class="java.util.Date"/>
				
				<c:forEach var="vo" items="${view}"> <!-- 향상된 for -->
					
					<table width="99%" align="center" border="0" cellpadding="5" cellspacing="0" 
					
						<c:if test="${vo.idx % 2 == 1}">
							bgcolor="yellow"
						</c:if>
						<c:if test="${vo.idx % 2 != 1}">
							bgcolor="pink"
						</c:if>
					
					>
						<tr>
							<td>
								${vo.idx}. 
								
								<%-- <%=vo.getName().replace("<", "&lt;").replace(">", "&gt;")%> --%>
								<c:set var="name" value="${vo.name}"/>
								<c:set var="name" value="${fn:replace(name, '<', '&lt;')}"/>
								<c:set var="name" value="${fn:replace(name, '>', '&gt;')}"/>
								
								<c:if test="${category == null || category == '내용'}">
									${name}
								</c:if>
								<c:if test="${category == '이름' || category == '이름+내용'}">
									<c:set var="search" value="<span>${item}</span>"/>
									${fn:replace(name, item, search)}
								</c:if>
								
								(${vo.ip})님이  
								
								<!-- 오늘 입력된 글은 시간만 어제 이전에 입력된 글은 날짜만 표시한다. -->
								<c:if test="${date.year == vo.writeDate.year && date.month == vo.writeDate.month &&
									date.date == vo.writeDate.date}">
									<fmt:formatDate value="${vo.writeDate}" pattern="HH:mm:ss"/>
								</c:if>
								
								<c:if test="${date.year != vo.writeDate.year || date.month != vo.writeDate.month ||
									date.date != vo.writeDate.date}">
									<fmt:formatDate value="${vo.writeDate}" pattern="yyyy.MM.dd(E)"/>
								</c:if>
								에 남긴글
								
								<!--
									수정 또는 삭제 버튼이 클릭되면 수정 또는 삭제할 글 한 건을 얻어오는 페이지로 수정 또는 삭제할
									글번호(${vo.idx})와 수정 또는 삭제 후 돌아갈 페이지 번호(${guestbookList.currentPage})와
									어떤 버튼이 클릭되었나를 의미하는 식별자(job)를 넘겨준다.
								-->
								<input type="button" value="수정" 
										onclick="location.href='selectByIdx.jsp?idx=${vo.idx}&currentPage=${guestbookList.currentPage}&job=update'">
								<input type="button" value="삭제" 
										onclick="location.href='selectByIdx.jsp?idx=${vo.idx}&currentPage=${guestbookList.currentPage}&job=delete'">
								<br/>
								
								<%-- <%=vo.getMemo().replace("<", "&lt;").replace(">", "&gt;").replace("\r\n", "<br/>")%> --%>
								<c:set var="memo" value="${vo.memo}"/>
								<c:set var="memo" value="${fn:replace(memo, '<', '&lt;')}"/>
								<c:set var="memo" value="${fn:replace(memo, '>', '&gt;')}"/>
								<c:set var="memo" value="${fn:replace(memo, rn, '<br/>')}"/>
								
								<c:if test="${category == null || category == '이름'}">
									${memo}
								</c:if>
								<c:if test="${category == '내용' || category == '이름+내용'}">
									<c:set var="search" value="<span>${item}</span>"/>
									${fn:replace(memo, item, search)}
								</c:if>
								
							</td>
						</tr>
					</table>
					
				</c:forEach>
				
			</c:if>
			
		</td>
	</tr>
	
	<!-- 페이지 이동 버튼 -->
	<tr>
		<td align="center">
		
			<!-- 처음으로, 10 페이지 앞으로 -->
			<c:if test="${guestbookList.startPage > 1}">
				<input type="button" value="start page" onclick="location.href='?currentPage=1'" title="첫 페이지 이동합니다."/>
				<input type="button" value="-10 page" onclick="location.href='?currentPage=${guestbookList.startPage - 1}'" 
						title="이전 10 페이지로 이동합니다."/>
			</c:if>
			<c:if test="${guestbookList.startPage <= 1}">
				<input type="button" value="start page" disabled="disabled" title="이미 첫 페이지 입니다."/>
				<input type="button" value="-10 page" disabled="disabled" title="이전 10 페이지가 없습니다."/>
			</c:if>
			<!-- 1 페이지 앞으로 -->
			<c:if test="${guestbookList.currentPage > 1}">
				<input type="button" value="-1 page" onclick="location.href='?currentPage=${guestbookList.currentPage - 1}'" 
						title="이전 페이지로 이동합니다."/>
			</c:if>
			<c:if test="${guestbookList.currentPage <= 1}">
				<input type="button" value="-1 page" disabled="disabled" title="이전 페이지가 없습니다."/>
			</c:if>

			<!-- 10 페이지 단위로 표시되는 페이지 이동 버튼 -->
			<c:forEach var="i" begin="${guestbookList.startPage}" end="${guestbookList.endPage}" step="1">
				<c:if test="${guestbookList.currentPage == i}">
					<input class="button button2" type="button" value="${i}" disabled="disabled"/>
				</c:if>
				<c:if test="${guestbookList.currentPage != i}">
					<input class="button button1" type="button" value="${i}" onclick="location.href='?currentPage=${i}'"/>
				</c:if>
			</c:forEach>
			
			<!-- 1 페이지 뒤로 -->
			<c:if test="${guestbookList.currentPage < guestbookList.totalPage}">
				<input type="button" value="+1 page" onclick="location.href='?currentPage=${guestbookList.currentPage + 1}'" 
						title="다음 페이지로 이동합니다."/>
			</c:if>
			<c:if test="${guestbookList.currentPage >= guestbookList.totalPage}">
				<input type="button" value="+1 page" disabled="disabled" title="다음 페이지가 없습니다."/>
			</c:if>
			<!-- 마지막으로, 10 페이지 뒤로 -->
			<c:if test="${guestbookList.endPage < guestbookList.totalPage}">
				<input type="button" value="+10 page" onclick="location.href='?currentPage=${guestbookList.endPage + 1}'" 
						title="다음 10 페이지로 이동합니다."/>
				<input type="button" value="end page" onclick="location.href='?currentPage=${guestbookList.totalPage}'" 
						title="마지막 페이지로 이동합니다."/>
			</c:if>
			<c:if test="${guestbookList.endPage >= guestbookList.totalPage}">
				<input type="button" value="+10 page" disabled="disabled" title="다음 10 페이지가 없습니다."/>
				<input type="button" value="end page" disabled="disabled" title="이미 마지막 페이지 입니다."/>
			</c:if>
			
		</td>
	</tr>
	
	<!-- 카테고리별 검색어를 입력받는다. -->
	<tr>
		<td align="center">
			<form action="list.jsp" method="post">
				<select name="category">
					<option>이름</option>
					<option>내용</option>
					<option>이름+내용</option>
				</select>
				<input type="text" name="item"/>
				<input type="submit" value="검색"/>
			</form>
		</td>
	</tr>
	
	<!-- 방명록 쓰기 페이지로 이동하는 버튼 -->
	<tr>
		<td align="right">
			<input type="button" value="글쓰기" onclick="location.href='insert.jsp'"/>
		</td>
	</tr>
	
</table>

</body>
</html>
















