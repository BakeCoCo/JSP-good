<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">

	div {
		width: 100px;
		height: 50px;
		border: 1px solid black;
		background: yellow;
 		transition: width 5s height 5s border 5s transform 5s;
 		-webkit-transition: width 2s, height 2s, border 2s, -webkit-transform 2s;
 	}
	div:hover {
		width: 200px;
		height: 100px;
		border: 10px solid red;
		transform: rotate(360deg);
		
 	}

</style>

</head>
<body>

	<div>마우스를 올려보세요</div>

</body>
</html>