# Ansible Batch Processing in Practice

---

## Software Overview

Ansible is an automation operations tool developed based on Python. It integrates the advantages of many operation and maintenance tools (such as Puppet, Chef, Func, Fabric), achieving functions like batch system configuration, batch program deployment, and batch command execution.

## Features

1. Easy deployment; only the Ansible environment needs to be deployed on the control end, with no actions required on the controlled end.
2. By default, it uses the SSH protocol for device management.
3. It has a large number of standard operation and maintenance modules that can handle most daily operations.
4. Simple configuration, powerful features, and strong extensibility.
5. Supports API and custom modules, which can be easily extended via Python.
6. Customizes powerful configuration and state management through Playbooks.

## Infrastructure

![image.png](../images/ansible-1.png)

- **Ansible**: The core program of Ansible.
- **HostInventory**: Records information about hosts managed by Ansible, including ports, passwords, IPs, etc.
- **Playbooks**: YAML formatted files where multiple tasks are defined in one file to specify which modules should be called to achieve certain functionalities.
- **CoreModules**: Core modules, mainly used to complete management tasks by calling these modules.
- **CustomModules**: Custom modules to achieve functionalities not covered by core modules, supporting multiple languages.
- **ConnectionPlugins**: Connection plugins used for communication between Ansible and Hosts.

## Task Execution

The Ansible system categorizes operations on managed nodes into two types: **adhoc** and **playbook**

- **Ad-hoc Mode (Point-to-point Mode)**
  Uses a single module, supporting batch execution of single commands. Ad-hoc commands are quick input commands that do not need to be saved, similar to a shell command in bash.

- **Playbook Mode (Script Mode)**
  The primary management method of Ansible and the key to its powerful capabilities. Playbooks perform a set of functionalities through multiple tasks, such as installing and deploying Web services or batch backup of database servers. Playbooks can be simply understood as configuration files that combine multiple ad-hoc operations.

## Batch Processing in Practice

### Environment Preparation

| IP        | System       | Hostname   | Description                           |
| --------- | ------------ | ---------- | ------------------------------------- |
| 10.0.0.65 | CentOS 7.8   | ansible01  | Management node (with dk installed)   |
| 10.0.0.66 | CentOS 7.8   | ansible02  | Managed node 1                        |
| 10.0.0.67 | CentOS 7.8   | ansible03  | Managed node 2                        |

### Software Installation

Log in to ansible01 and execute the installation command

```bash
yum install -y ansible
```

Main Programs

- `/usr/bin/ansible` Main program
- `/usr/bin/ansible-doc` Configuration documentation
- `/usr/bin/ansible-playbook` Tool for customizing automated tasks and orchestrating scripts
- `/usr/bin/ansible-pull` Tool for remote command execution
- `/usr/bin/ansible-vault` File encryption tool

Main Configuration Files

- `/etc/ansible/ansible.cfg` Main configuration file
- `/etc/ansible/hosts` Host inventory (place managed hosts in this file)
- `/etc/ansible/roles/` Directory for storing roles

### Password-less Login

Log in to ansible01 and generate keys, with the default path being `/root/.ssh/id_rsa`, `/root/.ssh/id_rsa.pub`

```bash
ssh-keygen
```

Distribute keys to the nodes that need to be managed

```bash
ssh-copy-id root@10.0.0.66
ssh-copy-id root@10.0.0.67
```

Modify the host inventory file `/etc/ansible/hosts` and add group names and host IPs

```bash
[guance]
10.0.0.67
10.0.0.66
```

Verify connectivity

```bash
ansible guance -m ping
```

![image.png](../images/ansible-2.png)

### Common Modules

#### Shell Module

The Shell module runs commands on remote hosts using the shell interpreter, supporting various shell features such as pipelines.

- Check the current user ID

```bash
ansible guance -m shell -a 'id'
```

![image.png](../images/ansible-3.png)

- Check users currently logged into the system

