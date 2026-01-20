Here are 4 essential commands to remember for troubleshooting port and service issues:

### 1. `netstat -tulpn`

**The "Who is there?" command.**
It shows you exactly which process is occupying a port.

* Use `grep` to filter for your specific port (e.g., `:8087`).
* Always use `sudo` to see the **PID/Program name**.

### 2. `systemctl status`

**The "How are you?" command.**
It tells you three things:

* **Active:** Is it currently running?
* **Loaded:** Will it start on reboot?
* **Logs:** The last few lines of errors if it failed to start.

### 3. `iptables -L -n`

**The "Is the door open?" command.**
If the service is running but you can't connect, check this.

* **Important:** Ensure your `ACCEPT` rule is higher in the list than any `DROP` or `REJECT` rule.

### 4. `curl -v localhost:<port>`

**The "Testing from inside" command.**
Run this on the server itself.

* If it works, the service is fine; the problem is the **firewall**.
* If it fails, the problem is the **service configuration**.

