# Ansible Batch Processing Practical Guide

---

## Software Overview

Ansible is an automation operations tool developed in Python. It integrates the advantages of many operations tools (such as puppet, chef, func, fabric) and achieves functions like batch system configuration, batch program deployment, and batch command execution.

## Features

1. Easy deployment, requiring only the deployment of the Ansible environment on the control node; no action is needed on the managed nodes.
2. Uses SSH protocol by default to manage devices.
3. Offers numerous standard operation modules that can handle most daily tasks.
4. Simple configuration, powerful functionality, and high extensibility.
5. Supports APIs and custom modules, which can be easily extended using Python.
6. Customizes powerful configuration and state management through Playbooks.

## Infrastructure

![image.png](../images/ansible-1.png)

- **Ansible**: Core program of Ansible.
- **HostInventory**: Records information about hosts managed by Ansible, including ports, passwords, IPs, etc.
- **Playbooks**: YAML format files where multiple tasks are defined in one file, specifying which modules the host needs to call to complete certain functions.
- **CoreModules**: Core modules primarily used for executing management tasks.
- **CustomModules**: Custom modules for completing tasks that core modules cannot handle, supporting multiple languages.
- **ConnectionPlugins**: Connection plugins used for communication between Ansible and hosts.

## Task Execution

Ansible systems can operate on managed nodes in two ways: **adhoc** and **playbook**

- **Ad-hoc Mode (Point-to-point mode)**
  Uses a single module to support batch execution of single commands. Ad-hoc commands are quick one-off commands that do not need to be saved, similar to a shell command in bash.

- **Playbook Mode (Script mode)**
  The main management method of Ansible and the key to its powerful features. Playbooks achieve specific functionalities by combining multiple tasks, such as installing web services or performing batch backups of database servers. Playbooks can be thought of as configuration files that combine multiple ad-hoc operations.

## Batch Processing Practical Guide

### Environment Preparation

| IP        | System       | Hostname   | Description                           |
| --------- | ------------ | ---------- | ------------------------------------- |
| 10.0.0.65 | CentOS 7.8   | ansible01  | Management node (with dk installed)   |
| 10.0.0.66 | CentOS 7.8   | ansible02  | Managed node 1                        |
| 10.0.0.67 | CentOS 7.8   | ansible03  | Managed node 2                        |

### Software Installation

Log into ansible01 and execute the installation command:

```bash
yum install -y ansible
```

Main programs:

- `/usr/bin/ansible`: Main program
- `/usr/bin/ansible-doc`: Configuration documentation
- `/usr/bin/ansible-playbook`: Customizes automated tasks and orchestrates playbooks
- `/usr/bin/ansible-pull`: Tool for remote command execution
- `/usr/bin/ansible-vault`: File encryption tool

Main configuration files:

- `/etc/ansible/ansible.cfg`: Main configuration file
- `/etc/ansible/hosts`: Host inventory (add managed hosts here)
- `/etc/ansible/roles/`: Directory for storing roles

### Password-less Login

Log into ansible01 and generate keys, with the default path being `/root/.ssh/id_rsa` and `/root/.ssh/id_rsa.pub`

```bash
ssh-keygen
```

Distribute keys to the nodes to be managed:

```bash
ssh-copy-id root@10.0.0.66
ssh-copy-id root@10.0.0.67
```

Modify the host inventory file `/etc/ansible/hosts`, adding group names and host IPs:

```bash
[guance]
10.0.0.67
10.0.0.66
```

Verify connectivity:

```bash
ansible guance -m ping
```

![image.png](../images/ansible-2.png)

### Common Modules

#### Shell Module

The Shell module runs commands on remote hosts via the shell interpreter, supporting various shell features such as pipes.

- View current user ID

```bash
ansible guance -m shell -a 'id'
```

![image.png](../images/ansible-3.png)

- View users currently logged into the system

```bash
ansible guance -m shell -a 'who'
```

