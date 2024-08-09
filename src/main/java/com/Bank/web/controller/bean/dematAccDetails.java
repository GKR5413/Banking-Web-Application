package com.Bank.web.controller.bean;

import java.text.DecimalFormat;

public class dematAccDetails {
	private long acc_no;
	private String original_total_amount;
	private String market_total_amount;
	
	private final DecimalFormat decfor = new DecimalFormat("0.00");
	
	public long getAcc_no() {
		return acc_no;
	}
	public void setAcc_no(long acc_no) {
		this.acc_no = acc_no;
	}
	public String getOriginal_total_amount() {
		return original_total_amount;
	}
	public void setOriginal_total_amount(double original_total_amount) {
		this.original_total_amount = decfor.format(original_total_amount);
	}
	public String getMarket_total_amount() {
		return market_total_amount;
	}
	public void setMarket_total_amount(double market_total_amount) {
		this.market_total_amount = decfor.format(market_total_amount);
	}
	
}
