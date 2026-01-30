### Short Summary

Deploy WordPress infra: **Apache (Port 5004)** and **PHP** on 3 App hosts, with a **MariaDB** backend on the DB server, all sharing `/var/www/html`.

---

### 1. App Hosts (stapp01, stapp02, stapp03)

Run on **all three** servers:

```bash
# Install packages
sudo yum install -y httpd php php-mysqlnd php-gd php-xml

# Change Port to 5004
sudo sed -i 's/Listen 80/Listen 5004/' /etc/httpd/conf/httpd.conf

# Start and enable Apache
sudo systemctl start httpd
sudo systemctl enable httpd

```

### 2. DB Server (stdb01)

Run these commands to setup MariaDB:

```bash
# Install and Start
sudo yum install -y mariadb-server
sudo systemctl start mariadb
sudo systemctl enable mariadb

# Create DB, User, and Grant Privileges
sudo mysql -u root -e "
CREATE DATABASE kodekloud_db3;
CREATE USER 'kodekloud_cap'@'%' IDENTIFIED BY 'Rc5C9EyvbU';
GRANT ALL PRIVILEGES ON kodekloud_db3.* TO 'kodekloud_cap'@'%';
FLUSH PRIVILEGES;"

```

### 3. Verification

Create a test script at `/var/www/html/index.php` (on any app host) to verify the connection:

```php
<?php
$conn = new mysqli('172.16.239.10', 'kodekloud_cap', 'Rc5C9EyvbU', 'kodekloud_db3');
if ($conn->connect_error) { die("Connection failed: " . $conn->connect_error); }
echo "App is able to connect to the database using user kodekloud_cap";
?>

```

