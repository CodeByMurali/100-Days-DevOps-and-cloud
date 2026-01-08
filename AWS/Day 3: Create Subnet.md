AWS subnets are the fundamental building blocks for network isolation. Here are 10 basic to advanced points:

### The Basics

1. **AZ Isolation:** A subnet must reside within a **single Availability Zone** (AZ). It cannot span multiple AZs.
2. **IP Reservation:** AWS reserves **5 IP addresses** in every subnet (first 4 and last 1) for internal networking (DNS, Router, etc.). A `/24` has 251 usable IPs instead of 254.
3. **Public vs. Private:** A **Public Subnet** has a route to an Internet Gateway (IGW). A **Private Subnet** does not and typically uses a NAT Gateway for outbound-only access.
4. **Size Constraints:** Subnet sizes range from `/28` (16 IPs) to `/16` (65,536 IPs). You cannot change the size of a subnet after creation.
5. **NACLs (Subnet Firewall):** Network ACLs act as a stateless firewall at the **subnet boundary**, providing a layer of security before traffic reaches the instance.

---

### Advanced Concepts

6. **Shared VPC (Resource Access Manager):** You can share subnets with other AWS accounts in your Organization. This allows centralizing network management while letting teams manage their own resources.
7. **Implicit vs. Explicit Association:** Every subnet must be associated with a **Route Table**. If you don't explicitly assign one, it defaults to the "Main" Route Table, which can be a security risk if the Main table is public.
8. **Secondary CIDRs:** If you run out of IPs, you can add secondary IPv4 CIDR blocks to your VPC and create new subnets from that range.
9. **IPv6-Only Subnets:** AWS supports IPv6-only subnets where resources do not have an IPv4 address at all, communicating via an Egress-Only Internet Gateway.
10. **BYOIP (Bring Your Own IP):** You can provision your own publicly routable IPv4/IPv6 address ranges to AWS and use them to create subnets, maintaining your existing IP reputation.