package com.Bank.web.controller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.Bank.web.controller.bean.AlertBean;
import com.Bank.web.controller.bean.overdraftBean;
import com.Bank.web.service.UserService;

@Controller
public class overdraftController {
	
	@Autowired
	UserService userService;
	
	@RequestMapping(value = "/overdraft", method = RequestMethod.GET)
	public String getOverdraft( @ModelAttribute("uid") String uid, Model model, HttpSession session) {
		//if(!uid.isEmpty()) {
	//		String Session = (String) session.getAttribute("ssid");
			if(((String) session.getAttribute("ssid")) == null) {
				return "redirect:/login";
			}
			else {
				System.out.println((String) session.getAttribute("ssid"));
				int usid = (int) session.getAttribute("usid");
				
				model.addAttribute("data", new overdraftBean());
				model.addAttribute("usid",usid);
				
				// Currency Symbol Variables
				
				String Currency = (String) session.getAttribute("Currency");
				
				if(Currency.equals("rupee")) {
					model.addAttribute("ind", "indian rupee");
				}else if(Currency.equals("usd")) {
					model.addAttribute("usd", "uscurrency");
				}else {
					model.addAttribute("euro", "european Currency");
				}
		
				return "overdraft"; 
			}
		}
		/*
		 * else { return "redirect:/login"; }
		 */
		
	//}

	@RequestMapping(value="/overdraft", method = RequestMethod.POST)
	public String postoverDraft(Model model, @ModelAttribute("data") overdraftBean data,
			RedirectAttributes redirectAttributes, @RequestParam("usr_id") int userid, HttpSession session) {
		String currency = (String)session.getAttribute("Currency");
		
		String out_msg = userService.Post_odData(data, userid, currency);
		
		String var = "yas";
		redirectAttributes.addFlashAttribute("uid", var);
		
		AlertBean alert = new AlertBean();
		  if(!out_msg.isEmpty()) {  
			  	alert.setAlert(out_msg);
			  	redirectAttributes.addFlashAttribute("alert_msg", alert);
			  }else {
				alert.setAlert("Failed");
				redirectAttributes.addFlashAttribute("alert_msg", alert);
		 }
		
		redirectAttributes.addFlashAttribute("usrid", userid);
		return "redirect:/account";
	}
	


}
