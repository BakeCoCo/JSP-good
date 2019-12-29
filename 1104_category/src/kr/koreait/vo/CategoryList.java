package kr.koreait.vo;

import java.util.ArrayList;

public class CategoryList {

	ArrayList<CategoryVO> categorylist = new ArrayList<CategoryVO>();	// 브라우저에 출력할 카테고리 목록을 기억한다.

	public ArrayList<CategoryVO> getCategorylist() {
		return categorylist;
	}
	public void setCategorylist(ArrayList<CategoryVO> categorylist) {
		this.categorylist = categorylist;
	}
	
	@Override
	public String toString() {
		return "CategoryList [categorylist=" + categorylist + "]";
	}
	
}
