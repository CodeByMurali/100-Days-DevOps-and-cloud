AWS Key Pairs are a security mechanism used to prove your identity when connecting to an EC2 instance. They rely on **Public Key Cryptography**, which uses a mathematically linked pair of keys to secure access without needing a traditional password.

### 1. What are AWS Key Pairs?

A key pair consists of two parts:

* **Public Key:** AWS stores this on their infrastructure and automatically injects it into your EC2 instance (specifically in the `~/.ssh/authorized_keys` file) when it boots.
* **Private Key:** You download and keep this locally on your computer. **AWS does not keep a copy** of this; if you lose it, you cannot download it again.

### 2. Why are they used?

* **Enhanced Security:** Unlike passwords, private keys are nearly impossible to brute-force.
* **Passwordless Login:** They allow you to log in via SSH (Linux) or decrypt the administrator password (Windows) without managing multiple passwords.
* **Automation:** They facilitate secure, scriptable access for DevOps tools like Boto3 or Terraform.

---

### 3. What is a .pem key?

A **.pem (Privacy Enhanced Mail)** file is a specific file format used to store your **Private Key**.

* **Format:** It is a Base64 encoded text file that usually starts with `-----BEGIN RSA PRIVATE KEY-----`.
* **Usage:** When you run an SSH command, you use the `-i` flag to point to this file (e.g., `ssh -i my-key.pem ec2-user@1.2.3.4`).
* **Permissions:** For security reasons, Linux and macOS require you to restrict the permissions of this file before use. If the file is "too open," SSH will reject it. You typically fix this with:
```bash
chmod 400 your-key.pem

```



### Key Differences at a Glance

| Feature | Public Key | Private Key (.pem) |
| --- | --- | --- |
| **Storage** | Stored by AWS on the EC2 instance. | Stored by YOU on your local machine. |
| **Function** | Acts as the "lock." | Acts as the "physical key." |
| **Visibility** | Can be shared or seen. | Must be kept secret. |
| **Recovery** | Always available in AWS. | **Irrecoverable if lost.** |
