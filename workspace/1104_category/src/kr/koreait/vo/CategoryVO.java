package kr.koreait.vo;

public class CategoryVO {

	private int idx;				// 카테고리 일련번호
	private String category;		// 카테고리 이름
	private int ref;				// 카테고리 그룹
	private int lev;				// 카테고리 레벨
	private int seq;				// 같은 카테고리 그룹에서 카테고리 출력순서
	private String deleteCheck;		// 카테고리 삭제 여부(yes => 삭제한 카테고리)
	private int deleteReport;		// 신고 횟수
	
	public int getDeleteReport() {
		return deleteReport;
	}
	public void setDeleteReport(int deleteReport) {
		this.deleteReport = deleteReport;
	}
	public String getDeleteCheck() {
		return deleteCheck;
	}
	public void setDeleteCheck(String deleteCheck) {
		this.deleteCheck = deleteCheck;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public int getLev() {
		return lev;
	}
	public void setLev(int lev) {
		this.lev = lev;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	
	@Override
	public String toString() {
		return "CategoryVO [idx=" + idx + ", categoey=" + category + ", ref=" + ref + ", lev=" + lev + ", seq=" + seq
				+ "]";
	}
	
}
