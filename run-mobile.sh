#!/bin/bash

# Banking Application - Mobile Runner Script
# This script builds and runs the Banking Web Application for mobile access

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}╔════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Banking Web Application - Mobile Runner     ║${NC}"
echo -e "${BLUE}╔════════════════════════════════════════════════╗${NC}"
echo ""

# Function to print colored messages
info() {
    echo -e "${BLUE}ℹ ${NC} $1"
}

success() {
    echo -e "${GREEN}✓${NC} $1"
}

warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

error() {
    echo -e "${RED}✗${NC} $1"
}

# Check if .env file exists
if [ ! -f .env ]; then
    warning ".env file not found. Creating from template..."
    if [ -f .env.example ]; then
        cp .env.example .env
        warning "Please edit .env file with your database credentials:"
        echo ""
        cat .env
        echo ""
        error "Exiting. Please configure .env and run again."
        exit 1
    else
        error ".env.example not found. Cannot continue."
        exit 1
    fi
fi

# Load environment variables
info "Loading environment variables from .env..."
export $(cat .env | grep -v '^#' | xargs)
success "Environment variables loaded"

# Check if MySQL is running
info "Checking MySQL status..."
if command -v systemctl &> /dev/null; then
    if systemctl is-active --quiet mysql || systemctl is-active --quiet mysqld; then
        success "MySQL is running"
    else
        warning "MySQL is not running. Attempting to start..."
        sudo systemctl start mysql || sudo systemctl start mysqld || {
            error "Could not start MySQL. Please start it manually."
            exit 1
        }
        success "MySQL started"
    fi
elif command -v service &> /dev/null; then
    if service mysql status &> /dev/null; then
        success "MySQL is running"
    else
        warning "MySQL is not running. Attempting to start..."
        sudo service mysql start || {
            error "Could not start MySQL. Please start it manually."
            exit 1
        }
        success "MySQL started"
    fi
else
    warning "Cannot check MySQL status. Please ensure MySQL is running."
fi

# Test MySQL connection
info "Testing database connection..."
if mysql -u"${DB_USERNAME}" -p"${DB_PASSWORD}" -e "USE Testing;" 2>/dev/null; then
    success "Database connection successful"
else
    warning "Database 'Testing' does not exist. Creating it..."
    mysql -u"${DB_USERNAME}" -p"${DB_PASSWORD}" -e "CREATE DATABASE Testing;" 2>/dev/null || {
        error "Could not create database. Please check credentials."
        exit 1
    }
    success "Database 'Testing' created"
fi

# Check if JAR exists
if [ ! -f target/web-0.0.1-SNAPSHOT.jar ]; then
    info "Application not built. Building now..."
    info "This may take a few minutes on first run..."

    if mvn clean package -DskipTests; then
        success "Build completed successfully"
    else
        error "Build failed. Check Maven output above."
        exit 1
    fi
else
    info "Found existing JAR file. Skipping build."
    read -p "Do you want to rebuild? (y/N): " rebuild
    if [ "$rebuild" = "y" ] || [ "$rebuild" = "Y" ]; then
        info "Rebuilding application..."
        mvn clean package -DskipTests || {
            error "Build failed."
            exit 1
        }
        success "Build completed"
    fi
fi

# Get IP address
info "Detecting network IP address..."
if command -v hostname &> /dev/null; then
    IP=$(hostname -I | awk '{print $1}')
elif command -v ip &> /dev/null; then
    IP=$(ip addr show | grep "inet " | grep -v 127.0.0.1 | head -1 | awk '{print $2}' | cut -d/ -f1)
else
    IP="localhost"
    warning "Could not detect IP address automatically"
fi

# Configure firewall (if ufw is available)
if command -v ufw &> /dev/null; then
    info "Configuring firewall..."
    if sudo ufw status | grep -q "8080.*ALLOW" &> /dev/null; then
        success "Port 8080 already allowed in firewall"
    else
        warning "Allowing port 8080 through firewall..."
        sudo ufw allow 8080/tcp &> /dev/null || warning "Could not configure firewall (may require sudo)"
    fi
fi

echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║           Ready to Start Application          ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════╝${NC}"
echo ""
info "Server will be accessible at:"
echo -e "  ${GREEN}Local:${NC}    http://localhost:8080/login"
if [ "$IP" != "localhost" ]; then
    echo -e "  ${GREEN}Network:${NC}  http://${IP}:8080/login"
    echo ""
    echo -e "${YELLOW}📱 On your mobile device:${NC}"
    echo -e "  1. Connect to the same WiFi network"
    echo -e "  2. Open browser and go to: ${GREEN}http://${IP}:8080/login${NC}"
fi
echo ""
info "Press Ctrl+C to stop the server"
echo ""

# Start the application
info "Starting Banking Web Application..."
echo ""

java -jar target/web-0.0.1-SNAPSHOT.jar \
    --spring.profiles.active=dev \
    --server.address=0.0.0.0 \
    --server.port=8080 \
    --logging.level.root=INFO \
    --logging.level.com.Bank.web=DEBUG
