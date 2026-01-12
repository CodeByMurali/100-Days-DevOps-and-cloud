To set up password-less SSH from the **jump host** as the `thor` user, execute the following commands:

### 1. Generate SSH Key

```bash
ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa

```

### 2. Copy Public Keys to App Servers

Enter the respective passwords when prompted:

* **App Server 1:** `ssh-copy-id tony@172.16.238.10` (Password: `Ir0nM@n`)
* **App Server 2:** `ssh-copy-id steve@172.16.238.11` (Password: `Am3ric@`)
* **App Server 3:** `ssh-copy-id banner@172.16.238.12` (Password: `BigGr33n`)

---

### 3. Verify Access

Ensure you can log in without a password:

```bash
ssh tony@172.16.238.10
ssh steve@172.16.238.11
ssh banner@172.16.238.12

```

Whats happening here?
## Thor's Role

`thor` is the **source user** who owns the **private key**. The app servers hold his **public key**. When `thor` connects, the server uses that public key to verify his identity.

## The Fingerprint

The fingerprint is the **server's unique identity (Host Key)**.

* **Trust:** It prevents **Man-in-the-Middle** attacks by ensuring you are connecting to the genuine server and not an impostor.
* **Storage:** Accepting it saves the server's ID to `~/.ssh/known_hosts` for future verification.

Would you like to know how to use `ssh-keyscan` to automate trusting these fingerprints for all servers at once?