package com.Bank.web.controller.bean;


import java.sql.Date;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;


public class User_Signup {

	@NotBlank(message = "Account type is required")
	private String Account_Type;

	@NotBlank(message = "Currency type is required")
	private String Currency_Type;

	@NotBlank(message = "First name is required")
	@Size(min = 2, max = 50, message = "First name must be between 2 and 50 characters")
	@Pattern(regexp = "^[a-zA-Z\\s]+$", message = "First name can only contain letters and spaces")
	private String First_Name;

	@NotBlank(message = "Last name is required")
	@Size(min = 2, max = 50, message = "Last name must be between 2 and 50 characters")
	@Pattern(regexp = "^[a-zA-Z\\s]+$", message = "Last name can only contain letters and spaces")
	private String Last_Name;

	@NotNull(message = "Date of birth is required")
	private java.sql.Date Date;

	@NotBlank(message = "Email is required")
	@Email(message = "Invalid email format")
	private String Email;

	@NotNull(message = "Phone number is required")
	private long PhoneNumber;

	@NotBlank(message = "Street address is required")
	@Size(max = 200, message = "Street address cannot exceed 200 characters")
	private String Street;

	@NotBlank(message = "City is required")
	@Size(max = 100, message = "City name cannot exceed 100 characters")
	private String City;

	@NotBlank(message = "State is required")
	@Size(max = 100, message = "State name cannot exceed 100 characters")
	private String State;

	@NotBlank(message = "Country is required")
	@Size(max = 100, message = "Country name cannot exceed 100 characters")
	private String Country;

	@NotNull(message = "Zipcode is required")
	private int Zipcode;

	@NotBlank(message = "Residential ID is required")
	@Pattern(regexp = "^[a-zA-Z0-9]+$", message = "Residential ID can only contain alphanumeric characters")
	private String Res_id;

	@NotBlank(message = "Financial ID is required")
	@Pattern(regexp = "^[a-zA-Z0-9]+$", message = "Financial ID can only contain alphanumeric characters")
	private String Fin_id;

	private String Residential_proof;
	private String Finanacial_proof;

	@NotBlank(message = "Password is required")
	@Size(min = 8, max = 100, message = "Password must be between 8 and 100 characters")
	@Pattern(
		regexp = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=]).*$",
		message = "Password must contain at least one digit, one lowercase, one uppercase, and one special character"
	)
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
