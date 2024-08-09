package com.Bank.web.controller.bean;


import java.sql.Date;


public class User_Signup {
	private String Account_Type;
	private String Currency_Type;
	private String First_Name;
	private String Last_Name;
	private java.sql.Date Date;
	private String Email; 
	private long PhoneNumber; 
	private String Street;
	private String City;
	private String State;
	private String Country; 
	private int Zipcode;
	private String Res_id;
	private String Fin_id;
	private String Residential_proof;
	private String Finanacial_proof;
	private String cred;
	
	public String getCred() {
		return cred;
	}
	public void setCred(String cred) {
		this.cred = cred;
	}
	public String getAccount_Type() {
		return Account_Type;
	}
	public void setAccount_Type(String account_Type) {
		Account_Type = account_Type;
	}
	public String getCurrency_Type() {
		return Currency_Type;
	}

	public String getResidential_proof() {
		return Residential_proof;
	}
	public void setResidential_proof(String string) {
		Residential_proof = string;
	}
	public String getFinanacial_proof() {
		return Finanacial_proof;
	}
	public void setFinanacial_proof(String finanacial_proof) {
		Finanacial_proof = finanacial_proof;
	}
	public void setCurrency_Type(String currency_Type) {
		Currency_Type = currency_Type;
	}
	public String getFirst_Name() {
		return First_Name;
	}
	public void setFirst_Name(String first_Name) {
		First_Name = first_Name;
	}
	public String getLast_Name() {
		return Last_Name;
	}
	public void setLast_Name(String last_Name) {
		Last_Name = last_Name;
	}
	public Date getDate() {
		return Date;
	}
	public void setDate(java.sql.Date date) {
		Date = date;
	}
	public String getEmail() {
		return Email;
	}
	public void setEmail(String email) {
		Email = email;
	}
	public long getPhoneNumber() {
		return PhoneNumber;
	}
	public void setPhoneNumber(long phoneNumber) {
		PhoneNumber = phoneNumber;
	}
	public String getStreet() {
		return Street;
	}
	public void setStreet(String street) {
		Street = street;
	}
	public String getCity() {
		return City;
	}
	public void setCity(String city) {
		City = city;
	}
	public String getState() {
		return State;
	}
	public void setState(String state) {
		State = state;
	}
	public String getCountry() {
		return Country;
	}
	public void setCountry(String country) {
		Country = country;
	}
	public int getZipcode() {
		return Zipcode;
	}
	public void setZipcode(int zipcode) {
		Zipcode = zipcode;
	}
	public String getRes_id() {
		return Res_id;
	}
	public void setRes_id(String res_id) {
		Res_id = res_id;
	}
	public String getFin_id() {
		return Fin_id;
	}
	public void setFin_id(String fin_id) {
		Fin_id = fin_id;
	}
	
	public User_Signup() {
		super();
	}
	
	@Override
	public String toString() {
		return "User_Signup [Account_Type=" + Account_Type + ", Currency_Type=" + Currency_Type + ", First_Name="
				+ First_Name + ", Last_Name=" + Last_Name + ", Date=" + Date + ", Email=" + Email + ", PhoneNumber="
				+ PhoneNumber + ", Street=" + Street + ", City=" + City + ", State=" + State + ", Country=" + Country
				+ ", Zipcode=" + Zipcode + ", Res_id=" + Res_id + ", Fin_id=" + Fin_id + "]";
	}
	

}
