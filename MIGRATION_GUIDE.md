# Migration Guide - Upgrading to Secure Version

## Overview

This guide helps you migrate from the old version of the Banking Web Application to the new secure version with BCrypt password hashing, enhanced security features, and improved error handling.

⚠️ **CRITICAL**: This migration involves breaking changes, especially in password handling. Plan for a maintenance window.

---

## Pre-Migration Checklist

- [ ] **Backup everything**
  - [ ] Database backup
  - [ ] Application files backup
  - [ ] Configuration files backup
  - [ ] Uploaded files backup
- [ ] **Test environment ready**
- [ ] **Maintenance window scheduled**
- [ ] **User notification sent**
- [ ] **Rollback plan prepared**

---

## Breaking Changes

### 1. Password Storage Format

**Old**: Plain text or simple encryption
**New**: BCrypt hashed passwords

**Impact**: All existing users will need to reset their passwords

### 2. Configuration Format

**Old**: Hardcoded credentials in `application.properties`
**New**: Environment variables

**Impact**: Deployment process changes required

### 3. File Upload Validation

**Old**: No validation
**New**: Strict file type and size validation

**Impact**: Some previously uploaded files may not meet new standards

---

## Migration Steps

### Step 1: Backup Current System

```bash
# Stop the application
sudo systemctl stop banking-app  # or your stop command

# Backup database
mysqldump -u root -p Testing > backup_before_migration_$(date +%Y%m%d_%H%M%S).sql

# Backup application directory
tar -czf banking_app_backup_$(date +%Y%m%d_%H%M%S).tar.gz /path/to/banking-app/

# Verify backups
ls -lh backup_*.sql
ls -lh banking_app_backup_*.tar.gz
```

### Step 2: Update Application Code

```bash
# Pull latest changes
git pull origin main

# Or download new version
# unzip banking-app-v2.0.zip
```

### Step 3: Update Dependencies

```bash
# Clean old build
./mvnw clean

# Download new dependencies
./mvnw dependency:resolve

# Verify no errors
./mvnw verify
```

### Step 4: Configure Environment Variables

```bash
# Create .env file
cp .env.example .env

# Edit with your credentials
nano .env
```

Add:
```bash
DB_URL=jdbc:mysql://localhost:3306/Testing?useSSL=true&serverTimezone=UTC
DB_USERNAME=your_db_user
DB_PASSWORD=your_db_password
SPRING_PROFILES_ACTIVE=prod
```

### Step 5: Database Schema Updates

**No schema changes required** - The application works with existing tables.

However, you may want to add a flag for password migration:

```sql
-- Optional: Track which users need password reset
ALTER TABLE users ADD COLUMN password_migrated BOOLEAN DEFAULT FALSE;
ALTER TABLE users ADD COLUMN password_reset_required BOOLEAN DEFAULT TRUE;
```

### Step 6: Password Migration Strategy

You have **three options**:

#### Option A: Force All Users to Reset Passwords (Recommended)

This is the **most secure option** as it ensures all passwords are properly hashed.

```sql
-- Mark all users for mandatory password reset
UPDATE users SET password_reset_required = TRUE;

-- Or clear passwords to force reset
UPDATE users SET password = NULL;
```

**User Communication Template:**
```
Subject: Important: Password Reset Required

Dear User,

We have upgraded our security systems to better protect your account.
As part of this upgrade, all users must reset their passwords.

Please use the "Forgot Password" link on the login page to set a new password.

Your new password must:
- Be at least 8 characters long
- Contain uppercase and lowercase letters
- Contain at least one number
- Contain at least one special character (@#$%^&+=)

Thank you for your cooperation.
```

#### Option B: Gradual Migration (Login-Time Hash)

Modify `UserController.login()` to migrate passwords on successful login:

```java
// In UserController.login() - Add after line 81
if (user.getCred() != null) {
    // Check if password is already BCrypt hashed
    if (!user.getCred().startsWith("$2a$") && !user.getCred().startsWith("$2b$")) {
        // Old plain text password
        if (user.getCred().equals(cred)) {
            // Successful login with old password - migrate it
            String hashedPassword = passwordEncoder.encodePassword(cred);
            userService.updatePassword(Integer.parseInt(userId), hashedPassword);
            logger.info("Migrated password to BCrypt for user ID: {}", userId);

            // Continue with login...
        }
    } else {
        // Already BCrypt - use new method
        if (passwordEncoder.matches(cred, user.getCred())) {
            // Login successful
        }
    }
}
```

**Note**: This requires adding `updatePassword()` method to UserService.

#### Option C: Batch Migration (If You Have Access to Plain Text Passwords)

⚠️ **Only if you still have plain text passwords in database**

```java
// Migration script (one-time use)
public class PasswordMigrationScript {
    public static void main(String[] args) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder(12);

        // Fetch all users
        List<User> users = getAllUsers();

        for (User user : users) {
            String plainPassword = user.getPassword();
            String hashedPassword = encoder.encode(plainPassword);
            updateUserPassword(user.getId(), hashedPassword);
        }
    }
}
```

### Step 7: Update Systemd Service (Linux)

Update `/etc/systemd/system/banking-app.service`:

```ini
[Unit]
Description=Banking Web Application
After=mysql.service

[Service]
User=bankingapp
WorkingDirectory=/opt/banking-app
EnvironmentFile=/opt/banking-app/.env
ExecStart=/usr/bin/java -jar /opt/banking-app/web-0.0.1-SNAPSHOT.jar
SuccessExitStatus=143
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
```

Reload and restart:
```bash
sudo systemctl daemon-reload
sudo systemctl restart banking-app
```

