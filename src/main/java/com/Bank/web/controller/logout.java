package com.Bank.web.controller;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class logout {
	
	private static final Logger logger = LoggerFactory.getLogger(logout.class);
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String Logout(HttpSession session, RedirectAttributes rd, HttpServletResponse response) {

		if (session != null) {
			String sessionId = (String) session.getAttribute("ssid");
			if (sessionId != null && !sessionId.isEmpty()) {
				logger.info("User logged out successfully");
			}
			session.invalidate();
		}
		
		return "redirect:/login"; 
	}
}
