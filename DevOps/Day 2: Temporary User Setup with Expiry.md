To create the user with the specified expiry date on **App Server 2**:

```bash
sudo useradd -e 2024-01-28 javed

```

**Verification:**

```bash
sudo chage -l javed

```

Would you like me to show you how to automate this for multiple servers using **Boto3**?