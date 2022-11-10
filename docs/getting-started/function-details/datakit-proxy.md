# Datakit 代理实现局域网数据统一汇聚
---

## 概述

企业内部出于安全原因，通常会进行网络管控，比如设置防火墙、安全组隔离、甚至划分 DMZ 区域。在没有公网的环境下，如何把这部分数据统一汇总处理，并且发送到观测云平台呢？Datakit 提供了代理功能。
## 前置条件

您需要先创建一个 [观测云账号](https://www.guance.com)，并在您的主机上 [安装 DataKit](../../datakit/datakit-install.md) ，作为代理主机需要能够访问公网。

## 代理功能

### 1. 开启代理
登录代理主机 (可访问公网)，开启 proxy 插件
```
cd /usr/local/datakit/conf.d/proxy
cp proxy.conf.sample proxy.conf
```
配置文件 proxy.conf 内容如下 (默认监听 9530 端口)
```
[[inputs.proxy]]
  ## default bind ip address
  bind = "0.0.0.0" 
  ## default bind port
  port = 9530
```
重启 Datakit
```
systemctl restart datakit
```
### 2. 离线安装
登录局域网内的主机 (无公网)，执行安装命令，并修改参数 

- proxy_ip，代理主机内网 ip
- token，工作空间的 token
```
export HTTPS_PROXY=http://<proxy_ip>:9530; DK_DATAWAY=https://openway.guance.com?token=<token> bash -c "$(curl -L https://static.guance.com/datakit/install.sh)"
```
工作空间 token 可以在管理 - 基本设置获取。

![](../img/8.datakit_proxy.png)

