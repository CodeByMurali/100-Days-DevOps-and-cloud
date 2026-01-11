As of 2026, AWS EC2 has evolved into a highly specialized compute service with features specifically designed for security, massive-scale AI, and cost optimization.

### 1. Nitro Enclaves (Isolated Compute)

Nitro Enclaves allow you to create fully isolated compute environments (enclaves) within your EC2 instance.

* **Hardened Security:** Even a `root` user on the parent instance cannot access the enclave. It has no persistent storage, no interactive access (no SSH), and no external networking.
* **Use Case:** Processing highly sensitive data like PII, healthcare records, or private cryptographic keys for tokenization.

### 2. EC2 Capacity Blocks for ML

This is a "hotel-style" reservation system for high-demand GPUs (like NVIDIA H100s).

* **Guaranteed Access:** You can reserve a specific number of GPU instances for a future start date and duration (up to 8 weeks in advance).
* **Cluster Performance:** These instances are always delivered within an **EC2 UltraCluster**, providing low-latency, high-throughput network connectivity.

### 3. Placement Group Strategies

To control the physical distribution of your instances on the underlying hardware, you can use:

* **Cluster:** Instances are packed on the same rack for the lowest possible latency (ideal for HPC).
* **Spread:** Each instance is on a distinct rack with separate power/network (max 7 per AZ) to minimize the blast radius of hardware failures.
* **Partition:** Instances are grouped into partitions (mini-racks) that do not share hardware, used for distributed data systems like Kafka or Hadoop.

[Image comparing Cluster vs Spread vs Partition placement groups]

### 4. EC2 Hibernate for State Preservation

Unlike "Stopping," hibernation saves the contents of your **RAM** to the encrypted EBS root volume.

* **Pre-warmed Apps:** Perfect for enterprise applications (like SAP) that take 20+ minutes to initialize. On resume, the app starts exactly where it left off.
* **Requirement:** The root volume **must** be encrypted via KMS.

### 5. EC2 Fleet (Multi-Purchase Model)

EC2 Fleet allows you to launch and manage thousands of instances across different purchasing models and AZs with a single API call.

* **Allocation Strategies:** You can specify "capacity-optimized" for Spot instances (to minimize interruptions) while maintaining a baseline of On-Demand instances for stability.
* **Attribute-Based Selection:** Instead of picking "m5.large," you can tell the fleet to "give me any instance with at least 8GB RAM and 2 vCPUs."

---

### EC2 Placement Group Comparison

| Feature | Cluster | Spread | Partition |
| --- | --- | --- | --- |
| **Main Goal** | Low Latency | Fault Isolation | Scalable Fault Tolerance |
| **Max Instances** | Unlimited (per instance limits) | 7 per AZ | Hundreds |
| **Distribution** | Tightly packed | One per rack | Many per partition |
| **Use Case** | Machine Learning, HPC | Load Balancers, Databases | Kafka, Cassandra, Hadoop |