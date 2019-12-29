<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="kr.koreait.calendar.MyCalendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>만년달력</title>

<link rel="stylesheet" href="calendar.css"/>

</head>
<body>

<%
//	out.println(MyCalendar.isLeapYear(2019) + "<br/>");
//	out.println(MyCalendar.lastDay(2019, 2) + "<br/>");
//	out.println(MyCalendar.totalDay(2019, 10, 18) + "<br/>");
//	out.println(MyCalendar.weekDay(2019, 10, 18) + "<br/>");

//	컴퓨터 시스템의 년, 월을 얻어온다.
//	Date date = new Date();
//	int year = date.getYear() + 1900;
//	int month = date.getMonth() + 1;
	Calendar calendar = Calendar.getInstance();
	int year = calendar.get(Calendar.YEAR);
	int month = calendar.get(Calendar.MONTH) + 1;
//	out.println(year+ "년 " + month + "월<br/>");

	try {
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		
		if(month >= 13) {
			year++;
			month = 1;
		} else if(month <= 0) {
			year--;
			month = 12;
		}
		
	} catch (Exception e) { }

%>

<!-- 달력을 만든다. -->
<table width="700" align="center" border="0" cellpadding="5" cellspacing="0">
	<tr>
		<th>
			<%-- <a href="?year=<%=year%>&month=<%=month-1%>">이전달</a> --%>
			<input type="button" value="이전달" onclick="location.href='?year=<%=year%>&month=<%=month-1%>'">
		</th>
		<th id="title" colspan="5">
			<%=year%>년 <%=month%>월
		</th>
		<th>
			<%-- <a href="?year=<%=year%>&month=<%=month+1%>">다음달</a> --%>
			<input type="button" value="다음달" onclick="location.href='?year=<%=year%>&month=<%=month+1%>'">
		</th>
	</tr>
	<tr>
		<td class="sunday">일</td>
		<td class="etcday">월</td>
		<td class="etcday">화</td>
		<td class="etcday">수</td>
		<td class="etcday">목</td>
		<td class="etcday">금</td>
		<td class="saturday">토</td>
	</tr>
	<tr>
<%
//	1일의 요일을 계산한다.
	int week = MyCalendar.weekDay(year, month, 1);

//	1일이 출력될 위치를 맞추기 위해서 1일을 요일 만큼 반복하며 빈 칸을 출력한다.
//	for(int i = 1; i <= week; i++) {
//		out.println("<td>&nbsp;</td>");
//	}

//	빈 칸에 출력할 전 달 날짜의 시작일을 계산한다.
	/*
	int start = 0;
	if(month == 1) {
		start = MyCalendar.lastDay(year - 1, 12) - week;		// 1월
	} else {
		start = MyCalendar.lastDay(year, month - 1) - week;		// 2 ~ 12월
	}
	*/
	int start = month == 1 ? 31 - week : MyCalendar.lastDay(year, month - 1) - week;

//	1일이 출력될 위치를 맞추기 위해서 1일을 요일 만큼 반복하며 전달의 날짜를 출력한다.
	for(int i = 1; i <= week; i++) {
		if(i == 1) {
			out.println("<td class='beforesun'>" + (month == 1 ? 12 : month - 1) + "/" + ++start + "</td>");
		} else {
			out.println("<td class='before'>" + (month == 1 ? 12 : month - 1) + "/" + ++start + "</td>");
		}
	}

