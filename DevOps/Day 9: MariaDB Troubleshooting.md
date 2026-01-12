# MariaDB Troubleshooting & Resolution

### 1. Verification & Diagnostics

Use these commands to identify if the service exists, its state, and network status:

* **Check installation:** `systemctl list-unit-files | grep mariadb`
* **Check status:** `sudo systemctl status mariadb`
* **Check port:** `ss -tunlp | grep 3306`

### 2. Resolution Steps

The issue was a permission conflict on the PID directory.

```bash
# Create directory and set ownership
sudo mkdir -p /run/mariadb
sudo chown mysql:mysql /run/mariadb

# Start and persist
sudo systemctl start mariadb
sudo systemctl enable mariadb

```

---

### 3. Key Concepts Explained

| Question | Answer |
| --- | --- |
| **list-units** vs **list-unit-files** | `list-units` shows units currently **in memory** (active/running). `list-unit-files` shows units **on disk** (installed/enabled/disabled). |
| **How I knew the user was `mysql`?** | MariaDB defaults to the `mysql` user. Systemd unit files and logs typically reference this user for process execution. |
| **How I knew permissions were missing?** | Your logs explicitly stated: `(Errcode: 13 "Permission denied")` when trying to write the `.pid` file. |


---

### Path and Sample Unit File

The default path for the MariaDB service file on RHEL/CentOS systems is:
**`/usr/lib/systemd/system/mariadb.service`**

```ini
[Unit]
Description=MariaDB 10.5 database server
After=network.target

[Service]
Type=notify
User=mysql
Group=mysql
PIDFile=/run/mariadb/mariadb.pid
ExecStart=/usr/libexec/mariadbd --basedir=/usr $MYSQLD_OPTS
Restart=on-failure

[Install]
WantedBy=multi-user.target

```

---

### Why these steps worked:

* **How I knew the user was `mysql`:** The `User=mysql` line in the unit file tells systemd to switch from `root` to `mysql` before starting the database.
* **How I knew about the PID permission:** The log error `can't create PID file: Permission denied` matched the path defined in `PIDFile=/run/mariadb/mariadb.pid`. If that folder is owned by `root`, the `mysql` user cannot write to it.

---

### Command Differences

| Command | Scope | Purpose |
| --- | --- | --- |
| `systemctl list-units` | **Runtime** | Shows what is currently loaded/active in memory. |
| `systemctl list-unit-files` | **Disk** | Shows all installed service files and if they are "enabled" to start on boot. |
