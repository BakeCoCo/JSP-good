package my.model;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Memo {
    private int idx;
    private String name;
    private String password;
    private String memo;
    private Date writeDate;
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public Date getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}
	@Override
	public String toString() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String msg = memo.replace("<","&lt;").replace(">","&gt;").replace("\n","<br/>");
		return name + "님이 " + sdf.format(writeDate) + "에 남긴글<br/>" + msg;
	}
}
