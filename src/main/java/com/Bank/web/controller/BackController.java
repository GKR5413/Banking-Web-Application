package com.Bank.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class BackController {
	
//	Performing Back before login or session initialization.
	@RequestMapping(value = "/back", method = RequestMethod.GET)
	public String Back(RedirectAttributes rs) {
		String var= "yas";
		rs.addFlashAttribute("uid", var);
		return "redirect:/login"; 
	}
	
//  Performing Back in overdraft
	@RequestMapping(value = "/backtoaccount", method = RequestMethod.GET)
	public String BackToAccountPage(RedirectAttributes rs) {
		String var= "yas";
		rs.addFlashAttribute("uid", var);
		return "redirect:/account"; 
	}
	
// Perform Back in Demat Landing Page
	
	@RequestMapping(value = "/demattoaccount", method = RequestMethod.GET)
	public String DematToAccountPage(RedirectAttributes rs) {
		String var= "yas";
		rs.addFlashAttribute("uid", var);
		return "redirect:/account"; 
	}
	
	@RequestMapping(value = "/gobacktodemat", method = RequestMethod.GET)
	public String BuyStocktoDemat(RedirectAttributes rs) {
		String var= "yas";
		rs.addFlashAttribute("uid", var);
		return "redirect:/demat"; 
	}
	
	@RequestMapping(value = "/selltodemat", method = RequestMethod.GET)
	public String selltoDemat(RedirectAttributes rs) {
		String var= "yas";
		rs.addFlashAttribute("uid", var);
		return "redirect:/demat"; 
	}
	
}
