---
title: '腾讯云 Memcached'
tags: 
  - 腾讯云
summary: '使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>'
__int_icon: 'icon/tencent_memcached'
dashboard:

  - desc: '腾讯云 Memcached 内置视图'
    path: 'dashboard/zh/tencent_memcached'

monitor:
  - desc: '腾讯云 Memcached 监控器'
    path: 'monitor/zh/tencent_memcached'

---

<!-- markdownlint-disable MD025 -->
# 腾讯云 Memcached
<!-- markdownlint-enable -->

使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>

## 配置 {#config}

### 安装 Func

推荐开通 <<< custom_key.brand_name >>>集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### 安装脚本

> 提示：请提前准备好符合要求的腾讯云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 Memcached 云资源的监控数据，我们安装对应的采集脚本：「<<< custom_key.brand_name >>>集成（腾讯云-Memcached 采集）」(ID：`guance_tencentcloud_memcached`)

点击【安装】后，输入相应的参数：腾讯云 AK、腾讯云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://<<< custom_key.func_domain >>>/doc/script-market-guance-tencentcloud-memcached/){:target="_blank"}

### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在<<< custom_key.brand_name >>>，「基础设施 / 自定义」中查看是否存在资产信息
3. 在<<< custom_key.brand_name >>>，「指标」查看是否有对应监控数据

## 指标 {#metric}

配置好腾讯云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [腾讯云云监控指标详情](https://cloud.tencent.com/document/product/248/62458){:target="_blank"}


| 指标英文名      | 含义           |   单位  | 维度                 |
| --------------- | ---------------------- |  ----- |--------------------|
| `allocsize`       | 已经分配的容量空间           |  MBytes    | InstanceName（实例 名） |
| `usedsize`         | 已使用的容量空间           |  MBytes    |InstanceName（实例 名）      |
| `get`       | GET命令每秒执行次数           |   Count/s   | InstanceName（实例 名）     |
| `set`       | SETT命令每秒执行次数           | Count/s   | InstanceName（实例 名）     |
| `delete`        | DELETE命令每秒执行次数        |   Count/s   | InstanceName（实例 名）     |
| `error`       | 错误命令           |       Count/s   | InstanceName（实例 名）     |
| `latency`      | 平均访问延迟       |  ms   | InstanceName（实例 名）    |
| `qps`           | 总请求次数         |    Count/s | InstanceName（实例 名）     |

## 对象 {#object}

采集到的腾讯云 Memcached 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
  "measurement": "tencentcloud_memcached",
  "tags": {
    "account_name": "Tencent",
    "class": "tencentcloud_memcached",
    "cloud_provider": "tencentcloud",
    "InstanceId": "cmem-xxxxx",
    "InstanceName": "0829-mh-xxxxx",
    "name": "cmem-xxxxxxx",
    "RegionId": "ap-shanghai"
  }
}
```

> *注意： `tags` 中的字段可能会随后续更新有所变动*
