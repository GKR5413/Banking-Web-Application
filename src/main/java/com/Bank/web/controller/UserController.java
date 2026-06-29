package com.Bank.web.controller;

import java.security.SecureRandom;
import java.util.Base64;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
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
import com.Bank.web.util.FileUploadUtil;
import com.Bank.web.util.FileUploadUtil.FileUploadResult;
import com.Bank.web.util.PasswordUtil;
import com.Bank.web.util.PasswordUtil.PasswordValidationResult;

@Controller
public class UserController {
	
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	UserService userService;
	
	@Autowired
	PasswordUtil passwordUtil;
	
	@Autowired
	FileUploadUtil fileUploadUtil;
	
//	Login API
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginpage(@ModelAttribute("alert_msg") AlertBean alert, Model model) {
		model.addAttribute("alert_msg" ,alert.getAlert());
		return "index"; 
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String welcomePage( ModelMap model,@RequestParam String userId, @RequestParam String cred, 
			@ModelAttribute("alert_msg") AlertBean alert, HttpSession session, RedirectAttributes rs) {

	     AlertBean alert1 = new AlertBean();
	     
	     if (userId == null || userId.isEmpty() || !userId.matches("^[0-9]{1,10}$")) {
	    	 model.clear();
	    	 model.addAttribute("Invalid_Credentials", "Invalid credentials. Please check your User ID and Password.");
	    	 model.addAttribute("alert_msg", alert1.getAlert());
	    	 return "index";
	     }
	     
	     int parsedUserId;
	     try {
	    	 parsedUserId = Integer.parseInt(userId);
	    	 if (parsedUserId < 0) {
	    		 throw new NumberFormatException("Negative user ID");
	    	 }
	     } catch (NumberFormatException e) {
	    	 model.clear();
	    	 model.addAttribute("Invalid_Credentials", "Invalid credentials. Please check your User ID and Password.");
	    	 model.addAttribute("alert_msg", alert1.getAlert());
	    	 logger.warn("Invalid userId format attempted: {}", userId);
	    	 return "index";
	     }
	
	    User user = userService.getUserByUserId(userId);
 
		boolean loginSuccess = false;
		
		if(user.getCred() != null && passwordUtil.verifyPassword(cred, user.getCred())) {
			loginSuccess = true;
		}
		
		if (loginSuccess) {
			SecureRandom secureRandom = new SecureRandom();
			byte[] sessionIdBytes = new byte[32];
			secureRandom.nextBytes(sessionIdBytes);
			String secureSessionId = Base64.getUrlEncoder().withoutPadding().encodeToString(sessionIdBytes);
			
			session.setAttribute("ssid", secureSessionId);
			session.setAttribute("usid", parsedUserId);
			
			String var= "yas";
			rs.addFlashAttribute("uid", var);
			return "redirect:/account";	
		} else {
			model.clear();
			String error = "Invalid credentials. Please check your User ID and Password.";
			model.addAttribute("Invalid_Credentials", error);
			model.addAttribute("alert_msg", alert1.getAlert());
			logger.warn("Failed login attempt for userId: {}", userId);
			return "index";
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

		int tempUserId = 0;
		
		if(file_1 == null || file_1.isEmpty()) {
			user_data.setResidential_proof("No File Uploaded");
			logger.debug("Residential Proof not uploaded");
		}
		else {
			FileUploadResult uploadResult = fileUploadUtil.uploadFile(file_1, tempUserId);
			if (uploadResult.isSuccess()) {
				user_data.setResidential_proof(uploadResult.getSavedFilename());
				logger.info("Residential Proof uploaded: {}", uploadResult.getSavedFilename());
			} else {
				model.addAttribute("File_Error", "Residential proof: " + uploadResult.getErrorMessage());
				model.addAttribute("input", user_data);
				return "register";
			}
		}
		
		if(file_2 == null || file_2.isEmpty()) {
			user_data.setFinanacial_proof("No File Uploaded");
			logger.debug("Financial Proof not uploaded");
		}
		else {
			FileUploadResult uploadResult = fileUploadUtil.uploadFile(file_2, tempUserId);
			if (uploadResult.isSuccess()) {
				user_data.setFinanacial_proof(uploadResult.getSavedFilename());
				logger.info("Financial Proof uploaded: {}", uploadResult.getSavedFilename());
			} else {
				model.addAttribute("File_Error", "Financial proof: " + uploadResult.getErrorMessage());
				model.addAttribute("input", user_data);
				return "register";
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
		boolean passwordStrengthValid = true;
		
		if(cred.equals(cred2)) {
			passwordmatch = 0;
			
			PasswordUtil.PasswordValidationResult passwordValidation = passwordUtil.validatePasswordStrength(cred);
			if (!passwordValidation.isValid()) {
				passwordStrengthValid = false;
				model.addAttribute("PasswordError", passwordValidation.getErrorMessage());
			}
		}
		else {
			passwordmatch = 1;
			String error = "Passwords don't match";
			model.addAttribute("PasswordError", error);
		}
		
		if(check.getEmail() == 0 && check.getPhno() == 0 && check.getAadhar() == 0 && check.getPan() == 0 && passwordmatch == 0 && passwordStrengthValid) {
			
			String hashedPassword = passwordUtil.hashPassword(cred);
			user_data.setCred(hashedPassword);
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























