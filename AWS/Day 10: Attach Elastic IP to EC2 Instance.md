In **Boto3 1.38.36**, managing Elastic IPs (EIPs) requires understanding their behavior beyond just being "static IPs."

### 1. Reverse DNS (rDNS) Customization

By default, EIPs map to generic AWS hostnames. For **Email Servers** (SMTP), you must manually request AWS to set a custom rDNS record to prevent your emails from being marked as spam.

### 2. EIPs and Network Interface (ENI) Detachment

An EIP is technically associated with a **Network Interface (ENI)**, not the Instance directly. This allows "warm recovery": you can move an ENI (with its EIP attached) from a failing instance to a standby instance in seconds.

### 3. Public IPv4 Costs (2024+ Update)

AWS now charges for **all** public IPv4 addresses, including EIPs, even if they are currently attached to a running instance. To save costs, release any EIP you aren't actively using.

### 4. BYOIP (Bring Your Own IP)

You can move your company's existing on-premise IPv4 range to AWS. This allows you to use your own IPs as Elastic IPs, which is critical for maintaining whitelisted IPs in legacy client firewalls.

### 5. Standard vs. VPC Scope

While rare in modern accounts, EIPs can be allocated in two scopes: **Standard** (EC2-Classic) and **VPC**. Standard EIPs cannot be moved into a VPC. Always ensure you are allocating within the VPC scope for modern architecture.

