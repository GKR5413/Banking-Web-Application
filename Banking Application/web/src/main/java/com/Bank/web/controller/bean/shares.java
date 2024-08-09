package com.Bank.web.controller.bean;

import java.text.DecimalFormat;

public class shares {
	
	private long sno;
	private String stock_id;
	private String stock_name;
	private String original_price;
	private String market_price;
	private int no_stocks;
	private String total_market_value;
	private long demat_acc_no;
	
	private final DecimalFormat decfor = new DecimalFormat("0.00");
	
	
	
	
	public long getSno() {
		return sno;
	}
	
	public void setSno(long sno) {
		this.sno = sno;
	}
	public String getStock_id() {
		return stock_id;
	}
	public void setStock_id(String stock_id) {
		this.stock_id = stock_id;
	}
	public void setOriginal_price(String original_price) {
		this.original_price = original_price;
	}
	public void setMarket_price(String market_price) {
		this.market_price = market_price;
	}
	public void setTotal_market_value(String total_market_value) {
		this.total_market_value = total_market_value;
	}
	public String getStock_name() {
		return stock_name;
	}
	public void setStock_name(String stock_name) {
		this.stock_name = stock_name;
	}
	public String getOriginal_price() {
		return original_price;
	}
	public void setOriginal_price(double original_price) {
		this.original_price = decfor.format(original_price);
	}
	public String getMarket_price() {
		return market_price;
	}
	public void setMarket_price(double market_price) {
		this.market_price = decfor.format(market_price);
	}
	public int getNo_stocks() {
		return no_stocks;
	}
	public void setNo_stocks(int no_stocks) {
		this.no_stocks = no_stocks;
	}
	public String getTotal_market_value() {
		return total_market_value;
	}
	public void setTotal_market_value() {
		this.total_market_value = decfor.format(Double.parseDouble(market_price) * no_stocks);
	}
	public void setTotal_market_value(double total_market_value) {
		this.total_market_value = decfor.format(total_market_value);
	}
	public long getDemat_acc_no() {
		return demat_acc_no;
	}
	public void setDemat_acc_no(long demat_acc_no) {
		this.demat_acc_no = demat_acc_no;
	}
	
	
	
}
