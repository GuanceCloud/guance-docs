---
title: '阿里云 SAE'
tags: 
  - 阿里云
summary: '采集阿里云 SAE 的指标信息'
__int_icon: 'icon/aliyun_sae'
dashboard:
  - desc: '阿里云 SAE 监控视图'
    path: 'dashboard/zh/aliyun_sae/'
monitor:
  - desc: '阿里云 SAE 监控器'
    path: 'monitor/zh/aliyun_sae/'
---

<!-- markdownlint-disable MD025 -->
# 阿里云 SAE
<!-- markdownlint-enable -->

采集阿里云 SAE（Serverless App Engine）的指标信息。


## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的阿里云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 SAE 的监控数据，我们安装对应的采集脚本：「观测云集成（阿里云-SAE-应用）」(ID：`guance_aliyun_sae_app`) 和 「观测云集成（阿里云-SAE-应用实例）」(ID：`guance_aliyun_sae_app_instance`)

点击【安装】后，输入相应的参数：阿里云 AK、阿里云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}

配置完阿里云-SAE 基础监控指标,默认的指标集如下, 可以通过配置的方式采集更多的指标 [SAE 基础监控指标详情](https://help.aliyun.com/zh/sae/serverless-app-engine-upgrade/user-guide/sae-2-microservices-sae-basic-monitoring-indicators?spm=5176.21213303.J_qCOwPWspKEuWcmp8qiZNQ.1.2a872f3dTrQiFH&scm=20140722.S_help@@%E6%96%87%E6%A1%A3@@2773772._.ID_help@@%E6%96%87%E6%A1%A3@@2773772-RL_acs~UND~serverless-LOC_llm-OR_ser-PAR1_213e38dc17286368694255187e16f5-V_3-RE_new4@@cardNew){:target="_blank"}


|指标 | 单位 | Dimensions | 描述 |
| -- | -- | -- |-- |
|`cpu_Average`|%|userId、appId|应用CPU|
|`diskIopsRead_Average`|Count/Second|userId、appId|应用磁盘IOPS读|
|`diskIopsWrite_Average`|Count/Second|userId、appId|应用磁盘IOPS写|
|`diskRead_Average`|Byte/Second|userId、appId|应用磁盘IO吞吐率读|
|`diskTotal_Average`|Kilobyte|userId、appId|应用磁盘总量|
|`diskUsed_Average`|Kilobyte|userId、appId|应用磁盘使用量|
|`diskWrite_Average`|Byte/Second|userId、appId|应用磁盘IO吞吐率写|
|`instanceId_memoryUsed_Average`|MB|userId、appId、instanceId|实例已使用内存|
|`instance_cpu_Average`|%|userId、appId、instanceId|实例CPU|
|`instance_diskIopsRead_Average`|Count/Second|userId、appId、instanceId|实例磁盘IOPS读|
|`instance_diskIopsWrite_Average`|Count/Second|userId、appId、instanceId|实例磁盘IOPS写|
|`instance_diskRead_Average`|Byte/Second|userId、appId、instanceId|实例磁盘IO吞吐率读|
|`instance_diskTotal_Average`|Kilobyte|userId、appId、instanceId|实例磁盘总量|
|`instance_diskUsed_Average`|Kilobyte|userId、appId、instanceId|实例磁盘使用量|
|`instance_diskWrite_Average`|Byte/Second|userId、appId、instanceId|实例磁盘IO吞吐率写|
|`instance_load_Average`|min|userId、appId、instanceId|实例平均负载|
|`instance_memoryTotal_Average`|MB|userId、appId、instanceId|实例总内存|
|`instance_memoryUsed_Average`|MB|userId、appId、instanceId|实例已使用内存|
|`instance_netRecv_Average`|Byte/Second|userId、appId、instanceId|实例接收字节|
|`instance_netRecvBytes_Average`|Byte|userId、appId、instanceId|实例总接收字节|
|`instance_netRecvDrop_Average`|Count/Second|userId、appId、instanceId|实例接收数据丢包|
|`instance_netRecvError_Average`|Count/Second|userId、appId、instanceId|实例接收错误数据包|
|`instance_netRecvPacket_Average`|Count/Second|userId、appId、instanceId|实例接收数据包|
|`instance_netTran_Average`|Byte/Second|userId、appId、instanceId|实例发送字节|
|`instance_netTranBytes_Average`|Byte|userId、appId、instanceId|实例总发送字节|
|`instance_netTranDrop_Average`|Count/Second|userId、appId、instanceId|实例发送数据丢包|
|`instance_netTranError_Average`|Count/Second|userId、appId、instanceId|实例发送错误数据包|
|`instance_netTranPacket_Average`|Count/Second|userId、appId、instanceId|实例发送数据包|
|`instance_tcpActiveConn_Average`|Count|userId、appId、instanceId|实例活跃TCP连接数|
|`instance_tcpInactiveConn_Average`|Count|userId、appId、instanceId|实例非活跃TCP连接数|
|`instance_tcpTotalConn_Average`|Count|userId、appId、instanceId|实例总TCP连接数|
|`load_Average`|min|userId、appId|应用平均负载|
|`memoryTotal_Average`|MB|userId、appId|应用总内存|
|`memoryUsed_Average`|MB|userId、appId|应用已使用内存|
|`netRecv_Average`|Byte/Second|userId、appId|应用接收字节|
|`netRecvBytes_Average`|Byte|userId、appId|应用总接收字节|
|`netRecvDrop_Average`|Count/Second|userId、appId|应用接收数据丢包|
|`netRecvError_Average`|Count/Second|userId、appId|应用接收错误数据包|
|`netRecvPacket_Average`|Count/Second|userId、appId|应用接收数据包|
|`netTran_Average`|Byte/Second|userId、appId|应用发送字节|
|`netTranBytes_Average`|Byte|userId、appId|应用总发送字节|
|`netTranDrop_Average`|Count/Second|userId、appId|应用发送数据丢包|
|`netTranError_Average`|Count/Second|userId、appId|应用发送错误数据包|
|`netTranPacket_Average`|Count/Second|userId、appId|应用发送数据包|
|`tcpActiveConn_Average`|Count|userId、appId|应用活跃TCP连接数|
|`tcpInactiveConn_Average`|Count|userId、appId|应用非活跃TCP连接数|
|`tcpTotalConn_Average`|Count|userId、appId|应用总TCP连接数|
