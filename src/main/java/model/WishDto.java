package model;

public class WishDto {
	private int wish_bno;
	private int bno;
    private String name;
    private String title;
    private String content;
    private String imgfile;
    private int views;
    private String  regdate;
    
	
    
    public int getWish_bno() {
    	return wish_bno;
    }
    public void setWish_bno(int wish_bno) {
    	this.wish_bno = wish_bno;
    }
    public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getImgfile() {
		return imgfile;
	}
	public void setImgfile(String imgfile) {
		this.imgfile = imgfile;
	}
	
	public int getViews() {
		return views;
	}
	public void setViews(int views) {
		this.views = views;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
}




