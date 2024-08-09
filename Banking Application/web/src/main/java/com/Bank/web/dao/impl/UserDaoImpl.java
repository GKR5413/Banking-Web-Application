	package com.Bank.web.dao.impl;


import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.jdbc.core.support.JdbcDaoSupport;
import org.springframework.stereotype.Repository;

import com.Bank.web.controller.bean.T_Data;
import com.Bank.web.controller.bean.User;
import com.Bank.web.dao.UserDao;

import com.Bank.web.controller.bean.User_Signup;
import com.Bank.web.controller.bean.dematAccDetails;
import com.Bank.web.controller.bean.forgotPass;
import com.Bank.web.controller.bean.newAvailableShares;
import com.Bank.web.controller.bean.overdraftBean;
import com.Bank.web.controller.bean.selectedStockDetails;
import com.Bank.web.controller.bean.shares;
import com.Bank.web.controller.bean.uniqueVariablesCheck;
import com.Bank.web.controller.bean.userInfo;

@Repository
public class UserDaoImpl extends JdbcDaoSupport implements UserDao {

	@Autowired
	DataSource datasource;
	private JdbcTemplate jdbcTemplate; 
	
	@PostConstruct
	private void initialize() {
		setDataSource(datasource);
	}
	
	@PostConstruct
    private void postConstruct() {
	   jdbcTemplate = new JdbcTemplate(datasource);
	}
	
	@Override
	public User getUserById(String userId) {
		
		SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
	            .withProcedureName("login_user");
		
		SqlParameterSource in = new MapSqlParameterSource().addValue("in_user_id", userId);
		
		Map<String, Object> out = call.execute(in);
		
		User user = new User();
		user.setCred((String) out.get("out_cred"));
		return user;
	}

	@Override
	public String RegisterUser(User_Signup user_data) {

	    SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
	            .withProcedureName("register_User");
	    
	    SqlParameterSource in = new MapSqlParameterSource().addValue("in_acc_type", user_data.getAccount_Type())
	    												   .addValue("in_currency", user_data.getCurrency_Type())
	    												   .addValue("in_fname", user_data.getFirst_Name())
	    												   .addValue("in_lname",user_data.getLast_Name())
	    												   .addValue("in_dob",user_data.getDate())
	    												   .addValue("in_mail_id",user_data.getEmail())
	    												   .addValue("in_ph_no",user_data.getPhoneNumber())
	    												   .addValue("in_street",user_data.getStreet())
	    												   .addValue("in_city",user_data.getCity())
	    												   .addValue("in_state",user_data.getState())
	    												   .addValue("in_country",user_data.getCountry())
	    												   .addValue("in_zipcode",user_data.getZipcode())
	    												   .addValue("in_res_id",user_data.getRes_id())
	    												   .addValue("in_fin_id",user_data.getFin_id())
	    												   .addValue("in_res_proof", user_data.getResidential_proof())
	    												   .addValue("in_fin_proof", user_data.getFinanacial_proof())
	    												   .addValue("in_cred", user_data.getCred());
	    													
	    Map<String, Object> out = call.execute(in);
		String out_msg = (String) out.get("out_msg");
		return out_msg;
	}
	
	@Override
	public userInfo getUserInfoByUserId(int usid) {
		
		SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
	            .withProcedureName("userInfo");
		
		SqlParameterSource in = new MapSqlParameterSource().addValue("in_userid", usid);
		
		Map<String, Object> out = call.execute(in);
		
		userInfo data = new userInfo();
		
		data.setAcc_no((long) out.get("out_accno"));
		data.setAcc_status((String) out.get("out_accstatus"));
		data.setAcc_type((String) out.get("out_acctype"));
		data.setIfsc((String) out.get("out_ifsc"));
		data.setBranchname((String) out.get("out_branchname"));
		data.setBranchid((int) out.get("out_branchid"));
		data.setCurrency((String) out.get("out_currency"));
		data.setAcc_balance((double) out.get("out_balance"));
		return data;
	}


