<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 보기</title>

<!-- jQuery를 사용하려면 아래와 같이 jQuery CDN을 추가한다. -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<script type="text/javascript">

	/*
	function formCheck(obj) {
		if(!obj.category.value || obj.category.value.trim().length == 0) {
			alert("카테고리는 반드시 입력해야 합니다.");
			obj.category.value = "";
			obj.category.focus();
			return false;
		}
		return true;
	}
	*/

//	$(document).ready() : body 태그의 모든 문서 내용이 브라우저에 출력되면 ready() 함수의 인수로 지정된 함수를 실행한다.
	$(document).ready(function () {
		
//		메인 카테고리에 아무것도 입력되지 않았는가 검사하는 jQuery => 1개만 있으므로 id를 지정해서 처리하면 된다.
//		$("#form").submit() : form 이라는 id가 지정된 객체에서 submit 버튼이 클릭되면 submit() 함수의 인수로 지정된 함수를 실행한다.
//		이 때, 이 함수의 인수(event)로 실행되는 이벤트가 넘어온다.
		$("#form").submit(function (event) {
//			$.trim() : 인수로 지정된 문자열의 앞, 뒤의 불필요한 빈 칸을 제거한다.
//			$("#category").val() : category라는 id가 지정된 객체에 입력된 데이터를 얻어온다.
			var category = $.trim($("#category").val()).length; // 메인 카테고리의 글자수를 얻어온다.
			if(category == 0) {
//				preventDefault() : 이벤트 실행을 중지시킨다.
				event.preventDefault();	// submit의 기본 이벤트인 action 페이지로 넘기는 기능이 실행되지 않는다.
				alert("메인 카테고리는 반드시 입력해야 합니다.");
				$("#form")[0].reset();	// form이란 id가 지정된 폼 객체의 모든 내용을 지운다. => [0]만 사용 가능하다.
				$("#category").focus();	// category라는 id가 지정된 객체로 포커스를 이동시킨다.
			}
		});
		
//		서브 카테고리에 아무것도 입력되지 않았는가 검사하는 jQuery => 여러개가 있으므로 class를 지정해서 처리하면 된다.
//		$(".sub_form").each() : sub_form 이란 class 속성이 지정된 객체의 개수 만큼 인수로 지정된 함수를 반복한다.
//		index => sub_form 이란 class가 지정된 객체의 일련번호(index)를 의미한다.
//		item => sub_form 이란 class가 지정된 index 번째 객체를 의미한다.

//		서브 카테고리를 입력하는 폼의 개수 만큼 반복하며 모든 서브 카테고리에 이름이 다른 class 속성을 지정한다.
		$(".sub_form").each(function (index, item) {	// 서브 카테고리 폼의 개수 만큼 반복한다.
//			$(item).addClass() : 반복문을 통해 반복되는 객체(서브 카테고리 폼)에 class 속성을 추가한다.
			$(item).addClass("sub_form" + index)
		});
		
//		서브 카테고리를 입력하는 텍스트 상자의 개수 만큼 반복하며 모든 서브 카테고리를 입력하는 텍스트 상자에 이름이 다른 class 
//		속성을 지정한다.
		$(".sub_category").each(function (index, item) {	// 서브 카테고리를 입력하는 텍스트 상자의 개수 만큼 반복한다.
			$(item).addClass("sub_category" + index)
		});
	
		$(".sub_form").each(function (index, item) {
			$(".sub_form" + index).submit(function (event) {
				var sub_category = $.trim($(".sub_category" + index).val()).length; // 서브 카테고리의 글자수를 얻어온다.
				if(sub_category == 0) {
					event.preventDefault();
					alert("서브 카테고리는 반드시 입력해야 합니다.");
					$(".sub_form" + index)[0].reset();
					$(".sub_category" + index).focus();
				}
			})
		});

	});
	
//	수정 버튼이 클릭되면 update.jsp로 form에 입력된 데이터를 전송하는 함수
	function mySubmitUpdate(obj) {
		if(!obj.category.value || obj.category.value.trim().length == 0) {
			alert("수정할 카테고리를 입력하세요");
			obj.category.value = "";
			obj.category.focus();
		} else {
			obj.action = "update.jsp";	// 인수로 넘어온 form의 action 페이지를 변경(지정)한다.
			obj.submit();				// action 페이지를 호출하고 form의 데이터를 전송한다.
		}
	}
	
