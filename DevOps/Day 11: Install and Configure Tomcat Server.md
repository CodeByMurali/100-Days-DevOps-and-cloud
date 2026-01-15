To complete this deployment on **App Server 3** (stapp03) using **Boto3 1.38.36** and Python 3.13 context, follow these steps.

### 1. Install & Configure Tomcat

Login to **App Server 3** and run:

```bash
# Install Tomcat
sudo yum install -y tomcat

# Change Port to 8086
# Edit /etc/tomcat/server.xml
sudo sed -i 's/Connector port="8080"/Connector port="8086"/' /etc/tomcat/server.xml

# Start and Enable
sudo systemctl start tomcat
sudo systemctl enable tomcat

```

### 2. Deploy ROOT.war

From the **Jump Host**, copy the file to the Tomcat webapps directory.

> **Note:** To make the app work on the **base URL**, the file must be named `ROOT.war`. If a `ROOT` folder already exists in `webapps`, delete it first.

```bash
# From Jump Host
scp /tmp/ROOT.war tony@stapp03:/tmp/

# On App Server 3
sudo rm -rf /var/lib/tomcat/webapps/ROOT/
sudo mv /tmp/ROOT.war /var/lib/tomcat/webapps/

```

### 3. Verify

Run the check from the server:

```bash
curl http://stapp03:8086

```

---


### `sudo systemctl start tomcat`

**Purpose:** This starts the Tomcat process **immediately**.

* Use this when you want the server to go live right now.
* If you restart the EC2 instance, Tomcat **will not** start automatically with this command alone.

### `sudo systemctl enable tomcat`

**Purpose:** This configures Tomcat to **start automatically on boot**.

* It creates a symbolic link in the system's library telling the OS to trigger Tomcat whenever the server powers on.
* This does **not** start the service immediately; it only ensures it starts in the future after a reboot.

---

| Command | Action | Persistence |
| --- | --- | --- |
| **start** | Starts it now | Lost on reboot |
| **enable** | Configs for future | Survives reboot |

**Pro Tip:** In production, you almost always run both to ensure your app stays up after AWS maintenance or an instance restart.
