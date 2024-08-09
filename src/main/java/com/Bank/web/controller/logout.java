package com.Bank.web.controller;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class logout {
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String Logout(HttpSession session, RedirectAttributes rd, HttpServletResponse response) {

		if(!((String) session.getAttribute("ssid")).isEmpty()) {
			session.invalidate();
		}
		
		return "redirect:/login"; 
	}
}
