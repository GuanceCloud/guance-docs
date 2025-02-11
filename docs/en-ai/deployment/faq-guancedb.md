## 1 GuanceDB Storage Component Expansion
Problem Description: Due to increased access of metrics data, it is necessary to expand the GuanceDB storage component.

Solution:

Expand the storage component
```shell
# Change the number of replicas according to actual conditions
kubectl -n middleware scale sts guancedb-cluster-guance-storage --replicas=2
```

Modify insert and select container configurations
```shell
# Modify insert and select configurations
kubectl -n middleware edit deploy guancedb-cluster-guance-select
kubectl -n middleware edit deploy guancedb-cluster-guance-insert
# Add the newly added pods to the startup parameters
- --storageNode=guancedb-cluster-guance-storage-1.guancedb-cluster-guance-storage.middleware.svc.cluster.local:8401
- --storageNode=guancedb-cluster-guance-storage-2.guancedb-cluster-guance-storage.middleware.svc.cluster.local:8401
```

## 2 Error Deploying GuanceDB in a Container
Problem Description: When deploying GuanceDB in a container, the service fails to start with the error message: "This program can only be run on AMD64 processors with v3 microarchitecture support."

Solution: The provided server's CPU architecture is not supported. Provide a server that supports V3 architecture.