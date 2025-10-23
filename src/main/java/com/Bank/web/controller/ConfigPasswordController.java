package com.Bank.web.controller;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
import com.Bank.web.security.PasswordEncoderUtil;
import com.Bank.web.service.UserService;

@Controller
public class ConfigPasswordController {

	private static final Logger logger = LoggerFactory.getLogger(ConfigPasswordController.class);

	@Autowired
	UserService userService;

	@Autowired
	PasswordEncoderUtil passwordEncoder;
	
	
	@RequestMapping(value = "/forgotpassword", method = RequestMethod.GET)
	public String Forgotpassword() {
		return "forgotpassword"; 
	}
	
	@RequestMapping(value = "/forgotpassword", method = RequestMethod.POST)
	public String forgotpass(ModelMap model, @RequestParam int usr_id, @RequestParam String email,
			RedirectAttributes redirectAttributes) {

		logger.debug("Password reset request for user ID: {}", usr_id);

		try {
			// Validate input
			if (email == null || email.trim().isEmpty()) {
				logger.warn("Password reset attempt with empty email");
				model.addAttribute("Invalid_Email", "Email is required");
				return "forgotpassword";
			}

			forgotPass user = userService.validateUser(usr_id);

			if (user.getEmail() != null) {
				if (user.getEmail().equalsIgnoreCase(email.trim())) {
					logger.info("Password reset validation successful for user ID: {}", usr_id);
					redirectAttributes.addFlashAttribute("usvid", usr_id);
					return "redirect:/resetpassword";
				} else {
					logger.warn("Password reset failed - incorrect email for user ID: {}", usr_id);
					model.clear();
					String error = "Incorrect Email, Please check your Email and try again";
					model.addAttribute("Invalid_Email", error);
					return "forgotpassword";
				}
			} else {
				logger.warn("Password reset failed - user ID not found: {}", usr_id);
				model.clear();
				String error = "Incorrect UserId, Please check your UserId and try again";
				model.addAttribute("Invalid_UserId", error);
				return "forgotpassword";
			}
		} catch (Exception e) {
			logger.error("Error during password reset validation for user ID: {}", usr_id, e);
			model.addAttribute("error", "An error occurred. Please try again.");
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
	public String Resetpassword(ModelMap model, @RequestParam String usr_id, @RequestParam String cred,
			@RequestParam String cred2, RedirectAttributes rs) {

		logger.debug("Password reset submission for user ID: {}", usr_id);

		try {
			int user_id = Integer.parseInt(usr_id);

			// Validate password requirements
			if (cred == null || cred.length() < 8) {
				logger.warn("Password reset failed - password too short");
				model.addAttribute("PasswordError", "Password must be at least 8 characters long");
				model.addAttribute("usid", usr_id);
				return "resetpassword";
			}

			// Check if passwords match
			if (cred.equals(cred2)) {
				// Hash the new password
				String hashedPassword = passwordEncoder.encodePassword(cred);

				String out_msg = userService.resetPassword(user_id, hashedPassword);

				AlertBean alert = new AlertBean();
				if (!out_msg.isEmpty()) {
					alert.setAlert(out_msg);
					rs.addFlashAttribute("alert_msg", alert);
					logger.info("Password reset successful for user ID: {}", user_id);
				} else {
					alert.setAlert("Failed");
					rs.addFlashAttribute("alert_msg", alert);
					logger.error("Password reset failed - empty response from service for user ID: {}", user_id);
				}

				return "redirect:/login";

			} else {
				logger.warn("Password reset failed - passwords don't match for user ID: {}", user_id);
				model.clear();
				String error = "Passwords don't match";
				model.addAttribute("PasswordError", error);
				model.addAttribute("usid", usr_id);
				return "resetpassword";
			}
		} catch (NumberFormatException e) {
			logger.error("Invalid user ID format: {}", usr_id);
			model.addAttribute("error", "Invalid user ID");
			return "resetpassword";
		} catch (Exception e) {
			logger.error("Error during password reset for user ID: {}", usr_id, e);
			model.addAttribute("error", "An error occurred. Please try again.");
			model.addAttribute("usid", usr_id);
			return "resetpassword";
		}
	}
	
}
