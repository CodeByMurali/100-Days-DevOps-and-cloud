Beyond the basics of attaching a standard managed policy, advanced IAM configurations for EC2 focus on **limiting blast radius**, **dynamic scaling**, and **pre-deployment enforcement**.

Here are 5 advanced points for IAM roles on EC2:

### 1. Enforcing IMDSv2 for Token Security

The **Instance Metadata Service (IMDS)** provides the temporary credentials to your EC2. Advanced setups enforce **IMDSv2**, which requires a session-oriented token. This prevents "SSRF" (Server-Side Request Forgery) attacks where an attacker might try to steal the role's credentials by making a simple HTTP request to the metadata URL.

* **Pro-tip:** Use an IAM policy condition `ec2:RoleDelivery` or a Service Control Policy (SCP) to deny the launch of any instance that doesn't have IMDSv2 mandated.

### 2. Attribute-Based Access Control (ABAC) with Session Tags

Instead of writing a different policy for every project, use **ABAC**. You can tag your EC2 instance with `Project: DaVinci` and use a single IAM policy that only allows access to resources (like S3 buckets) that have the exact same tag.

* **Mechanism:** The EC2 service "carries" these tags into the security session. Your policy would use a condition like:
`"StringEquals": {"aws:ResourceTag/Project": "${aws:PrincipalTag/Project}"}`

### 3. Trust Policy Condition: "SourceVpc"

Even if an attacker steals the temporary credentials from your EC2, you can render them useless outside your network. By adding a `Condition` to the **Trust Policy** of the IAM Role, you can restrict the role so it can *only* be assumed or used if the request originates from a specific **VPC Endpoint** or **Source VPC**.

* **Benefit:** This creates a "network perimeter" around your identity.

### 4. Instance Profile vs. IAM Role

Technically, you don't "attach a role" to an EC2; you attach an **Instance Profile**.

* **The Distinction:** An Instance Profile is a container for the role. In advanced automation (like Boto3 or Terraform), you must create the Role, then the Instance Profile, then add the Role to the Profile, and *then* associate the Profile with the EC2.
* **Version 1.38.36 Tip:** When using `boto3`, ensure you allow for "propagation delay" (usually 5–10 seconds) between creating the role and attaching it to the instance, or your API call will fail with a `404 Role Not Found`.

### 5. Permissions Boundaries for Delegated Admins

If you are allowing your AI agent or a junior dev to create roles for EC2, use a **Permissions Boundary**. This is a managed policy that sets the *maximum* permissions a role can ever have.

* **Scenario:** You give the agent permission to `iam:CreateRole`, but you attach a Boundary that says "This role can never touch IAM or Billing." No matter what policy the agent attaches to the new EC2 role, the role will be hard-capped by that boundary.

---

**Next Step:** Would you like the **Boto3 1.38.36** code to create an IAM role with an attached Permissions Boundary for your agent to use?
