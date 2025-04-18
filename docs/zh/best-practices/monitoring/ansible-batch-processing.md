# Ansible 批处理实战

---

## 软件简介

Ansible 是一款自动化运维工具，基于 Python 开发，集合了众多运维工具（puppet、chef、func、fabric）的优点，实现了批量系统配置、批量程序部署、批量运行命令等功能。

## 功能特点

1. 部署简单，只需在主控端部署 Ansible 环境，被控端无需做任何操作
2. 默认使用 SSH 协议对设备进行管理
3. 有大量常规运维操作模块，可实现日常绝大部分操作
4. 配置简单、功能强大、扩展性强
5. 支持 API 及自定义模块，可通过 Python 轻松扩展
6. 通过 Playbooks 来定制强大的配置、状态管理

## 基础架构

![image.png](../images/ansible-1.png)

- **Ansible**：Ansible 核心程序。
- **HostInventory**：记录由 Ansible 管理的主机信息，包括端口、密码、ip 等。
- **Playbooks**：YAML 格式文件，多个任务定义在一个文件中，定义主机需要调用哪些模块来完成的功能。
- **CoreModules**：核心模块，主要操作是通过调用核心模块来完成管理任务。
- **CustomModules**：自定义模块，完成核心模块无法完成的功能，支持多种语言。
- **ConnectionPlugins**：连接插件，Ansible 和 Host 通信使用

## 任务执行

Ansible 系统由控制主机对被管节点的操作方式可分为两类，即 **adhoc** 和 **playbook**

- **ad-hoc 模式(点对点模式)**
  使用单个模块，支持批量执行单条命令。ad-hoc 命令是一种可以快速输入的命令，而且不需要保存起来的命令，就相当于 bash 中的一句 shell 命令。

- **playbook 模式 (剧本模式)**
  Ansible 主要管理方式，也是 Ansible 功能强大的关键所在。playbook 通过多个 task 集合完成一类功能，如 Web 服务的安装部署、数据库服务器的批量备份等。可以简单地把 playbook 理解为通过组合多条 ad-hoc 操作的配置文件。

## 批处理实战

### 环境准备

| IP        | 系统       | 主机名    | 描述                           |
| --------- | ---------- | --------- | ------------------------------ |
| 10.0.0.65 | CentOS 7.8 | ansible01 | ansible 管理节点 (已经安装 dk) |
| 10.0.0.66 | CentOS 7.8 | ansible02 | 被管理节点 1                   |
| 10.0.0.67 | CentOS 7.8 | ansible03 | 被管理节点 2                   |

### 软件安装

登录 ansible01，执行安装命令

```bash
yum install -y ansible
```

主要程序

- `/usr/bin/ansible` 主程序
- `/usr/bin/ansible-doc` 配置文档
- `/usr/bin/ansible-playbook` 定制自动化任务，编排剧本工具
- `/usr/bin/ansible-pull` 远程执行命令的工具
- `/usr/bin/ansible-vault` 文件加密工具

主要配置文件

- `/etc/ansible/ansible.cfg` 主配置文件
- `/etc/ansible/hosts` 主机清单(将被管理的主机放到此文件)
- `/etc/ansible/roles/` 存放角色的目录

### 免密登录

登录 ansible01，生成秘钥，默认路径为 `/root/.ssh/id_rsa、/root/.ssh/id_rsa.pub`

```bash
ssh-keygen
```

秘钥分发至需要被管理的节点

```bash
ssh-copy-id root@10.0.0.66
ssh-copy-id root@10.0.0.67
```

修改主机清单文件 `/etc/ansible/hosts` ，添加分组名称以及主机 ip

```bash
[guance]
10.0.0.67
10.0.0.66
```

验证连通性

```bash
ansible guance -m ping
```

![image.png](../images/ansible-2.png)

### 常用模块

#### Shell 模块

Shell 模块可以在远程主机上调用 shell 解释器运行命令，支持 shell 的各种功能，例如管道等

