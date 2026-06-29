package com.Bank.web.util;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class FileUploadUtil {
    
    private static final Logger logger = LoggerFactory.getLogger(FileUploadUtil.class);
    
    private static final Set<String> ALLOWED_EXTENSIONS = new HashSet<>(
        Arrays.asList("jpg", "jpeg", "png", "gif", "pdf")
    );
    
    private static final Set<String> ALLOWED_MIME_TYPES = new HashSet<>(
        Arrays.asList(
            "image/jpeg",
            "image/png", 
            "image/gif",
            "application/pdf"
        )
    );
    
    private static final long MAX_FILE_SIZE = 5 * 1024 * 1024; // 5MB
    
    @Value("${file.upload.directory:uploads}")
    private String uploadDirectory;
    
    public static class FileUploadResult {
        private final boolean success;
        private final String savedFilename;
        private final String errorMessage;
        
        private FileUploadResult(boolean success, String savedFilename, String errorMessage) {
            this.success = success;
            this.savedFilename = savedFilename;
            this.errorMessage = errorMessage;
        }
        
        public static FileUploadResult success(String savedFilename) {
            return new FileUploadResult(true, savedFilename, null);
        }
        
        public static FileUploadResult failure(String errorMessage) {
            return new FileUploadResult(false, null, errorMessage);
        }
        
        public boolean isSuccess() { return success; }
        public String getSavedFilename() { return savedFilename; }
        public String getErrorMessage() { return errorMessage; }
    }
    
    public FileUploadResult uploadFile(MultipartFile file, int userId) {
        if (file == null || file.isEmpty()) {
            return FileUploadResult.failure("No file provided");
        }
        
        String originalFilename = file.getOriginalFilename();
        if (originalFilename == null || originalFilename.isEmpty()) {
            return FileUploadResult.failure("Invalid filename");
        }
        
        String extension = getFileExtension(originalFilename);
        if (!isAllowedExtension(extension)) {
            logger.warn("Rejected file upload with extension: {} for user: {}", extension, userId);
            return FileUploadResult.failure("File type not allowed. Allowed types: jpg, jpeg, png, gif, pdf");
        }
        
        String contentType = file.getContentType();
        if (!isAllowedMimeType(contentType)) {
            logger.warn("Rejected file upload with MIME type: {} for user: {}", contentType, userId);
            return FileUploadResult.failure("File content type not allowed");
        }
        
        if (file.getSize() > MAX_FILE_SIZE) {
            return FileUploadResult.failure("File size exceeds maximum limit of 5MB");
        }
        
        try {
            if (!validateFileContent(file)) {
                logger.warn("File content validation failed for user: {}", userId);
                return FileUploadResult.failure("File content does not match its extension");
            }
        } catch (IOException e) {
            logger.error("Error validating file content", e);
            return FileUploadResult.failure("Error processing file");
        }
        
        String safeFilename = generateSafeFilename(userId, extension);
        
        try {
            Path uploadPath = Paths.get(uploadDirectory).toAbsolutePath().normalize();
            Files.createDirectories(uploadPath);
            
            Path targetPath = uploadPath.resolve(safeFilename).normalize();
            
            if (!targetPath.startsWith(uploadPath)) {
                logger.error("Path traversal attempt detected for user: {}", userId);
                return FileUploadResult.failure("Invalid file path");
            }
            
            try (InputStream inputStream = file.getInputStream()) {
                Files.copy(inputStream, targetPath, StandardCopyOption.REPLACE_EXISTING);
            }
            
            logger.info("File uploaded successfully: {} for user: {}", safeFilename, userId);
            return FileUploadResult.success(safeFilename);
            
        } catch (IOException e) {
            logger.error("Error saving uploaded file", e);
            return FileUploadResult.failure("Error saving file");
        }
    }
    
    private String generateSafeFilename(int userId, String extension) {
        String uuid = UUID.randomUUID().toString();
        return String.format("user_%d_%s.%s", userId, uuid, extension);
    }
    
    private String getFileExtension(String filename) {
        if (filename == null || !filename.contains(".")) {
            return "";
        }
        String sanitized = filename.replaceAll("[^a-zA-Z0-9.]", "");
        int lastDot = sanitized.lastIndexOf('.');
        if (lastDot == -1 || lastDot == sanitized.length() - 1) {
            return "";
        }
        return sanitized.substring(lastDot + 1).toLowerCase();
    }
    
    private boolean isAllowedExtension(String extension) {
        return extension != null && ALLOWED_EXTENSIONS.contains(extension.toLowerCase());
    }
    
    private boolean isAllowedMimeType(String mimeType) {
        return mimeType != null && ALLOWED_MIME_TYPES.contains(mimeType.toLowerCase());
    }
    
    private boolean validateFileContent(MultipartFile file) throws IOException {
        byte[] bytes = new byte[8];
        try (InputStream is = file.getInputStream()) {
            if (is.read(bytes) < 4) {
                return false;
            }
        }
        
        if (bytes[0] == (byte) 0xFF && bytes[1] == (byte) 0xD8 && bytes[2] == (byte) 0xFF) {
            return true; // JPEG
        }
        if (bytes[0] == (byte) 0x89 && bytes[1] == (byte) 0x50 && bytes[2] == (byte) 0x4E && bytes[3] == (byte) 0x47) {
            return true; // PNG
        }
        if (bytes[0] == (byte) 0x47 && bytes[1] == (byte) 0x49 && bytes[2] == (byte) 0x46) {
            return true; // GIF
        }
        if (bytes[0] == (byte) 0x25 && bytes[1] == (byte) 0x50 && bytes[2] == (byte) 0x44 && bytes[3] == (byte) 0x46) {
            return true; // PDF
        }
        
        return false;
    }
}
