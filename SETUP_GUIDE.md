# Banking Web Application - Setup Guide

## Prerequisites

- Java 8 or higher
- Maven 3.6+
- MySQL 8.0+
- Git

## Quick Start

### 1. Clone the Repository

```bash
git clone <repository-url>
cd Banking-Web-Application
```

### 2. Database Setup

```sql
-- Create database
CREATE DATABASE Testing;

-- Use the database
USE Testing;

-- Run your schema scripts here
-- Make sure to create all necessary tables and stored procedures
```

### 3. Environment Configuration

```bash
# Copy the environment template
cp .env.example .env

# Edit .env with your actual values
nano .env
```

**Required Environment Variables:**

```bash
DB_URL=jdbc:mysql://localhost:3306/Testing?useSSL=true&requireSSL=false&serverTimezone=UTC
DB_USERNAME=your_mysql_username
DB_PASSWORD=your_mysql_password
SPRING_PROFILES_ACTIVE=dev
```

### 4. Export Environment Variables

#### Linux/Mac:
```bash
export $(cat .env | xargs)
```

#### Windows (PowerShell):
```powershell
Get-Content .env | ForEach-Object {
    $name, $value = $_.split('=')
    Set-Item -Path "env:$name" -Value $value
}
```

#### Windows (CMD):
```cmd
# Set each variable manually
set DB_URL=jdbc:mysql://localhost:3306/Testing
set DB_USERNAME=root
set DB_PASSWORD=your_password
set SPRING_PROFILES_ACTIVE=dev
```

### 5. Build the Application

```bash
# Clean and build
./mvnw clean install

# Or on Windows
mvnw.cmd clean install
```

### 6. Run the Application

```bash
# Using Maven
./mvnw spring-boot:run

# Or run the JAR directly
java -jar target/web-0.0.1-SNAPSHOT.jar
```

### 7. Access the Application

Open your browser and navigate to:
```
http://localhost:8080/login
```

---

## Configuration Profiles

### Development Profile

Activate for local development:
```bash
export SPRING_PROFILES_ACTIVE=dev
./mvnw spring-boot:run
```

**Features:**
- Detailed error messages
- Debug logging enabled
- HTTP cookies allowed

### Production Profile

Activate for production deployment:
```bash
export SPRING_PROFILES_ACTIVE=prod
./mvnw spring-boot:run
```

**Features:**
- Minimal error information
- Production logging
- HTTPS required
- Enhanced security

---

## First-Time Setup Checklist

- [ ] MySQL server is running
- [ ] Database `Testing` created
- [ ] All database tables and stored procedures created
- [ ] `.env` file created with correct credentials
- [ ] Environment variables exported
- [ ] Dependencies downloaded (`mvnw clean install`)
- [ ] Application starts without errors
- [ ] Can access login page

---

## Database Schema Requirements

The application requires the following stored procedures:

1. `login_user` - User authentication
2. `register_User` - User registration
3. Additional procedures for:
   - Transaction history
   - Demat operations
   - Overdraft management
   - Password reset

**Note:** Ensure all stored procedures are created before running the application.

---

## File Upload Configuration

The application stores uploaded files in the classpath directory by default.

### Recommended Production Configuration:

1. Create a dedicated upload directory:
```bash
sudo mkdir -p /var/banking-app/uploads
sudo chown -R tomcat:tomcat /var/banking-app/uploads
sudo chmod 750 /var/banking-app/uploads
```

2. Update file upload path in code (future enhancement)

---

## Troubleshooting

### Connection Refused Error

**Problem:** `java.sql.SQLException: Connection refused`

**Solution:**
1. Ensure MySQL is running: `sudo service mysql status`
2. Check database credentials in `.env`
3. Verify database exists: `mysql -u root -p -e "SHOW DATABASES;"`

### Environment Variables Not Found

**Problem:** `The server time zone value 'UTC' is unrecognized`

**Solution:**
Add timezone parameter to DB_URL:
```
DB_URL=jdbc:mysql://localhost:3306/Testing?serverTimezone=UTC
```

### Port Already in Use

**Problem:** `Port 8080 was already in use`

**Solution:**
1. Find and kill the process:
```bash
# Linux/Mac
lsof -ti:8080 | xargs kill -9

# Windows
netstat -ano | findstr :8080
taskkill /PID <PID> /F
```

2. Or change the port in `application.properties`:
```properties
server.port=8081
```

