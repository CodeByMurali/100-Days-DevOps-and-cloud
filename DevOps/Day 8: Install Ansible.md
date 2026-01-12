To install Ansible version 4.9.0 globally on the jump host, run:

```bash
sudo pip3 install ansible==4.9.0

```

### Verification

Verify that the binary is available globally:

```bash
ansible --version

```

If the `ansible` command is not found after installation, you may need to ensure `/usr/local/bin` is in the system's global `PATH` or update the `secure_path` in `/etc/sudoers`.