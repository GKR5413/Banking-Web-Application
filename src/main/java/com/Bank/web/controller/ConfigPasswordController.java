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
import com.Bank.web.util.PasswordUtil;
import com.Bank.web.util.PasswordUtil.PasswordValidationResult;

@Controller
public class ConfigPasswordController {
	@Autowired
	UserService userService;
	
	@Autowired
	PasswordUtil passwordUtil;
	
	
	@RequestMapping(value = "/forgotpassword", method = RequestMethod.GET)
	public String Forgotpassword() {
		return "forgotpassword"; 
	}
	
	@RequestMapping(value = "/forgotpassword", method = RequestMethod.POST)
	public String forgotpass( ModelMap model,@RequestParam int usr_id, @RequestParam String email, RedirectAttributes redirectAttributes) {
		forgotPass user = userService.validateUser(usr_id);
		
		boolean validCredentials = user.getEmail() != null && user.getEmail().equals(email);
		
		if(validCredentials) {
			redirectAttributes.addFlashAttribute("usvid", usr_id);
			return "redirect:/resetpassword";	
		} else {
			model.clear();
			String error = "If the provided User ID and Email match our records, you will be redirected to reset your password.";
			model.addAttribute("Validation_Message", error);
			return "forgotpassword";
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
	
		if (usr_id == null || usr_id.isEmpty() || !usr_id.matches("^[0-9]{1,10}$")) {
			return "redirect:/login";
		}
		
		int user_id;
		try {
			user_id = Integer.parseInt(usr_id);
			if (user_id < 0) {
				return "redirect:/login";
			}
		} catch (NumberFormatException e) {
			return "redirect:/login";
		}
		
		if(cred.equals(cred2)) {
			
			PasswordValidationResult passwordValidation = passwordUtil.validatePasswordStrength(cred);
			if (!passwordValidation.isValid()) {
				model.clear();
				model.addAttribute("PasswordError", passwordValidation.getErrorMessage());
				model.addAttribute("usid", usr_id);
				return "resetpassword";
			}
			
			String hashedPassword = passwordUtil.hashPassword(cred);
			String out_msg = userService.resetPassword(user_id, hashedPassword);
			 
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
			String error = "Passwords don't match";			
			model.addAttribute("PasswordError", error);
			model.addAttribute("usid", usr_id);
			return "resetpassword";
		}
		 
	}
	
}
