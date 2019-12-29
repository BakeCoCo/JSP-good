package kr.koreait.vo;

import java.util.ArrayList;

public class FreeboardCommentList {

	private ArrayList<FreeboardCommentVO> freeboardCommentList = new ArrayList<FreeboardCommentVO>();

	public ArrayList<FreeboardCommentVO> getFreeboardCommentList() {
		return freeboardCommentList;
	}
	public void setFreeboardCommentList(ArrayList<FreeboardCommentVO> freeboardCommentList) {
		this.freeboardCommentList = freeboardCommentList;
	}
	
	@Override
	public String toString() {
		return "FreeboardCommentList [freeboardCommentList=" + freeboardCommentList + "]";
	}
	
}
