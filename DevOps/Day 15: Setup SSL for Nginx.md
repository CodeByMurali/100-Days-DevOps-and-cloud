To configure NGINX with SSL, you follow a workflow of **Preparation**, **Configuration**, and **Validation**.

---

## 1. Installation & Environment

First, enable the repository and install the binary.

* **Command:** `sudo yum install -y epel-release nginx`
* **Explanation:** `epel-release` provides the NGINX package for RHEL/CentOS 7.
* **Common Error:** `No package nginx available.`
* **Fix:** You skipped installing or enabling `epel-release`.



---

## 2. Certificate Placement

Move your keys to the standard system security directories.

* **Command:** * `sudo mv /tmp/nautilus.crt /etc/pki/tls/certs/`
* `sudo mv /tmp/nautilus.key /etc/pki/tls/private/`


* **Explanation:** Keeps certificates in a centralized, secure location.
* **Common Error:** `Permission denied`.
* **Fix:** You must use `sudo` to move files into `/etc/pki/`.



---

## 3. Configuration (`/etc/nginx/nginx.conf`)

You must define the SSL server block.

* **Required Lines:**
```nginx
listen 443 ssl;
ssl_certificate "/etc/pki/tls/certs/nautilus.crt";
ssl_certificate_key "/etc/pki/tls/private/nautilus.key";

```


* **Explanation:** `listen 443 ssl` tells NGINX to handle encrypted traffic on the standard HTTPS port.
* **Critical Error:** `cannot load certificate key "/etc/nginx/etc/pki/..."`
* **Fix:** Use **absolute paths** (starting with `/`). If you omit the leading slash, NGINX looks inside its own config folder.



---

## 4. Troubleshooting & Verification

Before restarting, always test the logic of your file.

* **Command:** `sudo nginx -t`
* **Explanation:** Tests the configuration syntax and checks if files exist/are readable.
* **Common Error:** `BIO_new_file() failed`.
* **Fix:** Either the path is wrong, or the file has the wrong permissions (ensure root can read it).



---

## 5. Deployment

Apply the changes and ensure they survive a reboot.

* **Command:** `sudo systemctl enable --now nginx`
* **Explanation:** `--now` starts the service and enables it for boot in one step.
* **Common Error:** `Job for nginx.service failed`.
* **Fix:** Check `sudo netstat -tulpn | grep :443`. Another process (like Apache or Sendmail) might be sitting on that port.



---

## 6. Connectivity Test

Test from the **Jump Host** to bypass local firewall assumptions.

* **Command:** `curl -Ik https://<APP_SERVER_IP>/`
* **Explanation:** `-I` shows headers; `-k` tells curl to ignore the "Insecure" warning from your self-signed certificate.
* **Common Error:** `Connection refused`.
* **Fix:** The service is down or the NGINX SSL block is missing the `listen 443` line.


* **Common Error:** `No route to host` or timeout.
* **Fix:** **iptables** is blocking port 443.
