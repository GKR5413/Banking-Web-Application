package com.Bank.web.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Random;


import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.Bank.web.controller.bean.AlertBean;
import com.Bank.web.controller.bean.User;
import com.Bank.web.controller.bean.User_Signup;
import com.Bank.web.controller.bean.uniqueVariablesCheck;
import com.Bank.web.service.UserService;

@Controller
public class UserController {
	
	@Autowired
	UserService userService;
	
//	Login API
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginpage(@ModelAttribute("alert_msg") AlertBean alert, Model model) {
		model.addAttribute("alert_msg" ,alert.getAlert());
		return "index"; 
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String welcomePage( ModelMap model,@RequestParam String userId, @RequestParam String cred, 
			@ModelAttribute("alert_msg") AlertBean alert, HttpSession session, RedirectAttributes rs) {

		 Random r = new Random();
	     int n = r.nextInt();
	     String Hexadecimal = Integer.toHexString(n);
	     session.setAttribute("ssid", Hexadecimal);  	     
	     session.setAttribute("usid", Integer.parseInt(userId));
	     
	     AlertBean alert1 = new AlertBean();
	
	    User user = userService.getUserByUserId(userId);	//calling getUserByUserID method. 	
 
		if(user.getCred() != null) {	// Checking if UserId is valid
			if(user.getCred().equals(cred)) {
				String var= "yas";
				rs.addFlashAttribute("uid", var);
				return "redirect:/account";	
			}else {
				model.clear();
				String error =  "Incorrect Password, Please check your Password and try again";
				model.addAttribute("Invalid_Password", error);
				model.addAttribute("alert_msg" ,alert1.getAlert());
				return "index"; // Redirect back to login with wrong password error
			}
		}else {
			model.clear();
			String error = "Incorrect UserId, Please check your UserId and try again";
			model.addAttribute("Invalid_UserId", error);
			model.addAttribute("alert_msg" ,alert1.getAlert());
			return "index";	// Redirect back to login with wrong userid error
		}
	}
	
	
//	Registration API
	@RequestMapping(value="/register", method = RequestMethod.GET)
	public String RegistrationPage(Model model) {		
		return "register";
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String RegisterUser(@ModelAttribute("user_data") User_Signup user_data,
								@RequestParam(name = "Res_proof", required = false) MultipartFile file_1,
								@RequestParam(name = "Fin_proof", required = false) MultipartFile file_2, 
								@RequestParam String cred, @RequestParam String cred2, ModelMap model, BindingResult result, 
								RedirectAttributes rs,HttpSession session) {

		
		if(file_1 == null) {
			user_data.setResidential_proof("No File Uploaded");
			System.out.println("Residential Proof not uploaded!");
		}
		else {
			user_data.setResidential_proof(file_1.getOriginalFilename());
			try {
				File saveFile = new ClassPathResource("/").getFile();
				Path path = Paths.get(saveFile.getAbsolutePath()+File.separator+file_1.getOriginalFilename());
				Files.copy(file_1.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
				System.out.println("Residential Proof Uploaded Successfully");
			} catch (IOException e) {		
				e.printStackTrace();
			}
		}
		
		if(file_2 == null) {
			user_data.setFinanacial_proof("No File Uploaded");
			System.out.println("Financial Proof not uploaded!");
		}
		else {
			user_data.setFinanacial_proof(file_2.getOriginalFilename());
			try {
				File saveFile = new ClassPathResource("/").getFile();
				Path path = Paths.get(saveFile.getAbsolutePath()+File.separator+file_2.getOriginalFilename());
				Files.copy(file_2.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
				System.out.println("Financial Proof Uploaded Successfully");
			} catch (IOException e) {		
				e.printStackTrace();
			}
		}
		

		uniqueVariablesCheck check = new uniqueVariablesCheck();
		check = userService.CheckUserEntriesForUniqueness(user_data);
		
		model.clear();
		
		if(check.getEmail() != 0) {
			String Error = "Email Already Exists!";
			model.addAttribute("Email_Error",Error);
		}
		
		if(check.getPhno() != 0) {
			String Error = "Phone Already Exists!";
			model.addAttribute("PhoneNumber_Error",Error);
		}
		
		if(check.getAadhar() != 0) {
			String Error = "Aadhar Number Already Exists!";
			model.addAttribute("Aadhar_Error",Error);
		}
		
		if(check.getPan() != 0) {
			String Error = "Pan Number Already Exists!";
			model.addAttribute("Pan_Error",Error);
		}
		
		int passwordmatch = 1;
		if(cred.equals(cred2)) {
			passwordmatch = 0;
		}
		else {
			model.clear();
			passwordmatch = 1;
			String error = "Passwords doesn't match";
			model.addAttribute("PasswordError", error);
		}
		
		if(check.getEmail() == 0 && check.getPhno() == 0 && check.getAadhar() == 0 && check.getPan() == 0 && passwordmatch == 0) {
			
			String out_msg = userService.RegisterUser(user_data);
			
			AlertBean alert = new AlertBean();
			  if(!out_msg.isEmpty()) {  
				  	alert.setAlert(out_msg);
				  	rs.addFlashAttribute("alert_msg", alert);
				  }else {
					alert.setAlert("Failed");
					rs.addFlashAttribute("alert_msg", alert);
			 }
			  
			return "redirect:/login";
		}
		
		else {
			model.addAttribute("input", user_data);
			return "register";
		}	
	}	
}