### File Upload Fails

**Problem:** `MaxUploadSizeExceededException`

**Solution:**
- Check file size (max 5MB)
- Verify file type is allowed (PDF, JPG, PNG, GIF, DOC, DOCX)
- Check disk space

### Password Not Working After Update

**Problem:** Old passwords don't work after security update

**Solution:**
This is expected. All passwords now use BCrypt hashing. Users need to:
1. Click "Forgot Password"
2. Reset their password
3. New password will be properly hashed

---

## Development Setup

### IDE Configuration

#### IntelliJ IDEA
1. File → Open → Select `pom.xml`
2. Configure JDK (File → Project Structure → Project SDK)
3. Enable annotation processing
4. Set environment variables in Run Configuration

#### Eclipse
1. File → Import → Existing Maven Projects
2. Select the project directory
3. Right-click project → Properties → Java Build Path
4. Configure environment variables in Run Configurations

### Hot Reload (Development)

Spring Boot DevTools is included for automatic restart:
```bash
./mvnw spring-boot:run
```

Changes to Java files will trigger automatic restart.

---

## Building for Production

### Create Executable JAR

```bash
./mvnw clean package -DskipTests
```

Output: `target/web-0.0.1-SNAPSHOT.jar`

### Run in Production

```bash
# Set production profile
export SPRING_PROFILES_ACTIVE=prod

# Set environment variables
export DB_URL=jdbc:mysql://production-host:3306/Banking
export DB_USERNAME=prod_user
export DB_PASSWORD=secure_password

# Run with nohup (Linux)
nohup java -jar target/web-0.0.1-SNAPSHOT.jar > app.log 2>&1 &

# Or use systemd service (recommended)
```

### Systemd Service (Linux)

Create `/etc/systemd/system/banking-app.service`:

```ini
[Unit]
Description=Banking Web Application
After=mysql.service

[Service]
User=bankingapp
WorkingDirectory=/opt/banking-app
Environment="DB_URL=jdbc:mysql://localhost:3306/Banking"
Environment="DB_USERNAME=bankinguser"
Environment="DB_PASSWORD=secure_password"
Environment="SPRING_PROFILES_ACTIVE=prod"
ExecStart=/usr/bin/java -jar /opt/banking-app/web-0.0.1-SNAPSHOT.jar
SuccessExitStatus=143
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
```

Enable and start:
```bash
sudo systemctl daemon-reload
sudo systemctl enable banking-app
sudo systemctl start banking-app
sudo systemctl status banking-app
```

---

## Security Considerations

### SSL/TLS Configuration (Production)

For production, configure SSL in `application-prod.properties`:

```properties
server.port=8443
server.ssl.key-store=classpath:keystore.p12
server.ssl.key-store-password=${SSL_KEY_STORE_PASSWORD}
server.ssl.keyStoreType=PKCS12
server.ssl.keyAlias=banking-app
```

Generate keystore:
```bash
keytool -genkeypair -alias banking-app -keyalg RSA -keysize 2048 \
  -storetype PKCS12 -keystore keystore.p12 -validity 3650
```

### Firewall Configuration

```bash
# Allow only HTTPS
sudo ufw allow 8443/tcp
sudo ufw enable
```

---

## Monitoring and Logs

### Log Location

Development: Console output
Production: `logs/banking-app.log`

### View Logs

```bash
# Tail logs in real-time
tail -f logs/banking-app.log

# Search for errors
grep ERROR logs/banking-app.log

# View last 100 lines
tail -n 100 logs/banking-app.log
```

---

## Backup Strategy

### Database Backup

```bash
# Automated daily backup
mysqldump -u root -p Testing > backup_$(date +%Y%m%d).sql

# Restore from backup
mysql -u root -p Testing < backup_20240101.sql
```

### Application Files

```bash
# Backup uploaded files
tar -czf uploads_backup_$(date +%Y%m%d).tar.gz /var/banking-app/uploads/
```

---

## Support

For issues or questions:

1. Check `SECURITY_IMPROVEMENTS.md` for security-related information
2. Review logs: `logs/banking-app.log`
3. Check GitHub Issues
4. Contact development team

---

## Next Steps

After setup:

1. Review `SECURITY_IMPROVEMENTS.md`
2. Configure SSL for production
3. Set up database backups
4. Configure monitoring
5. Perform security audit
6. Load test the application
