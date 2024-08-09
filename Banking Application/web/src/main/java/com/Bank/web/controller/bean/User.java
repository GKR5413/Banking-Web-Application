package com.Bank.web.controller.bean;

public class User {
	
	private String userId;
	private String cred;
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getCred() {
		return cred;
	}
	public void setCred(String cred) {
		this.cred = cred;
	}
	
	@Override
	public String toString() {
		return "User [userId=" + userId + ", cred=" + cred + "]";
	}
	
}
