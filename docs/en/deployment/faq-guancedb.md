## 1 Expand the GuanceDB Storage Component

### Problem Description:
Due to an increase in metrics data ingestion, it is necessary to expand the GuanceDB storage component.

### Solution:

#### Expand the Storage Component
```shell
# Change the number of replicas according to actual conditions
kubectl -n middleware scale sts guancedb-cluster-guance-storage --replicas=2
```

#### Modify Insert and Select Container Configurations
```shell
# Edit the insert and select configurations
kubectl -n middleware edit deploy guancedb-cluster-guance-select
kubectl -n middleware edit deploy guancedb-cluster-guance-insert
# Add the newly added pods to the startup parameters
- --storageNode=guancedb-cluster-guance-storage-1.guancedb-cluster-guance-storage.middleware.svc.cluster.local:8401
- --storageNode=guancedb-cluster-guance-storage-2.guancedb-cluster-guance-storage.middleware.svc.cluster.local:8401
```

## 2 Deployment Error of GuanceDB in a Container

### Problem Description:
When deploying GuanceDB inside a container, the service fails to start with the error message: "This program can only be run on AMD64 processors with v3 microarchitecture support."

### Solution:
The provided server's CPU architecture is not supported. Provide a server that supports the V3 architecture.