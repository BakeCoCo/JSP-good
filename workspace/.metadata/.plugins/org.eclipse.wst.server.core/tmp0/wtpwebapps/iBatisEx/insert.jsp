<%@page import="java.util.Date"%>
<%@page import="my.ibatis.Person"%>
<%@page import="my.ibatis.MyAppSqlConfig"%>
<%@page import="com.ibatis.sqlmap.client.SqlMapClient"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>iBatis를 이용한 저장</title>
</head>
<body>
<%
	SqlMapClient mapper = MyAppSqlConfig.getSqlMapInstance();
	// mapper(DB 연결 및 연결된 테이블에서 실행할 SQL 명령)를 얻어온다.
	
	Person p1 = new Person();
	p1.setFirstName("홍");
	p1.setLastName("길동");
	p1.setBirthDate(new Date(1999,2,5));
	p1.setWeightInKilograms(45.8);
	p1.setHeightInMeters(1.81);
	
	mapper.insert("insertPerson", p1);
	// 연결된 DB에서 id가 insertPerson인 insert 명령을 실행한다.
	// p1의 내용이 parameterClass로 전달된다.
	out.println("저장완료");
	
	out.println("연결성공 : " + mapper);
%>
</body>
</html>





