## Overview

When deploying a production environment, to save costs, OpenSearch clusters often choose disks with lower I/O and throughput when usage is not heavy. However, as data volume increases, performance bottlenecks may occur. At this point, changing the disk type to improve I/O and throughput becomes necessary.

### Prerequisites

- Huawei Cloud CCE v1.23
- Using Huawei Cloud's own StorageClass `csi-disk-topology`
- A highly available OpenSearch cluster has been deployed

### Flowchart

Please refer to the following **operation steps** for more details.

![](img/hw-change-disk-type.png)

## Operation Steps

### Step One: Change the Default Disk Type of `csi-disk-topology`

Since we are using Huawei Cloud CCE's built-in StorageClass, it needs to be modified to ensure that the default created disk type meets the requirements.

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
  everest.io/disk-volume-type: SSD    ## Modify the disk type
  everest.io/passthrough: "true"
provisioner: everest-csi-provisioner
reclaimPolicy: Delete
volumeBindingMode: WaitForFirstConsumer
```

- Parameter Description

| Parameter                        | Description                                                         |
| ---------------------------------- | ------------------------------------------------------------------- |
| everest.io/disk-volume-type       | Cloud disk type, in all uppercase. SAS: High I/O SSD: Ultra-high I/O GPSSD: General Purpose SSD ESSD: Extreme Speed SSD |

### Step Two: Migrate Shards and Adjust Rate

- Exclude nodes based on node names, excluding them in order from smallest to largest. After excluding the node, no new shards will be written to this data node, and existing shards will migrate to other nodes due to cluster self-balancing.

  > Note: Ensure that the storage on other nodes can accommodate the data from the excluded node before performing this operation.

```json
PUT _cluster/settings
{
  "persistent" : {
    "cluster.routing.allocation.exclude._name" : "opensearch-cluster-data-0"
  }
}
```

- Configure the maximum number of balanced shards.
- `incoming` indicates the maximum number of shards that can be written, usually representing the number of shards accepted by nodes other than the excluded one.
- `outgoing` indicates the maximum number of shards that can be output, usually representing the number of shards output by the excluded node. It is recommended to set this to **the number of remaining nodes * incoming shard limit**.

```json
PUT _cluster/settings
{
  "persistent": {
    "cluster.routing.allocation.node_concurrent_incoming_recoveries": 2, 
    "cluster.routing.allocation.node_concurrent_outgoing_recoveries": 12
  }
}
```

- Set the maximum transfer rate for balancing shards.
- You can adjust the migration throughput rate based on usage to minimize impact on business operations. For example, set a lower rate during the day and a higher rate at night.

```json
PUT _cluster/settings
{
  "persistent": {
    "indices.recovery.max_bytes_per_sec": "100mb"
  }
}
```

> Note: Adjust according to the actual disk throughput.

- Check Migration Status

```shell
GET _cluster/health  ## Check cluster status
GET _cat/tasks?v     ## View detailed shard information
GET _cat/indices?v&s=health:desc     ## View index health status in order
```

### Step Three: Replace Disks

- Delete the PVC and Pod corresponding to the previously excluded data node so that it can automatically use the StorageClass modified in **Step One**.
- Pay attention to the deletion order.

```
kubectl delete pvc -n middleware opensearch-cluster-data-opensearch-cluster-data-0
kubectl delete pods -n middleware opensearch-cluster-data-0
```

> If PVC deletion gets stuck, you can directly **Ctrl + c** to skip it.

### Step Four: Expand New Disks

- Directly expand the newly created disks to the required size via the Huawei Cloud console.

- Modify the size of the corresponding data node's PVC to match the size of other nodes.

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

> Note: Disks can only be expanded, not reduced, so choose the size carefully.

### Step Five: Remove Excluded Nodes

Since this is a cluster-wide migration, steps 2-4 only migrate and replace the disk type of one data node. Repeat steps 2-4 until all nodes have their disk types replaced. Then execute the following command to reset the excluded nodes, allowing the cluster to rebalance shards to the empty nodes.

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

> If there are no issues with the cluster status, don't forget to release the old disks to avoid additional charges.