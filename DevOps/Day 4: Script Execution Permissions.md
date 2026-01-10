To grant executable permissions to all users on **App Server 3**, log in and run:

```bash
sudo chmod +x /tmp/xfusioncorp.sh

```

### Verification

Check the permissions with:

```bash
ls -l /tmp/xfusioncorp.sh

```

The output should start with `-rwxr-xr-x`.

---

**Next Step:** Would you like a Python snippet using **Boto3** and **SSM** to apply this permission change across all your servers simultaneously?


| Value | Binary | Description                          |
|-------|--------|--------------------------------------|
| 0     | 000    | No permissions (---)                 |
| 1     | 001    | Execute only (--x)                  |
| 2     | 010    | Write only (-w-)                    |
| 3     | 011    | Write and Execute (-wx)             |
| 4     | 100    | Read only (r--)                     |
| 5     | 101    | Read and Execute (r-x)              |
| 6     | 110    | Read and Write (rw-)                |
| 7     | 111    | Read, Write, and Execute (rwx)      |



| Mode | User | Group | Others | Common Use Case                     |
|------|------|-------|--------|-------------------------------------|
| 777  | rwx  | rwx   | rwx    | Fully public (⚠️ Security risk)     |
| 755  | rwx  | r-x   | r-x    | Public scripts / programs           |
| 644  | rw-  | r--   | r--    | Standard text files                 |
| 600  | rw-  | ---   | ---    | Private keys (SSH)                  |
