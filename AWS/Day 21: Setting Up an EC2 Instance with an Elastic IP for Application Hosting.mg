1. Waiter-Driven Association
Never attempt to associate an Elastic IP (EIP) immediately after calling run_instances. The instance must be in a running state, or the API call will fail. Use Boto3 waiters to pause execution until the resource is ready.

Python
# Wait for the instance to be ready before associating the EIP
instance.wait_until_running()
ec2_client.associate_address(InstanceId=instance.id, AllocationId='eipalloc-xyz')
2. IAM Instance Profiles over Keys
Instead of hardcoding AWS keys or passing them via User Data, use IAM Instance Profiles. This allows your application to securely call other AWS services (like S3 or RDS) using temporary credentials automatically rotated by the SDK.

Action: Pass IamInstanceProfile={'Name': 'YourRoleName'} in your run_instances call.

3. Enforce IMDSv2
To prevent SSRF (Server-Side Request Forgery) attacks, force the use of Instance Metadata Service Version 2 (IMDSv2). This requires a session-oriented token to access instance metadata.

Config: Set MetadataOptions={'HttpTokens': 'required'}.

4. Idempotent Tagging & User Data
Use the TagSpecifications parameter directly within the run_instances call rather than a separate create_tags call. This ensures that the instance is never "born" without its identity tags, which is critical for automated billing and security auditing.

5. Termination Protection & Monitoring
For application-hosting instances that shouldn't disappear due to a script error or accidental click:

Disable Api Termination: Set DisableApiTermination=True in your launch config.

Detailed Monitoring: Enable 1-minute CloudWatch metrics (instead of the default 5-minute) by setting Monitoring={'Enabled': True} for faster scaling and incident response.
