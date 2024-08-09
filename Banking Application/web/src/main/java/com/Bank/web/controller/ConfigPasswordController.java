package com.Bank.web.controller;


import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.Bank.web.controller.bean.AlertBean;
import com.Bank.web.controller.bean.forgotPass;
import com.Bank.web.service.UserService;

@Controller
public class ConfigPasswordController {
	@Autowired
	UserService userService;
	
	
	@RequestMapping(value = "/forgotpassword", method = RequestMethod.GET)
	public String Forgotpassword() {
		return "forgotpassword"; 
	}
	
	@RequestMapping(value = "/forgotpassword", method = RequestMethod.POST)
	public String forgotpass( ModelMap model,@RequestParam int usr_id, @RequestParam String email, RedirectAttributes redirectAttributes) {
		forgotPass user = userService.validateUser(usr_id);
		
		if(user.getEmail() != null) {	// Checking if UserId is valid
			if(user.getEmail().equals(email)) {
				redirectAttributes.addFlashAttribute("usvid", usr_id);
				return "redirect:/resetpassword";	
			}else {
				model.clear();
				String error =  "Incorrect Email, Please check your Email and try again";
				model.addAttribute("Invalid_Email", error);
				return "forgotpassword"; // Redirect back to login with wrong Email error
			}
		}else {
			model.clear();
			String error = "Incorrect UserId, Please check your UserId and try again";
			model.addAttribute("Invalid_UserId", error);
			return "forgotpassword";	// Redirect back to forgotpassword with wrong userid error
		}
	}
		
	@RequestMapping(value = "/resetpassword", method = RequestMethod.GET)
	public String Resetpassword( @ModelAttribute("usvid") String usr_id , Model model,  RedirectAttributes redirectAttributes) {
		if(!usr_id.isEmpty()) {
			model.addAttribute("usid",usr_id);
			return "resetpassword";
		}
		else {
			return "index";
		}
	}
	
	@RequestMapping(value = "/resetpassword", method = RequestMethod.POST)
	public String Resetpassword(ModelMap model, @RequestParam String usr_id ,@RequestParam String cred, @RequestParam String cred2, RedirectAttributes rs) {
	
		int user_id = Integer.parseInt(usr_id); 	
		
		if(cred.equals(cred2)) {
			
			String out_msg = userService.resetPassword(user_id, cred);
			 
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
			model.clear();
			String error = "Passwords doesn't match";			
			model.addAttribute("PasswordError", error);
			return "resetpassword";
		}
		 
	}
	
}
