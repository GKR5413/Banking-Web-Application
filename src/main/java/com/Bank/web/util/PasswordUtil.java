package com.Bank.web.util;

import java.util.regex.Pattern;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

@Component
public class PasswordUtil {
    
    private static final BCryptPasswordEncoder encoder = new BCryptPasswordEncoder(12);
    
    private static final int MIN_PASSWORD_LENGTH = 8;
    private static final int MAX_PASSWORD_LENGTH = 128;
    
    private static final Pattern UPPERCASE_PATTERN = Pattern.compile("[A-Z]");
    private static final Pattern LOWERCASE_PATTERN = Pattern.compile("[a-z]");
    private static final Pattern DIGIT_PATTERN = Pattern.compile("[0-9]");
    private static final Pattern SPECIAL_CHAR_PATTERN = Pattern.compile("[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>/?]");
    
    public static class PasswordValidationResult {
        private final boolean valid;
        private final String errorMessage;
        
        private PasswordValidationResult(boolean valid, String errorMessage) {
            this.valid = valid;
            this.errorMessage = errorMessage;
        }
        
        public static PasswordValidationResult success() {
            return new PasswordValidationResult(true, null);
        }
        
        public static PasswordValidationResult failure(String message) {
            return new PasswordValidationResult(false, message);
        }
        
        public boolean isValid() { return valid; }
        public String getErrorMessage() { return errorMessage; }
    }
    
    public PasswordValidationResult validatePasswordStrength(String password) {
        if (password == null || password.isEmpty()) {
            return PasswordValidationResult.failure("Password cannot be empty");
        }
        
        if (password.length() < MIN_PASSWORD_LENGTH) {
            return PasswordValidationResult.failure(
                "Password must be at least " + MIN_PASSWORD_LENGTH + " characters long");
        }
        
        if (password.length() > MAX_PASSWORD_LENGTH) {
            return PasswordValidationResult.failure(
                "Password cannot exceed " + MAX_PASSWORD_LENGTH + " characters");
        }
        
        if (!UPPERCASE_PATTERN.matcher(password).find()) {
            return PasswordValidationResult.failure(
                "Password must contain at least one uppercase letter");
        }
        
        if (!LOWERCASE_PATTERN.matcher(password).find()) {
            return PasswordValidationResult.failure(
                "Password must contain at least one lowercase letter");
        }
        
        if (!DIGIT_PATTERN.matcher(password).find()) {
            return PasswordValidationResult.failure(
                "Password must contain at least one digit");
        }
        
        if (!SPECIAL_CHAR_PATTERN.matcher(password).find()) {
            return PasswordValidationResult.failure(
                "Password must contain at least one special character (!@#$%^&*()_+-=[]{}|;':\",./<>?)");
        }
        
        return PasswordValidationResult.success();
    }
    
    public String hashPassword(String plainPassword) {
        if (plainPassword == null || plainPassword.isEmpty()) {
            throw new IllegalArgumentException("Password cannot be null or empty");
        }
        return encoder.encode(plainPassword);
    }
    
    public boolean verifyPassword(String plainPassword, String hashedPassword) {
        if (plainPassword == null || hashedPassword == null) {
            return false;
        }
        return encoder.matches(plainPassword, hashedPassword);
    }
}
