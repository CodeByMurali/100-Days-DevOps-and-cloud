Below are the **exact commands** to do what you described (RHEL / CentOS / Rocky / AlmaLinux–style systems).

---

### 1️⃣ Install required SELinux packages

```bash
sudo yum install -y selinux-policy selinux-policy-targeted policycoreutils
```

*(On newer systems you can replace `yum` with `dnf`)*

---

### 2️⃣ Temporarily disable SELinux (no reboot required)

```bash
sudo setenforce 0
```

> This puts SELinux into **permissive mode immediately** for the current session.

---

### 3️⃣ Permanently disable SELinux (takes effect after reboot)

```bash
sudo sed -i 's/^SELINUX=.*/SELINUX=disabled/' /etc/selinux/config
```

Verify the config file (optional):

```bash
cat /etc/selinux/config
```

Expected:

```text
SELINUX=disabled
```

---

### 4️⃣ (Optional) Confirm current runtime status

*(Can be ignored per your instruction, but useful for sanity check)*

```bash
getenforce
```

Expected **before reboot**:

```text
Permissive
```

Expected **after scheduled reboot**:

```text
Disabled
```

---