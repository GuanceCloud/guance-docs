# Ansible Batch Processing in Practice

---

## Software Introduction

Ansible is an automation operations tool developed in Python. It integrates the advantages of many operations tools (puppet, chef, func, fabric), achieving functionalities such as batch system configuration, batch program deployment, and batch command execution.

## Features

1. Simple deployment; only the Ansible environment needs to be deployed on the control end, while no operation is required on the managed end.
2. Uses SSH protocol by default for device management.
3. Comes with a large number of regular operations modules that can handle most daily tasks.
4. Simple configuration, powerful functions, and highly extensible.
5. Supports APIs and custom modules, which can be easily extended through Python.
6. Customizes powerful configurations and status management via Playbooks.

## Basic Architecture

![image.png](../images/ansible-1.png)

- **Ansible**: The core program of Ansible.
- **HostInventory**: Records information about hosts managed by Ansible, including ports, passwords, IPs, etc.
- **Playbooks**: YAML format files where multiple tasks are defined in one file, specifying which modules should be called to complete the required functions.
- **CoreModules**: Core modules, primarily used to complete management tasks by calling these modules.
- **CustomModules**: Custom modules, used to achieve functions that cannot be completed by core modules, supporting various languages.
- **ConnectionPlugins**: Connection plugins used for communication between Ansible and Hosts.

## Task Execution

The Ansible system divides the operation methods of control host nodes into two types: **adhoc** and **playbook**.

- **ad-hoc mode (point-to-point mode)**
  Uses a single module and supports batch execution of single commands. Ad-hoc commands are quick-to-enter commands that do not need to be saved, similar to a shell command in bash.

- **playbook mode (script mode)**
  The main management method of Ansible and the key to its powerful functionality. Playbooks accomplish a set of functions through a collection of multiple tasks, such as installing and deploying Web services or performing bulk backups of database servers. Playbooks can simply be understood as configuration files that combine multiple ad-hoc operations.

## Batch Processing in Practice

### Environment Preparation

| IP        | System       | Hostname    | Description                           |
| --------- | ---------- | --------- | ------------------------------ |
| 10.0.0.65 | CentOS 7.8 | ansible01 | Ansible management node (already installed dk) |
| 10.0.0.66 | CentOS 7.8 | ansible02 | Managed node 1                   |
| 10.0.0.67 | CentOS 7.8 | ansible03 | Managed node 2                   |

### Software Installation

Log in to ansible01 and execute the installation command

```bash
yum install -y ansible
```

Main Programs:

- `/usr/bin/ansible` Main Program
- `/usr/bin/ansible-doc` Configuration Documentation
- `/usr/bin/ansible-playbook` Customizes automated tasks, orchestration script tool
- `/usr/bin/ansible-pull` Remote command execution tool
- `/usr/bin/ansible-vault` File encryption tool

Main Configuration Files:

- `/etc/ansible/ansible.cfg` Main Configuration File
- `/etc/ansible/hosts` Host List (place managed hosts here)
- `/etc/ansible/roles/` Directory for storing roles

### Passwordless Login

Log in to ansible01 and generate a key, default path is `/root/.ssh/id_rsa, /root/.ssh/id_rsa.pub`

```bash
ssh-keygen
```

Distribute the key to the nodes that need to be managed

```bash
ssh-copy-id root@10.0.0.66
ssh-copy-id root@10.0.0.67
```

Modify the host list file `/etc/ansible/hosts`, add group name and host IPs

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

The Shell module can invoke the shell interpreter on remote hosts to run commands, supporting various shell features like pipes.

- View current user id

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

This module copies files to remote hosts and also supports generating files from given content and modifying permissions.

- Copy `ansible.cfg` file to remote host and specify permission as "read-write" `-rw-rw-rw-`

```bash
ansible guance -m copy -a 'src=/etc/ansible/ansible.cfg dest=/tmp/ansible.cfg mode=666'
```

![image.png](../images/ansible-5.png)

View `ansible.cfg` file on remote host

```bash
ansible guance -m shell -a 'ls -l /tmp/ansible.cfg'
```

![image.png](../images/ansible-6.png)

- Specify content and generate a file

```bash
ansible guance -m copy -a 'content="hello world" dest=/tmp/hello mode=666'
```

![image.png](../images/ansible-7.png)

View file on remote host

```bash
ansible guance -m shell -a 'cat /tmp/hello'
```

![image.png](../images/ansible-8.png)

#### File Module

This module sets file attributes, such as creating files, creating link files, deleting files, etc.

- Create `app` directory under `/tmp`

```bash
ansible guance -m file -a 'path=/tmp/app state=directory'
```

![image.png](../images/ansible-9.png)

View `/tmp` directory

```bash
ansible guance -m shell -a 'ls -l /tmp'
```

![image.png](../images/ansible-10.png)

- Delete `ansible.cfg` file previously copied from ansible01

```bash
ansible guance -m file -a 'path=/tmp/ansible.cfg state=absent'
```

![image.png](../images/ansible-11.png)

#### Fetch Module

This module retrieves (copies) files from remote hosts to the local machine.

- Pull `/tmp/hello` file from remote host to `/root` directory

```bash
ansible guance -m fetch -a 'src=/tmp/hello dest=/root'
```

![image.png](../images/ansible-12.png)

In `/root` directory, you can see two new directories (remote host IPs are used as directory names)

```bash
yum -y install tree
tree /root
```

![image.png](../images/ansible-13.png)

### <<< custom_key.brand_name >>> Application

#### Bulk Installation

Use Shell module to install DataKit (note to modify the corresponding token)

```bash
ansible guance -m shell -a 'DK_DATAWAY="https://openway.<<< custom_key.brand_main_domain >>>?token=token" bash -c "$(curl -L https://static.<<< custom_key.brand_main_domain >>>/datakit/install.sh)"'
```

Check if the process has started

```bash
ansible guance -m shell -a 'ps -ef|grep datakit|grep -v grep'
```

![image.png](../images/ansible-14.png)

#### Bulk Configuration

- Enable netstat plugin

Use shell module to copy file `netstat.conf.sample` as `netstat.conf`

```bash
ansible guance -m shell -a 'cp /usr/local/datakit/conf.d/host/netstat.conf.sample /usr/local/datakit/conf.d/host/netstat.conf'
```

Bulk restart DataKit

```bash
ansible guance -m shell -a 'systemctl restart datakit'
```

#### Bulk Upgrade

Create a DataKit upgrade yaml file, `/etc/ansible/dk_upgrade.yaml`

```bash
- hosts: guance
  remote_user: root
  tasks:
    - name: dk version check
      shell: datakit --version|grep -i upgrade|wc -l
      register: version
    - name: dk upgrade
      when: version.stdout > "0"
      shell: DK_UPGRADE=1 bash -c "$(curl -L https://static.<<< custom_key.brand_main_domain >>>/datakit/install.sh)"
```

Run playbook

```bash
ansible-playbook /etc/ansible/dk_upgrade.yaml
```

![image.png](../images/ansible-15.png)

Check if DataKit version is updated

```bash
ansible guance -m shell -a 'datakit --version'
```

![image.png](../images/ansible-16.png)

Add scheduled task crontab -e (execute bulk upgrade at 02:02 AM every day)

```bash
02 02 * * * ansible-playbook /etc/ansible/dk_upgrade.yaml
```