package com.Bank.web.util;

import org.apache.commons.io.FilenameUtils;
import org.apache.tika.Tika;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

/**
 * Utility class to validate file uploads for security
 */
@Component
public class FileUploadValidator {

    private static final Logger logger = LoggerFactory.getLogger(FileUploadValidator.class);

    // Maximum file size in bytes (5MB)
    private static final long MAX_FILE_SIZE = 5 * 1024 * 1024;

    // Allowed file extensions
    private static final Set<String> ALLOWED_EXTENSIONS = new HashSet<>(Arrays.asList(
        "pdf", "jpg", "jpeg", "png", "gif", "doc", "docx"
    ));

    // Allowed MIME types
    private static final Set<String> ALLOWED_MIME_TYPES = new HashSet<>(Arrays.asList(
        "application/pdf",
        "image/jpeg",
        "image/jpg",
        "image/png",
        "image/gif",
        "application/msword",
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    ));

    private final Tika tika = new Tika();

    /**
     * Validates a file upload for security
     * @param file The uploaded file
     * @return ValidationResult containing validation status and error message
     */
    public ValidationResult validateFile(MultipartFile file) {
        if (file == null || file.isEmpty()) {
            return new ValidationResult(false, "File is empty or null");
        }

        // Check file size
        if (file.getSize() > MAX_FILE_SIZE) {
            logger.warn("File upload rejected: exceeds size limit - {}", file.getOriginalFilename());
            return new ValidationResult(false, "File size exceeds maximum allowed size of 5MB");
        }

        // Get and validate file extension
        String filename = file.getOriginalFilename();
        if (filename == null || filename.isEmpty()) {
            return new ValidationResult(false, "Invalid filename");
        }

        String extension = FilenameUtils.getExtension(filename).toLowerCase();
        if (!ALLOWED_EXTENSIONS.contains(extension)) {
            logger.warn("File upload rejected: invalid extension - {}", filename);
            return new ValidationResult(false, "File type not allowed. Allowed types: PDF, JPG, PNG, GIF, DOC, DOCX");
        }

        // Validate actual file content type using Apache Tika
        try {
            String detectedMimeType = tika.detect(file.getInputStream());
            if (!ALLOWED_MIME_TYPES.contains(detectedMimeType)) {
                logger.warn("File upload rejected: MIME type mismatch - claimed: {}, actual: {}",
                    file.getContentType(), detectedMimeType);
                return new ValidationResult(false, "File content does not match expected type");
            }
        } catch (IOException e) {
            logger.error("Error detecting file type: {}", e.getMessage());
            return new ValidationResult(false, "Error processing file");
        }

        // Sanitize filename
        String sanitizedFilename = sanitizeFilename(filename);
        if (!sanitizedFilename.equals(filename)) {
            logger.info("Filename sanitized from {} to {}", filename, sanitizedFilename);
        }

        return new ValidationResult(true, "File is valid", sanitizedFilename);
    }

    /**
     * Sanitizes filename to prevent path traversal and injection attacks
     * @param filename Original filename
     * @return Sanitized filename
     */
    public String sanitizeFilename(String filename) {
        if (filename == null) {
            return null;
        }

        // Remove path characters
        filename = FilenameUtils.getName(filename);

        // Remove special characters except dots, underscores, and hyphens
        filename = filename.replaceAll("[^a-zA-Z0-9._-]", "_");

        // Prevent multiple dots
        filename = filename.replaceAll("\\.{2,}", ".");

        // Add timestamp to prevent filename conflicts
        String baseName = FilenameUtils.getBaseName(filename);
        String extension = FilenameUtils.getExtension(filename);

        return baseName + "_" + System.currentTimeMillis() + "." + extension;
    }

    /**
     * Inner class to hold validation results
     */
    public static class ValidationResult {
        private final boolean valid;
        private final String message;
        private final String sanitizedFilename;

        public ValidationResult(boolean valid, String message) {
            this(valid, message, null);
        }

        public ValidationResult(boolean valid, String message, String sanitizedFilename) {
            this.valid = valid;
            this.message = message;
            this.sanitizedFilename = sanitizedFilename;
        }

        public boolean isValid() {
            return valid;
        }

        public String getMessage() {
            return message;
        }

        public String getSanitizedFilename() {
            return sanitizedFilename;
        }
    }
}
