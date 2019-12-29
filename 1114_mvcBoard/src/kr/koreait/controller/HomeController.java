package kr.koreait.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.koreait.service.MvcboardService;

@WebServlet("*.nhn")
public class HomeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	MvcboardService service = MvcboardService.getInstance();
	
    public HomeController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actionDo(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actionDo(request, response);
	}
	
	protected void actionDo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		String url = request.getRequestURI();
		String contextPath = request.getContextPath();
		String context = url.substring(contextPath.length());
		
		String viewPage = "/WEB-INF/";
		switch(context) {
			case "/insert.nhn":
				viewPage += "insert.jsp";
				break;
			case "/insertOK.nhn":
//				insert.jsp에서 테이블에 저장할 데이터를 입력하고 submit 버튼을 클릭하면 폼에 입력된 정보가 컨트롤러의 doPost() 
//				메소드의 HttpServletRequest 인터페이스 타입의 request 객체로 전달된다. => doPost() 메소드에서는 request 객체에
//				저장된 데이터를 가지고 actionDo() 메소드를 실행하므로 insert.jsp에서 폼에 입력한 데이터가 actionDo() 메소드의
//				request 객체로 전달된다.
//				System.out.println("이름 : " + request.getParameter("name"));
//				System.out.println("제목 : " + request.getParameter("subject"));
//				System.out.println("내용 : " + request.getParameter("content"));
//				insert.jsp의 폼에 입력한 데이터를 테이블에 저장하는 메소드를 호출한다.
				service.insert(request, response);
				viewPage += "insertOK.jsp";
				break;
			case "/list.nhn":
//				브라우저에 출력할 한 페이지 분량의 글과 페이지 작업에 사용할 8개의 변수가 저장된 클래스 객체를 얻어오는 메소드를
//				호출한다.
				service.selectList(request, response);
				viewPage += "list.jsp";
				break;
			case "/increment.nhn":
//				조회수를 증가시키는 메소드를 호출한다.
				service.increment(request, response);
				viewPage += "increment.jsp";
				break;
			case "/contentView.nhn":
//				조회수를 증가시킨 글 한 건을 얻어오는 메소드를 호출한다.
				service.selectByIdx(request, response);
				viewPage += "contentView.jsp";
				break;
			case "/delete.nhn":
//				글 한 건을 삭제하는 메소드를 호출한다.
				service.delete(request, response);
				viewPage += "goList.jsp";
				break;
			case "/update.nhn":
//				글 한 건을 수정하는 메소드를 호출한다.
				service.update(request, response);
				viewPage += "goList.jsp";
				break;
			case "/reply.nhn":
//				답글을 입력하는 페이지에 질문글을 출력하기 위해 질문글 글 한 건을 얻어서 답변을 입력하는 페이지로 넘겨준다.
				service.selectByIdx(request, response);
				viewPage += "reply.jsp";
				break;
			case "/replyInsert.nhn":
//				답글이 브라우저에 표시되는 위치를 정하기 위해 조건에 만족하는 seq 값을 1씩 증가시키킨 후 답글을 저장한다.
				service.replyInsert(request, response);
				viewPage += "goList.jsp";
				break;
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
		
	}

}









