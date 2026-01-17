To help you learn the debugging process, here is a breakdown of the exact steps we took to fix the Apache (`httpd`) issue.

### 🪜 Step 1: Identification (The "Status Check")

We started by confirming the service was actually broken.

* **Command:** `systemctl status httpd.service`
* **Why:** You need to know if the service is "Stopped," "Failed," or "Active."
* **Flags:**
* `status`: Displays the current state, recent logs, and the "exit-code."



---

### 🪜 Step 2: Inspection (The "Logs Check")

When `systemctl` showed a generic "FAILURE," we looked for the specific error message.

* **Command:** `sudo journalctl -xeu httpd.service`
* **Why:** This reveals the "death rattle" of the process—the very last things it tried to do before it crashed.
* **Flags:**
* `-x`: (eXplain) Adds extra descriptive text to help explain the error.
* `-e`: (End) Jumps directly to the end of the logs so you see the newest info.
* `-u`: (Unit) Filters to show only logs for a specific service (in our case, `httpd`).



---

### 🪜 Step 3: Conflict Discovery (The "Port Check")

Your logs showed a failure to "bind" to a port. We checked what was already using that port.

* **Command:** `sudo netstat -tulpn | grep :5001`
* **Why:** Only one program can own a port at a time. We found `sendmail` was already using 5001.
* **Flags:**
* `-t`: (TCP) Show TCP connections.
* `-u`: (UDP) Show UDP connections.
* `-l`: (Listening) Show only ports that are actively waiting for connections.
* `-p`: (Program) Show the Process ID (PID) and the name of the program using the port.
* `-n`: (Numeric) Show port numbers (5001) instead of service names (sometimes 5001 is mapped to a service name).



---

### 🪜 Step 4: Resolution (The "Cleanup")

We removed the obstacle so Apache could take the port.

* **Command:** `sudo systemctl stop sendmail`
* **Why:** By stopping the competing service, we freed up Port 5001.

---

### 🪜 Step 5: Network Access (The "Firewall Check")

Apache was finally running, but the Jump Host couldn't reach it ("No route to host").

* **Command:** `sudo iptables -I INPUT -p tcp --dport 5001 -j ACCEPT`
* **Why:** Even if the software is running, the Linux kernel will block outside traffic unless a "hole" is punched in the firewall.
* **Flags:**
* `-I INPUT`: **I**nserts a rule at the top of the **INPUT** chain (traffic coming into the server).
* `-p tcp`: Specifies the protocol is **TCP**.
* `--dport 5001`: Targets the specific **D**estination **Port** we want to open.
* `-j ACCEPT`: Tells the firewall to **J**ump to the **ACCEPT** action (allow the packet).



---

### 🪜 Step 6: Final Verification

* **Command:** `curl http://stapp01:5001` (from the Jump Host)
* **Why:** This is the ultimate "End-to-End" test. If this works, every layer (Service, Port, and Firewall) is correct.

Would you like me to show you how to make that **iptables** rule permanent so it survives a server reboot?