//	삭제 버튼이 클릭되면 delete.jsp로 form에 입력된 데이터를 전송하는 함수
	function mySubmitDelete(obj) {
		obj.action = "delete.jsp";
		obj.submit();
	}
	
//	복구 버튼이 클릭되면 deleteRestore.jsp로 form에 입력된 데이터를 전송하는 함수
	function mySubmitDeleteRestore(obj) {
		obj.action = "deleteRestore.jsp";
		obj.submit();
	}
	
//	신고 버튼이 클릭되면 deleteReport.jsp로 form에 입력된 데이터를 전송하는 함수
	function mySubmitDeleteReport(obj) {
		obj.action = "deleteReport.jsp";
		obj.submit();
	}
	
</script>

</head>
<body>

<h1>Category Project</h1>

<!-- javascript 함수로 메인 카테고리 폼 체크 -->
<!-- <form action="insert.jsp" method="post" onsubmit="return formCheck(this)"> -->

<!-- jQuery로 메인 카테고리 폼 체크 -->
<form id="form" action="insert.jsp" method="post">
	<input id="category" type="text" name="category"/>
	<input type="submit" value="메인 카테고리 만들기"/>
</form>
<hr size="3" color="red"/>

<!-- 여기 부터 카테고리 목록을 출력한다. -->
<c:forEach var="vo" items="${categoryList.categorylist}">
	
	<!-- 서브 카테고리를 입력하는 모든 폼에 다른 이름이 있어야 식별이 가능하므로 폼의 이름을 만든다. -->
	<c:set var="formName" value="form${vo.idx}"/>
	
	<!-- javascript 함수로 서브 카테고리 폼 체크 -->
	<%-- <form action="reply.jsp" method="get" onsubmit="return formCheck(this)" name="${formName}"> --%>
	
	<!-- jQuery로 메인 카테고리 폼 체크 -->
	<form class="sub_form" action="reply.jsp" method="get" name="${formName}">
		<!-- idx, ref, lev, seq를 표시하는 텍스트 상자는 모두 hidden으로 처리한다. -->
		<input type="text" name="idx" value="${vo.idx}" size="1"/>
		<input type="text" name="ref" value="${vo.ref}" size="1"/>
		<input type="text" name="lev" value="${vo.lev}" size="1"/>
		<input type="text" name="seq" value="${vo.seq}" size="1"/>
		
		<!-- 카테고리 레벨(lev)에 따라 들여쓰기를 한다. -->
		<c:if test="${vo.lev > 0}">
			<c:forEach var="i" begin="1" end="${vo.lev}" step="1">
				&nbsp;&nbsp;&nbsp;&nbsp;
			</c:forEach>
			<img src="images/reply.png"/>
		</c:if>
		
		<c:if test="${fn:trim(vo.deleteCheck) == 'yes'}">
			삭제된 카테고리 입니다.
		</c:if>
		<c:if test="${fn:trim(vo.deleteCheck) == 'no'}">
			<c:if test="${vo.deleteReport >= 10}">
				신고 만땅 먹은 카테고리 입니다.
			</c:if>
			<c:if test="${vo.deleteReport < 10}">
				<c:set var="category" value="${fn:replace(vo.category, '<', '&lt;')}"/>
				<c:set var="category" value="${fn:replace(category, '>', '&gt;')}"/>
				${category}(신고 횟수 : ${vo.deleteReport}번)
			</c:if>
		</c:if>
		
		<input class="sub_category" type="text" name="category"/>
		<input type="submit" value="서브 카테고리 만들기"/>
		<input type="button" value="삭제" onclick="mySubmitDelete(${formName})"/>
		<input type="button" value="복구" onclick="mySubmitDeleteRestore(${formName})"/>
		<input type="button" value="신고" onclick="mySubmitDeleteReport(${formName})"/>
		<input type="button" value="수정" onclick="mySubmitUpdate(${formName})"/>
	</form>
	
</c:forEach>

</body>
</html>















