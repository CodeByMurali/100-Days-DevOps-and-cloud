To create the user with the specified expiry date on **App Server 2**:

```bash
sudo useradd -e 2024-01-28 javed

```

**Verification:**

```bash
sudo chage -l javed

```

What chage Means

chage = change age (of password)

It controls:

When a password expires

When a user must change their password

When an account expires or becomes inactive