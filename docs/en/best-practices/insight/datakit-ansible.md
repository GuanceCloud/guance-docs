# Best Practices for Bulk Deployment of DataKit

---

## Environment Information

| Name    | Environment                                     |
| ------- | ----------------------------------------------- |
| Centos  | 7.6                                             |
| Ansible | 2.10.4                                          |
| Host IP | 10.200.14.56; 10.200.14.57; 10.200.14.63        |

**Note: Only supports Linux hosts**

## Deploy Ansible

### Install Ansible

Log in to the server 10.200.14.56 and execute the installation command
```
yum -y install ansible
```

### Configure Ansible

Edit the Ansible hosts file 
```
vim /etc/ansible/hosts
```

Add the list of hosts and user/password

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

| 10.200.14.57 &#124; SUCCESS => { "ansible_facts": { "discovered_interpreter_python": "/usr/bin/python" }, "changed": false, "ping": "pong" } <br />10.200.14.56 &#124; SUCCESS => { "ansible_facts": { "discovered_interpreter_python": "/usr/bin/python" }, "changed": false, "ping": "pong" } <br />10.200.14.63 &#124; SUCCESS => { "ansible_facts": { "discovered_interpreter_python": "/usr/bin/python" }, "changed": false, "ping": "pong" } |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |

## Bulk Deployment

### Configure PlayBook

#### Get Command

Click on the [**Integration**] module, top right corner [_Quickly Get DataKit Installation Command_], choose the appropriate [_Datakit Installation Command_] based on your operating system and system type.

![image.png](../images/datakit-ansible-1.png)

#### Create YAML File

Enter the Ansible directory

```
cd /etc/ansible
```

Create a new file

```
vim datakit-install.yaml
```

Add the following content (copy the previous _[Datakit Installation Command]_)

```
- hosts: all
  remote_user: root
  tasks:
   - name: judge datakit is exits
     shell: ls /usr/local/datakit/conf.d
     ignore_errors: True
     register: result
   - name: install datakit
     shell: [Datakit Installation Command]
     when: result.rc != 0

```
#### Execute YAML File

*** Requires server access to the public network ***

```
ansible-playbook datakit-install.yaml
```

| PLAY [all] ************************************************************************ ************************************************************************ ************************************************************************ ******************************************* <br />TASK [Gathering Facts] ************************************************************************ ************************************************************************ ************************************************************************ ******************************* <br />ok: [10.200.14.57] <br />ok: [10.200.14.56] <br />ok: [10.200.14.63] <br />PLAY RECAP ************************************************************************ ************************************************************************ ************************************************************************ ******************************************* <br />10.200.14.56 : ok=2 changed=1 unreachable=0 failed=0 skipped=1 rescued=0 ignored=0 <br />10.200.14.57 : ok=3 changed=2 unreachable=0 failed=0 skipped=0 rescued=0 ignored=1 <br />10.200.14.63 : ok=3 changed=2 unreachable=0 failed=0 skipped=0 rescued=0 ignored=1 |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |

#### Verify Information

Click on the [**Infrastructure**] module, [_Hosts_] to view the list of all hosts that have installed DataKit along with basic information.
![image.png](../images/datakit-ansible-2.png)

## Bulk Upgrade

#### Create YAML File

Enter the Ansible directory

```
cd /etc/ansible
```

Create a new file
```
vim datakit-upgrade.yaml
```

Add the following content
```
- hosts: all
  remote_user: root
  tasks:
   - name: judge datakit is exits
     shell: ls /usr/local/datakit/conf.d
     ignore_errors: True
     register: result
   - name: install datakit
     shell: sudo -- sh -c "curl https://static.<<< custom_key.brand_main_domain >>>/datakit/installer-linux-amd64 -o dk-installer && chmod +x ./dk-installer && ./dk-installer -upgrade && rm -rf ./dk installer"
     when: result.rc == 0
```

#### Execute YAML File

```
ansible-playbook datakit-upgrade.yaml
```

#### Verify Information

Click on the [**Infrastructure**] module, use quick filter conditions to select the latest [_DataKit Version_]

![image.png](../images/datakit-ansible-3.png)

## Bulk Synchronization

#### Create YAML File

Enter the Ansible directory

```
cd /etc/ansible
```

Create a new file

```
vim datakit-config-upgrade.yaml
```

Add the following content

```
- hosts: all
  remote_user: root
  tasks:
   - name: judge datakit is exit
     shell: ls /usr/local/datakit/conf.d
     ignore_errors: True
     register: result
   - name: judge /usr/bin/rsync is exits
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
   - name: reload datakit
     shell: systemctl restart datakit
     when: res.changed == true
```

#### Execute YAML File

```
ansible-playbook datakit-config-upgrade.yaml
```

#### Verify Information

All hosts will apply the same DataKit configuration (conf.d directory). If encountering customized server configurations, you can use the DataKit whitelist feature.