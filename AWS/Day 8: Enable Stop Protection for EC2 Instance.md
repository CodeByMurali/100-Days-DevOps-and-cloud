1. **Accidental Prevention:** Blocks Console or API "fat-finger" errors from stopping or deleting production workloads.
2. **Boto3 Control:** In version 1.38.36, toggle these using `modify_instance_attribute` with `DisableApiTermination` or `DisableApiStop`.
3. **ASG/Spot Limitation:** These flags **do not** prevent Auto Scaling Groups or Spot interruptions from terminating instances.
4. **Data Persistence:** Safeguards EBS volumes from being deleted if `DeleteOnTermination` is set to true.
5. **IAM Security:** Even if enabled, a user with `ec2:ModifyInstanceAttribute` permissions can disable the protection and then terminate.