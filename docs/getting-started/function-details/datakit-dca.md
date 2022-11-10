# DCA通过客户端友好管理datakit的配置
---

## 概述：

当您的公司部署了多个datakit 后，为了方便管理这些 datakit，观测云提供了一个可视化的工具 DCA。
## 前置条件

您需要先创建一个 [观测云账号](https://www.guance.com)，并在您的主机上 [安装 DataKit](../../datakit/datakit-install.md) 。

## 可视化管理您的datakit

### 1. 安装DCA
登录「观测云」-「集成」-「DCA」 按照步骤安装 DCA 。

注意：这里需要安装在一台与所部署的 datakit 同一个内网的服务器上。

![](../img/11.datakit_dca_1.png)

### 2. datakit开启DCA服务

登录一台部署了 datakit 的服务器，执行如下命令：
```
cd /usr/local/datakit/conf.d
vim datakit.conf
```
设置 enable 为 true，设置 white_list 为 ["0.0.0.0/0"] 即允许所有地址访问。

![](../img/11.datakit_dca_2.png)

参数说明

- enable：是否开启 dca，true 为开启。
- listen:  监听地址和端口。
- white_list：白名单，支持指定 IP 地址或者 CIDR 格式网络地址。

如果 DCA 部署在 172.16.0.32 服务器上，datakit 只允许这个 DCA 访问，请设置为：
```
white_list = ["172.16.0.32"]
```
重启 datakit
```
systemctl restart datakit
```
### 3. DCA客户端管理datakit

DCA 开启和安装以后，即可在浏览器输入地址 `localhost:8000` 打开 DCA Web 端，登录账号，选择工作空间，即可查看该工作空间下所有已经安装 DataKit 的主机名和 IP 信息。点击 DataKit 主机，即可远程连接到 DataKit ，查看该主机上 DataKit 的运行情况，包括版本、运行时间、发布日期、采集器运行情况等。

![](../img/11.datakit_dca_3.png)

