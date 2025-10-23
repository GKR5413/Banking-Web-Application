package com.Bank.web.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Random;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
import com.Bank.web.security.PasswordEncoderUtil;
import com.Bank.web.service.UserService;
import com.Bank.web.util.FileUploadValidator;
import com.Bank.web.util.FileUploadValidator.ValidationResult;

@Controller
public class UserController {

	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	@Autowired
	UserService userService;

	@Autowired
	PasswordEncoderUtil passwordEncoder;

	@Autowired
	FileUploadValidator fileUploadValidator;
	
//	Login API
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginpage(@ModelAttribute("alert_msg") AlertBean alert, Model model) {
		model.addAttribute("alert_msg" ,alert.getAlert());
		return "index"; 
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String welcomePage(ModelMap model, @RequestParam String userId, @RequestParam String cred,
			@ModelAttribute("alert_msg") AlertBean alert, HttpSession session, RedirectAttributes rs) {

		logger.debug("Login attempt for user ID: {}", userId);

		try {
			// Validate input
			if (userId == null || userId.trim().isEmpty() || cred == null || cred.trim().isEmpty()) {
				logger.warn("Login attempt with empty credentials");
				model.addAttribute("Invalid_Input", "User ID and password are required");
				return "index";
			}

			Random r = new Random();
			int n = r.nextInt();
			String Hexadecimal = Integer.toHexString(n);
			session.setAttribute("ssid", Hexadecimal);
			session.setAttribute("usid", Integer.parseInt(userId));

			AlertBean alert1 = new AlertBean();

			User user = userService.getUserByUserId(userId);

			if (user.getCred() != null) {
				// Use BCrypt to verify password
				if (passwordEncoder.matches(cred, user.getCred())) {
					logger.info("Successful login for user ID: {}", userId);
					String var = "yas";
					rs.addFlashAttribute("uid", var);
					return "redirect:/account";
				} else {
					logger.warn("Failed login attempt - incorrect password for user ID: {}", userId);
					model.clear();
					String error = "Incorrect Password, Please check your Password and try again";
					model.addAttribute("Invalid_Password", error);
					model.addAttribute("alert_msg", alert1.getAlert());
					return "index";
				}
			} else {
				logger.warn("Failed login attempt - user ID not found: {}", userId);
				model.clear();
				String error = "Incorrect UserId, Please check your UserId and try again";
				model.addAttribute("Invalid_UserId", error);
				model.addAttribute("alert_msg", alert1.getAlert());
				return "index";
			}
		} catch (NumberFormatException e) {
			logger.error("Invalid user ID format: {}", userId);
			model.addAttribute("Invalid_UserId", "Invalid User ID format");
			return "index";
		} catch (Exception e) {
			logger.error("Error during login for user ID: {}", userId, e);
			model.addAttribute("error", "An error occurred during login. Please try again.");
			return "index";
		}
	}
	
	
//	Registration API
	@RequestMapping(value="/register", method = RequestMethod.GET)
	public String RegistrationPage(Model model) {		
		return "register";
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String RegisterUser(@Valid @ModelAttribute("user_data") User_Signup user_data,
								BindingResult result,
								@RequestParam(name = "Res_proof", required = false) MultipartFile file_1,
								@RequestParam(name = "Fin_proof", required = false) MultipartFile file_2,
								@RequestParam String cred, @RequestParam String cred2, ModelMap model,
								RedirectAttributes rs, HttpSession session) {

		logger.debug("Registration attempt for email: {}", user_data.getEmail());

		// Check for validation errors
		if (result.hasErrors()) {
			logger.warn("Validation errors in registration form: {}", result.getAllErrors());
			model.addAttribute("validationErrors", result.getAllErrors());
			model.addAttribute("input", user_data);
			return "register";
		}

		// Validate and handle residential proof file upload
		if (file_1 == null || file_1.isEmpty()) {
			user_data.setResidential_proof("No File Uploaded");
			logger.info("Residential proof not uploaded for registration");
		} else {
			ValidationResult validationResult = fileUploadValidator.validateFile(file_1);
			if (!validationResult.isValid()) {
				logger.warn("Invalid residential proof file: {}", validationResult.getMessage());
				model.addAttribute("ResidentialProof_Error", validationResult.getMessage());
				model.addAttribute("input", user_data);
				return "register";
			}

			String sanitizedFilename = validationResult.getSanitizedFilename();
			user_data.setResidential_proof(sanitizedFilename);

			try {
				File saveFile = new ClassPathResource("/").getFile();
				Path path = Paths.get(saveFile.getAbsolutePath() + File.separator + sanitizedFilename);
				Files.copy(file_1.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
				logger.info("Residential proof uploaded successfully: {}", sanitizedFilename);
			} catch (IOException e) {
				logger.error("Error uploading residential proof: {}", e.getMessage(), e);
				model.addAttribute("ResidentialProof_Error", "Error uploading file. Please try again.");
				model.addAttribute("input", user_data);
				return "register";
			}
		}

		// Validate and handle financial proof file upload
		if (file_2 == null || file_2.isEmpty()) {
			user_data.setFinanacial_proof("No File Uploaded");
			logger.info("Financial proof not uploaded for registration");
		} else {
			ValidationResult validationResult = fileUploadValidator.validateFile(file_2);
			if (!validationResult.isValid()) {
				logger.warn("Invalid financial proof file: {}", validationResult.getMessage());
				model.addAttribute("FinancialProof_Error", validationResult.getMessage());
				model.addAttribute("input", user_data);
				return "register";
			}

			String sanitizedFilename = validationResult.getSanitizedFilename();
			user_data.setFinanacial_proof(sanitizedFilename);

			try {
				File saveFile = new ClassPathResource("/").getFile();
				Path path = Paths.get(saveFile.getAbsolutePath() + File.separator + sanitizedFilename);
				Files.copy(file_2.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
				logger.info("Financial proof uploaded successfully: {}", sanitizedFilename);
			} catch (IOException e) {
				logger.error("Error uploading financial proof: {}", e.getMessage(), e);
				model.addAttribute("FinancialProof_Error", "Error uploading file. Please try again.");
				model.addAttribute("input", user_data);
				return "register";
			}
		}
		

		// Check for unique constraints
		uniqueVariablesCheck check = new uniqueVariablesCheck();
		check = userService.CheckUserEntriesForUniqueness(user_data);

		model.clear();
		boolean hasUniqueErrors = false;

		if (check.getEmail() != 0) {
			String Error = "Email Already Exists!";
			model.addAttribute("Email_Error", Error);
			logger.warn("Registration failed - duplicate email: {}", user_data.getEmail());
			hasUniqueErrors = true;
		}

		if (check.getPhno() != 0) {
			String Error = "Phone Already Exists!";
			model.addAttribute("PhoneNumber_Error", Error);
			logger.warn("Registration failed - duplicate phone number");
			hasUniqueErrors = true;
		}

		if (check.getAadhar() != 0) {
			String Error = "Aadhar Number Already Exists!";
			model.addAttribute("Aadhar_Error", Error);
			logger.warn("Registration failed - duplicate Aadhar number");
			hasUniqueErrors = true;
		}

		if (check.getPan() != 0) {
			String Error = "Pan Number Already Exists!";
			model.addAttribute("Pan_Error", Error);
			logger.warn("Registration failed - duplicate PAN number");
			hasUniqueErrors = true;
		}

		// Validate password match
		boolean passwordmatch = false;
		if (cred == null || cred2 == null || !cred.equals(cred2)) {
			model.clear();
			String error = "Passwords don't match";
			model.addAttribute("PasswordError", error);
			logger.warn("Registration failed - passwords don't match");
		} else {
			passwordmatch = true;
		}

		// If all validations pass, proceed with registration
		if (!hasUniqueErrors && passwordmatch) {
			try {
				// Hash the password before storing
				String hashedPassword = passwordEncoder.encodePassword(cred);
				user_data.setCred(hashedPassword);

				String out_msg = userService.RegisterUser(user_data);

				AlertBean alert = new AlertBean();
				if (!out_msg.isEmpty()) {
					alert.setAlert(out_msg);
					rs.addFlashAttribute("alert_msg", alert);
					logger.info("User registered successfully: {}", user_data.getEmail());
				} else {
					alert.setAlert("Failed");
					rs.addFlashAttribute("alert_msg", alert);
					logger.error("Registration failed - empty response from service");
				}

				return "redirect:/login";
			} catch (Exception e) {
				logger.error("Error during user registration: {}", e.getMessage(), e);
				model.addAttribute("error", "An error occurred during registration. Please try again.");
				model.addAttribute("input", user_data);
				return "register";
			}
		} else {
			model.addAttribute("input", user_data);
			return "register";
		}
	}	
}























