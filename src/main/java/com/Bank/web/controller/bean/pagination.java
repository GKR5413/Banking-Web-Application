package com.Bank.web.controller.bean;

public class pagination {
	private int pgno = 0;
	private int pagesize = 10;
	private String sortfield = "sno";
	private String sortDir = "DESC";
	private String ScrollPosition = "false";
	private String keyword = "";
	
	

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getScrollPosition() {
		return ScrollPosition;
	}

	public void setScrollPosition(String scrollPosition) {
		ScrollPosition = scrollPosition;
	}

	public int getPgno() {
		return pgno;
	}

	public void setPgno(int pgno) {
		this.pgno = pgno;
	}

	public int getPagesize() {
		return pagesize;
	}

	public void setPagesize(int pagesize) {
		this.pagesize = pagesize;
	}

	public String getSortfield() {
		return sortfield;
	}

	public void setSortfield(String sortfield) {
		this.sortfield = sortfield;
	}

	public String getSortDir() {
		return sortDir;
	}

	public void setSortDir(String sortDir) {
		this.sortDir = sortDir;
	}
	
}
