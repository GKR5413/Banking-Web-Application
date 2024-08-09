package com.Bank.web.controller.bean;

import java.text.DecimalFormat;

public class selectedStockDetails {
	private String stock_name;
	private String price;
	private int avl_quantity;
	private String stock_id;
	private long sno;
	
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
	public String getStock_name() {
		return stock_name;
	}
	public void setStock_name(String stock_name) {
		this.stock_name = stock_name;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = decfor.format(price);
	}
	public int getAvl_quantity() {
		return avl_quantity;
	}
	public void setAvl_quantity(int avl_quantity) {
		this.avl_quantity = avl_quantity;
	}
	
	
}
