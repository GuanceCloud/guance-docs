# 构建内网API的可用性观测
## 概述

可用性监测支持通过观测云控制台自定义云拨测数据采集。通过创建拨测任务，您可以周期性的监控基于`HTTP、TCP、ICMP、WEBSOCKET`等不同协议的拨测任务，全面监测不同地区、不同运营商到各个服务的网络性能、网络质量、网络数据传输稳定性等状况。通过实时监测，统计拨测任务可用情况，提供拨测任务日志和实时告警，帮助您快速发现网络问题，提高网络访问质量。

对于公网站点的可用性监测，观测云提供了16个默认的节点以供拨测，但这些节点不能访问您的内网站点。为了监测内网的可用性，需要您在内网自建节点，通过该节点访问您的内网站点，从而判断可用性。

本文将介绍在观测云如何构建一个内网 API 可用性监测。

## 前置条件

您需要先创建一个[观测云账号](https://www.guance.com)，并在您的主机上[安装 DataKit](https://www.yuque.com/dataflux/datakit/datakit-install)。

## 操作流程图

![](../img/4.keyongxing_1.png)

## 操作步骤

### 创建自建节点

通过「可用性监测」-「自建节点管理」，点击「新建节点」，创建一个新的节点。

![](../img/4.keyongxing_2.png)

完成「新建节点」后，在「自建节点管理」的列表中获取该节点的「配置信息」

![](../img/4.keyongxing_3.png)

### 开启采集器

进入 DataKit 安装目录下的 conf.d/network 目录，复制 `dialtesting.conf.sample` 并命名为 `dialtesting.conf` 把获取的云拨测自建节点的配置信息填入 `dailtesting.conf` 文件

![](../img/4.keyongxing_4.png)



配置完成后，使用命令 `datakit --restart` 重启DataKit，使配置生效。

### 配置API拨测自建节点

按照如下内容配置 API 拨测任务。
● 选择拨测类型： HTTP 协议
● 定义请求格式：选择GET，输入内网url
● 高级设置：可根据实际情况进行高级设置
● 名称：用户自定义的云拨测名称
● 可用判断：依据该条件判断该站点是否可用
● 选择拨测节点：自建节点
● 选择拨测频率：任意

![](../img/4.keyongxing_5.png)

### 在查看器查看拨测数据

![](../img/4.keyongxing_6.png)