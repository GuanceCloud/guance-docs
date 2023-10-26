---
title: 'AWS DMS'
summary: 'Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.'
__int_icon: 'icon/aws_dms'
dashboard:

  - desc: 'AWS DMS Monitoring View'
    path: 'dashboard/zh/aws_dms'

monitor:
  - desc: 'AWS DMS Monitor'
    path: 'monitor/zh/aws_dms'

---


<!-- markdownlint-disable MD025 -->
# AWS DMS
<!-- markdownlint-enable -->

Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.


## config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installation script

> Tip：Please prepare AWS AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of AWS DMS cloud resources, we install the corresponding collection script：「Guance Integration（AWS-DMSCollect）」(ID：`guance_aws_dms`)

Click 【Install】 and enter the corresponding parameters: AWS AK, AWS account name.

tap【Deploy startup Script】，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

Then, in the collection script, add the collector_configs and cloudwatch_change the regions in configs to the actual regions

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」. Click【Run】，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs。

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure AWS Cloud - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Monitoring.html){:target="_blank"}

### Metric

`AWS/DMS` The namespace includes the following instance metrics 。

| Metric                                           | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
|:---------------------------------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `CPUUtilization`                             | The percentage of allocated vCPU (virtual CPU) currently in use on the instance.Units: Percent                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| `FreeMemory`                                 | The amount of physical memory available for use by applications, page cache, and for the kernel’s own data structures. For more information, see MemFree value in /proc/memInfo section of the Linux man-pages.Units: Bytes                                                                                                                                                                                                                                                                                                    |
| `FreeStorageSpace`                           | The amount of available storage space.Units: Bytes                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| `WriteIOPS`                                  | The average number of disk write I/O operations per second.Units: Count/Second                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| `ReadIOPS`                                   | The average number of disk read I/O operations per second.Units: Count/Second                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| `WriteThroughput`                            | The average number of bytes written to disk per second.Units: Bytes/Second                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| `ReadThroughput`                             | The average number of bytes read from disk per second.Units: Bytes/Second                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| `NetworkTransmitThroughput`                  | The outgoing (Transmit) network traffic on the replication instance, including both customer database traffic and AWS DMS traffic used for monitoring and replication.Units: Bytes/second                                                                                                                                                                                                                                                                                                                                                  |
| `NetworkReceiveThroughput`                   | The incoming (Receive) network traffic on the replication instance, including both customer database traffic and AWS DMS traffic used for monitoring and replication.Units: Bytes/second                                                                                                                                                                                                                                                                                                                                                   |
| `CDCChangesMemorySource`                     | Amount of rows accumulating in a memory and waiting to be committed from the source. You can view this metric together with CDCChangesDiskSource.                                                                                                                                                                                                                                                                                                                                                                                          |
| `CDCChangesMemoryTarget`                     | Amount of rows accumulating in a memory and waiting to be committed to the target. You can view this metric together with CDCChangesDiskTarget.                                                                                                                                                                                                                                                                                                                                                                                            |
| `CDCChangesDiskSource`                       | Amount of rows accumulating on disk and waiting to be committed from the source. You can view this metric together with CDCChangesMemorySource.。                                                                                                                                                                                                                                                                                                                                                                                           |
| `CDCChangesDiskTarget`                       | Amount of rows accumulating on disk and waiting to be committed to the target. You can view this metric together with CDCChangesMemoryTarget.。                                                                                                                                                                                                                                                                                                                                                                                             |
| `CDCThroughputBandwidthTarget`               | Outgoing data transmitted for the target in KB per second. CDCThroughputBandwidth records outgoing data transmitted on sampling points. If no task network traffic is found, the value is zero. Because CDC does not issue long-running transactions, network traffic may not be recorded.                                                                                                                                                                                                                                                 |
| `CDCThroughputRowsSource`                    | Incoming task changes from the source in rows per second.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| `CDCThroughputRowsTarget`                    | Outgoing task changes for the target in rows per second.|

## Object {#object}

The collected AWS DMS object data structure, You can see the object data from「Infrastructure-Custom」

```json
{
  "measurement": "aws_gateway",
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

> *Note: The fields in 'tags' may change with subsequent updates*
>
> Tip 1: The 'name' value is the instance ID and serves as a unique identifier
