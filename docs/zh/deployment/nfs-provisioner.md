# Kubernetes Storage 组件部署 {#kube-storage}

## 简介

nfs-subdir-external-provisioner可动态为kubernetes提供pv卷，是Kubernetes的简易NFS的外部provisioner，本身不提供NFS，需要现有的NFS服务器提供存储。持久卷目录的命名规则为: ${namespace}-${pvcName}-${pvName}。

Kubernetes  nfs subdir external provisioner  组件部署参考 [https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner](https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner)


## 前提条件

- 已部署 NFS 服务，未部署可参考 [NFS 部署](nfs-install.md) 
- 已部署 Kubernetes 集群，未部署可参考 [Kubernetes 部署](infra-kubernetes.md) 
- （可选）已部署 Helm 工具，未部署可参考 [Helm 安装](helm-install.md) 

## 基础信息及兼容

|     NFS IP      | NSF Path | storageClass name |              描述              |
| :-------------: | :------: | :---------------: | :----------------------------: |
| 192.168.100.105 | /nfsdata |  df-nfs-storage   | 部署时，请根据实际情况修改配置 |



|              名称               |  版本  | 是否支持离线部署 |  支持架构   | 支持集群版本 |
| :-----------------------------: | :----: | :--------------: | :---------: | :----------: |
| nfs subdir external provisioner | 4.0.16 |        是        | amd64/arm64 |    1.18+     |




## 部署步骤

### 1、Kubernetes nfs subdir external provisioner  部署

???+ warning "注意"
     Kubernetes 所有节点都必须安装 nfs-utils ，如未安装请执行以下命令：
     ``` shell
     yum install -y nfs-utils
     ```

=== "Helm"

    执行命令安装：
    
    ```bash
    helm install nfs-provisioner nfs-subdir-external-provisioner \
        --repo https://pubrepo.<<< custom_key.brand_main_domain >>>/chartrepo/dataflux-chart \
        --set nfs.server=192.168.100.105 \
        --set nfs.path=/nfsdata \
        --set storageClass.name=df-nfs-storage \
        -n kube-system 
    ```
    
    ???+ warning "注意"
    
         注意 `nfs.server` 为 `nfs`地址，`nfs.path`为路径，不能弄错。

=== "Yaml"
     
    修改以下 yaml 高亮部分并部署。
    
    ???- note "nfs-provisioner.yaml(单击点开)"
        ```yaml hl_lines='103 105 109-110'
        ---
        apiVersion: v1
        kind: ServiceAccount
        metadata:
          name: nfs-client-provisioner
          # replace with namespace where provisioner is deployed
          namespace: kube-system
        ---
        kind: ClusterRole
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          name: nfs-client-provisioner-runner
        rules:
          - apiGroups: [""]
            resources: ["nodes"]
            verbs: ["get", "list", "watch"]
          - apiGroups: [""]
            resources: ["persistentvolumes"]
            verbs: ["get", "list", "watch", "create", "delete"]
          - apiGroups: [""]
            resources: ["persistentvolumeclaims"]
            verbs: ["get", "list", "watch", "update"]
          - apiGroups: ["storage.k8s.io"]
            resources: ["storageclasses"]
            verbs: ["get", "list", "watch"]
          - apiGroups: [""]
            resources: ["events"]
            verbs: ["create", "update", "patch"]
        ---
        kind: ClusterRoleBinding
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          name: run-nfs-client-provisioner
        subjects:
          - kind: ServiceAccount
            name: nfs-client-provisioner
            # replace with namespace where provisioner is deployed
            namespace: kube-system
        roleRef:
          kind: ClusterRole
          name: nfs-client-provisioner-runner
          apiGroup: rbac.authorization.k8s.io
        ---
        kind: Role
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          name: leader-locking-nfs-client-provisioner
          # replace with namespace where provisioner is deployed
          namespace: kube-system
        rules:
          - apiGroups: [""]
            resources: ["endpoints"]
            verbs: ["get", "list", "watch", "create", "update", "patch"]
        ---
        kind: RoleBinding
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          name: leader-locking-nfs-client-provisioner
          # replace with namespace where provisioner is deployed
          namespace: kube-system
        subjects:
          - kind: ServiceAccount
            name: nfs-client-provisioner
            # replace with namespace where provisioner is deployed
            namespace: kube-system
        roleRef:
          kind: Role
          name: leader-locking-nfs-client-provisioner
          apiGroup: rbac.authorization.k8s.io
    
        ---
        apiVersion: apps/v1
        kind: Deployment
        metadata:
          name: nfs-client-provisioner
          labels:
            app: nfs-client-provisioner
          # replace with namespace where provisioner is deployed
          namespace: kube-system
        spec:
          replicas: 1
          strategy:
            type: Recreate
          selector:
            matchLabels:
              app: nfs-client-provisioner
          template:
            metadata:
              labels:
                app: nfs-client-provisioner
            spec:
              serviceAccountName: nfs-client-provisioner
              containers:
                - name: nfs-client-provisioner
                  image: dyrnq/nfs-subdir-external-provisioner:v4.0.2
                  volumeMounts:
                    - name: nfs-client-root
                      mountPath: /persistentvolumes
                  env:
                    - name: PROVISIONER_NAME
                      value: k8s-sigs.io/nfs-subdir-external-provisioner
                    - name: NFS_SERVER
                      value: 192.168.100.105   # 填写实际nfs server
                    - name: NFS_PATH
                      value: /nfsdata   # 实际共享目录       
              volumes:
                - name: nfs-client-root
                  nfs:
                    server: 192.168.100.105 # 填写实际nfs server地址
                    path: /nfsdata  # 实际共享目录
        ---
        apiVersion: storage.k8s.io/v1
        kind: StorageClass
        metadata:
          name: df-nfs-storage
          annotations:
            storageclass.beta.kubernetes.io/is-default-class: "true"  # 配置该 storageclass 为默认
            storageclass.kubernetes.io/is-default-class: "true"
        provisioner: k8s-sigs.io/nfs-subdir-external-provisioner # or choose another name, must match deployment's env PROVISIONER_NAME'
        allowVolumeExpansion: true 
        reclaimPolicy: Delete
        parameters:
          archiveOnDelete: "false"            
    
        ```
    
    执行命令安装：
    ```shell
    kubectl apply -f nfs-provisioner.yaml
    ```

### 2、验证部署

#### 2.1  查看 pod 状态

```shell
$ kubectl get pod -n kube-system | grep  nfs-provisione

nfs-provisioner-nfs-subdir-external-provisioner-79d448b5d7tbp7v   1/1     Running   0          3d5h
```

#### 2.2 创建 pvc

执行命令，创建 pvc

```shell
$ cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
 name: cfs-pvc001
spec:
 accessModes:
   - ReadWriteOnce
 resources:
   requests:
     storage: 1Gi
 storageClassName: df-nfs-storage
EOF
```

#### 2.3 查看 pvc 状态

```shell
$ kubectl get pvc | grep cfs-pvc001

cfs-pvc001       Bound    pvc-a17a0e50-04d2-4ee0-908d-bacd8d53aaa4   1Gi        RWO            df-nfs-storage           3d7h
```

>`Bound` 为部署成功标准


## 如何卸载

=== "Helm"
    
    ```shell
    helm uninstall -n kube-system nfs-provisioner
    ```

=== "Yaml"

    ```shell
    kubectl delete -f nfs-provisioner.yaml
    ```

