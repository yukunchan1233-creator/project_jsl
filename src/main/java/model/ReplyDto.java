package model;

public class ReplyDto {
	private int bno;              // 댓글 번호 (PK)
	private int blog_bno;        // 블로그 번호 (FK)
	private String userid;       // 글쓴이 아이디 (FK)
	private String replytext;     // 댓글 내용
	private String regdate;       // 등록 날짜
	
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public int getBlog_bno() {
		return blog_bno;
	}
	public void setBlog_bno(int blog_bno) {
		this.blog_bno = blog_bno;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getReplytext() {
		return replytext;
	}
	public void setReplytext(String replytext) {
		this.replytext = replytext;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
}




