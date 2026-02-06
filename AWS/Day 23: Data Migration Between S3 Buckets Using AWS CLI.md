To migrate data between S3 buckets as part of the Nautilus DevOps team, follow these steps using the AWS CLI.

### 1. Create the New Private S3 Bucket

Use the `s3api` or `s3 mb` command to create the bucket. By default, S3 buckets are private.

```bash
# Create the bucket (defaulting to us-east-1)
aws s3 mb s3://xfusion-sync-30486

```

> **Note:** If you are in a specific region, use `--region <region-name>`.

### 2. Migrate Data (S3 to S3)

The `aws s3 sync` command is the most efficient way to transfer data because it recursively copies only new or updated files, ensuring the destination matches the source.

```bash
# Sync data from source to destination
aws s3 sync s3://xfusion-s3-2663 s3://xfusion-sync-30486

```

* **Source:** `xfusion-s3-2663`
* **Destination:** `xfusion-sync-30486`

### 3. Ensure Data Consistency

To verify that the transfer was complete and accurate, you should compare the object counts and total sizes of both buckets.

**Check Source Bucket:**

```bash
aws s3 ls s3://xfusion-s3-2663 --recursive --human-readable --summarize

```

**Check Destination Bucket:**

```bash
aws s3 ls s3://xfusion-sync-30486 --recursive --human-readable --summarize

```

---

### Summary Table of Commands

| Task | Command |
| --- | --- |
| **Create Bucket** | `aws s3 mb s3://xfusion-sync-30486` |
| **Sync Data** | `aws s3 sync s3://xfusion-s3-2663 s3://xfusion-sync-30486` |
| **Verify Sync** | `aws s3 ls s3://<bucket> --summarize --recursive` |
