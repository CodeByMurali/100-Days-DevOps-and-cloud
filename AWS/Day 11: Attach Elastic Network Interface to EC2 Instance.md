In **Boto3 1.38.36**, managing **Elastic Network Interfaces (ENIs)** is key to advanced networking. Here are 5 advanced points:

### 1. Dual-Homing (Multi-Homed Instances)

You can attach ENIs from different **Subnets** to a single EC2 instance. This is used to create "Management Networks" or "DMZs," where one interface handles public traffic and the other handles private backend traffic.

### 2. MAC Address Persistence

The MAC address is tied to the **ENI**, not the EC2 hardware. If you move an ENI from one instance to another, the MAC address moves with it. This is critical for software licenses tied to a specific MAC address.

### 3. Source/Dest Check Disabling

By default, an ENI only accepts traffic intended for its own IP. If you are building a **NAT Instance** or a **Network Firewall**, you must disable the `SourceDestCheck` attribute so the ENI can forward traffic meant for other destinations.

### 4. Separate Security Groups per ENI

Each ENI can have its own unique set of **Security Groups**. This allows you to apply different firewall rules to different interfaces on the same machine (e.g., Port 80 on eth0, but only Port 22 on eth1).

### 5. Primary vs. Secondary ENI Behavior

The **Primary ENI (eth0)** is created with the instance and cannot be detached. **Secondary ENIs (eth1+)** can be detached and reattached "hot" (while the instance is running), making them perfect for high-availability (HA) failover patterns.

---
