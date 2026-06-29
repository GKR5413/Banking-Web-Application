package com.Bank.web.util;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.Bank.web.controller.bean.dematAccDetails;
import com.Bank.web.service.UserService;

@Component
public class SecurityUtil {
    
    @Autowired
    private UserService userService;
    
    public boolean isAuthenticated(HttpSession session) {
        return session != null && session.getAttribute("ssid") != null;
    }
    
    public Integer getAuthenticatedUserId(HttpSession session) {
        if (!isAuthenticated(session)) {
            return null;
        }
        Object usid = session.getAttribute("usid");
        return usid != null ? (Integer) usid : null;
    }
    
    public boolean validateDematAccountOwnership(HttpSession session, long requestedAccNo) {
        Integer userId = getAuthenticatedUserId(session);
        if (userId == null) {
            return false;
        }
        
        dematAccDetails userAccount = userService.getAcc_No(userId);
        if (userAccount == null) {
            return false;
        }
        
        return userAccount.getAcc_no() == requestedAccNo;
    }
    
    public Long getUserDematAccountNo(HttpSession session) {
        Integer userId = getAuthenticatedUserId(session);
        if (userId == null) {
            return null;
        }
        
        dematAccDetails userAccount = userService.getAcc_No(userId);
        return userAccount != null ? userAccount.getAcc_no() : null;
    }
}
