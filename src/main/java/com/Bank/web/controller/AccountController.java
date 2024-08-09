package com.Bank.web.controller;

import java.util.List;

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
import com.Bank.web.controller.bean.T_Data;
import com.Bank.web.controller.bean.pagination;
import com.Bank.web.controller.bean.userInfo;
import com.Bank.web.service.UserService;

@Controller
public class AccountController {

	@Autowired
	UserService userService;

	
	  @RequestMapping(value="/Raccount", method= RequestMethod.GET) 
	  public String  reload(
	  @RequestParam(value="pgno", required= true, defaultValue = "0") int pgno ,
	  @RequestParam(value="pagesize", required= true, defaultValue = "10") int pagesize, 
	  @RequestParam(value="sortfield", required= true, defaultValue = "sno") String sortfield,
	  @RequestParam(value="sortdir", required = true, defaultValue="DESC") String sortdir,
	  @RequestParam(value="keyword", required = false, defaultValue="") String keyword,
	  Model model, HttpSession session, RedirectAttributes rs) {
	  
	  if(((String) session.getAttribute("ssid")) != null) { 	
		  String var= "yas";
		  rs.addFlashAttribute("uid", var); 
		  pagination page = new pagination();
		  page.setPgno(pgno); 
		  page.setPagesize(pagesize); 
		  page.setSortDir(sortdir);
		  page.setSortfield(sortfield);
		  page.setScrollPosition("true");
		  page.setKeyword(keyword);
		  rs.addFlashAttribute("page",page); 
	  return "redirect:/account";
	  	}
	  else {
		  return "redirect:/login"; 
	  }
	  }
	 

	@RequestMapping(value = "/account", method = RequestMethod.GET)
	public String userAccount(@ModelAttribute("uid") String uid, Model model,
			@ModelAttribute(value = "alert_msg") AlertBean alert, HttpSession session,
			@ModelAttribute("page") pagination page, RedirectAttributes rs) {

		//if (!uid.isEmpty()) {

			if (((String) session.getAttribute("ssid")) != null) {

				int usid = (int) session.getAttribute("usid");

				// Fetching Data from Database
				userInfo data = userService.getUserInfoByUserId(usid);
				
				int total_Transactions = userService.totalTransactions(usid, page.getKeyword());
				model.addAttribute("total", total_Transactions);
				
				int start = 0;
				
				if(total_Transactions == 0) {
					total_Transactions = 1;
				}
			
				if(page.getPagesize() > total_Transactions) {
					page.setPagesize(total_Transactions);
				}
				int recordCount = page.getPagesize();
				
				model.addAttribute("end", recordCount);
				model.addAttribute("pgno", page.getPgno());
				model.addAttribute("pagesize", page.getPagesize());
				model.addAttribute("ScrollPosition", page.getScrollPosition());

				int begin = 0;

				switch (page.getPgno() - 2) {
				case 0:
					begin = 0;
					break;
				case -1:
					begin = 0;
					break;
				case -2:
					begin = 0;
					break;
				case -3:
					begin = 0;
					break;
				case -4:
					begin = 0;
					break;
				default:
					begin = (page.getPgno() - 2);
					break;
				}

				int totalNoofpages = 0;
				
				if (total_Transactions % recordCount == 0) {
					totalNoofpages = (int) Math.ceil(total_Transactions / recordCount) - 1;
				} else {
					totalNoofpages = (int) Math.ceil(total_Transactions / recordCount);
				}
				model.addAttribute("last_page", totalNoofpages);

				int stop = page.getPgno() + 2;
				if (stop > totalNoofpages) {
					stop = totalNoofpages;
				}

				model.addAttribute("stop", stop);
				model.addAttribute("begin", begin);

				start = page.getPgno() * recordCount;
				model.addAttribute("start", start);
				
				String sortfield = page.getSortfield();
				String sortdir = page.getSortDir();
				
				model.addAttribute("sortfield", sortfield);
				model.addAttribute("sortdir", sortdir);
				model.addAttribute("revsortdir", sortdir.equals("ASC") ? "DESC" : "ASC" );
				model.addAttribute("keyword", page.getKeyword());

				List<T_Data> tdata = userService.getTransactionHistory(data.getAcc_no(), data.getCurrency(), start,
																			recordCount, sortfield, sortdir, page.getKeyword());

				// Header Variables
				if (data.getAcc_type().equals("savings")) {
					model.addAttribute("hs", "notempty");
				} else {
					model.addAttribute("hc", "notempty");
				}

				// Currency Symbol Variables
				if (data.getCurrency().equals("rupee")) {
					model.addAttribute("ind", "indian rupee");
				} else if (data.getCurrency().equals("usd")) {
					model.addAttribute("usd", "uscurrency");
				} else {
					model.addAttribute("euro", "european Currency");
				}

				// Data set Being sent to the view
				model.addAttribute("data", data);
				model.addAttribute("td", tdata);
				model.addAttribute("uid", uid);

				// Alert
				model.addAttribute("alert_msg", alert.getAlert());

				// passing currency type to Demat and overdraft pages using session variable
				session.setAttribute("Currency", data.getCurrency());

				return "account";
			} else {
				return "redirect:/login";
			}
		//}
		//else {
		//	return "redirect:/login";
		//}
	}

	@RequestMapping(value = "/todemat", method = RequestMethod.POST)
	public String Account_Demat(@ModelAttribute("uid") String uid, Model model, HttpSession session,
			RedirectAttributes rs) {

		if (((String) session.getAttribute("ssid")) != null) {
			String var = "yas";
			rs.addFlashAttribute("uid", var);
			return "redirect:/demat";
		} else {
			return "redirect:/login";
		}
	}

	@RequestMapping(value = "/tooverdraft", method = RequestMethod.POST)
	public String Account_Overdraft(@ModelAttribute("uid") String uid, Model model, HttpSession session,
			RedirectAttributes rs) {
		if (((String) session.getAttribute("ssid")) != null) {
			String var = "yas";
			rs.addFlashAttribute("uid", var);
			return "redirect:/overdraft";
		} else {
			return "redirect:/login";
		}
	}

}
