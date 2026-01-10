AWS S3 bucket versioning is often misunderstood as a simple "backup" feature, but its mechanics are quite complex. Here are 5 advanced points:

### 1. The "Null" Version ID

When you enable versioning for the first time on an existing bucket, objects already in the bucket do **not** retroactively get a unique version ID. Instead, their version ID is set to `null`.

* If you overwrite an object that has a `null` ID, the new version gets a unique ID, but the old one remains as the `null` version.
* If you **suspend** versioning, new uploads will simply overwrite any existing `null` version.

### 2. Delete Markers and "404 Not Found"

When you delete an object in a versioned bucket without specifying a version ID, AWS does not delete the data. Instead, it inserts a **Delete Marker**.

* **Behavior:** A GET request for that object will return a `404 Not Found` even though the data is still there.
* **Undeleting:** To "undelete" the file, you simply delete the Delete Marker itself.

### 3. MFA Delete (CLI Only)

For high-security environments, you can enable **MFA Delete**. This prevents anyone (even the root user) from permanently deleting an object version or changing the versioning state of the bucket without providing a physical MFA code.

* **Crucial Detail:** This feature **cannot** be enabled via the AWS Management Console; it must be configured using the AWS CLI or API.

---

### 4. Lifecycle Management Complexity

Lifecycle rules behave differently with versioning. You can set separate actions for the **Current Version** and **Noncurrent Versions**.

* **Transitioning:** You can move older versions to cheaper storage (like S3 Glacier) while keeping the current version in S3 Standard.
* **Expired Delete Markers:** If a delete marker is the only version of an object left, it is called an "Expired Object Delete Marker." You can set a specific lifecycle rule to clean these up to keep your bucket organized.

### 5. Storage Cost Multiplier

Every single version of an object costs money as if it were a standalone file.

* If you have a 1GB file and you update its metadata 10 times, you are now paying for **10GB of storage**, even if the file content never changed.
* Without a **NoncurrentVersionExpiration** lifecycle policy, these costs can grow exponentially without being visible in the standard file list.