### Step 8: Test the Migration

#### Test Checklist:

```bash
# 1. Application starts
sudo systemctl status banking-app
tail -f logs/banking-app.log

# 2. Login page accessible
curl -I http://localhost:8080/login

# 3. Database connection works (check logs)
grep "HikariPool" logs/banking-app.log

# 4. Registration works
# - Try registering a new user
# - Verify password is hashed in database

# 5. Password reset works
# - Test forgot password flow
# - Verify new password is hashed

# 6. File upload validation works
# - Try uploading valid file (should work)
# - Try uploading .exe file (should fail)
# - Try uploading 10MB file (should fail)
```

#### Database Verification:

```sql
-- Check if new passwords are BCrypt hashed (should start with $2a$ or $2b$)
SELECT user_id,
       SUBSTRING(password, 1, 10) as password_hash_prefix,
       CASE
           WHEN password LIKE '$2a$%' OR password LIKE '$2b$%' THEN 'BCrypt'
           ELSE 'Plain/Old'
       END as password_type
FROM users
LIMIT 10;
```

### Step 9: Monitor Initial Usage

```bash
# Watch logs for errors
tail -f logs/banking-app.log | grep ERROR

# Monitor login attempts
tail -f logs/banking-app.log | grep "Login attempt"

# Check for failed password validations
tail -f logs/banking-app.log | grep "password"
```

### Step 10: User Communication & Support

**Day 1-3 After Migration:**
- Monitor support requests closely
- Have staff ready to help with password resets
- Track common issues

**Email to Users:**
```
Subject: System Upgrade Complete - New Security Features

Dear User,

Our banking application has been upgraded with enhanced security features:

✓ Stronger password encryption
✓ Secure file uploads
✓ Enhanced session security
✓ Improved error handling

What You Need to Do:
1. Reset your password using "Forgot Password" link
2. Use a strong password meeting our new requirements
3. Update your browser if you experience any issues

Need Help?
Contact support@yourbank.com or call 1-800-XXX-XXXX

Thank you,
IT Security Team
```

---

## Rollback Procedure

If critical issues occur:

### Step 1: Stop New Application

```bash
sudo systemctl stop banking-app
```

### Step 2: Restore Database

```bash
mysql -u root -p Testing < backup_before_migration_YYYYMMDD_HHMMSS.sql
```

### Step 3: Restore Application

```bash
# Extract old backup
tar -xzf banking_app_backup_YYYYMMDD_HHMMSS.tar.gz -C /

# Or revert git
git revert HEAD
```

### Step 4: Restart Old Version

```bash
sudo systemctl start banking-app
```

### Step 5: Verify Rollback

```bash
# Check application is running
sudo systemctl status banking-app

# Test login with old credentials
curl -X POST http://localhost:8080/login -d "userId=1&cred=oldpassword"
```

---

## Post-Migration Tasks

### Week 1:
- [ ] Monitor logs daily
- [ ] Track password reset completion rate
- [ ] Address user support tickets
- [ ] Verify all security features working

### Week 2:
- [ ] Review security logs
- [ ] Identify any edge cases
- [ ] Update documentation based on issues found

### Month 1:
- [ ] Ensure 100% password migration
- [ ] Conduct security audit
- [ ] Review and optimize performance
- [ ] Plan for future enhancements

---

## Common Migration Issues

### Issue 1: Users Can't Login

**Cause**: Passwords not migrated

**Solution**:
1. Verify database password format
2. Ask user to reset password
3. Check logs for authentication errors

### Issue 2: File Uploads Fail

**Cause**: New validation rules

**Solution**:
1. Check file size (max 5MB)
2. Verify file type is allowed
3. Review logs for specific validation error

### Issue 3: Environment Variables Not Loaded

**Cause**: Systemd not reading .env file

**Solution**:
```bash
# Verify .env file exists
cat /opt/banking-app/.env

# Check systemd service configuration
sudo systemctl cat banking-app

# Restart service
sudo systemctl restart banking-app
```

### Issue 4: Session Timeout Too Short

**Cause**: New 30-minute session timeout

**Solution**: Adjust in `application-prod.properties`:
```properties
server.servlet.session.timeout=60m
```

---

## Performance Considerations

### BCrypt Performance Impact

BCrypt is CPU-intensive by design (security feature). Expect:
- **Login time**: +100-200ms per login
- **Registration time**: +100-200ms per registration
- **Password reset**: +100-200ms per reset

This is **normal and expected** for BCrypt with strength 12.

### Mitigation:
- Implement result caching (for repeated verifications)
- Consider async password verification for non-critical paths
- Monitor CPU usage and scale if needed

---

## Security Verification

After migration, verify:

```bash
# 1. Passwords are hashed
SELECT password FROM users LIMIT 1;
# Should see: $2a$12$... or $2b$12$...

# 2. No hardcoded credentials in config
grep -r "password=" src/main/resources/
# Should only show ${DB_PASSWORD}

# 3. Security headers present
curl -I http://localhost:8080/login | grep -E "X-Frame|X-XSS|Strict-Transport"

# 4. CSRF protection enabled
curl -v http://localhost:8080/register 2>&1 | grep CSRF
```

---

## Support & Questions

For migration assistance:
1. Review logs: `logs/banking-app.log`
2. Check `SECURITY_IMPROVEMENTS.md`
3. Consult `SETUP_GUIDE.md`
4. Contact development team

---

## Conclusion

The migration enhances security significantly but requires careful planning and execution. Follow this guide step-by-step, and don't skip the backup phase.

**Remember**: Security is a journey, not a destination. Regular updates and monitoring are essential.
