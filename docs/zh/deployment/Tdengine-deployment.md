# TDengine 高可用部署

## 1. 简介

TDengine 是一款高性能、分布式、支持 SQL 的时序数据库 (Database)，其核心代码，包括集群功能全部开源（开源协议，AGPL v3.0）。TDengine 能被广泛运用于物联网、工业互联网、车联网、IT 运维、金融等领域。除核心的时序数据库 (Database) 功能外，TDengine 还提供缓存、数据订阅、流式计算等大数据平台所需要的系列功能，最大程度减少研发和运维的复杂度。

## 2. 前提条件

- 已部署 Kubernetes 集群
- 已部署 OpenEBS 存储插件驱动

```shell
root@k8s-node01 ]# kubectl  get pods -n kube-system|grep openebs
openebs-localpv-provisioner-6b56b5567c-k5r9l   1/1     Running   0          23h
openebs-ndm-jqxtr                              1/1     Running   0          23h
openebs-ndm-operator-5df6ffc98-cplgp           1/1     Running   0          23h
openebs-ndm-qtjxm                              1/1     Running   0          23h
openebs-ndm-vlcrv                              1/1     Running   0          23h
```



## 3. 安装准备

由于 TDengine 比较吃资源需要独占集群资源，我们需要提前配置集群调度。



## 4. 集群标签设置

执行命令标记集群

```shell
# 根据集群规划，将需要部署TDengine服务k8s节点打上标签 建议使用三台节点
# xxx 代表实际集群中的节点，多个节点用空格分开
kubectl label nodes xxx tdengine=true
```

检测标记

```shell
kubectl get nodes --show-labels  | grep 'tdengine'
```



## 5. 集群污点设置

执行命令设置集群污点
执行命令设置集群污点
???+ Tips "小贴士"
    若未规划TDengine服务运行独立节点，不需要对节点打污点，该步可以忽略。

    ```shell
    kubectl taint node  xxxx infrastructure=middleware:NoExecute
    ```



## 6. 配置 StorageClass 

配置 TDengine 专用存储类

```yaml
# 将下列yaml内容复制到k8s集群保存为sc-td.yaml 按照实际情况修改后部署
apiVersion: storage.k8s.io/v1
allowVolumeExpansion: true
kind: StorageClass
metadata:
  annotations:
    cas.openebs.io/config: |
      - name: StorageType
        value: "hostpath"
      - name: BasePath
        value: "/data/tdengine"  # 该路劲可以根据实际情况修改，请确保存储空间足够 确保路径存在
  name: openebs-tdengine   # 名字集群内唯一，需要执行安装前同步修改部署文件/etc/kubeasz/guance/infrastructure/yaml/taos.yaml 
provisioner: openebs.io/local
reclaimPolicy: Retain
volumeBindingMode: WaitForFirstConsumer
```

> `/data/tdengine` 目录请确保磁盘容量足够。

配置存储空间大小

```shell
volumeClaimTemplates:
  - metadata:
      name: taos-tdengine-taosdata
    spec:
      accessModes:
        - "ReadWriteOnce"
      storageClassName: "openebs-tdengine"
      resources:
        requests:
          storage: "50Gi"  ## 分配数据存空间 按照实际需要设置
  - metadata:
      name: taos-tdengine-taoslog
    spec:
      accessModes:
        - "ReadWriteOnce"
      storageClassName: "openebs-tdengine"
      resources:
        requests:
          storage: "1Gi"  ## 分配日志存储空间 按照实际需要设置
```



## 7. 安装

```shell
# 创建命名空间
kubectl  create  ns middleware
# 部署tdengine服务
kubectl  apply  -f /etc/kubeasz/guance/infrastructure/yaml/taos.yaml  -n middleware
```



## 8. 验证部署及配置

### 8.1  查看容器状态

```shell
[root@ecs-788c ~]# kubectl  get pods -n middleware  |grep  taos
taos-tdengine-0                                             1/1     Running   0          5m32s
taos-tdengine-arbitrator-5bfd76b7bd-8jtmd                   1/1     Running   0          5m32s
```



