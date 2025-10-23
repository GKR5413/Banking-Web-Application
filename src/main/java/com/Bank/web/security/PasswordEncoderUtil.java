package com.Bank.web.security;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

/**
 * Utility class for password encoding and validation using BCrypt
 */
@Component
public class PasswordEncoderUtil {

    private final BCryptPasswordEncoder passwordEncoder;

    public PasswordEncoderUtil() {
        this.passwordEncoder = new BCryptPasswordEncoder(12);
    }

    /**
     * Encode a raw password using BCrypt
     * @param rawPassword The plain text password
     * @return The BCrypt hashed password
     */
    public String encodePassword(String rawPassword) {
        if (rawPassword == null || rawPassword.isEmpty()) {
            throw new IllegalArgumentException("Password cannot be null or empty");
        }
        return passwordEncoder.encode(rawPassword);
    }

    /**
     * Verify if a raw password matches an encoded password
     * @param rawPassword The plain text password
     * @param encodedPassword The BCrypt hashed password
     * @return true if passwords match, false otherwise
     */
    public boolean matches(String rawPassword, String encodedPassword) {
        if (rawPassword == null || encodedPassword == null) {
            return false;
        }
        return passwordEncoder.matches(rawPassword, encodedPassword);
    }

    /**
     * Get the BCryptPasswordEncoder instance
     * @return BCryptPasswordEncoder instance
     */
    public BCryptPasswordEncoder getPasswordEncoder() {
        return passwordEncoder;
    }
}
