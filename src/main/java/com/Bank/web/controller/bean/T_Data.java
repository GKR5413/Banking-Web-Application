package com.Bank.web.controller.bean;

import java.sql.Date;
import java.text.DecimalFormat;

public class T_Data {
	
	DecimalFormat f = new DecimalFormat("0.00");
	
	private Date t_date;
	private long acc_no;
	private String t_id;
	private String pmnt_method;
	private String pmnt_type;
	private String amnt;
	public Date getT_date() {
		return t_date;
	}
	public void setT_date(Date t_date) {
		this.t_date = t_date;
	}
	public long getAcc_no() {
		return acc_no;
	}
	public void setAcc_no(long acc_no) {
		this.acc_no = acc_no;
	}
	public String getT_id() {
		return t_id;
	}
	public void setT_id(String t_id) {
		this.t_id = t_id;
	}
	public String getPmnt_method() {
		return pmnt_method;
	}
	public void setPmnt_method(String pmnt_method) {
		this.pmnt_method = pmnt_method;
	}
	public String getPmnt_type() {
		return pmnt_type;
	}
	public void setPmnt_type(String pmnt_type) {
		this.pmnt_type = pmnt_type;
	}
	public String getAmnt() {
		return amnt;
	}
	public void setAmnt(double amnt) {
		this.amnt = f.format(amnt);
	}
	
	@Override
	public String toString() {
		return "T_Data [t_date=" + t_date + ", acc_no=" + acc_no + ", t_id=" + t_id + ", pmnt_method=" + pmnt_method
				+ ", pmnt_type=" + pmnt_type + ", amnt=" + amnt + "]";
	}
	public T_Data() {
		super();
		// TODO Auto-generated constructor stub
	}
	public T_Data(Date t_date, long acc_no, String t_id, String pmnt_method, String pmnt_type, String amnt) {
		this.t_date = t_date;
		this.acc_no = acc_no;
		this.t_id = t_id;
		this.pmnt_method = pmnt_method;
		this.pmnt_type = pmnt_type;
		this.amnt = amnt;
	}
	
	
}
