# Best Practices for Bulk Deployment of DataKit

---

## Environment Information

| Name    | Environment                                     |
| ------- | ----------------------------------------------- |
| Centos  | 7.6                                            |
| Ansible | 2.10.4                                         |
| Host IPs | 10.200.14.56; 10.200.14.57; 10.200.14.63       |

**Note: Only supports Linux hosts**

## Deploying Ansible

### Installing Ansible

Log in to the server at 10.200.14.56 and execute the installation command:
```
yum -y install ansible
```

### Configuring Ansible

Edit the Ansible `hosts` file:
```
vim /etc/ansible/hosts
```

Add the list of hosts along with the user/password:

```
[all]
10.200.14.56 ansible_ssh_user=root ansible_ssh_pass=xxx 
10.200.14.57 ansible_ssh_user=root ansible_ssh_pass=xxx 
10.200.14.63 ansible_ssh_user=root ansible_ssh_pass=xxx 
```

#### Disable Connection Prompt

```
sed -i '/host_key_checking/c\host_key_checking = False' /etc/ansible/ansible.cfg
```

#### Verify Configuration

```
ansible all -m ping
```

| 10.200.14.57 \| SUCCESS => { "ansible_facts": { "discovered_interpreter_python": "/usr/bin/python" }, "changed": false, "ping": "pong" } <br />10.200.14.56 \| SUCCESS => { "ansible_facts": { "discovered_interpreter_python": "/usr/bin/python" }, "changed": false, "ping": "pong" } <br />10.200.14.63 \| SUCCESS => { "ansible_facts": { "discovered_interpreter_python": "/usr/bin/python" }, "changed": false, "ping": "pong" } |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |

## Bulk Deployment

### Configure Playbook

#### Get Command

Click on the [**Integration**] module, top-right corner [_Quickly get DataKit installation command_], choose the appropriate [_DataKit installation command_] based on your operating system and type.

![image.png](../images/datakit-ansible-1.png)

#### Create YAML File

Navigate to the Ansible directory:

```
cd /etc/ansible
```

Create a new file:

```
vim datakit-install.yaml
```

Add the following content (copy the previous _[DataKit installation command]_):

```yaml
- hosts: all
  remote_user: root
  tasks:
   - name: judge DataKit exists
     shell: ls /usr/local/datakit/conf.d
     ignore_errors: True
     register: result
   - name: install DataKit
     shell: [DataKit installation command]
     when: result.rc != 0
```

#### Execute YAML File

*** Ensure the server can access the public network ***

```
ansible-playbook datakit-install.yaml
```

| PLAY [all] ************************************************************************ ************************************************************************ ************************************************************************ ******************************************* <br />TASK [Gathering Facts] ************************************************************************ ************************************************************************ ************************************************************************ ******************************* <br />ok: [10.200.14.57] <br />ok: [10.200.14.56] <br />ok: [10.200.14.63] <br />PLAY RECAP ************************************************************************ ************************************************************************ ************************************************************************ ******************************************* <br />10.200.14.56 : ok=2 changed=1 unreachable=0 failed=0 skipped=1 rescued=0 ignored=0 <br />10.200.14.57 : ok=3 changed=2 unreachable=0 failed=0 skipped=0 rescued=0 ignored=1 <br />10.200.14.63 : ok=3 changed=2 unreachable=0 failed=0 skipped=0 rescued=0 ignored=1 |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |

#### Verify Information

Click on the [**Infrastructure**] module, [_Hosts_] to view the list of all hosts with installed DataKit and basic information.
![image.png](../images/datakit-ansible-2.png)

## Bulk Upgrade

#### Create YAML File

Navigate to the Ansible directory:

```
cd /etc/ansible
```

Create a new file:
```
vim datakit-upgrade.yaml
```

Add the following content:
```yaml
- hosts: all
  remote_user: root
  tasks:
   - name: judge DataKit exists
     shell: ls /usr/local/datakit/conf.d
     ignore_errors: True
     register: result
   - name: upgrade DataKit
     shell: sudo -- sh -c "curl https://static.guance.com/datakit/installer-linux-amd64 -o dk-installer && chmod +x ./dk-installer && ./dk-installer -upgrade && rm -rf ./dk installer"
     when: result.rc == 0
```

#### Execute YAML File

```
ansible-playbook datakit-upgrade.yaml
```

#### Verify Information

Click on the [**Infrastructure**] module, use quick filter conditions to select the latest [_DataKit version_]

![image.png](../images/datakit-ansible-3.png)

## Bulk Synchronization

#### Create YAML File

Navigate to the Ansible directory:

```
cd /etc/ansible
```

Create a new file:

```
vim datakit-config-upgrade.yaml
```

Add the following content:

```yaml
- hosts: all
  remote_user: root
  tasks:
   - name: judge DataKit exists
     shell: ls /usr/local/datakit/conf.d
     ignore_errors: True
     register: result
   - name: judge /usr/bin/rsync exists
     shell: ls /usr/bin/rsync
     ignore_errors: True
     register: result
   - name: install rsync
     shell: yum -y install rsync
     when: result.rc != 0
   - name: Synchronize passing in extra rsync options
     synchronize:
       src: /usr/local/datakit/conf.d/
       dest: /usr/local/datakit/conf.d/
       rsync_opts:
        - "--exclude=datakit.conf"
       checksum: true
     register: res
   - debug: var=res.stdout_lines
   - debug: var=res.changed
   - name: reload DataKit
     shell: systemctl restart datakit
     when: res.changed == true
```

#### Execute YAML File

```
ansible-playbook datakit-config-upgrade.yaml
```

#### Verify Information

All hosts will apply the same DataKit configuration (conf.d directory). If encountering customized server configurations, you can use the DataKit whitelist feature.