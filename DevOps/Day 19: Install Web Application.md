### Short Summary

Configure **Apache (httpd)** on **App Server 1** to serve two static websites from `/var/www/html` on port **3001**.

---

### 1. Install & Configure Apache (on stapp01)

```bash
# Install httpd
sudo yum install -y httpd

# Change port to 3001
sudo sed -i 's/Listen 80/Listen 3001/' /etc/httpd/conf/httpd.conf

# Start and enable
sudo systemctl start httpd
sudo systemctl enable httpd

```

### 2. Deploy Website Files

On the **jump_host**, copy the folders to the app server:

```bash
scp -r /home/thor/ecommerce tony@stapp01:/tmp/
scp -r /home/thor/games tony@stapp01:/tmp/

```

On **stapp01**, move them to the web root:

```bash
sudo mv /tmp/ecommerce /var/www/html/
sudo mv /tmp/games /var/www/html/

```

### 3. Verification (on stapp01)

Test both links locally:

```bash
curl http://localhost:3001/ecommerce/
curl http://localhost:3001/games/

```

Would you like me to show you how to set up Virtual Hosts if you wanted to use different domains instead?
