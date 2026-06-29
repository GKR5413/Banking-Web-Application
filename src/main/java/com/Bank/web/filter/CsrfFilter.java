package com.Bank.web.filter;

import java.io.IOException;
import java.security.SecureRandom;
import java.util.Base64;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

@Component
@Order(1)
public class CsrfFilter implements Filter {
    
    private static final Logger logger = LoggerFactory.getLogger(CsrfFilter.class);
    public static final String CSRF_TOKEN_ATTR = "_csrf_token";
    public static final String CSRF_TOKEN_PARAM = "_csrf";
    
    private static final SecureRandom secureRandom = new SecureRandom();
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(true);
        
        String csrfToken = (String) session.getAttribute(CSRF_TOKEN_ATTR);
        if (csrfToken == null) {
            csrfToken = generateToken();
            session.setAttribute(CSRF_TOKEN_ATTR, csrfToken);
        }
        
        httpRequest.setAttribute(CSRF_TOKEN_ATTR, csrfToken);
        
        if (isStateChangingRequest(httpRequest)) {
            String requestToken = httpRequest.getParameter(CSRF_TOKEN_PARAM);
            
            if (requestToken == null || !csrfToken.equals(requestToken)) {
                logger.warn("CSRF token validation failed for request: {} from IP: {}", 
                    httpRequest.getRequestURI(), httpRequest.getRemoteAddr());
                httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "CSRF token validation failed");
                return;
            }
        }
        
        chain.doFilter(request, response);
    }
    
    @Override
    public void destroy() {
    }
    
    private boolean isStateChangingRequest(HttpServletRequest request) {
        String method = request.getMethod();
        return "POST".equalsIgnoreCase(method) || 
               "PUT".equalsIgnoreCase(method) || 
               "DELETE".equalsIgnoreCase(method) ||
               "PATCH".equalsIgnoreCase(method);
    }
    
    private String generateToken() {
        byte[] tokenBytes = new byte[32];
        secureRandom.nextBytes(tokenBytes);
        return Base64.getUrlEncoder().withoutPadding().encodeToString(tokenBytes);
    }
}