//	1일 부터 달력을 출력할 달의 마지막 날짜 까지 반복하며 날짜를 출력한다.
	boolean flag = false;
	int child = 0;
	for(int i = 1; i <= MyCalendar.lastDay(year, month); i++) {
		
//		어린이날이 토요일 또는 일요일과 겹치는 경우 그 다음 첫 번째 비 공휴일을 대체 공휴일로 한다.
		if(MyCalendar.weekDay(year, 5, 5) == 6) {
			flag = true;
			child = 7;
		} else if(MyCalendar.weekDay(year, 5, 5) == 0) {
			flag = true;
			child = 6;
		}
		
//		공휴일을 표시한다. => 일단 양력 공휴일과, 어린이날 대체 공휴일 => 설날, 추석, 부처님오신날은 solatolunar.sql 를 이용해서 
//		양력, 음력 대조 테이블을 붙이고 해야 한다.
		if(month == 1 && i == 1) {
			out.println("<td class='sun'>" + i + "<br><span>신정</span></td>");
		} else if(month == 3 && i == 1) {
			out.println("<td class='sun'>" + i + "<br><span>삼일절</span></td>");
		} else if(month == 5 && i == 1) {
			out.println("<td class='sun'>" + i + "<br><span>근로자의날</span></td>");
		} else if(month == 5 && i == 5) {
			out.println("<td class='sun'>" + i + "<br><span>어린이날</span></td>");
		} else if(month == 6 && i == 6) {
			out.println("<td class='sun'>" + i + "<br><span>현충일</span></td>");
		} else if(month == 8 && i == 15) {
			out.println("<td class='sun'>" + i + "<br><span>광복절</span></td>");
		} else if(month == 10 && i == 3) {
			out.println("<td class='sun'>" + i + "<br><span>개천절</span></td>");
		} else if(month == 10 && i == 9) {
			out.println("<td class='sun'>" + i + "<br><span>한글날</span></td>");
		} else if(month == 12 && i == 25) {
			out.println("<td class='sun'>" + i + "<br><span>크리스마스</span></td>");
		} else if(flag && month == 5 && i == child) {
			out.println("<td class='sun'>" + i + "<br><span>대체공휴일</span></td>");
		} else if(year == calendar.get(Calendar.YEAR) && month == calendar.get(Calendar.MONTH) + 1 && 
				i == calendar.get(Calendar.DAY_OF_MONTH)) {
			out.println("<td class='today'>" + i + "<br></td>");
		}
		else {
//			요일 별로 색깔을 다르게 출력하기 위해 <td> 태그에 class 속성을 지정해야 한다.
			switch(MyCalendar.weekDay(year, month, i)) {
				case 0:
					out.println("<td class='sun'>" + i + "</td>");
					break;
				case 6:
					out.println("<td class='sat'>" + i + "</td>");
					break;
				default:
					out.println("<td class='etc'>" + i + "</td>");
					break;
			}
		}
		
//			출력한 날짜(i)가 토요일 이고 그 달의 마지막 날짜가 아니면 줄을 바꾼다.
			if(MyCalendar.weekDay(year, month, i) == 6 && i != MyCalendar.lastDay(year, month)) {
				out.println("</tr><tr>");
			}
	}

//	날짜를 다 출력하고 남은 칸에 다음 달의 날짜를 다음 달 1일의 요일 부터 토요일 까지 반복하며 출력한다.
//	다음 달 1일의 요일을 계산한다.
	/*
	if(month == 12) {
		week = MyCalendar.weekDay(year + 1, 1, 1);
	} else {
		week = MyCalendar.weekDay(year, month + 1, 1);
	}
	*/
	week = month == 12 ? MyCalendar.weekDay(year + 1, 1, 1) : MyCalendar.weekDay(year, month + 1, 1);
	if(week != 0) {
		start = 0;
		for(int i = week; i <= 6; i++) {
			if(i == 6) {
				out.println("<td class='aftersat'>" + (month == 12 ? 1 : month + 1) + "/" + ++start + "</td>");
			} else {
				out.println("<td class='after'>" + (month == 12 ? 1 : month + 1) + "/" + ++start + "</td>");
			}
		}
	}
%>
	</tr>
	
	<!-- 년, 월을 선택하고 보기 버튼을 클릭하면 특정 달의 달력으로 한 번에 넘아가게 한다. -->
	<tr>
		<td colspan="7">
			<form action="?" method="post">
				<select name="year">
<%
	for(int i = 1950; i <= 2050; i++) {
		if(calendar.get(Calendar.YEAR) == i) {
			out.println("<option selected='selected'>" + i + "</option>");
		} else {
			out.println("<option>" + i + "</option>");
		}
	}
%>
				</select>년&nbsp;
				<select name="month">
<%
	for(int i = 1; i <= 12; i++) {
		if(calendar.get(Calendar.MONTH) + 1 == i) {
			out.println("<option selected='selected'>" + i + "</option>");
		} else {
			out.println("<option>" + i + "</option>");
		}
	}
%>
				</select>월&nbsp;
				<input type="submit" value="보기"/>
			</form>
		</td>
	</tr>
	
</table>

</body>
</html>











