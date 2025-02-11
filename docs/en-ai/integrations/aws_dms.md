---
title: 'AWS DMS'
tags: 
  - AWS
summary: 'The metrics displayed for AWS DMS include data migration speed, latency, data consistency, and migration success rate. These metrics reflect the performance and reliability of DMS during database migration and replication.'
__int_icon: 'icon/aws_dms'
dashboard:

  - desc: 'AWS DMS Monitoring View'
    path: 'dashboard/en/aws_dms'

monitor:
  - desc: 'AWS DMS Monitor'
    path: 'monitor/en/aws_dms'

---

<!-- markdownlint-disable MD025 -->
# AWS DMS
<!-- markdownlint-enable -->

The metrics displayed for AWS DMS include data migration speed, latency, data consistency, and migration success rate. These metrics reflect the performance and reliability of DMS during database migration and replication.


## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare a qualified Amazon AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize monitoring data from AWS DMS cloud resources, we install the corresponding collection script: 「Guance Integration (AWS-DMS Collection)」(ID: `guance_aws_dms`)

After clicking 【Install】, enter the corresponding parameters: Amazon AK, Amazon account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

Then, in the collection script, change the regions in `collector_configs` and `cloudwatch_configs` to the actual regions.

Additionally, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

By default, we collect some configurations. For more details, see the metrics section [Custom Cloud Object Metrics Configuration](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. In 「Management / Automatic Trigger Configuration」, confirm that the corresponding automatic trigger configuration exists for the task. You can also check the task records and logs to ensure there are no anomalies.
2. On the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. On the Guance platform, under 「Metrics」, check if the corresponding monitoring data exists.

## Metrics {#metric}
After configuring Amazon CloudWatch, the default metric sets are as follows. You can collect more metrics through configuration. [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/zh_cn/dms/latest/userguide/CHAP_Monitoring.html){:target="_blank"}

### Instance Metrics

The `AWS/DMS` namespace includes the following instance metrics.

| Metric                                           | Description                                                                                                                                          |
|:---------------------------------------------|:--------------------------------------------------------------------------------------------------------------------------------------------|
| `CPUUtilization`                             | The percentage of allocated vCPUs (virtual CPUs) currently in use on the instance. Unit: Percentage                                                                                                       |
| `FreeMemory`                                 | The amount of physical memory available for applications, page cache, and kernel data structures. For more information, see the MemFree value in the Linux manpage `/proc/memInfo`. Unit: Bytes                                                           |
| `FreeStorageSpace`                           | The size of available storage space. Unit: Bytes                                                                                                                             |
| `WriteIOPS`                                  | The average number of disk write I/O operations per second. Unit: Count/Second                                                                                                                    |
| `ReadIOPS`                                   | The average number of disk read I/O operations per second. Unit: Count/Second                                                                                                                    |
| `WriteThroughput`                            | The average number of bytes written to disk per second. Unit: Bytes/Second                                                                                                                        |
| `ReadThroughput`                             | The average number of bytes read from disk per second. Unit: Bytes/Second                                                                                                                       |
| `NetworkTransmitThroughput`                  | Outgoing (transmit) network traffic on the replication instance, including customer database AWS DMS traffic and traffic used for monitoring and replication. Unit: Bytes/Second                                                                                        |
| `NetworkReceiveThroughput`                   | Incoming (receive) network traffic on the replication instance, including customer database AWS DMS traffic and traffic used for monitoring and replication. Unit: Bytes/Second                                                                                        |
| `CDCChangesMemorySource`                     | The number of rows accumulated in memory and waiting to be committed from the source. This metric can be viewed together with CDC ChangesDiskSource.                                                                                          |
| `CDCChangesMemoryTarget`                     | The number of rows accumulated in memory and waiting to be committed to the target. This metric can be viewed together with CDC ChangesDiskTarget.                                                                                         |
| `CDCChangesDiskSource`                       | The number of rows accumulated on disk and waiting to be committed from the source. This metric can be viewed together with CDC ChangesMemorySource.                                                                                        |
| `CDCChangesDiskTarget`                       | The number of rows accumulated on disk and waiting to be committed to the target. This metric can be viewed together with CDC ChangesMemoryTarget.                                                                                       |
| `CDCThroughputBandwidthTarget`               | Outbound data transmitted for the target, in KB per second. CDC ThroughputBandwidth records outbound data transmitted at sampling points. If no task network traffic is found, this value is zero. Since CDC does not publish long-running transactions, network traffic may not be recorded.                                |
| `CDCThroughputRowsSource`                    | Incoming task changes for the source, in rows per second.                                                                                                                           |
| `CDCThroughputRowsTarget`                    | Outgoing task changes for the target, in rows per second.|

## Objects {#object}

The structure of collected AWS DMS object data can be viewed in 「Infrastructure - Custom」

```json
{
  "measurement": "aws_dms",
  "tags": {
    "AvailabilityZone"              :"cn-northwest-1b",
    "class"                         :"aws_dms",
    "cloud_provider"                :"aws",
    "KmsKeyId:arn"                  :"aws-cn:kms:cn-northwest-1:294654068288:key/531cd79a-5a86-47d6-b216-0d63e2e32b3a",
    "name"                          :"hn-test",
    "ReplicationInstanceClass"      :"dms.t3.micro",
    "ReplicationInstanceIdentifier" :"hn-test"
  }
}
```

> *Note: Fields in `tags` may change with subsequent updates.*
>
> Note 1: The `name` value is the instance ID, used for unique identification.