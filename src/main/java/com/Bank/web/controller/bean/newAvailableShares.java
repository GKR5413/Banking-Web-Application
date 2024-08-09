package com.Bank.web.controller.bean;

import java.text.DecimalFormat;

public class newAvailableShares {
	
	private String stock_id;
	private String stock_name;
	private String stock_price;
	private int no_of_avl_stocks;
	
	private final DecimalFormat decfor = new DecimalFormat("0.00");
	
	
	
	public String getStock_id() {
		return stock_id;
	}
	public void setStock_id(String stock_id) {
		this.stock_id = stock_id;
	}
	public String getStock_name() {
		return stock_name;
	}
	public void setStock_name(String stock_name) {
		this.stock_name = stock_name;
	}
	public String getStock_price() {
		return stock_price;
	}
	public void setStock_price(double stock_price) {
		this.stock_price = decfor.format(stock_price);
	}
	public int getNo_of_avl_stocks() {
		return no_of_avl_stocks;
	}
	public void setNo_of_avl_stocks(int no_of_avl_stocks) {
		this.no_of_avl_stocks = no_of_avl_stocks;
	}
	
	
}
