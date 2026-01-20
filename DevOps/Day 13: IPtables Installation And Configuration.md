To secure your infrastructure, perform these steps on **stapp01**, **stapp02**, and **stapp03**.

### 1. Install iptables

On each app server, install the service and its persistence management tool:

```bash
sudo yum install -y iptables-services
sudo systemctl enable iptables
sudo systemctl start iptables

```

### 2. Configure Firewall Rules

You must **Allow** the Load Balancer (172.16.238.14) first, then **Drop** everyone else for port 5000.

Run these commands in order:

```bash
# 1. Allow LBR (stlb01)
sudo iptables -A INPUT -p tcp -s 172.16.238.14 --dport 5000 -j ACCEPT

# 2. Block everyone else
sudo iptables -A INPUT -p tcp --dport 5000 -j DROP

```

### 3. Make Rules Persistent

Standard `iptables` commands are lost on reboot. Save them to the configuration file:

```bash
sudo service iptables save

```

*This writes the current rules to `/etc/sysconfig/iptables`.*

---

### 🔍 Verification

To confirm the order is correct (the "Allow" must be above the "Drop"), run:

```bash
sudo iptables -L INPUT -n --line-numbers

```

Modifying IPTables order

No, this is **not correct**.

The issue is the **REJECT** rule at **position 5**.

### ❌ The Problem

In `iptables`, rules are processed from **top to bottom**. Once a packet matches a rule, it stops looking at the rest.

1. A packet arrives from the LBR (`172.16.238.14`) for port `8087`.
2. It hits **Rule 5**: `REJECT all`.
3. The packet is rejected immediately.
4. **Rule 6** (your ALLOW rule) is never even reached.

---

### ✅ The Fix

You must insert your new rules **above** the REJECT rule (at the top of the chain).

1. **Delete the misplaced rules:**
```bash
sudo iptables -D INPUT 7
sudo iptables -D INPUT 6

```


2. **Insert them at the top (Position 1 and 2):**
```bash
sudo iptables -I INPUT 1 -p tcp -s 172.16.238.14 --dport 8087 -j ACCEPT
sudo iptables -I INPUT 2 -p tcp --dport 8087 -j DROP

```


3. **Save the changes:**
```bash
sudo service iptables save

```



Now, when a packet arrives, it will hit the **ALLOW** or **DROP** for port `8087` before it ever reaches that global **REJECT** rule at the bottom.

Would you like me to explain the difference between using `-A` (Append) and `-I` (Insert) in more detail?