	@Override
	public List<T_Data> getTransactionHistory(long acc_no, String Currency, int offset, int limit, String sortfield, String sortdir, String Keyword) {
		SimpleJdbcCall procedureActor = new SimpleJdbcCall(jdbcTemplate)
		        .withProcedureName("T_data")
		        .returningResultSet("tdata", new RowMapper<T_Data>() {	 
		            @Override
		            public T_Data mapRow(ResultSet rs, int rowNum) throws SQLException {
		                T_Data t = new T_Data();
		                t.setAcc_no(rs.getLong("acc_no"));
		                t.setT_date(rs.getDate("t_date"));
		                t.setT_id(rs.getString("t_id"));
		                t.setPmnt_method(rs.getString("pmnt_method"));
		                t.setPmnt_type(rs.getString("pmnt_type"));
		                if(Currency.equals("eur")) {
		                	t.setAmnt(rs.getDouble("amnt"));
		                }else if(Currency.equals("usd")) {
		                	t.setAmnt(rs.getDouble("amnt"));
		                }else{
		                	t.setAmnt(rs.getDouble("amnt"));
		                }
		                return t;
		            }
		        });
		
		SqlParameterSource in = new MapSqlParameterSource().addValue("in_accno", acc_no)
															.addValue("in_offset", offset)
															.addValue("in_limit", limit)
															.addValue("in_sortdir", sortdir)
															.addValue("in_sortfield", sortfield)
															.addValue("in_Keyword", Keyword);
															
		
		Map<String, Object> out = procedureActor.execute(in);
		
		@SuppressWarnings("unchecked")
		List<T_Data> listdata = (List<T_Data>) out.get("tdata");
		
		return listdata;
	}

	@Override
	public forgotPass validateUser(int usr_id) {
		
		SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
	            .withProcedureName("ValidateUser");
		
		SqlParameterSource in = new MapSqlParameterSource().addValue("in_user_id", usr_id);
		
		Map<String, Object> out = call.execute(in);
		
		forgotPass data = new forgotPass();
		data.setEmail((String) out.get("out_email"));
		return data;
	}

	@Override
	public String resetPassword(int usr_id, String cred) {
		
		SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
	            .withProcedureName("resetPassword");
	    
	    SqlParameterSource in = new MapSqlParameterSource().addValue("in_user_id", usr_id)
	    												   .addValue("in_cred", cred);
	    
		Map <String, Object> out = call.execute(in);
		
		String out_msg = (String) out.get("out_msg");
		
		return out_msg;
	    
	}

	@Override
	public String Post_odData(overdraftBean data, int userid, String currency) {
		
		double montly_Income;
		double req_LoanAmount;
		DecimalFormat f = new DecimalFormat("0.00");
		
		SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
				.withProcedureName("od_Application");
		if(currency.equals("eur")) {
			montly_Income =  Double.parseDouble(f.format(data.getMnth_incm()));
			req_LoanAmount = Double.parseDouble(f.format(data.getRqloan_amnt()));
		}
		else if(currency.equals("usd")) {
			montly_Income =  Double.parseDouble(f.format(data.getMnth_incm()));
			req_LoanAmount  =  Double.parseDouble(f.format(data.getRqloan_amnt()));
		}else {
			montly_Income = data.getMnth_incm();
			req_LoanAmount  = data.getRqloan_amnt();
		}
		 SqlParameterSource in = new MapSqlParameterSource().addValue("in_userId", userid)
				   .addValue("in_rqloan_amnt", req_LoanAmount)
				   .addValue("in_mnth_incm", montly_Income)
				   .addValue("in_mode_of_salary", data.getMode_of_salary());
		 
		Map <String, Object> out = call.execute(in);
		String out_msg = (String) out.get("out_msg");
		
		return out_msg;
	}

	@Override
	public dematAccDetails getAcc_no(int usid) {
		
		SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
	            .withProcedureName("fetch_Acc_No");
	    
	    SqlParameterSource in = new MapSqlParameterSource().addValue("in_user_id", usid);
	    
		Map<String, Object> out = call.execute(in);
		dematAccDetails d = new dematAccDetails();
		 d.setAcc_no((long)out.get("out_acc_no"));
		 d.setOriginal_total_amount((double)out.get("out_original_total_amount"));
		 d.setMarket_total_amount((double)out.get("out_market_total_amount"));
		 
		return d;
	}