- 查看当前用户 id

```bash
ansible guance -m shell -a 'id'
```

![image.png](../images/ansible-3.png)

- 查看当前登录至系统的用户

```bash
ansible guance -m shell -a 'who'
```

![image.png](../images/ansible-4.png)

#### Copy 模块

该模块用于将文件复制到远程主机，同时支持给定内容生成文件和修改权限等

- 复制 `ansible.cfg` 文件至远程主机，并指定权限为 "读写" `-rw-rw-rw-`

```bash
ansible guance -m copy -a 'src=/etc/ansible/ansible.cfg dest=/tmp/ansible.cfg mode=666'
```

![image.png](../images/ansible-5.png)

查看远程主机 `ansible.cfg` 文件

```bash
ansible guance -m shell -a 'ls -l /tmp/ansible.cfg'
```

![image.png](../images/ansible-6.png)

- 指定内容并生成文件

```bash
ansible guance -m copy -a 'content="hello world" dest=/tmp/hello mode=666'
```

![image.png](../images/ansible-7.png)

查看远程主机文件

```bash
ansible guance -m shell -a 'cat /tmp/hello'
```

![image.png](../images/ansible-8.png)

#### File 模块

该模块用于设置文件的属性，比如创建文件、创建链接文件、删除文件等

- 在 `/tmp` 下创建 `app` 目录

```bash
ansible guance -m file -a 'path=/tmp/app state=directory'
```

![image.png](../images/ansible-9.png)

查看 `/tmp` 目录

```bash
ansible guance -m shell -a 'ls -l /tmp'
```

![image.png](../images/ansible-10.png)

- 删除之前从 ansible01 复制过来的 `ansible.cfg` 文件

```bash
ansible guance -m file -a 'path=/tmp/ansible.cfg state=absent'
```

![image.png](../images/ansible-11.png)

#### Fetch 模块

该模块用于从远程某主机获取（复制）文件到本地

- 拉取远程主机 `/tmp/hello` 文件至 `/root` 目录

```bash
ansible guance -m fetch -a 'src=/tmp/hello dest=/root'
```

![image.png](../images/ansible-12.png)

在 `/root` 目录下，可以看到两个新目录 (远程主机 ip 为目录名称)

```bash
yum -y install tree
tree /root
```

![image.png](../images/ansible-13.png)

### <<< custom_key.brand_name >>>应用

#### 批量安装

使用 Shell 模块安装 DataKit (注意修改对应的 token)

```bash
ansible guance -m shell -a 'DK_DATAWAY="https://openway.<<< custom_key.brand_main_domain >>>?token=token" bash -c "$(curl -L https://static.<<< custom_key.brand_main_domain >>>/datakit/install.sh)"'
```

查看进程是否已经启动

```bash
ansible guance -m shell -a 'ps -ef|grep datakit|grep -v grep'
```

![image.png](../images/ansible-14.png)

#### 批量配置

- 开启 netstat 插件

使用 shell 模块复制文件 `netstat.conf.sample` 为 `netstat.conf`

```bash
ansible guance -m shell -a 'cp /usr/local/datakit/conf.d/host/netstat.conf.sample /usr/local/datakit/conf.d/host/netstat.conf'
```

批量重启 DataKit

```bash
ansible guance -m shell -a 'systemctl restart datakit'
```

#### 批量升级

新建 DataKit 升级 yaml 文件，`/etc/ansible/dk_upgrade.yaml`

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

运行 playbook

```bash
ansible-playbook /etc/ansible/dk_upgrade.yaml
```

![image.png](../images/ansible-15.png)

查看 DataKit 版本已经为最新

```bash
ansible guance -m shell -a 'datakit --version'
```

![image.png](../images/ansible-16.png)

添加定时任务 crontab -e (每天 02 点 02 分执行批量升级)

```bash
02 02 * * * ansible-playbook /etc/ansible/dk_upgrade.yaml
```
