### Advanced EC2 Modification Points

1. **Driver Compatibility:** Upgrading to Nitro-based instances (e.g., `t3` or `m5`) requires installing **ENA** and **NVMe drivers** in the OS before the change, or the instance will fail to boot.
2. **Architecture Limits:** You cannot switch between **x86_64** (Intel/AMD) and **ARM64** (Graviton) architectures; a new AMI and instance are required for such transitions.
3. **Instance Store Loss:** Stopping an instance permanently deletes all data stored on **Instance Store (ephemeral)** volumes; ensure critical data is backed up to EBS.
4. **IP Address Changes:** Unless using an **Elastic IP**, stopping an instance releases its Public IPv4 address, which will change upon restart.
5. **Virtualization Type:** Older instances using **PV (Paravirtual)** cannot be changed to newer types that only support **HVM (Hardware Virtual Machine)** without a full migration.