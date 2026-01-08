To disable direct SSH root login on **App Server 1 (stapp01)**, **App Server 2 (stapp02)**, and **App Server 3 (stapp03)**, follow these steps for each:

### 1. Edit SSH Configuration

Open the configuration file using `sudo`:

```bash
sudo vi /etc/ssh/sshd_config

```

### 2. Modify `PermitRootLogin`

Find the line `PermitRootLogin` and change it to `no`. Ensure it is not commented out (remove the `#`).

```text
PermitRootLogin no

```

### 3. Restart SSH Service

Apply the changes by restarting the service:

```bash
sudo systemctl restart sshd

```

---

### Automation via Python (Boto3/Paramiko)

Since you are using **Python 3.13**, you can automate this across all three servers using the `Paramiko` library.

**Would you like me to provide a Python script to apply this change to all servers at once?**