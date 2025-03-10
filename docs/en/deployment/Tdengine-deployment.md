# High Availability Deployment of TDengine

## 1. Introduction

TDengine is a high-performance, distributed, SQL-supporting time series database (Database). Its core code, including cluster functionality, is fully open-source (under the AGPL v3.0 license). TDengine can be widely used in fields such as IoT, industrial internet, connected vehicles, IT operations, and finance. In addition to core time series database (Database) features, TDengine also provides caching, data subscription, stream computing, and other big data platform functionalities to minimize development and maintenance complexity.

## 2. Prerequisites

- Kubernetes cluster has been deployed
- OpenEBS storage plugin driver has been deployed

```shell
root@k8s-node01 ]# kubectl get pods -n kube-system | grep openebs
openebs-localpv-provisioner-6b56b5567c-k5r9l   1/1     Running   0          23h
openebs-ndm-jqxtr                              1/1     Running   0          23h
openebs-ndm-operator-5df6ffc98-cplgp           1/1     Running   0          23h
openebs-ndm-qtjxm                              1/1     Running   0          23h
openebs-ndm-vlcrv                              1/1     Running   0          23h
```

## 3. Preparations for Installation

Since TDengine consumes significant resources and requires exclusive use of cluster resources, we need to configure cluster scheduling in advance.

## 4. Cluster Label Configuration

Execute commands to label nodes in the cluster:

```shell
# According to cluster planning, label the k8s nodes that will deploy TDengine services. It is recommended to use three nodes.
# xxx represents actual nodes in the cluster, multiple nodes are separated by spaces
kubectl label nodes xxx tdengine=true
```

Check labels:

```shell
kubectl get nodes --show-labels | grep 'tdengine'
```

## 5. Cluster Taint Configuration

Execute commands to set taints on the cluster:
???+ Tips "Tip"
    If you have not planned for TDengine services to run on dedicated nodes, you do not need to apply taints to the nodes; this step can be skipped.

    ```shell
    kubectl taint node xxxx infrastructure=middleware:NoExecute
    ```

## 6. Configure StorageClass 

Configure a dedicated StorageClass for TDengine

```yaml
# Copy the following YAML content into the k8s cluster and save it as sc-td.yaml. Modify according to actual conditions before deployment.
apiVersion: storage.k8s.io/v1
allowVolumeExpansion: true
kind: StorageClass
metadata:
  annotations:
    cas.openebs.io/config: |
      - name: StorageType
        value: "hostpath"
      - name: BasePath
        value: "/data/tdengine"  # This path can be modified based on actual conditions. Ensure sufficient storage space and that the path exists.
  name: openebs-tdengine   # The name must be unique within the cluster. Modify the deployment file /etc/kubeasz/guance/infrastructure/yaml/taos.yaml accordingly before installation.
provisioner: openebs.io/local
reclaimPolicy: Retain
volumeBindingMode: WaitForFirstConsumer
```

> Ensure that the `/data/tdengine` directory has sufficient disk capacity.

Configure storage size:

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
          storage: "50Gi"  ## Allocate data storage space according to actual needs.
  - metadata:
      name: taos-tdengine-taoslog
    spec:
      accessModes:
        - "ReadWriteOnce"
      storageClassName: "openebs-tdengine"
      resources:
        requests:
          storage: "1Gi"  ## Allocate log storage space according to actual needs.
```

## 7. Installation

```shell
# Create namespace
kubectl create ns middleware
# Deploy TDengine service
kubectl apply -f /etc/kubeasz/guance/infrastructure/yaml/taos.yaml -n middleware
```

## 8. Verify Deployment and Configuration

### 8.1 Check Container Status

```shell
[root@ecs-788c ~]# kubectl get pods -n middleware | grep taos
taos-tdengine-0                                             1/1     Running   0          5m32s
taos-tdengine-arbitrator-5bfd76b7bd-8jtmd                   1/1     Running   0          5m32s
```

### 8.2 Verify Service
???+ success "Verify TDengine Service Availability"

    ```shell
    # After successful installation, use the following command to verify login.

    [root@ecs-788c ~]# kubectl exec -it -n middleware taos-tdengine-0 -- taos

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

### 8.3 Cluster Scaling
???+ note "Note"
    Optional, determine whether scaling is needed based on resource planning.
    ```shell

    [root@ecs-788c ~]# kubectl scale --replicas=3 -n middleware statefulset taos-tdengine
    statefulset.apps/taos-tdengine scaled
    ```
    ???+ success "Verification After Scaling"
        ```shell
        [root@ecs-788c ~]# kubectl exec -it -n middleware taos-tdengine-0 -- taos -uroot

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

        [root@ecs-788c ~]# kubectl get pods -n middleware | grep taos
        taos-tdengine-0                                             1/1     Running   0          41m
        taos-tdengine-1                                             1/1     Running   0          41m
        taos-tdengine-2                                             1/1     Running   0          40m
        taos-tdengine-arbitrator-5bfd76b7bd-925wf                   1/1     Running   0          41m
        ```

### 8.4 User Management

System administrators can add, delete users, and modify passwords via the CLI interface. The SQL syntax in the CLI is as follows:

```sql
CREATE USER <user_name> PASS <'password'>;
```

Create a user with a specified username and password. The password should be enclosed in single quotes, which must be ASCII single quotes.

```sql
DROP USER <user_name>;
```

Delete a user; this operation is limited to the root user.

```sql
ALTER USER <user_name> PASS <'password'>;
```

Modify the user's password. To avoid case conversion, the password should be enclosed in single quotes, which must be ASCII single quotes.

```sql
ALTER USER <user_name> PRIVILEGE <write|read>;
```

Change the user's privileges to either write or read. Do not enclose these terms in quotes.

???+ info "Note"
    The system supports three levels of privileges: super, write, and read. However, it currently does not allow assigning super privileges to users using the ALTER command.

```sql
SHOW USERS;
```

Display all users.

In SQL syntax, `< >` indicates parts that require user input but do not include the `< >` symbols themselves.

#### 8.4.1 Account Management

```shell
# Create a new account
taos> CREATE USER zhuyun PASS 'dfjdljf12341@3$';
Query OK, 0 of 0 row(s) in database (0.002040s)

# Modify account privileges
taos> ALTER USER zhuyun PRIVILEGE write;

# Modify account password
taos> ALTER USER zhuyun PASS 'hjdkaGHJH123#';
Query OK, 0 of 0 row(s) in database (0.001996s)
```

#### 8.4.2 Verify User
???+ success "Verify TDengine Service Availability"
      ```shell
      [root@ecs-788c ~]# kubectl exec -it -n middleware taos-tdengine-0 -- taos -u zhuyun -p
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