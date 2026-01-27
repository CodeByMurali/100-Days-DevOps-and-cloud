### Summary

Setup a **t2.micro** instance named **nautilus-ec2** accessible from **aws-client** via passwordless SSH (root user) by injecting a specific public key.

---

### Step 1: Generate SSH Key (on aws-client)

If not already present, create the key pair:

```bash
ssh-keygen -t rsa -b 4096 -f /root/.ssh/id_rsa -N ""

```

### Step 2: Launch EC2 Instance

1. **Open Console:** Navigate to **EC2** > **Instances** > **Launch instance**.
2. **Name:** Set to `nautilus-ec2`.
3. **Instance Type:** Select `t2.micro`.
4. **Key Pair:** Select **Proceed without a key pair** (as we are using User Data).
5. **Network:** Ensure the Security Group allows **Port 22** from your client IP.

### Step 3: Add User Data

Expand **Advanced details**, scroll to **User data**, and paste:

```bash
#!/bin/bash
mkdir -p /root/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDXD6CCSTjKhBTMo+cjwvyRQH5rxQMJTHcvPnhB7toewxMb341u7+5Vm7nXidn6byI67cl4WdkHqjEz1YHZ/euCad9+5q2p83HFkkVDGkHTdCba5O/5zOaT+FXreJ5y75p6DSLhojkKmabj5oC8wozI9CH3aWx22OVPv/tzUVF74k0LSFowwSTVXv+hV/vMJhRBAS3wNUPv4O6U6W0qSkden4U+HLZjSI/0x9kLwXKiRxcODKd1QDalLAlizrqd3NY56wh6nlUeT1uDxU1tfHXJSQAjSURV2zrmi8wExmNqQLI8+33w9KKtXegSIu70vx8w5HOSObtZFyQo2t6f9wfXs2fFRgiJS7JUDLHZFydhf8jU+iPHXXHSz7MAOTsSsYNto9KV0OQKCQ1kcJqEgGgSHdmRJDLQ9DhXpj2wfzZ7bIxdrEI8AuPOGPA85oqfsfLoZhE/x5XXP643MO7RHgPi/biB4EzI7getX0PSrkBYUMgDPJRoDIWaZ+Ok/V71OqgS4QKZzsHCgIuT+gExmcQFslYIdmcmUmM6sYp32hPRx1WJIiUf4auMIAtA0qN79VdFK9m7QicTSsR5QBaMq/Xb9+9JC/ZogpkcLnLKVAGVtfw06lKUz7Sv3pLvE4bpK4EHHMMcnvDbiT+taaRpyHU4mlwSJVTXmMmI1QeW1GqSYQ== root@aws-client" >> /root/.ssh/authorized_keys
chmod 700 /root/.ssh
chmod 600 /root/.ssh/authorized_keys

```

### Step 4: Verify Access

From the `aws-client` host, connect using:

```bash
ssh root@<EC2-Public-IP>

```

Would you like me to explain how to find the `<EC2-Public-IP>` in the console?
