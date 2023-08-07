---
title: '华为云 DCS'
summary: '使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云'
__int_icon: 'icon/huawei_dcs'
dashboard:

  - desc: '华为云 DCS 内置视图'
    path: 'dashboard/zh/huawei_dcs'

monitor:
  - desc: '华为云 DCS 监控器'
    path: 'monitor/zh/huawei_dcs'

---

使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云

## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### 安装脚本

> 提示：请提前准备好符合要求的华为云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步云资源的监控数据，我们一般情况下要安装两个脚本，一个采集对应云资产基本信息的脚本，一个是采集云监控信息的脚本。

如果要采集对应的日志，还要开启相应的日志采集脚本。如果要采集账单，要开启云账单采集脚本。

分别在「管理 / 脚本市场」中，依次点击并按照对应的脚本包：

- 「观测云集成（华为云-云监控采集）」(ID：`guance_huaweicloud_ces`)
- 「观测云集成（华为云-DCS采集）」(ID：`guance_huaweicloud_dcs`)

点击【安装】后，输入相应的参数：华为云 AK、华为云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-huaweicloud-ces/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好华为云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [华为云云监控指标详情](https://support.huaweicloud.com/usermanual-dcs/dcs-ug-0713011.html){:target="_blank"}

## 对象 {#object}

```json
{
  "measurement": "huaweicloud_redis",
  "tags": {
    "name"              : "71be0037-xxxx-xxxx-xxxx-b6b91f134066",
    "instance_id"       : "71be0037-xxxx-xxxx-xxxx-b6b91f134066",
    "instance_name"     : "dcs-iash",
    "RegionId"          : "cn-north-4",
    "project_id"        : "c631f04625xxxxxxxxxxf253c62d48585",
    "engine"            : "Redis",
    "engine_version"    : "5.0",
    "status"            : "RUNNING",
    "az_codes"          : "[\"cn-north-4c\", \"cn-north-4a\"]",
    "port"              : "6379",
    "ip"                : "192.xxx.x.144",
    "charging_mode"     : "0",
    "no_password_access": "true",
    "enable_publicip"   : "False"
  },
  "fields": {
    "created_at" : "2022-07-12T07:29:56.875Z",
    "max_memory" : 128,
    "used_memory": 2,
    "capacity"   : 0,
    "description": "",
    "message"    : "{实例 JSON 数据}"
  }
}
```

部分字段说明如下：

| 字段                 | 类型    | 说明                                                         |
| :------------------- | :------ | :----------------------------------------------------------- |
| `ip`                 | String  | 连接缓存实例的 IP 地址。如果是集群实例，返回多个 IP 地址，使用逗号分隔。如：192.168.0.1，192.168.0.2。 |
| `charging_mode`      | String  | 计费模式，0 表示按需计费，1 表示包年/包月计费。              |
| `no_password_access` | String  | 是否允许免密码访问缓存实例： true：该实例无需密码即可访问。 false：该实例必须通过密码认证才能访问 |
| `enable_publicip`    | String  | Redis 缓存实例是否开启公网访问功能 True：开启 False：不开启  |
| `max_memory`         | Integer | 总内存，单位：MB。                                           |
| `used_memory`        | Integer | 已使用的内存，单位：MB。                                     |
| `capacity`           | Integer | 缓存容量（G Byte）。                                         |
| `status`             | String  | CREATING ：申请缓存实例后，在缓存实例状态进入运行中之前的状态。 CREATEFAILED：缓存实例处于创建失败的状态。 RUNNING：缓存实例正常运行状态。 RESTARTING：缓存实例正在进行重启操作。 FROZEN：缓存实例处于已冻结状态，用户可以在“我的订单”中续费开启冻结的缓存实例。 EXTENDING：缓存实例处于正在扩容的状态。 RESTORING：缓存实例数据恢复中的状态。 FLUSHING：缓存实例数据清空中的状态。 |

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示 1：`tags.name`值为实例 ID，作为唯一识别
> 提示 2：以下字段均为 JSON 序列化后字符串 - `fields.message` - `tags.az_codes`
