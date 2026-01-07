# Day 1 — Linux user setup with non-interactive shell

This document shows how to create a user with a non-interactive shell on App Server 1. Setting the shell to a "no-login" shell ensures the account exists for system tasks but cannot start an interactive session.

## Prerequisites
- SSH access to App Server 1 (stapp01)
- A user with sudo privileges

## Steps

### 1. Connect to App Server 1
Open your terminal and SSH into the server:

```bash
ssh <your_user>@stapp01
sudo useradd -s /sbin/nologin kareem
grep kareem /etc/passwd
```


