### Solution One: Scaling Up

You can choose to scale horizontally or vertically.

Horizontal scaling: Increase the data nodes in the cluster.

Vertical scaling: Expand the data disk of the data nodes.

### Solution Two: Data Cleanup

1. First, use the `df -h` command to check the disk space of the corresponding ES instance and determine if it is full.

2. Use the following command to view index storage:

```shell
$ kubectl exec -ti -n middleware <es_pod_name> -- curl -XGET -u <user>:<password> 127.0.0.1:9200/_cat/indices?v

health status index                                                                                 uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   wksp_4bcd96fc753e4a87a7f035717e3492f4_logging-000002                                 v8EAVH4FR32gSGIeMGKtSw   1   0          0            0       60.0gb           60.0gb
green  open   wksp_4bcd96fc753e4a87a7f035717e3492f4_logging-000001                                 blKeVx7mT1edx-EJFf0PBA   1   0          0            0       60.1gb           60.1gb
green  open   wksp_4bcd96fc753e4a87a7f035717e3492f4_logging-000003                                 XGDzVakRT4yLx3KdgJpl6Q   1   0          0            0       59.9gb           59.9gb
green  open   wksp_4bcd96fc753e4a87a7f035717e3492f4_logging-000004                                 dXaJwIuKQMKj1W-sGQMgYA   1   0          8            0     53.6kb         53.6kb
green  open   .monitoring-es-7-2023.05.31                                                           hWN-pIKWSpyxHGLAuyrR-w   1   0    3342741      1023346      1.3gb          1.3gb
green  open   .monitoring-es-7-2023.05.30                                                           06VnZgosSuCZR4mUXewBxg   1   0    3386407       931888      1.3gb          1.3gb
green  open   wksp_ae656f5d29764fdd904707a2564b7517_keyevent-000002                                 PecXZi1sTGOvFgEhpbXifA   1   0          0            0       208b           208b
green  open   .monitoring-es-7-2023.06.01                                                           obPVFxemQeGVQC2flCtUiA   1   0    3466792       519395      1.4gb          1.4gb
green  open   .monitoring-es-7-2023.06.02                                                           HcxlyaH1R7-R7Wh1jF12bw   1   0     390356       151592    292.7mb        292.7mb
green  open   .infini_activities-00001                                                              f8f6rb1wTCe7IZDEECrKmQ   1   0        460            0    252.1kb        252.1kb
```

3. As shown above, each index has its size and number. We prioritize deleting indexes with smaller numbers to clean up data.

> **Index Name Explanation**: The index name consists of a workspace ID + data type + number.

> Note: Delete indexes in ascending order based on **the same workspace and data type but different numbers**, **but do not delete the largest numbered index**. Smaller numbers represent older data. Generally, the largest numbered index is the one currently being written to.

For example, from the query results, you can see that `wksp_4bcd96fc753e4a87a7f035717e3492f4_logging` has four indexed logs: 000001, 000002, 000003, and 000004. In this case, you can delete up to 000001, 000002, and 000003 in order.

Deletion command:

```shell
$ kubectl exec -ti -n middleware <es_pod_name> -- curl -XDELETE -u <user>:<password> 127.0.0.1:9200/<index>
```