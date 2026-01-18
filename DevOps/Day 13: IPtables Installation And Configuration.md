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