![image.png](../images/ansible-4.png)

#### Copy Module

This module copies files to remote hosts and supports generating files from given content and modifying permissions.

- Copy `ansible.cfg` file to remote hosts with permission set to "read-write" `-rw-rw-rw-`

```bash
ansible guance -m copy -a 'src=/etc/ansible/ansible.cfg dest=/tmp/ansible.cfg mode=666'
```

![image.png](../images/ansible-5.png)

Check the `ansible.cfg` file on the remote host:

```bash
ansible guance -m shell -a 'ls -l /tmp/ansible.cfg'
```

![image.png](../images/ansible-6.png)

- Generate a file with specified content

```bash
ansible guance -m copy -a 'content="hello world" dest=/tmp/hello mode=666'
```

![image.png](../images/ansible-7.png)

Check the file on the remote host:

```bash
ansible guance -m shell -a 'cat /tmp/hello'
```

![image.png](../images/ansible-8.png)

#### File Module

This module sets file attributes, such as creating files, creating symbolic links, and deleting files.

- Create an `app` directory under `/tmp`

```bash
ansible guance -m file -a 'path=/tmp/app state=directory'
```

![image.png](../images/ansible-9.png)

Check the `/tmp` directory:

```bash
ansible guance -m shell -a 'ls -l /tmp'
```

![image.png](../images/ansible-10.png)

- Delete the previously copied `ansible.cfg` file from ansible01

```bash
ansible guance -m file -a 'path=/tmp/ansible.cfg state=absent'
```

![image.png](../images/ansible-11.png)

#### Fetch Module

This module retrieves (copies) files from remote hosts to the local machine.

- Fetch the `/tmp/hello` file from remote hosts to the `/root` directory

```bash
ansible guance -m fetch -a 'src=/tmp/hello dest=/root'
```

![image.png](../images/ansible-12.png)

In the `/root` directory, you will see two new directories (named after the remote host IPs):

```bash
yum -y install tree
tree /root
```

![image.png](../images/ansible-13.png)

### Guance Application

#### Batch Installation

Use the Shell module to install DataKit (note to modify the corresponding token):

```bash
ansible guance -m shell -a 'DK_DATAWAY="https://openway.guance.com?token=token" bash -c "$(curl -L https://static.guance.com/datakit/install.sh)"'
```

Check if the process has started:

```bash
ansible guance -m shell -a 'ps -ef|grep datakit|grep -v grep'
```

![image.png](../images/ansible-14.png)

#### Batch Configuration

- Enable the netstat plugin

Use the shell module to copy `netstat.conf.sample` to `netstat.conf`

```bash
ansible guance -m shell -a 'cp /usr/local/datakit/conf.d/host/netstat.conf.sample /usr/local/datakit/conf.d/host/netstat.conf'
```

Batch restart DataKit:

```bash
ansible guance -m shell -a 'systemctl restart datakit'
```

#### Batch Upgrade

Create a DataKit upgrade YAML file, `/etc/ansible/dk_upgrade.yaml`:

```yaml
- hosts: guance
  remote_user: root
  tasks:
    - name: Check DataKit version
      shell: datakit --version|grep -i upgrade|wc -l
      register: version
    - name: Upgrade DataKit
      when: version.stdout > "0"
      shell: DK_UPGRADE=1 bash -c "$(curl -L https://static.guance.com/datakit/install.sh)"
```

Run the playbook:

```bash
ansible-playbook /etc/ansible/dk_upgrade.yaml
```

![image.png](../images/ansible-15.png)

Check the DataKit version to ensure it is up-to-date:

```bash
ansible guance -m shell -a 'datakit --version'
```

![image.png](../images/ansible-16.png)

Add a cron job (`crontab -e`) to perform batch upgrades daily at 02:02 AM:

```bash
02 02 * * * ansible-playbook /etc/ansible/dk_upgrade.yaml
```