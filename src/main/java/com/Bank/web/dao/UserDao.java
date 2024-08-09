package com.Bank.web.dao;

import java.util.List;

import com.Bank.web.controller.bean.T_Data;
import com.Bank.web.controller.bean.User;
import com.Bank.web.controller.bean.User_Signup;
import com.Bank.web.controller.bean.dematAccDetails;
import com.Bank.web.controller.bean.forgotPass;
import com.Bank.web.controller.bean.newAvailableShares;
import com.Bank.web.controller.bean.overdraftBean;
import com.Bank.web.controller.bean.selectedStockDetails;
import com.Bank.web.controller.bean.shares;
import com.Bank.web.controller.bean.uniqueVariablesCheck;
import com.Bank.web.controller.bean.userInfo;


public interface UserDao {

	User getUserById(String userId);
	
	String RegisterUser(User_Signup user_data);

	userInfo getUserInfoByUserId(int usid);

	List<T_Data> getTransactionHistory(long acc_no, String Currency, int offset, int limit, String sortfield, String sortdir, String keyword);

	forgotPass validateUser(int usr_id);


	String resetPassword(int usr_id, String cred);

	String Post_odData(overdraftBean data, int userid, String currency);

	dematAccDetails getAcc_no(int usid);

	List<shares> getShares(long acc_no, int start, int recordCount, String sortfield, String sortdir, String keyword);

	uniqueVariablesCheck checkVariables(User_Signup user_data);

	String sellStock(String sName, long daccno);

	List<newAvailableShares> fetchNewStocks(int start, int recordCount, String sortfield, String sortdir, String keyword);

	selectedStockDetails SelectedStock(String sName, String stock_id, long daccno);

	String processbuy(String stock_id, String stock_name, int no_of_stock, int usid);

	selectedStockDetails SelectedStock(String sName, long daccno, long stockid);

	String sell(int stock_id, String stock_name, int quantity, int usid);

	int total_transactions(int usid, String keyword);

	int totalsharesbeingheld(int usid, String keyword);

	int totalNoofNewSharesAvailable(String keyword);
	
	

}