	@Override
	public List<shares> getShares(long acc_no, int start, int recordCount, String sortfield, String sortdir, String Keyword) {
		
		SimpleJdbcCall procedureActor = new SimpleJdbcCall(jdbcTemplate)
		        .withProcedureName("fetch_shares")
		        .returningResultSet("data", new RowMapper<shares>() {
		        	 
		            @Override
		            public shares mapRow(ResultSet rs, int rowNum) throws SQLException {
		                shares s = new shares();
		                s.setSno(rs.getLong("sno"));
		                s.setStock_id(rs.getString("stock_id"));
		                s.setStock_name(rs.getString("stock_name"));
		                s.setOriginal_price(rs.getDouble("original_price"));
		                s.setMarket_price(rs.getDouble("current_market_price"));
		                s.setNo_stocks(rs.getInt("no_stocks"));
		                s.setDemat_acc_no(rs.getLong("demat_acc_no"));
		                return s;
		            }
		        });
		
		SqlParameterSource in = new MapSqlParameterSource().addValue("in_accno", acc_no)
		.addValue("in_offset", start)
		.addValue("in_limit", recordCount)
		.addValue("in_sortfield",  sortfield)
		.addValue("in_sortdir", sortdir)
		.addValue("in_Keyword", Keyword);
		
		Map<String, Object> out = procedureActor.execute(in);
		
		@SuppressWarnings("unchecked")
		List<shares> listdata = (List<shares>) out.get("data");
		return listdata;
	}

	@Override
	public uniqueVariablesCheck checkVariables(User_Signup user_data) {
		SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
	            .withProcedureName("checkVariables");
		SqlParameterSource in = new MapSqlParameterSource().addValue("in_email", user_data.getEmail())
				   .addValue("in_phone", user_data.getPhoneNumber())
				   .addValue("in_res_id", user_data.getRes_id())
				   .addValue("in_fin_id", user_data.getFin_id());
		
		 Map<String, Object> out = call.execute(in);
		
		uniqueVariablesCheck data = new uniqueVariablesCheck();
		if(out.get("out_email") == null) {
			data.setEmail(0);
		}else {
			data.setEmail((int)out.get("out_email"));
		}
		if(out.get("out_phone") == null) {
			data.setPhno(0);
		}
		else {
			data.setPhno((int) out.get("out_phone"));
		}
		if(out.get("out_res_id") == null) {
			data.setAadhar(0);
		}else {
			data.setAadhar((int) out.get("out_res_id"));
		}
		if(out.get("out_fin_id") == null) {
			data.setPan(0);
		}else {
			data.setPan((int) out.get("out_fin_id"));
		}
		return data;
	}

	@Override
	public String sellStock(String sName, long daccno) {
		
		SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
	            .withProcedureName("sellStock");
		SqlParameterSource in = new MapSqlParameterSource().addValue("in_Stock_name", sName)
				   .addValue("in_demat_acc_no", daccno);
		Map<String, Object> out = call.execute(in);
		String out_msg = (String) out.get("out_msg");
		return out_msg;
	}

	@Override
	public List<newAvailableShares> fetchNewStocks(int start, int recordCount, String sortfield, String sortdir, String Keyword) {
		
		SimpleJdbcCall procedureActor = new SimpleJdbcCall(jdbcTemplate)
		        .withProcedureName("fetchNewShares")
		        .returningResultSet("data", new RowMapper<newAvailableShares>() {	 
		            @Override
		            public newAvailableShares mapRow(ResultSet rs, int rowNum) throws SQLException {
		            	newAvailableShares t = new newAvailableShares();
		            	t.setStock_id(rs.getString("stock_id"));
		                t.setStock_name(rs.getString("stock_name"));
		                t.setStock_price(rs.getDouble("stock_price"));
		                t.setNo_of_avl_stocks(rs.getInt("no_of_avl_stocks"));
		                return t;
		            }
		        });
		
		SqlParameterSource in = new MapSqlParameterSource().addValue("in_offset", start)
				   .addValue("in_limit", recordCount)
				   .addValue("in_sortdir", sortdir)
				   .addValue("in_sortfield", sortfield)
				   .addValue("in_Keyword", Keyword);
		
		Map<String, Object> out = procedureActor.execute(in);
		
		@SuppressWarnings("unchecked")
		List<newAvailableShares> data = (List<newAvailableShares>) out.get("data");
		return data;
	}

