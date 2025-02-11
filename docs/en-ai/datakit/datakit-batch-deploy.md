# Bulk Deployment
---

We can use Ansible to install DataKit in bulk.

## Prerequisites {#requirements}

- Install Ansible on the management machine.
- Configure the `host` file and `install.yaml` file under the default Ansible configuration path `/etc/ansible/`.
- If managing Windows machines via Ansible, refer to the [Ansible documentation](https://ansible-tran.readthedocs.io/en/latest/docs/intro_windows.html#windows-installing){:target="_blank"} for the necessary prerequisites.

## Configuration {#config}

Example configuration for the Ansible `host` file:

```toml
[linux]
# ansible_become_pass is the password for privilege escalation. By default, it is not specified (root). You can specify it using become_user (refer to the official documentation).
10.200.6.58    ansible_ssh_user=xxx   ansible_ssh_pass=xxx   ansible_become_pass=xxx
10.100.64.117  ansible_ssh_user=xxx   ansible_ssh_pass=xxx   ansible_become_pass=xxx

[windows]
# ansible_connection uses winrm for connection (refer to the official documentation).
10.100.65.17 ansible_ssh_user="xxx" ansible_ssh_pass="xxx" ansible_ssh_port=5986 ansible_connection="winrm" ansible_winrm_server_cert_validation=ignore
```

Example configuration for the Ansible `install.yaml` file:

```yaml
- hosts: linux # Corresponds to the Linux machines in the host configuration file.
  become: true
  gather_facts: no
  tasks:
  - name: install
    # The shell command here performs a bulk installation by specifying the DataWay address, enabling default host collectors (cpu, disk, mem), and setting -global-tags host=__datakit_hostname.
    shell: DK_DATAWAY=https://openway.guance.com?token=<TOKEN> bash -c "$(curl -L https://static.guance.com/datakit/install.sh)"
    async: 120  # This represents the upper limit of execution time for this task. If the task exceeds this time, it is considered failed. If not set, it runs synchronously. poll: 10 # Represents the polling interval for asynchronous task execution. If poll is 0, the result is not cared about.

- hosts: windows # Corresponds to the Windows machines in the host configuration file.
  gather_facts: no
  tasks:
  - name: install
    win_shell: Remove-Item -ErrorAction SilentlyContinue Env:DK_*; $env:DK_DATAWAY="https://openway.guance.com?token=<TOKEN>"; Set-ExecutionPolicy Bypass -scope Process -Force; Import-Module bitstransfer; start-bitstransfer  -source https://static.guance.com/datakit/install.ps1 -destination .install.ps1; powershell ./.install.ps1;
    async: 120
    poll: 10
```

## Deployment {#deploy}

Run the following command on the management machine to achieve bulk deployment:

```shell
ansible-playbook -i hosts install.yaml
```