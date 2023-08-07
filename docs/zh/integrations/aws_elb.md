---
title: 'AWS ELB'
summary: '使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云'
__int_icon: 'icon/aws_elb'
dashboard:

  - desc: 'AWS ELB 内置视图'
    path: 'dashboard/zh/aws_elb'

monitor:
  - desc: 'AWS ELB 监控器'
    path: 'monitor/zh/aws_elb'

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
- 「观测云集成（AWS-ELB采集）」(ID：`guance_aws_elb`)

点击【安装】后，输入相应的参数：亚马逊 AK、亚马逊账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好亚马逊-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [亚马逊云监控指标详情](https://docs.aws.amazon.com/zh_cn/elasticloadbalancing/latest/application/load-balancer-cloudwatch-metrics.html){:target="_blank"}

## 对象 {#object}

采集到的AWS ELB 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
  "measurement": "aws_aelb",
  "tags": {
    "name"                 : "app/openway/8e8d762xxxxxx",
    "RegionId"             : "cn-northwest-1",
    "LoadBalancerArn"      : "arn:aws-cn:elasticloadbalancing:cn-northwest-1:588271xxxxx:loadbalancer/app/openway/8e8d762xxxxxx",
    "State"                : "active",
    "Type"                 : "application",
    "VpcId"                : "vpc-2exxxxx",
    "Scheme"               : "internet-facing",
    "DNSName"              : "openway-203509xxxx.cn-northwest-1.elb.amazonaws.com.cn",
    "LoadBalancerName"     : "openway",
    "CanonicalHostedZoneId": "ZM7IZAIxxxxxx"
  },
  "fields": {
    "CreatedTime"         : "2022-03-09T06:13:31Z",
    "ListenerDescriptions": "{JSON 数据}",
    "AvailabilityZones"   : "{可用区 JSON 数据}",
    "message"             : "{实例 JSON 数据}"
  }
}
```

> *注意：`tags`、`fields`*中的字段可能会随后续更新有所变动*
>
> > 提示 1：AWS ELB 指标集根据不同类型的负载均衡分四种：
> >
> > 1. Application ELB 对应指标集 `aws_aelb`
> > 2. Network ELB 对应指标集 `aws_nelb`
> > 3. Gateway ELB 对应指标集 `aws_gelb`
> > 4. Classic ELB 对应指标集 `aws_elb`
> >
> > 提示 2：`tags.name` 取值方式分两种：
> >
> > 1. Classic Load Balancers 取 LoadBalancerName 字段。
> > 2. Application、Network、Gateway 三类 Load Balancers 截取负载均衡器 ARN 的结尾部分（LoadBalancerArn）。
> >
> > 以 Network Load Balancer 为例：
> >
```json
> > LoadBalancerArn`为`arn:awS-cn:elasticloadbalancing:cn-northwest-1:xxxx1335135:loadbalancer/net/k8s-forethou-kodongin-xxxxa46f01/xxxxe75ae81d08c2
> > ```
> >
> > 对应的`tags.name`为`net/k8s-forethou-kodongin-xxxxa46f01/xxxxe75ae81d08c2`
> >
> > 提示 3：
> >
> > - `fields.message`、`tags.AvailabilityZones` 为 JSON 序列化后字符
> > - `tags.state`字段表示 Load Balancers 状态，取值：`active`、`provisioning`、`active_impaired`、`failed` （"classic" 类型负载均衡实例没有该字段）
> > - `tags.Type`字段表示 Load Balancers 类型，取值：`application`、`network`、`gateway`、`classic`
> > - `tags.Scheme`字段表示 Load Balancers 模式，取值：`internet-facing`、`internal`
> > - `fields.ListenerDescriptions`字段为该负载均衡的监听器列表
> > - `fields.AvailabilityZones` 字段表示负载均衡器关联的 Amazon Route 53 可用区信息
