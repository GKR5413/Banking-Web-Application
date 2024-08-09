package com.Bank.web.controller.bean;

public class AlertBean {
	
	private String Alert = "null";

	public String getAlert() {
		return Alert;
	}

	public void setAlert(String alert) {
		Alert = alert;
	}

	@Override
	public String toString() {
		return "AlertBean [Alert=" + Alert + "]";
	}	
	
}
