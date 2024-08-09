package com.Bank.web.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.Bank.web.controller.bean.AlertBean;
import com.Bank.web.controller.bean.dematAccDetails;
import com.Bank.web.controller.bean.newAvailableShares;
import com.Bank.web.controller.bean.pagination;
import com.Bank.web.controller.bean.selectedStockDetails;
import com.Bank.web.controller.bean.shares;
import com.Bank.web.service.UserService;

@Controller
public class dematController {
	@Autowired
	UserService userService;
	
	@RequestMapping(value="/Rdemat", method= RequestMethod.GET)
	public String reload(@RequestParam(value="pgno1", required=false, defaultValue="0") int pgno1,
			@RequestParam(value="pgno2", required=false, defaultValue="0") int pgno2,
			 @RequestParam(value="pagesize1", required= true, defaultValue = "10") int pagesize1,
			 @RequestParam(value="pagesize2", required= true, defaultValue = "10") int pagesize2,
			 @RequestParam(value="sortfield1", required= true, defaultValue = "sno") String sortfield1,
			 @RequestParam(value="sortdir1", required = true, defaultValue = "DESC") String sortdir1,
			 @RequestParam(value="sortfield2", required= true, defaultValue = "sno") String sortfield2,
			 @RequestParam(value="sortdir2", required = true, defaultValue = "DESC") String sortdir2,
			  @RequestParam(value="keyword1", required = false, defaultValue="") String keyword1,
			  @RequestParam(value="keyword2", required = false, defaultValue="") String keyword2,
			 @RequestParam(value="table", required = true, defaultValue = "0") int table,
			Model model, HttpSession session, RedirectAttributes rs) {
		
		if(((String) session.getAttribute("ssid")) != null) {
			
			String var= "yas";
			rs.addFlashAttribute("uid", var);
			pagination page1 = new pagination();
			page1.setPgno(pgno1);
			page1.setPagesize(pagesize1);
			page1.setSortfield(sortfield1);
			page1.setSortDir(sortdir1);
			page1.setKeyword(keyword1);
			
			rs.addFlashAttribute("pgno1", page1);
			if(table == 1) {
				rs.addFlashAttribute("ScrollPosition", "sell_table");
			}else if(table == 2) {
				rs.addFlashAttribute("ScrollPosition", "buy_table");
			}else {
				rs.addFlashAttribute("ScrollPosition", "null");
			}
			pagination page2 = new pagination();
			page2.setPgno(pgno2);
			page2.setPagesize(pagesize2);
			page2.setSortfield(sortfield2);
			page2.setSortDir(sortdir2);
			page2.setKeyword(keyword2);
			
			rs.addFlashAttribute("pgno2", page2);
			
			return "redirect:/demat";	
		}
		else {
			return "redirect:/login";
		}
	}
	
	
	
	