### 8.2 验证服务
???+ success "验证TDengine服务可用性"

    ```shell
    # 安装成功后使用如下命令进行登录验证
    

    [root@ecs-788c ~]# kubectl  exec -it -n middleware taos-tdengine-0  -- taos

    Welcome to the TDengine shell from Linux, Client Version:2.6.0.18
    Copyright (c) 2022 by TAOS Data, Inc. All rights reserved.

      *********************  How to Use TAB in TAOS Shell ******************************
      *   Taos shell supports pressing TAB key to complete word. You can try it.       *
      *   Press TAB key anywhere, You'll get surprise.                                 *
      *   KEYBOARD SHORTCUT:                                                           *
      *    [ TAB ]        ......  Complete the word or show help if no input           *
      *    [ Ctrl + A ]   ......  move cursor to [A]head of line                       *
      *    [ Ctrl + E ]   ......  move cursor to [E]nd of line                         *
      *    [ Ctrl + W ]   ......  move cursor to line of middle                        *
      *    [ Ctrl + L ]   ......  clean screen                                         *
      *    [ Ctrl + K ]   ......  clean after cursor                                   *
      *    [ Ctrl + U ]   ......  clean before cursor                                  *
      *                                                                                *
      **********************************************************************************

    taos> show mnodes;
      id   |           end_point            |     role     |        role_time        |       create_time       |
    =============================================================================================================
          1 | taos-tdengine-0.taos-tdengi... | leader       | 2022-11-03 08:52:13.219 | 2022-11-03 08:52:13.219 |
    Query OK, 1 row(s) in set (0.000748s)

    taos> show dnodes;
      id   |           end_point            | vnodes | cores  |   status   | role  |       create_time       |      offline reason      |
    ======================================================================================================================================
          1 | taos-tdengine-0.taos-tdengi... |      1 |      8 | ready      | any   | 2022-11-03 08:52:13.219 |                          |
          0 | taos-tdengine-arbitrator       |      0 |      0 | ready      | arb   | 2022-11-03 08:52:14.044 | -                        |
    Query OK, 2 row(s) in set (0.000451s)

    taos> show databases;
                  name              |      created_time       |   ntables   |   vgroups   | replica | quorum |  days  |           keep           |  cache(MB)  |   blocks    |   minrows   |   maxrows   | wallevel |    fsync    | comp | cachelast | precision | update |   status   |
    ====================================================================================================================================================================================================================================================================================
    log                            | 2022-11-03 08:52:14.221 |          12 |           1 |       1 |      1 |     10 | 30                       |           1 |           3 |         100 |        4096 |        1 |        3000 |    2 |         0 | us        |      0 | ready      |
    Query OK, 1 row(s) in set (0.000493s)

    taos> show users;
              name           | privilege |       create_time       |         account          |           tags           |
    =======================================================================================================================
    _root                    | writable  | 2022-11-03 08:52:13.219 | root                     |                          |
    monitor                  | writable  | 2022-11-03 08:52:13.219 | root                     |                          |
    root                     | super     | 2022-11-03 08:52:13.219 | root                     |                          |
    Query OK, 3 row(s) in set (0.000691s)

    ```

## 8.3 集群扩容
???+ note "说明"
    可选项，根据实际资源规划确定是否需要扩容
    ```shell

    [root@ecs-788c ~]# kubectl  scale --replicas=3 -n middleware  statefulset taos-tdengine
    statefulset.apps/taos-tdengine scaled
    ```
    ???+ success "扩容成功验证"
        ```shell
        [root@ecs-788c ~]# kubectl  exec -it -n middleware taos-tdengine-0  -- taos -uroot

        Welcome to the TDengine shell from Linux, Client Version:2.6.0.18
        Copyright (c) 2022 by TAOS Data, Inc. All rights reserved.

          *********************  How to Use TAB in TAOS Shell ******************************
          *   Taos shell supports pressing TAB key to complete word. You can try it.       *
          *   Press TAB key anywhere, You'll get surprise.                                 *
          *   KEYBOARD SHORTCUT:                                                           *
          *    [ TAB ]        ......  Complete the word or show help if no input           *
          *    [ Ctrl + A ]   ......  move cursor to [A]head of line                       *
          *    [ Ctrl + E ]   ......  move cursor to [E]nd of line                         *
          *    [ Ctrl + W ]   ......  move cursor to line of middle                        *
          *    [ Ctrl + L ]   ......  clean screen                                         *
          *    [ Ctrl + K ]   ......  clean after cursor                                   *
          *    [ Ctrl + U ]   ......  clean before cursor                                  *
          *                                                                                *
          **********************************************************************************

        taos> show dnodes;
          id   |           end_point            | vnodes | cores  |   status   | role  |       create_time       |      offline reason      |
        ======================================================================================================================================
              1 | taos-tdengine-0.taos-tdengi... |      0 |      8 | ready      | any   | 2022-11-03 09:46:02.087 |                          |
              2 | taos-tdengine-1.taos-tdengi... |      0 |      8 | ready      | any   | 2022-11-03 09:46:40.592 |                          |
              3 | taos-tdengine-2.taos-tdengi... |      1 |      8 | ready      | any   | 2022-11-03 09:49:44.772 |                          |
              0 | taos-tdengine-arbitrator       |      0 |      0 | ready      | arb   | 2022-11-03 09:46:02.905 | -                        |
        Query OK, 4 row(s) in set (0.000708s)

        taos> show mnodes;
          id   |           end_point            |     role     |        role_time        |       create_time       |
        =============================================================================================================
              1 | taos-tdengine-0.taos-tdengi... | leader       | 2022-11-03 09:46:02.087 | 2022-11-03 09:46:02.087 |
              2 | taos-tdengine-1.taos-tdengi... | follower     | 2022-11-03 09:47:02.166 | 2022-11-03 09:46:53.208 |
              3 | taos-tdengine-2.taos-tdengi... | follower     | 2022-11-03 09:50:02.214 | 2022-11-03 09:49:57.378 |
        Query OK, 3 row(s) in set (0.000542s)

        taos> show databases;
                      name              |      created_time       |   ntables   |   vgroups   | replica | quorum |  days  |           keep           |  cache(MB)  |   blocks    |   minrows   |   maxrows   | wallevel |    fsync    | comp | cachelast | precision | update |   status   |
        ====================================================================================================================================================================================================================================================================================
        log                            | 2022-11-03 09:46:03.089 |          24 |           1 |       1 |      1 |     10 | 30                       |           1 |           3 |         100 |        4096 |        1 |        3000 |    2 |         0 | us        |      0 | ready      |
        Query OK, 1 row(s) in set (0.000449s)

        [root@ecs-788c ~]# kubectl  get pods -n middleware  |grep taos
        taos-tdengine-0                                             1/1     Running   0          41m
        taos-tdengine-1                                             1/1     Running   0          41m
        taos-tdengine-2                                             1/1     Running   0          40m
        taos-tdengine-arbitrator-5bfd76b7bd-925wf                   1/1     Running   0          41m
        ```
    

