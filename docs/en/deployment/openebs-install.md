# OpenEBS Deployment

## Introduction

Kubernetes local persistent volumes allow users to access local storage in a simple and portable way through the standard PVC interface. PVs contain node affinity information, which the system uses to schedule pods to the correct nodes.
OpenEBS dynamic local PV extends the functionality provided by Kubernetes local PV by using the OpenEBS Node Disk Manager (NDM). The main differences include:

- Users do not need to pre-format and mount devices on nodes.
- Support for dynamic local PVs—where devices can be used by CAS solutions and applications. CAS solutions typically access devices directly. By using blockdeviceclaims supported by OpenEBS NDM, OpenEBS local PV simplifies the management of storage devices used between CAS solutions (direct access) and applications (via PV).
- Support for providing local PVs using hostpath. In fact, in some cases, Kubernetes nodes may have only a limited number of storage devices connected to the nodes, and hostpath-based local PVs provide effective management of available storage on the nodes.

## Prerequisites

- A Kubernetes cluster has been deployed; if not, refer to [Kubernetes Deployment](infra-kubernetes.md)
- (Optional) Helm tool has been deployed; if not, refer to [Helm Installation](helm-install.md)

## Basic Information and Compatibility

| Name                    | Version | Offline Deployment Supported | Supported Architectures | Supported Cluster Versions |
| :---------------------- | :-----: | :--------------------------: | :----------------------: | :------------------------: |
| localpv-provisioner     |   2.0   |            Yes               |      amd64/arm64         |          1.18+             |

## Deployment Steps

### 1. Installation

=== "Helm"

    Execute the command to install:
    
    ```shell
    helm install localpv localpv-provisioner --repo https://pubrepo.<<< custom_key.brand_main_domain >>>/chartrepo/dataflux-chart -n kube-system
    ```

    Output result:

    ```text
    NAME: localpv
    LAST DEPLOYED: Wed Nov  2 12:44:53 2022
    NAMESPACE: kube-system
    STATUS: deployed
    REVISION: 1
    TEST SUITE: None
    NOTES:
    The OpenEBS Dynamic LocalPV Provisioner has been installed.
    Check its status by running:
    $ kubectl get pods -n kube-system

    Use `kubectl get bd -n kube-system` to list the
    blockdevices attached to the Kubernetes cluster nodes.

    Get started with the Dynamic LocalPV Provisioner Quickstart guide at:
    https://github.com/openebs/dynamic-localpv-provisioner/blob/develop/docs/quickstart.md

    For more information, visit our Slack at https://openebs.io/community or view
    the OpenEBS documentation online at https://openebs.io/docs
    ```

    > `STATUS: deployed` indicates successful deployment

=== "Yaml"
    
         
    Download [ebs.yaml](ebs.yaml)
    
    Execute the command to install:
    ```shell
    kubectl apply -f ebs.yaml
    ```

### 2. Verify Deployment

#### 2.1 Check Pod Status

```shell
kubectl get pods -n kube-system -l release=localpv
```

Output result: 

```shell
NAME                                           READY   STATUS    RESTARTS   AGE
localpv-localpv-provisioner-c7dd598dc-wtrgg    1/1     Running   0          27m
localpv-openebs-ndm-65987                      1/1     Running   0          27m
localpv-openebs-ndm-6h2x4                      1/1     Running   0          27m
localpv-openebs-ndm-krf47                      1/1     Running   0          27m
localpv-openebs-ndm-operator-8d67c79dd-482sb   1/1     Running   0          27m
```

#### 2.2 Create StorageClass

We create a `localpv` StorageClass under the `/data` directory

```yaml
apiVersion: storage.k8s.io/v1
allowVolumeExpansion: true
kind: StorageClass
metadata:
  annotations:
    cas.openebs.io/config: |
      - name: StorageType
        value: "hostpath"
      - name: BasePath
        value: "/data" ## hostpath path
  name: openebs-data
provisioner: openebs.io/local
reclaimPolicy: Retain
volumeBindingMode: WaitForFirstConsumer ## wait for pod scheduling before creation
```

Execute the command to install:

```shell
kubectl apply -f sc-data.yaml
```

Check if it was created successfully:

```shell
kubectl get sc
```

Result:

```shell
NAME               PROVISIONER        RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
openebs-data       openebs.io/local   Retain          WaitForFirstConsumer   true                   24m
```

#### 2.3 Create PVC

Save the following YAML as `test-pvc.yaml`

```yaml
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: test-pvc
spec:
  storageClassName: openebs-data ## StorageClass deployed above
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
```

Execute the command to install:

```shell
kubectl apply -f test-pvc.yaml
```

Check the status:

```shell
kubectl get pvc
```

PVC status is as follows:

```shell
NAME       STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
test-pvc   Pending                                      openebs-data   18s
```

> Since the `volumeBindingMode` of the StorageClass is set to `WaitForFirstConsumer`, the PVC status being `Pending` is normal.

#### 2.4 Create Test Deployment

Save the following YAML as `test-deploy.yaml`

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-pvc
spec:
  selector:
    matchLabels:
      app: nginx-pvc
  replicas: 1 # tells deployment to run 2 pods matching the template
  template:
    metadata:
      labels:
        app: nginx-pvc
    spec:
      containers:
      - name: nginx-pvc
        image: nginx:1.14.1
        ports:
        - containerPort: 80
        resources:
          requests:
            cpu: 100m
            memory: 30Mi
          limits:
            cpu: 100m
            memory: 30Mi
        volumeMounts:
          - mountPath: "/var/www/html" ## mount the directory in the container to the directory in the pvc nfs
            name: storage    ## add storage
      volumes:
      - name: storage   ## corresponding to the previous one
        persistentVolumeClaim:  ## PVC claim
          claimName: test-pvc   ## created PVC name
```

Execute the command to install:

```shell
kubectl apply -f test-deploy.yaml
```

Check the status:

```shell
kubectl get pods -l app=nginx-pvc
```

Pod status:

```shell
NAME                         READY   STATUS    RESTARTS   AGE
nginx-pvc-6654f7478c-sjm88   1/1     Running   0          7m5s
```

PVC status:

```shell
NAME        STATUS    VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
test-pvc    Bound     pvc-4023bf79-235e-4310-8fb6-a4f13b3900f2   1Gi        RWO            openebs-data   2m1s
```

## How to Uninstall

=== "Helm"
    
    ```shell
    helm uninstall -n kube-system localpv
    ```

=== "Yaml"

    ```shell
    kubectl delete -f ebs.yaml
    ```