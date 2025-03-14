## Overview

When deploying a production environment, to save costs, OpenSearch clusters often choose disks with lower I/O and throughput when usage is not high. However, as data volumes increase, performance bottlenecks may occur. At this point, changing the disk type to improve I/O and throughput becomes necessary.

### Prerequisites

- Huawei Cloud CCE v1.23
- Using Huawei Cloud's own StorageClass `csi-disk-topology`
- A highly available OpenSearch cluster has been deployed

### Flowchart

Please refer to the following **operation steps** for details.

![](img/hw-change-disk-type.png)

## Operation Steps

### Step One: Change the default disk type of `csi-disk-topology`

Since the StorageClass used is provided by the Huawei Cloud CCE cluster, it needs to be modified to ensure that the default disk type created meets the requirements.

```shell
kubectl edit sc -n middleware csi-disk-topology
```

```yaml
---
allowVolumeExpansion: true
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: csi-disk-topology
parameters:
  csi.storage.k8s.io/csi-driver-name: disk.csi.everest.io
  csi.storage.k8s.io/fstype: ext4
  everest.io/disk-volume-type: SSD    ## Modify disk type
  everest.io/passthrough: "true"
provisioner: everest-csi-provisioner
reclaimPolicy: Delete
volumeBindingMode: WaitForFirstConsumer
```

- Parameter Description

| Parameter                        | Description                                                         |
| ---------------------------------- | ------------------------------------------------------------------- |
| everest.io/disk-volume-type       | Cloud disk type, all uppercase. SAS: High I/O SSD: Ultra-high I/O   GPSSD: General Purpose SSD    ESSD: Extreme Speed SSD |

### Step Two: Migrate shards and adjust rates

- Exclude nodes based on node names in ascending order. After excluding a node, no new shards will be written to this data node, and existing shards will migrate to other nodes due to cluster self-balancing principles.

  > Note: Ensure that the storage of other nodes can accommodate the data from the excluded node before performing this operation.

```json
PUT _cluster/settings
{
  "persistent" : {
    "cluster.routing.allocation.exclude._name" : "opensearch-cluster-data-0"
  }
}
```

- Configure the maximum number of balanced shards.
- `incoming` indicates the maximum number of incoming shards, typically representing the number of shards accepted by non-excluded nodes.
- `outcoming` indicates the maximum number of outgoing shards, typically representing the number of shards output by the excluded node. It is recommended to set it to **the number of remaining nodes * the maximum number of incoming shards**.

```json
PUT _cluster/settings
{
  "persistent": {
    "cluster.routing.allocation.node_concurrent_incoming_recoveries": 2, 
    "cluster.routing.allocation.node_concurrent_outgoing_recoveries": 12
  }
}
```

- Configure the maximum transfer rate during shard balancing.
- Adjust the migration throughput rate according to actual usage to minimize impact on business operations. For example, set a lower rate during the day and a higher rate at night.

```json
PUT _cluster/settings
{
  "persistent": {
    "indices.recovery.max_bytes_per_sec": "100mb"
  }
}
```

> Note: Adjust based on the actual disk throughput.

- Check migration status

```shell
GET _cluster/health  ## Check cluster status
GET _cat/tasks?v     ## Check detailed shard information
GET _cat/indices?v&s=health:desc     ## Check index health status in order
```

### Step Three: Replace Disk

- Delete the PVC and Pod corresponding to the previously excluded data node so that it automatically uses the modified StorageClass from **Step One**.
- Pay attention to the deletion order.

```
kubectl delete pvc -n middleware opensearch-cluster-data-opensearch-cluster-data-0
kubectl delete pods -n middleware opensearch-cluster-data-0
```

> Deleting PVC might hang; you can directly use **Ctrl + c** to skip.

### Step Four: Expand the new disk

- Directly expand the newly created disk to the required size via the Huawei Cloud console.

- Modify the size of the PVC corresponding to the data node to match the size of other nodes.

```shell
kubectl edit pvc -n middleware opensearch-cluster-data-opensearch-cluster-data-0
```

```yaml
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 2500Gi    ## Modify to match the size of other nodes.
  storageClassName: csi-disk-topology
  volumeMode: Filesystem
  volumeName: pvc-7025138f-04e0-4d5b-879d-7cf998f54628
```

> Note: Disks can only be expanded, not shrunk, so choose the size carefully.

### Step Five: Remove node exclusion

Since this involves migrating the entire cluster, steps 2-4 only migrate and replace the disk type of one data node. Repeat steps 2-4 until all nodes have their disk types replaced, then execute the following command to clear the excluded nodes. According to the cluster's self-balancing characteristics, it will automatically balance shards to the empty nodes.

```json
PUT _cluster/settings
{
  "persistent" : {
    "cluster.routing.allocation.exclude._name" : ""
  }
}
```

## Verification Method

```shell
GET _cluster/health
```

> If there are no issues with the cluster status, don't forget to release old disks to avoid additional charges.