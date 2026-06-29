package com.Bank.web.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;

import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

@Component
@Order(0)
public class SecurityHeadersFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        httpResponse.setHeader("X-Content-Type-Options", "nosniff");
        
        httpResponse.setHeader("X-Frame-Options", "DENY");
        
        httpResponse.setHeader("X-XSS-Protection", "1; mode=block");
        
        httpResponse.setHeader("Content-Security-Policy", 
            "default-src 'self'; " +
            "script-src 'self' 'unsafe-inline' https://cdnjs.cloudflare.com https://ajax.googleapis.com; " +
            "style-src 'self' 'unsafe-inline' https://use.fontawesome.com; " +
            "font-src 'self' https://use.fontawesome.com; " +
            "img-src 'self' data:; " +
            "frame-ancestors 'none';"
        );
        
        httpResponse.setHeader("Referrer-Policy", "strict-origin-when-cross-origin");
        
        httpResponse.setHeader("Permissions-Policy", 
            "geolocation=(), microphone=(), camera=(), payment=()");
        
        httpResponse.setHeader("Cache-Control", "no-store, no-cache, must-revalidate, max-age=0");
        httpResponse.setHeader("Pragma", "no-cache");
        httpResponse.setHeader("Expires", "0");
        
        chain.doFilter(request, response);
    }
    
    @Override
    public void destroy() {
    }
}
