# 采集器「AWS-ELB」配置手册
---


阅读本文前，请先阅读：

- [观测云集成 - 基本操作](/dataflux-func/script-market-guance-integration)

> 提示：使用本采集器前，必须安装「观测云集成（核心包）」及其配套的第三方依赖包

## 1. 配置结构

本采集器配置结构如下：

| 字段         | 类型 | 是否必须 | 说明                                      |
| ------------ | ---- | -------- | ----------------------------------------- |
| `regions`    | list | 必须     | 所需采集的地域列表                        |
| `regions[#]` | str  | 必须     | 地域 ID。如：`'cn-north-1'`<br>总表见附录 |

## 2. 配置示例

采集宁夏、北京地域的实例数据

```python
collector_configs = {
    'regions': [ 'cn-northwest-1', 'cn-north-1' ]
}
```

## 3. 数据上报格式

数据正常同步后，可以在观测云的「基础设施 - 自定义（对象）」中查看数据。

上报的数据示例如下：

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

*注意：`tags`、`fields`*中的字段可能会随后续更新有所变动*

> 提示：AWS ELB 指标集根据不同类型的负载均衡分四种：
>
> 1. Application ELB 对应指标集 `aws_aelb`
> 2. Network ELB 对应指标集 `aws_nelb`
> 3. Gateway ELB 对应指标集 `aws_gelb`
> 4. Classic ELB 对应指标集 `aws_elb`

> 提示 2：`tags.name` 取值方式分两种：
>
> 1. Classic Load Balancers 取 LoadBalancerName 字段。
> 2. Application、Network、Gateway 三类 Load Balancers 截取负载均衡器 ARN 的结尾部分（LoadBalancerArn）。
>
> 以 Network Load Balancer 为例：
>
> `LoadBalancerArn`为`arn:awS-cn:elasticloadbalancing:cn-northwest-1:xxxx1335135:loadbalancer/net/k8s-forethou-kodongin-xxxxa46f01/xxxxe75ae81d08c2`
>
> 对应的`tags.name`为`net/k8s-forethou-kodongin-xxxxa46f01/xxxxe75ae81d08c2`

> 提示 3：
>
> - `fields.message`、`tags.AvailabilityZones` 为 JSON 序列化后字符
> - `tags.state`字段表示 Load Balancers 状态，取值：`active`、`provisioning`、`active_impaired`、`failed` （"classic" 类型负载均衡实例没有该字段）
> - `tags.Type`字段表示 Load Balancers 类型，取值：`application`、`network`、`gateway`、`classic`
> - `tags.Scheme`字段表示 Load Balancers 模式，取值：`internet-facing`、`internal`
> - `fields.ListenerDescriptions`字段为该负载均衡的监听器列表
> - `fields.AvailabilityZones` 字段表示负载均衡器关联的 Amazon Route 53 可用区信息

## X. 附录

请参考 AWS 官方文档：

- [Elastic Load Balancing Documentation](https://docs.aws.amazon.com/elasticloadbalancing/index.html)
- [AWS service endpoints](https://docs.aws.amazon.com/general/latest/gr/rande.html)
