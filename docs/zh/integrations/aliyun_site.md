---
title: '阿里云 站点监控'
tags: 
  - 阿里云
summary: '阿里云 站点监控主要获取站点拨测信息'
__int_icon: 'icon/aliyun_site'
dashboard:
  - desc: '阿里云 - 站点监控'
    path: 'dashboard/zh/aliyun_site/'
---

<!-- markdownlint-disable MD025 -->

# 阿里云 站点监控
<!-- markdownlint-enable -->

阿里云站点监控主要获取站点拨测信息。


## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的阿里云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

我们安装对应的采集脚本：观测云集成（阿里云-站点监控任务采集）」(ID：`guance_aliyun_site_monitor_task`)

点击【安装】后，输入相应的参数：阿里云 AK、阿里云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏

[配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}

配置好阿里云-站点监控任务采集,默认的指标集如下, 可以通过[阿里云站点监控日志详情](https://help.aliyun.com/zh/cms/developer-reference/api-cms-2019-01-01-describesitemonitorlog?spm=a2c4g.11186623.0.i8){:target="_blank"}查看更多信息


### 标签

| 标签名 | 描述 |
| -- | -- |
| Address | 站点地址 |
| TaskName| 拨测任务名称|
| countryCN| 国家中文名|
| countryEN | 国家英文名|
| cityCN| 城市中文名|
| cityEN| 城市英文名|
| provinceCN| 省份中文名|
| provinceEN| 省份英文名|
| areaCN| 区域中文名|
| areaEN| 区域英文名|


### 指标 `aliyun_site_monitor`

| 指标 | 描述 | 单位 |
| -- | -- | -- |
| `HTTPResponseCode` | http 响应码 | int |
| `HTTPConnectTime` | http 链接时间| seconds|
| `HTTPDNSTime`| DNS 解析时间| seconds|
|`HTTPDownloadTime`| http 下载时间| seconds |
|`HTTPDownloadSpeed`| http 下载速度| Frequency |
|`HTTPDownloadSize`| http 下载大小| bytes |
|`SSLConnectTime`| ssl 链接时间| seconds |
|`redirectTime`| 重定向时间 | seconds |
|`redirectCount`| 重定向次数 | count|
|`tcpConnectTime`| tcp 链接时间| seconds |
|`TotalTime`|总响应时间| seconds |

