package com.Bank.web.filter;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

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
@Order(2)
public class AuthenticationFilter implements Filter {
    
    private static final Logger logger = LoggerFactory.getLogger(AuthenticationFilter.class);
    
    private static final Set<String> PUBLIC_PATHS = new HashSet<>(Arrays.asList(
        "/login",
        "/register",
        "/forgotpassword",
        "/resetpassword",
        "/back",
        "/css",
        "/js",
        "/img"
    ));
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        String path = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        String relativePath = path.substring(contextPath.length());
        
        if (isPublicPath(relativePath)) {
            chain.doFilter(request, response);
            return;
        }
        
        HttpSession session = httpRequest.getSession(false);
        
        if (session == null || session.getAttribute("ssid") == null) {
            logger.warn("Unauthorized access attempt to: {} from IP: {}", 
                relativePath, httpRequest.getRemoteAddr());
            httpResponse.sendRedirect(contextPath + "/login");
            return;
        }
        
        chain.doFilter(request, response);
    }
    
    @Override
    public void destroy() {
    }
    
    private boolean isPublicPath(String path) {
        if (path == null || path.isEmpty() || path.equals("/")) {
            return true;
        }
        
        for (String publicPath : PUBLIC_PATHS) {
            if (path.equals(publicPath) || path.startsWith(publicPath + "/") || path.startsWith(publicPath + "?")) {
                return true;
            }
        }
        
        return false;
    }
}
