While IAM Groups are often considered a "basic" feature for organizing users, they have specific architectural constraints and advanced integration behaviors that are critical for senior cloud engineers to understand.

### 1. The "No Nesting" Limitation & The AWS Organizations Shift

A common mistake for those coming from Active Directory (AD) is trying to put a group inside another group (Nesting). **IAM Groups cannot be nested.** * **The Advanced Workaround:** In 2026, organizations bypass this limitation by using **IAM Identity Center (SSO)**. In Identity Center, you can sync a nested group structure from an external provider (like Okta or Google Workspace), and AWS will "flatten" that structure into Permission Sets. If you stay within "Standard IAM," you are forced to manage a flat structure, which often leads to "Group Sprawl."

### 2. Groups are Not "Principals" (The Permission Boundary Gap)

This is a high-level security distinction: **You cannot attach a Permissions Boundary to a Group.** * **The Impact:** A Permissions Boundary is a guardrail that sets the maximum possible permissions an entity can have. Because boundaries only apply to **Users** and **Roles**, a user in a "SuperAdmin" group could technically bypass certain guardrails if the boundary isn't applied to their individual user object.

* **Pro Tip:** If you want to limit a group's power globally, you shouldn't look at the Group itself. Instead, you must use a **Service Control Policy (SCP)** at the AWS Organizations level, which acts as a "super-boundary" for every user in that account, regardless of what group they belong to.

---

### **Summary Table: IAM Groups in the MLOps/Quant Context**

| Feature | Standard IAM Group | Enterprise Identity Center Group |
| --- | --- | --- |
| **Nesting** | ❌ Not Supported | ✅ Supported (via Sync) |
| **Permissions Boundary** | ❌ Not Supported | ✅ Supported (via Permission Sets) |
| **Usage** | Best for local/test accounts | Best for workforce/production |
| **Cross-Account** | ❌ Local to one account | ✅ Works across all Org accounts |
