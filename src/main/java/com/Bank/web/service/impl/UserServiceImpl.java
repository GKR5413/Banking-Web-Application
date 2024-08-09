package com.Bank.web.service.impl;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Bank.web.controller.bean.T_Data;
import com.Bank.web.controller.bean.User;
import com.Bank.web.dao.UserDao;
import com.Bank.web.service.UserService;

import com.Bank.web.controller.bean.User_Signup;
import com.Bank.web.controller.bean.dematAccDetails;
import com.Bank.web.controller.bean.forgotPass;
import com.Bank.web.controller.bean.newAvailableShares;
import com.Bank.web.controller.bean.overdraftBean;
import com.Bank.web.controller.bean.selectedStockDetails;
import com.Bank.web.controller.bean.shares;
import com.Bank.web.controller.bean.uniqueVariablesCheck;
import com.Bank.web.controller.bean.userInfo;



@Service
public class UserServiceImpl implements UserService{

	@Autowired
	UserDao userDao;
	
	@Override
	public User getUserByUserId(String userId) {
		User user = userDao.getUserById(userId);
		return user;
	}

	@Override
	public String RegisterUser(User_Signup user_data) {		
		return userDao.RegisterUser(user_data);
	}


	@Override
	public userInfo getUserInfoByUserId(int usid) {
		return userDao.getUserInfoByUserId(usid);
	}

	@Override
	public List<T_Data> getTransactionHistory(long acc_no, String currency, int offset, int limit, String sortfield, String sortdir, String Keyword) {
		return userDao.getTransactionHistory(acc_no, currency, offset, limit, sortfield, sortdir, Keyword);
	}

	@Override
	public forgotPass validateUser(int usr_id) {
		
		return userDao.validateUser(usr_id);
	}

	@Override
	public String resetPassword(int usr_id,  String cred) {
		return userDao.resetPassword(usr_id, cred);
	}

	@Override
	public String Post_odData(overdraftBean data, int userid, String currency) {
		return userDao.Post_odData(data, userid, currency);
		
	}

	@Override
	public dematAccDetails getAcc_No(int usid) {
		return userDao.getAcc_no(usid);
	}

	@Override
	public List<shares> getShares(long acc_no, int start, int recordCount, String sortfield, String sortdir, String Keyword) {
		return userDao.getShares(acc_no, start, recordCount, sortfield, sortdir, Keyword);
	}

	@Override
	public uniqueVariablesCheck CheckUserEntriesForUniqueness(User_Signup user_data) {
		return userDao.checkVariables(user_data);
	}

	@Override
	public String sellStock(String sName, long daccno) {
		return userDao.sellStock(sName, daccno);
	}

	@Override
	public List<newAvailableShares> fetchNewStocks( int start, int recordCount, String sortfield, String sortdir, String  Keyword) {
		return userDao.fetchNewStocks(start, recordCount, sortfield, sortdir, Keyword);
	}

	@Override
	public selectedStockDetails stockDetails(String sName, String stock_id,long daccno) {
		return userDao.SelectedStock(sName, stock_id,daccno);
	}

	@Override
	public String processbuy( String stock_id, String stock_name, int no_of_stock, int usid) {
		return userDao.processbuy( stock_id, stock_name, no_of_stock, usid);
	}

	@Override
	public selectedStockDetails stockDetails(long stockid, String sName, long daccno) {
		return userDao.SelectedStock( sName, daccno, stockid );
	}

	@Override
	public String sell(int stock_id, String stock_name, int quantity, int usid) {
		 return userDao.sell(stock_id,stock_name,quantity, usid);
	}

	@Override
	public int totalTransactions(int usid, String keyword) {
		return userDao.total_transactions(usid, keyword);
	}

	@Override
	public int totalsharesbeingheld(int usid, String keyword) {
		return userDao.totalsharesbeingheld(usid, keyword);
	}

	@Override
	public int totalNoofNewSharesAvailable(String Keyword) {
		return userDao.totalNoofNewSharesAvailable(Keyword);
	}





}





















