AWS Security Groups (SGs) act as virtual firewalls for your instances. Here are the essential and advanced points:

### The Basics

* **Instance Level:** SGs secure the specific instance (ENI), not the entire subnet.
* **Stateful:** If an inbound request is allowed, the response is automatically allowed (you don't need a matching outbound rule).
* **Implicit Deny:** By default, all traffic is blocked unless an "Allow" rule exists. You cannot create "Deny" rules.

---

### Advanced Concepts

* **Referencing Other SGs:** Instead of using IP addresses (e.g., `10.0.0.5`), you can set a Security Group as the **source**. This allows any instance belonging to the source SG to communicate with your target, regardless of its IP.
* **The 1000-Rule Limit:** AWS enforces a formula: . If you have 5 SGs on one instance, each can only have 200 rules.
* **Managed Prefix Lists:** You can group multiple CIDR blocks into a "Prefix List" and reference it in a single rule, simplifying management for large-scale networks.
* **Security Groups vs. NACLs:** While SGs are stateful and permissive (Allow only), Network ACLs are **stateless** (require two-way rules) and support **explicit Deny** rules at the subnet level.