	@RequestMapping(value = "/demat", method = RequestMethod.GET)
	public String getDematPage(@ModelAttribute("uid") String uid, @ModelAttribute("alert_msg") AlertBean alert,
			@ModelAttribute("pgno1") pagination page1, @ModelAttribute("pgno2") pagination page2,
			@ModelAttribute("ScrollPosition") String ScrollPosition , Model model, HttpSession session) {

		// if (!uid.isEmpty()) {

			if (((String) session.getAttribute("ssid")) != null) {

				int usid = (int) session.getAttribute("usid");
				int total_Transactions1 = userService.totalsharesbeingheld(usid, page1.getKeyword());
				model.addAttribute("total1", total_Transactions1);
				
				
				int total_Transactions2 = userService.totalNoofNewSharesAvailable(page2.getKeyword());
				model.addAttribute("total2", total_Transactions2);
				
				if(total_Transactions1 == 0) {
					total_Transactions1 = 1;
				}
				if(total_Transactions1 == 0) {
					total_Transactions1 = 1;
				}
				
				// Currency Symbol Variables
				String Currency = (String) session.getAttribute("Currency");

				if (Currency.equals("rupee")) {
					model.addAttribute("ind", "indian rupee");
				} else if (Currency.equals("usd")) {
					model.addAttribute("usd", "uscurrency");
				} else {
					model.addAttribute("euro", "european Currency");
				}
				
				// Fetching demat account number from database
				dematAccDetails d = new dematAccDetails();
				d = userService.getAcc_No(usid);
				
				int start1 = 0;
				
				if(page1.getPagesize() > total_Transactions1) {
					page1.setPagesize(total_Transactions1);
				}
				int recordCount1 = page1.getPagesize();
				
				model.addAttribute("end1", recordCount1);
				model.addAttribute("pgno1", page1.getPgno());
				model.addAttribute("pagesize1", page1.getPagesize());
				
				
				int begin1 = 0;
				
				switch(page1.getPgno()-4) {
				case 0: begin1 = 0;
				break;
				case -1: begin1 = 0;
				break;
				case -2: begin1 = 0;
				break;
				case -3: begin1 = 0;
				break;
				case -4: begin1 = 0;
				break;
				default:
					begin1 = (page1.getPgno()-4);
					break;
				}
				
				
				int totalNoofpages1 = 0;
				if(total_Transactions1 % recordCount1 == 0) {  
					totalNoofpages1 = (int)Math.ceil(total_Transactions1/recordCount1) - 1;
				}else {
					totalNoofpages1 = (int)Math.ceil(total_Transactions1/recordCount1);
				}
				model.addAttribute("last_page1", totalNoofpages1);
				
				int stop1 = page1.getPgno()+4;
				if(stop1 > totalNoofpages1) {
					stop1 = totalNoofpages1;
				}
				
				model.addAttribute("stop1", stop1);
				model.addAttribute("begin1", begin1);
				
				start1 = page1.getPgno() * recordCount1;
				model.addAttribute("start1", start1);
				
				// Sorting
				
				String sortfield = page1.getSortfield();
				String sortdir = page1.getSortDir();
				 
				model.addAttribute("sortfield1", sortfield);
				model.addAttribute("sortdir1", sortdir);
				model.addAttribute("revsortdir1", sortdir.equals("ASC") ? "DESC" : "ASC" );
				model.addAttribute("keyword1", page1.getKeyword());
				
				List<shares> data = userService.getShares(d.getAcc_no(), start1, recordCount1, sortfield, sortdir, page1.getKeyword());
				
				
				int start2 = 0;
				
				if(page2.getPagesize() > total_Transactions2) {
					page2.setPagesize(total_Transactions2);
				}
				int recordCount2 = page2.getPagesize();
				
				model.addAttribute("end2", recordCount2);
				model.addAttribute("pgno2", page2.getPgno());
				model.addAttribute("pagesize2", page2.getPagesize());
				int begin2 = 0;
				
				switch(page2.getPgno()-4) {
				case 0: begin2 = 0;
				break;
				case -1: begin2 = 0;
				break;
				case -2: begin2 = 0;
				break;
				case -3: begin2 = 0;
				break;
				case -4: begin2 = 0;
				break;
				default:
					begin2 = (page2.getPgno()-4);
					break;
				}
				
				int totalNoofpages2 = 0;
				if(total_Transactions2 % recordCount2 == 0) {  
					totalNoofpages2 = (int)Math.ceil(total_Transactions2/recordCount2) - 1;
				}else {
					totalNoofpages2 = (int)Math.ceil(total_Transactions2/recordCount2);
				}
				model.addAttribute("last_page2", totalNoofpages2);
				
				int stop2 = page2.getPgno()+4;
				if(stop2 > totalNoofpages2) {
					stop2 = totalNoofpages2;
				}
				
				model.addAttribute("stop2", stop2);
				model.addAttribute("begin2", begin2);
				start2 =  page2.getPgno()* recordCount2;
				model.addAttribute("start2", start2);
				
				// Sorting
				
				String sortfield2 = page2.getSortfield();
				String sortdir2 = page2.getSortDir();
				 
				model.addAttribute("sortfield2", sortfield2);
				model.addAttribute("sortdir2", sortdir2);
				model.addAttribute("revsortdir2", sortdir2.equals("ASC") ? "DESC" : "ASC" );
				model.addAttribute("keyword2", page2.getKeyword());
				
				List<newAvailableShares> Stocks_data = userService.fetchNewStocks(start2, recordCount2, sortfield2, sortdir2, page2.getKeyword());

				// Data set Being sent to the view
				model.addAttribute("d", d);
				model.addAttribute("sd", data);
				model.addAttribute("nsd", Stocks_data);
				
				// Alerts
				model.addAttribute("alert_msg" ,alert.getAlert());
				
				model.addAttribute("ScrollPosition", ScrollPosition);
				return "demat";

			} else {
				return "redirect:/login";
			}
		/*}
			 * else { return "redirect:/login"; }
			 */
	}


	@RequestMapping(value = "/buystock/{stock_name}/{stock_id}/{dematAccNo}", method = RequestMethod.GET)
	public String buyStock(@PathVariable(value = "stock_name") String sName, @PathVariable(value = "stock_id") String stock_id,
			@PathVariable(value = "dematAccNo") long daccno, HttpSession session, Model model, RedirectAttributes rs) {
		String var = "yas";
		rs.addFlashAttribute("uid", var);
		rs.addFlashAttribute("sName", sName);
		rs.addFlashAttribute("daccno", daccno);
		rs.addFlashAttribute("stock_id", stock_id);
		
		return "redirect:/buystock";
	}

