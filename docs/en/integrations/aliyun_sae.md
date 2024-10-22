---
title: 'Aliyun SAE'
tags: 
  - Alibaba Cloud
summary: 'Collect metric information for Aliyun SAE (Serverless App Engine)'
__int_icon: 'icon/aliyun_sae'
dashboard:
  - desc: 'Aliyun SAE '
    path: 'dashboard/en/aliyun_sae/'
monitor:
  - desc: 'Aliyun SAE Monitor'
    path: 'monitor/en/aliyun_sae/'
---

<!-- markdownlint-disable MD025 -->
# Aliyun SAE
<!-- markdownlint-enable -->

Collect metric information for Aliyun SAE (Serverless App Engine).

## Configuration {#config}

### Install Func

It is recommended to enable the Observability Cloud Integration - Extension - Managed Edition Func: All prerequisites are automatically installed, please proceed with the script installation.

If you want to deploy Func on your own, please refer to [Deploy Func on Your Own](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare Aliyun Access Key (AK) that meets the requirements in advance (For simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize monitoring data from Aliyun SAE , we will install the corresponding collection script:

- ID：`guance_aliyun_sae_app`
- ID：`guance_aliyun_sae_app_instance`

After clicking "Install", enter the corresponding parameters: Aliyun AK, Aliyun account name.

tap **Deploy startup Script**，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

After this function is enabled, you can view the automatic triggering configuration in "**Management / Crontab Config**". Click "**Run**"，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs。

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}

### Verification

1. In "Management / Auto Trigger Configuration", confirm whether the corresponding task has the automatic trigger configuration and check for task records and logs for any abnormalities.
2. In the Guance platform, under "Infrastructure / Custom", check if there is asset information.
3. In the Guance platform, under "Metrics", check for corresponding monitoring data.

## Metrics {#metric}
After configuring Aliyun SAE Monitor, the default set of metrics are as follows. You can collect more metrics by configuring [SAE Details of Basic Monitoring Metrics](https://help.aliyun.com/zh/sae/serverless-app-engine-upgrade/user-guide/sae-2-microservices-sae-basic-monitoring-indicators?spm=5176.21213303.J_qCOwPWspKEuWcmp8qiZNQ.1.2a872f3dTrQiFH&scm=20140722.S_help@@%E6%96%87%E6%A1%A3@@2773772._.ID_help@@%E6%96%87%E6%A1%A3@@2773772-RL_acs~UND~serverless-LOC_llm-OR_ser-PAR1_213e38dc17286368694255187e16f5-V_3-RE_new4@@cardNew){:target="_blank"}

| Metric Name | Unit | Dimensions | Description |
| -- | -- | -- | -- |
| cpu_Average | % | userId, appId | Application CPU |
| diskIopsRead_Average | Count/Second | userId, appId | Application Disk IOPS Read |
| diskIopsWrite_Average | Count/Second | userId, appId | Application Disk IOPS Write |
| diskRead_Average | Byte/Second | userId, appId | Application Disk IO Throughput Read |
| diskTotal_Average | Kilobyte | userId, appId | Application Disk Total |
| diskUsed_Average | Kilobyte | userId, appId | Application Disk Usage |
| diskWrite_Average | Byte/Second | userId, appId | Application Disk IO Throughput Write |
| instanceId_memoryUsed_Average | MB | userId, appId, instanceId | Instance Used Memory |
| instance_cpu_Average | % | userId, appId, instanceId | Instance CPU |
| instance_diskIopsRead_Average | Count/Second | userId, appId, instanceId | Instance Disk IOPS Read |
| instance_diskIopsWrite_Average | Count/Second | userId, appId, instanceId | Instance Disk IOPS Write |
| instance_diskRead_Average | Byte/Second | userId, appId, instanceId | Instance Disk IO Throughput Read |
| instance_diskTotal_Average | Kilobyte | userId, appId, instanceId | Instance Disk Total |
| instance_diskUsed_Average | Kilobyte | userId, appId, instanceId | Instance Disk Usage |
| instance_diskWrite_Average | Byte/Second | userId, appId, instanceId | Instance Disk IO Throughput Write |
| instance_load_Average | min | userId, appId, instanceId | Instance Average Load |
| instance_memoryTotal_Average | MB | userId, appId, instanceId | Instance Total Memory |
| instance_memoryUsed_Average | MB | userId, appId, instanceId | Instance Used Memory |
| instance_netRecv_Average | Byte/Second | userId, appId, instanceId | Instance Received Bytes |
| instance_netRecvBytes_Average | Byte | userId, appId, instanceId | Instance Total Received Bytes |
| instance_netRecvDrop_Average | Count/Second | userId, appId, instanceId | Instance Received Packet Drops |
| instance_netRecvError_Average | Count/Second | userId, appId, instanceId | Instance Received Error Packets |
| instance_netRecvPacket_Average | Count/Second | userId, appId, instanceId | Instance Received Packets |
| instance_netTran_Average | Byte/Second | userId, appId, instanceId | Instance Transmitted Bytes |
| instance_netTranBytes_Average | Byte | userId, appId, instanceId | Instance Total Transmitted Bytes |
| instance_netTranDrop_Average | Count/Second | userId, appId, instanceId | Instance Transmitted Packet Drops |
| instance_netTranError_Average | Count/Second | userId, appId, instanceId | Instance Transmitted Error Packets |
| instance_netTranPacket_Average | Count/Second | userId, appId, instanceId | Instance Transmitted Packets |
| instance_tcpActiveConn_Average | Count | userId, appId, instanceId | Instance Active TCP Connections |
| instance_tcpInactiveConn_Average | Count | userId, appId, instanceId | Instance Inactive TCP Connections |
| instance_tcpTotalConn_Average | Count | userId, appId, instanceId | Instance Total TCP Connections |
| load_Average | min | userId, appId | Application Average Load |
| memoryTotal_Average | MB | userId, appId | Application Total Memory |
| memoryUsed_Average | MB | userId, appId | Application Used Memory |
| netRecv_Average | Byte/Second | userId, appId | Application Received Bytes |
| netRecvBytes_Average | Byte | userId, appId | Application Total Received Bytes |
| netRecvDrop_Average | Count/Second | userId, appId | Application Received Packet Drops |
| netRecvError_Average | Count/Second | userId, appId | Application Received Error Packets |
| netRecvPacket_Average | Count/Second | userId, appId | Application Received Packets |
| netTran_Average | Byte/Second | userId, appId | Application Transmitted Bytes |
| netTranBytes_Average | Byte | userId, appId | Application Total Transmitted Bytes |
| netTranDrop_Average | Count/Second | userId, appId | Application Transmitted Packet Drops |
| netTranError_Average | Count/Second | userId, appId | Application Transmitted Error Packets |
| netTranPacket_Average | Count/Second | userId, appId | Application Transmitted Packets |
| tcpActiveConn_Average | Count | userId, appId | Application Active TCP Connections |
| tcpInactiveConn_Average | Count | userId, appId | Application Inactive TCP Connections |
| tcpTotalConn_Average | Count | userId, appId | Application Total TCP Connections |
