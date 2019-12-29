package kr.koreait.vo;

import java.util.ArrayList;

//	1페이지 분량의 글 목록과 페이지 작업에 사용할 8개의 변수를 초기화 시키는 클래스 => 1페이지 분량의 글을 기억하는 클래스
public class GuestbookList {

	private ArrayList<GuestbookVO> guestbookList = new ArrayList<GuestbookVO>();	// 1페이지 분량의 글 목록을 기억하는 ArrayList
//	페이지 작업에 사용할 8개의 변수를 선언한다.
	private int pageSize = 10;			// 한 페이지에 표시할 글의 개수
	private int totalCount = 0;			// 테이블에 저장된 전체 글의 개수
	private int totalPage = 0;			// 테이블에 저장된 전체 글의 개수를 한 페이지에 표시할 글의 개수로 나눈 전체 페이지 개수
	private int currentPage = 1;		// 현재 브라우저에 표시되는 페이지 번호
//	select 명령 실행결과 인덱스 값은 mysql은 0부터 시작하고 oracle은 1부터 시작한다.
	private int startNo = 0;			// 현재 브라우저에 표시되는 페이지 시작 글의 인덱스
	private int endNo = 0;				// 현재 브라우저에 표시되는 페이지 마지막 글의 인덱스, oracle에서 사용한다.
	private int startPage = 0;			// 페이지 이동 하이퍼링크 또는 버튼의 시작 페이지 번호
	private int endPage = 0;			// 페이지 이동 하이퍼링크 또는 버튼의 마지막 페이지 번호

	public GuestbookList() { }
//	pageSize, totalCount, currentPage를 인수로 넘겨받아 초기화하고 나머지 변수를 계산해서 초기화하는 생성자
	public GuestbookList(int pageSize, int totalCount, int currentPage) {
		this.pageSize = pageSize;
		this.totalCount = totalCount;
		this.currentPage = currentPage;
		calculator();
	}
	
//	나머지 5개의 변수에 저장될 값을 계산하는 메소드
	private void calculator() {
		totalPage = (totalCount - 1) / pageSize + 1;
		currentPage = currentPage > totalPage ? totalPage : currentPage;
//		oracle은 select 명령 실행결과 인덱스 값이 1부터 시작되므로 1을 더해야 한다.
		startNo = (currentPage - 1) * pageSize + 1;
		endNo = startNo + pageSize - 1;
		endNo = endNo > totalCount ? totalCount : endNo;
		startPage = (currentPage - 1) / 10 * 10 + 1;
		endPage = startPage + 9;
		endPage = endPage > totalPage ? totalPage : endPage;
	}
	
	public ArrayList<GuestbookVO> getGuestbookList() {
		return guestbookList;
	}
	public void setGuestbookList(ArrayList<GuestbookVO> guestbookList) {
		this.guestbookList = guestbookList;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getStartNo() {
		return startNo;
	}
	public void setStartNo(int startNo) {
		this.startNo = startNo;
	}
	public int getEndNo() {
		return endNo;
	}
	public void setEndNo(int endNo) {
		this.endNo = endNo;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	
	@Override
	public String toString() {
		return "GuestbookList [guestbookList=" + guestbookList + ", pageSize=" + pageSize + ", totalCount=" + totalCount
				+ ", totalPage=" + totalPage + ", currentPage=" + currentPage + ", startNo=" + startNo + ", endNo="
				+ endNo + ", startPage=" + startPage + ", endPage=" + endPage + "]";
	}
	
}











