package com.Bank.web.controller.bean;

import java.text.DecimalFormat;

public class userInfo {
	private long acc_no;
	private String acc_type;
	private String acc_status;
	private String ifsc;
	private String branchname;
	private int branchid;
	private String currency;
	private String acc_balance;
	
	private final DecimalFormat decfor = new DecimalFormat("0.00");
	
	public String getCurrency() {
		return currency;
	}
	public void setCurrency(String currency) {
		this.currency = currency;
	}
	public long getAcc_no() {
		return acc_no;
	}
	public void setAcc_no(long acc_no) {
		this.acc_no = acc_no;
	}
	public String getAcc_type() {
		return acc_type;
	}
	public void setAcc_type(String acc_type) {
		this.acc_type = acc_type;
	}
	public String getAcc_status() {
		return acc_status;
	}
	public void setAcc_status(String acc_status) {
		this.acc_status = acc_status;
	}
	public String getIfsc() {
		return ifsc;
	}
	public void setIfsc(String ifsc) {
		this.ifsc = ifsc;
	}
	public String getBranchname() {
		return branchname;
	}
	public void setBranchname(String branchname) {
		this.branchname = branchname;
	}
	public int getBranchid() {
		return branchid;
	}
	public void setBranchid(int branchid) {
		this.branchid = branchid;
	}
	public String getAcc_balance() {
		return acc_balance;
	}
	public void setAcc_balance(double acc_balance) {
		this.acc_balance = decfor.format(acc_balance);
	}
	
	
}