```bash
ansible guance -m shell -a 'who'
```

![image.png](../images/ansible-4.png)

#### Copy Module

This module copies files to remote hosts, supports generating files from given content, and modifying permissions.

- Copy the `ansible.cfg` file to remote hosts and set permissions to "read/write" `-rw-rw-rw-`

```bash
ansible guance -m copy -a 'src=/etc/ansible/ansible.cfg dest=/tmp/ansible.cfg mode=666'
```

![image.png](../images/ansible-5.png)

Check the `ansible.cfg` file on remote hosts

```bash
ansible guance -m shell -a 'ls -l /tmp/ansible.cfg'
```

![image.png](../images/ansible-6.png)

- Specify content and create a file

```bash
ansible guance -m copy -a 'content="hello world" dest=/tmp/hello mode=666'
```

![image.png](../images/ansible-7.png)

Check the file on remote hosts

```bash
ansible guance -m shell -a 'cat /tmp/hello'
```

![image.png](../images/ansible-8.png)

#### File Module

This module sets file attributes, such as creating files, creating symbolic links, deleting files, etc.

- Create an `app` directory under `/tmp`

```bash
ansible guance -m file -a 'path=/tmp/app state=directory'
```

![image.png](../images/ansible-9.png)

Check the `/tmp` directory

```bash
ansible guance -m shell -a 'ls -l /tmp'
```

![image.png](../images/ansible-10.png)

- Delete the `ansible.cfg` file previously copied from ansible01

```bash
ansible guance -m file -a 'path=/tmp/ansible.cfg state=absent'
```

![image.png](../images/ansible-11.png)

#### Fetch Module

This module retrieves (copies) files from remote hosts to the local machine.

- Pull the `/tmp/hello` file from remote hosts to the `/root` directory

```bash
ansible guance -m fetch -a 'src=/tmp/hello dest=/root'
```

![image.png](../images/ansible-12.png)

In the `/root` directory, you will see two new directories (the remote host IPs are the directory names)

```bash
yum -y install tree
tree /root
```

![image.png](../images/ansible-13.png)

### <<< custom_key.brand_name >>> Application

#### Batch Installation

Use the Shell module to install DataKit (note to modify the corresponding token)

```bash
ansible guance -m shell -a 'DK_DATAWAY="https://openway.guance.com?token=token" bash -c "$(curl -L https://<<< custom_key.static_domain >>>/datakit/install.sh)"'
```

Check if the process has started

```bash
ansible guance -m shell -a 'ps -ef|grep datakit|grep -v grep'
```

![image.png](../images/ansible-14.png)

#### Batch Configuration

- Enable the netstat plugin

Use the shell module to copy the `netstat.conf.sample` file to `netstat.conf`

```bash
ansible guance -m shell -a 'cp /usr/local/datakit/conf.d/host/netstat.conf.sample /usr/local/datakit/conf.d/host/netstat.conf'
```

Batch restart DataKit

```bash
ansible guance -m shell -a 'systemctl restart datakit'
```

#### Batch Upgrade

Create a DataKit upgrade YAML file, `/etc/ansible/dk_upgrade.yaml`

```bash
- hosts: guance
  remote_user: root
  tasks:
    - name: Check dk version
      shell: datakit --version|grep -i upgrade|wc -l
      register: version
    - name: Upgrade dk
      when: version.stdout > "0"
      shell: DK_UPGRADE=1 bash -c "$(curl -L https://<<< custom_key.static_domain >>>/datakit/install.sh)"
```

Run the playbook

```bash
ansible-playbook /etc/ansible/dk_upgrade.yaml
```

![image.png](../images/ansible-15.png)

Check that the DataKit version is up to date

```bash
ansible guance -m shell -a 'datakit --version'
```

![image.png](../images/ansible-16.png)

Add a cron job (`crontab -e`) to run batch upgrades at 02:02 AM every day

```bash
02 02 * * * ansible-playbook /etc/ansible/dk_upgrade.yaml
```