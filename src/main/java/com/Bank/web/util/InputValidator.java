package com.Bank.web.util;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;
import java.util.regex.Pattern;

import org.springframework.stereotype.Component;

@Component
public class InputValidator {
    
    private static final Set<String> ALLOWED_TRANSACTION_SORT_FIELDS = new HashSet<>(
        Arrays.asList("sno", "t_date", "t_id", "pmnt_method", "pmnt_type", "amnt")
    );
    
    private static final Set<String> ALLOWED_SHARES_SORT_FIELDS = new HashSet<>(
        Arrays.asList("sno", "stock_id", "stock_name", "original_price", "current_market_price", "no_stocks")
    );
    
    private static final Set<String> ALLOWED_NEW_SHARES_SORT_FIELDS = new HashSet<>(
        Arrays.asList("sno", "stock_id", "stock_name", "stock_price", "no_of_avl_stocks")
    );
    
    private static final Set<String> ALLOWED_SORT_DIRECTIONS = new HashSet<>(
        Arrays.asList("ASC", "DESC")
    );
    
    private static final Pattern EMAIL_PATTERN = Pattern.compile(
        "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$"
    );
    
    private static final Pattern ALPHANUMERIC_PATTERN = Pattern.compile(
        "^[A-Za-z0-9]+$"
    );
    
    private static final Pattern NUMERIC_PATTERN = Pattern.compile(
        "^[0-9]+$"
    );
    
    public String validateTransactionSortField(String sortField) {
        if (sortField == null || !ALLOWED_TRANSACTION_SORT_FIELDS.contains(sortField.toLowerCase())) {
            return "sno";
        }
        return sortField.toLowerCase();
    }
    
    public String validateSharesSortField(String sortField) {
        if (sortField == null || !ALLOWED_SHARES_SORT_FIELDS.contains(sortField.toLowerCase())) {
            return "sno";
        }
        return sortField.toLowerCase();
    }
    
    public String validateNewSharesSortField(String sortField) {
        if (sortField == null || !ALLOWED_NEW_SHARES_SORT_FIELDS.contains(sortField.toLowerCase())) {
            return "sno";
        }
        return sortField.toLowerCase();
    }
    
    public String validateSortDirection(String sortDir) {
        if (sortDir == null || !ALLOWED_SORT_DIRECTIONS.contains(sortDir.toUpperCase())) {
            return "DESC";
        }
        return sortDir.toUpperCase();
    }
    
    public boolean isValidEmail(String email) {
        return email != null && EMAIL_PATTERN.matcher(email).matches();
    }
    
    public boolean isValidNumeric(String value) {
        return value != null && NUMERIC_PATTERN.matcher(value).matches();
    }
    
    public boolean isValidAlphanumeric(String value) {
        return value != null && ALPHANUMERIC_PATTERN.matcher(value).matches();
    }
    
    public int validatePageSize(int pageSize, int maxPageSize) {
        if (pageSize < 1) {
            return 10;
        }
        if (pageSize > maxPageSize) {
            return maxPageSize;
        }
        return pageSize;
    }
    
    public int validatePageNumber(int pageNumber) {
        return Math.max(0, pageNumber);
    }
    
    public String sanitizeSearchKeyword(String keyword) {
        if (keyword == null) {
            return "";
        }
        return keyword.replaceAll("[^A-Za-z0-9\\s\\-_.]", "").trim();
    }
}
