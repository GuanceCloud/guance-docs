# DataKit的强大自维护能力，状态及文档集成
---

## 概述

当用户通过 DataKit 进行数据接入时，不希望频繁的在更改配置的同时又在外部浏览器中查询配置方法，又不能在配置完成后频繁的去观测云平台查看是否有数据上报，为了以上种种用户体验问题， DataKit 内置很多不同的小工具，便于日常使用。

本指南为您介绍 DataKit 所提供的 一些便捷的小工具，来提高我们的使用效率。

## 前置条件
您需要先创建一个 [观测云账号](https://www.guance.com)，并在您的主机上 [安装 DataKit](../../datakit/datakit-install.md) 。
## 查看 DataKit 运行情况
在终端即可查看 DataKit 运行情况：
```shell
datakit --monitor     # 或者 datakit -M
# 同时可查看采集器开启情况：
datakit -M --vvv
```
![](../img/10.datakit_help_1.png)

注：Windows 下暂不支持在终端查看 monitor 数据，只能在浏览器端查看。

## 查看采集器配置是否正确
编辑完采集器的配置文件后，可能某些配置有误（如配置文件格式错误），通过如下命令可检查是否正确：
```shell
sudo datakit --check-config
------------------------
checked 13 conf, all passing, cost 22.27455ms
```
![](../img/10.datakit_help_2.png)
## 查看帮助文档
为便于用户不用这么频繁的切换界面可以直接在服务端查看 DataKit 帮助文档，DataKit 提供如下交互式文档查看入口（Windows 不支持）：
```shell
datakit --man
man> nginx
(显示 Nginx 采集文档)
man> mysql
(显示 MySQL 采集文档)
man> Q               # 输入 Q 或 exit 退出
```
![](../img/10.datakit_help_3.png)
## 查看工作空间信息
为了便于用户在需要时可以直接在服务端查看工作空间信息，DataKit 提供如下命令查看：
```shell
datakit --workspace-info
{
  "token":{
   "ws_uuid":"wksp_2dc431d6693711eb8ff97aeee04b54af",
   "bill_state":"normal",
   "ver_type":"pay",
   "token":"tkn_2dc438b6693711eb8ff97aeee04b54af",
   "db_uuid":"ifdb_c0fss9qc8kg4gj9bjjag",
   "status":0,
   "creator":"",
   "expire_at": -1,
   "create_at":0,
   "update_at":0,
   "delete_at":0
  },
  "data_usage":{
   "data_metric":96966,
   "data_logging":3253,
   "data_tracing":2868,
   "data_rum":0,
   "is_over_usage":false
  }
}
```
## 查看 DataKit 相关事件
DataKit 运行过程中，一些关键事件会以日志的形式进行上报，比如 DataKit 的启动、采集器的运行错误等。在命令行终端，可以通过 dql 进行查询。
```shell
sudo datakit --dql


dql > L::datakit limit 10;


-----------------[ r1.datakit.s1 ]-----------------
    __docid 'L_c6vvetpaahl15ivd7vng'
  category 'input'
create_time 1639970679664
    date_ns 835000
       host'demo'
    message 'elasticsearch Get "http://myweb:9200/_nodes/_local/name": dial tcp 150.158.54.252:9200: connect: connection refused'
     source'datakit'
    status 'warning'
       time2022-01-13 11:24:34 +0800 CST
-----------------[ r2.datakit.s1 ]-----------------
    __docid 'L_c6vvetpaahl15ivd7vn0'
  category 'input'
create_time 1639970679664
    date_ns 67000
       host'demo'
    message 'postgresql pq: password authentication failed for user "postgres"'
     source'datakit'
    status 'warning'
       time2022-01-13 11:24:32 +0800 CST
-----------------[ r3.datakit.s1 ]-----------------
    __docid 'L_c6tish1aahlf03dqas00'
  category 'default'
create_time 1639657028706
    date_ns 246000
       host'zhengs-MacBook-Pro.local'
    message 'datakit start ok, ready for collecting metrics.'
     source'datakit'
    status 'info'
       time2022-01-13 11:16:58 +0800 CST       
         
         ...
```
## 上传 DataKit 运行日志
排查 DataKit 问题时，通常需要检查 DataKit 运行日志，为了简化日志搜集过程，DataKit 支持一键上传日志文件：
```shell
sudo datakit --upload-log
log info: path/to/tkn_xxxxx/your-hostname/datakit-log-2021-11-08-1636340937.zip
```
将这个路径信息发送给我们工程师即可。运行命令后，会将日志目录下的所有日志文件进行打包压缩，然后上传至指定的存储。我们的工程师会根据上传日志的主机名以及 Token 传找到对应文件，进而排查 DataKit 问题。

## 查看云属性数据
如果安装 DataKit 所在的机器是一台云服务器（目前支持 aliyun/tencent/aws/hwcloud/azure 这几种），可通过如下命令查看部分云属性数据，如（标记为 - 表示该字段无效）：
```shell
datakit --show-cloud-info aws


          cloud_provider: aws
              description: -
    instance_charge_type: -
              instance_id: i-09b37dc1xxxxxxxxx
            instance_name: -
    instance_network_type: -
          instance_status: -
            instance_type: t2.nano
              private_ip: 172.31.22.123
                  region: cn-northwest-1
        security_group_id: launch-wizard-1
                  zone_id: cnnw1-az2
```

