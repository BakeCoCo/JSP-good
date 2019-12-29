<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">

	div {
		width: 50px;
		height: 50px;
		background-color: yellow;
		border: 1px solid black;
		text-align: center;;
 	}
	div#box2 {
		transform: translate(100px, 0px);
		background-color: blue;
 	}
	div#box3 {
		transform: scale(1.2, 1.2);
		background-color: red;
 	}


</style>

</head>
<body>

	<div id="box1">Box1</div>
	<div id="box2">Box2</div>
	<div id="box3">Box2</div>

</body>
</html>