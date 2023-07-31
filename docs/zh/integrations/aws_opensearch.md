---
title: 'AWS OpenSearch'
summary: '使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云'
__int_icon: 'icon/aws_opensearch'
dashboard:

  - desc: 'AWS OpenSearch 内置视图'
    path: 'dashboard/zh/aws_opensearch'

monitor:
  - desc: 'AWS OpenSearch 监控器'
    path: 'monitor/zh/aws_opensearch'

---

使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云

## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### 安装脚本

> 提示：请提前准备好符合要求的亚马逊 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步云资源的监控数据，我们一般情况下要安装两个脚本，一个采集对应云资产基本信息的脚本，一个是采集云监控信息的脚本。

如果要采集对应的日志，还要开启相应的日志采集脚本。如果要采集账单，要开启云账单采集脚本。

分别在「管理 / 脚本市场」中，依次点击并按照对应的脚本包：

- 「观测云集成（AWS-CloudWatch采集）」(ID：`guance_aws_cloudwatch`)
- 「观测云集成（AWS-OpenSearch采集）」(ID：`guance_aws_open_search`)

点击【安装】后，输入相应的参数：亚马逊 AK、亚马逊账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好亚马逊-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [亚马逊云监控指标详情](https://docs.aws.amazon.com/zh_cn/opensearch-service/latest/developerguide/monitoring.html){:target="_blank"}

## 对象 {#object}

采集到的AWS OpenSearch 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
  "measurement": "aws_opensearch",
  "tags": {
    "name"                  : "df-prd-es",
    "EngineVersion"         : "Elasticsearch_7.10",
    "DomainId"              : "5882XXXXX135/df-prd-es",
    "DomainName"            : "df-prd-es",
    "ClusterConfig"         : "{域中的实例类型和实例数量 JSON 数据}",
    "ServiceSoftwareOptions": "{服务软件的当前状态 JSON 数据}",
    "region"                : "cn-northwest-1",
    "RegionId"              : "cn-northwest-1"
  },
  "fields": {
    "EBSOptions": "{指定域的弹性块存储数据 JSON 数据}",
    "Endpoints" : "{用于提交索引和搜索请求的域端点的映射 JSON 数据}",
    "message"   : "{实例 JSON 数据}"
  }
}
```

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示 1：`tags.name`值为实例 ID，作为唯一识别
> 提示 2：本脚本`tags.name`对应的数据字段为`DomainName`，使用本脚本的时候需要注意多个 AWS 账户内不要出现重复的`DomainName`值。
> 提示 3：`tags.ClusterConfig`、`tags.Endpoint`、`tags.ServiceSoftwareOptions`、`fields.message`、`fields.EBSOptions`、`fields.Endpoints`、均为 JSON 序列化后字符串