	@RequestMapping(value = "/buystock", method = RequestMethod.GET)
	public String buystockController(@ModelAttribute("uid") String uid, @ModelAttribute("sName") String sName, @ModelAttribute("stock_id") String stock_id,
			@ModelAttribute("daccno") long daccno, Model model, HttpSession session, RedirectAttributes rs) {

		//if (!uid.isEmpty()) {

			if (((String) session.getAttribute("ssid")) != null) {
				selectedStockDetails sd = new selectedStockDetails();
				sd = userService.stockDetails(sName, stock_id,daccno);
				model.addAttribute("sd", sd);
				
				// Currency Symbol Variables
				String Currency = (String) session.getAttribute("Currency");

				if (Currency.equals("rupee")) {
					model.addAttribute("ind", "indianRupee");
				} else if (Currency.equals("usd")) {
					model.addAttribute("usd", "usDollar");
				} else {
					model.addAttribute("euro", "europeanEuro");
				}
				
				return "Buy_Stocks";
			} else {
				return "redirect:/login";
			}
		} //else {
//			return "redirect:/login";
//		}
//	}

	
	  @RequestMapping(value = "/buySelectedStock", method = RequestMethod.POST)
	  public String getstockdetails(@RequestParam String stock_id, @RequestParam String stock_name, @RequestParam int quantity,
			  Model model, HttpSession session, RedirectAttributes rs) {
		  
		  if (((String) session.getAttribute("ssid")) != null) {
			  
			  int usid = (int) session.getAttribute("usid");
			  
			  String out_msg = userService.processbuy(stock_id ,stock_name, quantity, usid);
			  
			  String var = "yas";  
			  rs.addFlashAttribute("uid", var);
			  
			  AlertBean alert = new AlertBean();
			  if(!out_msg.isEmpty()) {  
				  	alert.setAlert(out_msg);
				  	rs.addFlashAttribute("alert_msg", alert);
				  }else {
					alert.setAlert("Failed");
					rs.addFlashAttribute("alert_msg", alert);
			  }
			  
		  return "redirect:/demat";
		  } 
		  else { 
			  return "redirect:/login"; 
		  } 
	  }
	  
	  
		@RequestMapping(value = "/sellstock/{demataccno}/{stock_name}/{stockid}", method = RequestMethod.GET)
		public String sellStock(@PathVariable(value = "stock_name") String sName, @PathVariable(value = "demataccno") String daccno,
				@PathVariable(value = "stockid") long stockid, HttpSession session, Model model, RedirectAttributes rs) {
			
			String var = "yas";
			rs.addFlashAttribute("uid", var);
			rs.addFlashAttribute("sName", sName);
			rs.addFlashAttribute("stockid", stockid);
			rs.addFlashAttribute("daccno", daccno);
			return "redirect:/sellstock";
		}
	  
	  @RequestMapping(value ="/sellstock", method = RequestMethod.GET)
	  public String getSellStock(@ModelAttribute("uid") String uid, @ModelAttribute("sName") String sName,
				@ModelAttribute("stockid") long stockid, @ModelAttribute("daccno") long daccno, Model model, HttpSession session, RedirectAttributes rs) {
			//if (!uid.isEmpty()) {

				if (((String) session.getAttribute("ssid")) != null) {
					
					selectedStockDetails sd = new selectedStockDetails();
					sd = userService.stockDetails(stockid, sName, daccno);
					model.addAttribute("sd", sd);
					
					// Currency Symbol Variables
					String Currency = (String) session.getAttribute("Currency");

					if (Currency.equals("rupee")) {
						model.addAttribute("ind", "indianRupee");
					} else if (Currency.equals("usd")) {
						model.addAttribute("usd", "usDollar");
					} else {
						model.addAttribute("euro", "europeanEuro");
					}
					
					return "Sell_Stock";
					
				} else {
					
					return "redirect:/login";
				
				}
			}
//		 else {
//				return "redirect:/login";
//			}
//	  }
	  
	  @RequestMapping(value = "/sellselectedstock", method = RequestMethod.POST)
	  public String sellstock(@RequestParam int sno, @RequestParam String stock_name, @RequestParam int quantity, Model model, HttpSession session, RedirectAttributes rs) {
		  
		  if (((String) session.getAttribute("ssid")) != null) {
			  int usid = (int) session.getAttribute("usid");
			  
			  String var = "yas";
			  rs.addFlashAttribute("uid", var);
			  
			  String out_msg = userService.sell(sno, stock_name, quantity, usid);
			  
			  AlertBean alert = new AlertBean();
			  if(!out_msg.isEmpty()) {  
				  	alert.setAlert(out_msg);
				  	rs.addFlashAttribute("alert_msg", alert);
				  }else {
					alert.setAlert("Failed");
					rs.addFlashAttribute("alert_msg", alert);
			  }
			  
		  return "redirect:/demat";
		  } 
		  else { 
			  return "redirect:/login"; 
		  } 
	  }
	 
}