	@Override
	public selectedStockDetails SelectedStock(String sName, String Stock_id,long daccno) {
		SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
	            .withProcedureName("buyStock");
		
		SqlParameterSource in = new MapSqlParameterSource().addValue("in_stock_name", sName)
				.addValue("in_stock_id", Stock_id);
		
		Map<String, Object> out = call.execute(in);
		
		selectedStockDetails data = new selectedStockDetails();
		data.setStock_id((String) out.get("out_stock_id"));
		data.setStock_name((String) out.get("out_stock_name"));
		data.setAvl_quantity((int) out.get("out_stock_avl_qunatity"));
		data.setPrice((double) out.get("out_stock_price"));
		return data;
	}

	@Override
	public String processbuy( String stock_id,String stock_name, int no_of_stock, int usid) {
		SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
	            .withProcedureName("processbuy");
		
		SqlParameterSource in = new MapSqlParameterSource().addValue("in_stock_id", stock_id)
															.addValue("in_stock_name", stock_name)	
															.addValue("in_no_of_stock", no_of_stock)
															.addValue("in_user_id", usid);
		
		Map<String, Object> out = call.execute(in);
		String val = (String)out.get("out_msg");
		return val;
		
	}

	@Override
	public selectedStockDetails SelectedStock(String sName, long daccno, long sno) {
		SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
	            .withProcedureName("selected_stock_from_shares");
		
		SqlParameterSource in = new MapSqlParameterSource().addValue("in_out_sno", sno)
															.addValue("in_out_stock_name", sName)
															.addValue("in_demat_acc_no", daccno);
		
		Map<String, Object> out = call.execute(in);
		
		selectedStockDetails data = new selectedStockDetails();
		data.setSno((long) out.get("in_out_sno"));
		data.setStock_id((String) out.get("out_stock_id"));
		data.setStock_name((String) out.get("in_out_stock_name"));
		data.setAvl_quantity((int) out.get("out_no_stocks"));
		data.setPrice((double) out.get("out_market_price"));
		return data;
	}

	@Override
	public String sell(int sno, String stock_name, int quantity, int usid) {
		
		SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
	            .withProcedureName("sellStock");
		
		SqlParameterSource in = new MapSqlParameterSource().addValue("in_sno", sno)
															.addValue("in_Stock_name", stock_name)	
															.addValue("in_no_of_stocks", quantity)
															.addValue("in_user_id", usid);
		
		Map<String, Object> out = call.execute(in);
		
		String val = ((String)out.get("out_msg"));
		
		return val;
	}

	@Override
	public int total_transactions(int usid, String keyword) {
		
		SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
	            .withProcedureName("total_noof_transactions");
		
		SqlParameterSource in = new MapSqlParameterSource().addValue("in_user_id", usid)
															.addValue("in_Keyword", keyword);
		
		Map<String, Object> out = call.execute(in);
		
		int total = (int)out.get("out_totalcount");
		
		return total;
	}

	@Override
	public int totalsharesbeingheld(int usid, String Keyword) {
		SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
	            .withProcedureName("totalsharesbeingheld");
		
		SqlParameterSource in = new MapSqlParameterSource().addValue("in_user_id", usid)
														   .addValue("in_Keyword", Keyword);
		
		Map<String, Object> out = call.execute(in);
		
		int total = (int)out.get("out_totalcount");
		
		return total;
	}

	@Override
	public int totalNoofNewSharesAvailable(String Keyword) {
		SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
	            .withProcedureName("totalNoofNewSharesAvailable");
		
		SqlParameterSource in = new MapSqlParameterSource()
				   .addValue("in_Keyword", Keyword);
		
		Map<String, Object> out = call.execute(in);
		
		int total = (int)out.get("out_totalcount");
		
		return total;
	}

}
























