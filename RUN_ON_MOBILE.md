# How to Run Banking App on Your Mobile Browser

## Prerequisites

Before you can run this application on your mobile device, you need:

1. ✅ Internet connection (for downloading dependencies)
2. ✅ MySQL database installed and running
3. ✅ Java 8+ installed
4. ✅ Maven installed

## Step-by-Step Instructions

### 1. Set Up Database

First, ensure MySQL is running and create the database:

```bash
# Start MySQL
sudo service mysql start

# Create database
mysql -u root -p <<EOF
CREATE DATABASE IF NOT EXISTS Testing;
EOF
```

### 2. Configure Environment Variables

```bash
# Create .env file from template
cp .env.example .env

# Edit the .env file with your MySQL credentials
nano .env

# Set these values:
# DB_URL=jdbc:mysql://localhost:3306/Testing?useSSL=false&serverTimezone=UTC
# DB_USERNAME=root
# DB_PASSWORD=your_mysql_password
# SPRING_PROFILES_ACTIVE=dev
```

### 3. Export Environment Variables

```bash
# Load environment variables
export $(cat .env | grep -v '^#' | xargs)

# Verify they're set
echo $DB_PASSWORD
```

### 4. Build the Application

This step requires internet connection to download Maven dependencies:

```bash
# Build (will download ~100MB of dependencies)
mvn clean package -DskipTests

# This may take 2-5 minutes on first run
```

### 5. Find Your Computer's IP Address

You need to find your computer's local network IP address:

#### On Linux:
```bash
# Find your IP address
ip addr show | grep "inet " | grep -v 127.0.0.1

# Or simpler:
hostname -I | awk '{print $1}'
```

#### On Mac:
```bash
ifconfig | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}'
```

#### On Windows:
```cmd
ipconfig | findstr IPv4
```

**Example output:** Your IP might be something like `192.168.1.100`

### 6. Configure Application for Network Access

By default, Spring Boot only listens on localhost. We need to make it accessible from the network:

```bash
# Add this to your environment variables
export SERVER_ADDRESS=0.0.0.0
```

Or add to `src/main/resources/application-dev.properties`:
```properties
server.address=0.0.0.0
server.port=8080
```

### 7. Start the Application

```bash
# Run with development profile (allows HTTP for mobile testing)
java -jar target/web-0.0.1-SNAPSHOT.jar --spring.profiles.active=dev --server.address=0.0.0.0
```

You should see:
```
...
Tomcat started on port(s): 8080 (http)
Started WebApplication in X seconds
```

### 8. Access from Mobile

On your mobile device:

1. **Ensure your mobile is on the same WiFi network as your computer**

2. Open your mobile browser (Chrome, Safari, etc.)

3. Navigate to:
   ```
   http://YOUR_COMPUTER_IP:8080/login
   ```

   For example:
   ```
   http://192.168.1.100:8080/login
   ```

4. You should see the Banking App login page!

## Quick Start Script

I've created a convenient script to automate this process:

```bash
# Make it executable
chmod +x run-mobile.sh

# Run it
./run-mobile.sh
```

## Troubleshooting

### Cannot Connect from Mobile

**Problem:** Mobile browser shows "Cannot connect" or "Page not found"

**Solutions:**

1. **Check same WiFi network:**
   - Both devices must be on the same WiFi
   - Corporate or public WiFi may block device-to-device communication

2. **Check firewall:**
   ```bash
   # Allow port 8080 through firewall
   sudo ufw allow 8080/tcp

   # Or disable firewall temporarily for testing
   sudo ufw disable
   ```

3. **Verify IP address:**
   ```bash
   # Check your current IP
   ip addr show

   # Try all IP addresses shown
   ```

4. **Check application is running:**
   ```bash
   # Should show Java process
   ps aux | grep java

   # Should show port 8080 listening
   netstat -tuln | grep 8080
   ```

### Application Won't Start

**Problem:** Database connection errors

**Solution:**
```bash
# Make sure MySQL is running
sudo service mysql status

# Test MySQL connection
mysql -u root -p -e "SHOW DATABASES;"

# Verify credentials match .env file
```

**Problem:** Port 8080 already in use

**Solution:**
```bash
# Find and kill process using port 8080
sudo lsof -ti:8080 | xargs kill -9

# Or use different port
java -jar target/web-0.0.1-SNAPSHOT.jar --server.port=8081
# Then access: http://YOUR_IP:8081/login
```

### Maven Build Fails

**Problem:** "Cannot resolve dependencies"

**Solution:**
- Ensure you have internet connection
- Check proxy settings if behind corporate firewall
- Clear Maven cache: `rm -rf ~/.m2/repository`

### Security Certificate Errors

**Problem:** Browser shows security warning

**Solution:**
- This is normal when using HTTP (not HTTPS)
- In development mode, it's safe to proceed
- For production, you'd set up SSL/HTTPS

## Using a Different Device

### Access from Tablet/Other Computer

Same process as mobile - just use:
```
http://YOUR_COMPUTER_IP:8080/login
```

### Access from Internet (Port Forwarding)

⚠️ **Not recommended for security reasons**, but if needed:

1. Configure router port forwarding: Port 8080 → Your computer's IP
2. Find your public IP: https://whatismyipaddress.com
3. Access: `http://YOUR_PUBLIC_IP:8080/login`

**Security Warning:** This exposes your application to the internet. Only do this in a secure, controlled environment.

## Production Deployment

For production use:

1. Use HTTPS (SSL certificate)
2. Use production profile: `--spring.profiles.active=prod`
3. Deploy to proper server (AWS, Azure, etc.)
4. Use environment variables for all credentials
5. Set up proper firewall rules

See `SETUP_GUIDE.md` for production deployment instructions.

## Performance Tips

### On Mobile

- Use Chrome or Safari for best compatibility
- Enable JavaScript
- Clear browser cache if pages don't load correctly
- Use WiFi (not mobile data) for better performance

### On Server

- Allocate more memory for Java:
  ```bash
  java -Xmx1024m -jar target/web-0.0.1-SNAPSHOT.jar
  ```

- Use production mode for better performance:
  ```bash
  java -jar target/web-0.0.1-SNAPSHOT.jar --spring.profiles.active=prod
  ```

## Features Available on Mobile

All features work on mobile:

- ✅ User registration
- ✅ Login/logout
- ✅ Account management
- ✅ Transaction history
- ✅ Demat trading
- ✅ Overdraft management
- ✅ Password reset
- ✅ File uploads (photos from camera)

The interface is responsive and should work well on mobile screens.

## Need Help?

1. Check application logs: `logs/banking-app.log`
2. Review `SECURITY_IMPROVEMENTS.md`
3. Check `SETUP_GUIDE.md`
4. Verify MySQL is running: `sudo service mysql status`

---

**Happy Mobile Banking! 📱💰**
