package com.Bank.web.service;


import java.util.List;


import com.Bank.web.controller.bean.T_Data;
import com.Bank.web.controller.bean.User;
import com.Bank.web.controller.bean.User_Signup;
import com.Bank.web.controller.bean.dematAccDetails;
import com.Bank.web.controller.bean.forgotPass;
import com.Bank.web.controller.bean.newAvailableShares;
import com.Bank.web.controller.bean.overdraftBean;
import com.Bank.web.controller.bean.selectedStockDetails;
import com.Bank.web.controller.bean.uniqueVariablesCheck;
import com.Bank.web.controller.bean.userInfo;


public interface UserService {
	
	User getUserByUserId(String userId);

	String RegisterUser(User_Signup user_data);

	userInfo getUserInfoByUserId(int usid);

	List<T_Data> getTransactionHistory(long acc_no, String currency, int pageid, int total, String sortfield, String sortdir, String keyword);

	forgotPass validateUser(int usr_id);

	String resetPassword(int usr_id, String cred);

	String Post_odData(overdraftBean data, int usid, String currency);

	dematAccDetails getAcc_No(int usid);

	List<com.Bank.web.controller.bean.shares> getShares(long acc_no, int start1, int recordCount1, String sortfield, String sortdir, String Keyword);

	uniqueVariablesCheck CheckUserEntriesForUniqueness(User_Signup user_data);

	String sellStock(String sName, long daccno);

	List<newAvailableShares> fetchNewStocks(int start2, int recordCount2, String sortfield2, String sortdir2, String Keyword);

	selectedStockDetails stockDetails(String sName, String stock_id, long daccno);

	String processbuy(String stock_name, String stock_name2, int no_of_stock, int usid);

	selectedStockDetails stockDetails(long stockid, String sName, long daccno);

	String sell(int stock_id, String stock_name, int quantity, int usid);

	int totalTransactions(int usid, String string);

	int totalsharesbeingheld(int usid, String string);

	int totalNoofNewSharesAvailable(String keyword);
	
	

}
