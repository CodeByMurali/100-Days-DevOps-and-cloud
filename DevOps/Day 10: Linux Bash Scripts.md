Question

The production support team of xFusionCorp Industries is working on developing some bash scripts to automate different day to day tasks. One is to create a bash script for taking websites backup. They have a static website running on App Server 1 in Stratos Datacenter, and they need to create a bash script named beta_backup.sh which should accomplish the following tasks. (Also remember to place the script under /scripts directory on App Server 1).



a. Create a zip archive named xfusioncorp_beta.zip of /var/www/html/beta directory.


b. Save the archive in /backup/ on App Server 1. This is a temporary storage, as backups from this location will be clean on weekly basis. Therefore, we also need to save this backup archive on Nautilus Backup Server.


c. Copy the created archive to Nautilus Backup Server server in /backup/ location.


d. Please make sure script won't ask for password while copying the archive file. Additionally, the respective server user (for example, tony in case of App Server 1) must be able to run it.


e. Do not use sudo inside the script.

Note:
The zip package must be installed on given App Server before executing the script. This package is essential for creating the zip archive of the website files. Install it manually outside the script.


To complete this task on **App Server 1**, follow these concise steps.

### 1. Pre-requisites (Manual)

Install the `zip` utility and set up passwordless SSH from **tony** (App Server) to **clint** (Backup Server).

```bash
# Install zip
sudo yum install -y zip

# Setup SSH Key (Press Enter for defaults)
ssh-keygen -t rsa
ssh-copy-id clint@172.16.238.16

```

---

### 2. Create the Script

Create the file at `/scripts/beta_backup.sh`:

```bash
#!/bin/bash

# a & b. Create zip in /backup/
zip -r /backup/xfusioncorp_beta.zip /var/www/html/beta

# c. Copy to Nautilus Backup Server
scp /backup/xfusioncorp_beta.zip clint@172.16.238.16:/backup/

```

---

### 3. Set Permissions

Ensure the script is executable by **tony**.

```bash
sudo chmod +x /scripts/beta_backup.sh
sudo chown tony:tony /scripts/beta_backup.sh

```

---

To enable passwordless copies, you must share your **Public Key** with the Backup Server.

### 🛠️ Fix: Set up SSH Key-Based Authentication

Run these commands as user **tony** on **App Server 1**:

1. **Generate the key** (press **Enter** for all prompts to keep it empty/default):
```bash
ssh-keygen -t rsa

```


2. **Copy the key to the Backup Server**:
```bash
ssh-copy-id clint@172.16.238.16

```


*(You will be asked for clint's password **one last time** here.)*
3. **Test the connection**:
```bash
ssh clint@172.16.238.16

```


If it logs in without asking for a password, your script will now run successfully.

---

**Why this works:** The `ssh-copy-id` command places your public key in the `~/.ssh/authorized_keys` file on the remote server, allowing it to verify your identity using cryptography instead of a password.
