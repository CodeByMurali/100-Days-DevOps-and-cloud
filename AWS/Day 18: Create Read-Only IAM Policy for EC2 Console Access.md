Creating a truly robust Read-Only IAM policy for the EC2 console involves moving beyond the basic `AmazonEC2ReadOnlyAccess` managed policy.

Here are 5 advanced points to consider:

### 1. Resource-Level Permission Limitations

While many AWS actions support resource-level permissions (e.g., `arn:aws:ec2:*:*:instance/i-xxx`), most **ec2:Describe*** actions do not. This means you cannot create a policy that only allows a user to "see" specific instances in the console. You must use `Resource: "*"` for Describe actions, or the console will fail to load the list of resources (resulting in "API Error" messages).

### 2. Differentiating "Read-Only" vs. "View-Only"

AWS provides two distinct managed policies that are often confused:

* **ReadOnlyAccess**: Includes permissions to view metadata *and* read actual data (e.g., `s3:GetObject` or `dynamodb:GetItem`).
* **ViewOnlyAccess**: Intended for "business users." It allows viewing resource metadata and configurations but explicitly denies access to the underlying data (like the contents of an S3 bucket or the data inside an EC2's attached EBS volume).

### 3. Permission Boundaries as Guardrails

For advanced security, you can attach a **Permission Boundary** to a user or role. Even if a user is granted "Full Administrator" access via an identity-based policy, the Permission Boundary acts as a maximum ceiling. If the boundary only allows `ec2:Describe*`, the user will never be able to terminate an instance, regardless of any other policies attached to them.

### 4. ABAC (Attribute-Based Access Control)

Instead of hardcoding instance IDs, use **Tags** to control read access dynamically. You can use a `Condition` element to allow access only if the instance has a specific tag:

```json
"Condition": {
    "StringEquals": { "ec2:ResourceTag/Environment": "Production" }
}

```

*Note: As mentioned in point #1, this works for "Actions" like Start/Stop, but for "Describe" (viewing) in the console, the user generally needs broad access to see the list first.*

### 5. IAM Identity Center Permission Sets

In a multi-account environment, do not create local IAM users. Use **AWS IAM Identity Center** (formerly SSO) to create **Permission Sets**. This allows you to centrally manage a "ReadOnly" template and assign it to different groups across your entire AWS Organization, ensuring consistent read-only access in Production, Dev, and Staging accounts without manual duplication.

---