## 8.4  用户管理

系统管理员可以在 CLI 界面里添加、删除用户，也可以修改密码。CLI 里 SQL 语法如下：

```sql
CREATE USER <user_name> PASS <'password'>;
```



创建用户，并指定用户名和密码，密码需要用单引号引起来，单引号为英文半角

```sql
DROP USER <user_name>;
```



删除用户，限 root 用户使用

```sql
ALTER USER <user_name> PASS <'password'>;
```



修改用户密码，为避免被转换为小写，密码需要用单引号引用，单引号为英文半角

```sql
ALTER USER <user_name> PRIVILEGE <write|read>;
```



修改用户权限为：write 或 read，不需要添加单引号

???+ info "说明"
    系统内共有 super/write/read 三种权限级别，但目前不允许通过 alter 指令把 super 权限赋予用户。

```sql
SHOW USERS;
```



显示所有用户

SQL 语法中，< >表示需要用户输入的部分，但请不要输入< >本身。







#### 8.4.1 账号管理

```shell
# 创建新账号
taos> CREATE USER zhuyun PASS 'dfjdljf12341@3$';
Query OK, 0 of 0 row(s) in database (0.002040s)

# 修改账号权限
taos> ALTER USER zhuyun PRIVILEGE write;

# 修改账号密码
taos> ALTER USER zhuyun PASS 'hjdkaGHJH123#';
Query OK, 0 of 0 row(s) in database (0.001996s)


```



#### 8.4.2 验证用户
???+ success "验证TDengine服务可用性"
      ```shell
      [root@ecs-788c ~]# kubectl  exec -it -n middleware taos-tdengine-0  -- taos -u zhuyun -p
      Welcome to the TDengine shell from Linux, Client Version:2.6.0.18
      Copyright (c) 2022 by TAOS Data, Inc. All rights reserved.

      Enter password:
        *********************  How to Use TAB in TAOS Shell ******************************
        *   Taos shell supports pressing TAB key to complete word. You can try it.       *
        *   Press TAB key anywhere, You'll get surprise.                                 *
        *   KEYBOARD SHORTCUT:                                                           *
        *    [ TAB ]        ......  Complete the word or show help if no input           *
        *    [ Ctrl + A ]   ......  move cursor to [A]head of line                       *
        *    [ Ctrl + E ]   ......  move cursor to [E]nd of line                         *
        *    [ Ctrl + W ]   ......  move cursor to line of middle                        *
        *    [ Ctrl + L ]   ......  clean screen                                         *
        *    [ Ctrl + K ]   ......  clean after cursor                                   *
        *    [ Ctrl + U ]   ......  clean before cursor                                  *
        *                                                                                *
        **********************************************************************************

      taos> show users;
                name           | privilege |       create_time       |         account          |           tags           |
      =======================================================================================================================
      _root                    | writable  | 2022-11-03 08:52:13.219 | root                     |                          |
      monitor                  | writable  | 2022-11-03 08:52:13.219 | root                     |                          |
      zhuyun                   | writable  | 2022-11-03 09:06:41.294 | root                     |                          |
      root                     | super     | 2022-11-03 08:52:13.219 | root                     |                          |
      Query OK, 4 row(s) in set (0.000730s)
      ```


