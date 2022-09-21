
# Consul
---

## 视图预览

consul 性能指标展示：包括监控状态、集群中服务数量、集群中成员数量、集群中成员的状态等。

![image](imgs/input-consul-1.png)

## 版本支持

操作系统支持：Linux 

## 前置条件

- consul 所在服务器 <[安装 DataKit](../datakit/datakit-install.md)>
- 启动consul

```
./consul agent -dev   
```

- 启动consul_exporter

```
./consul_exporter
```

## 安装配置

说明：示例 consul 版本为：[consul:1.9.9](https://releases.hashicorp.com/consul/1.9.9/consul_1.9.9_linux_amd64.zip)(CentOS环境)，各个不同版本指标可能存在差异。
示例consul_exporter版本是：[consul_exporter-0.7.1](https://github.com/prometheus/consul_exporter/releases/download/v0.7.1/consul_exporter-0.7.1.linux-amd64.tar.gz)。

### 部署实施

#### 指标采集 (必选)

1、 开启consul插件，复制sample文件 

```
cd /usr/local/datakit/conf.d/consul
cp consul.conf.sample consul.conf  
```

2、 修改consul.conf配置文件

```
vi consul.conf
```

```
[[inputs.prom]]
  ## Exporter 地址
  url = "http://127.0.0.1:9107/metrics"

  ## 采集器别名
  source = "consul"

  ## 指标类型过滤, 可选值为 counter, gauge, histogram, summary
  # 默认只采集 counter 和 gauge 类型的指标
  # 如果为空，则不进行过滤
  metric_types = ["counter", "gauge"]

  ## 指标名称过滤
  # 支持正则，可以配置多个，即满足其中之一即可
  # 如果为空，则不进行过滤
    metric_name_filter = ["consul_raft_leader", "consul_raft_peers", "consul_serf_lan_members", "consul_catalog_service", "consul_catalog_service_node_healthy", "consul_health_node_status", "consul_serf_lan_member_status"]


  ## 指标集名称前缀
  # 配置此项，可以给指标集名称添加前缀
  measurement_prefix = ""

  ## 过滤tags, 可配置多个tag
  # 匹配的tag将被忽略
  tags_ignore = ["check"]

  ## 采集间隔 "ns", "us" (or "µs"), "ms", "s", "m", "h"
  interval = "10s"

  ## 自定义指标集名称
  # 可以将包含前缀prefix的指标归为一类指标集
  # 自定义指标集名称配置优先measurement_name配置项
  [[inputs.prom.measurements]]
  	prefix = "consul_"
	  name = "consul"
 
```

参数说明

- url：consul exporter监听地址
- source：采集器别名
- metric_types：指标类型过滤
- metric_name_filter：指标名称过滤
- measurement_prefix：指标集名称前缀
- measurement_name：指标集名称
- interval：采集间隔
- tags_ignore：匹配的tag将被忽略

3、 重启 DataKit

```
systemctl restart datakit
```

指标预览

![image](imgs/input-consul-2.png)

#### 插件标签 (非必选)

参数说明

- 该配置为自定义标签，可以填写任意 key-value 值
- 以下示例配置完成后，所有 consul 指标都会带有 app = oa 的标签，可以进行快速查询
- 相关文档 <[DataFlux Tag 应用最佳实践](../best-practices/insight/tag.md)>

```
[inputs.prom.tags]
  metrics_from="consul"  
```

重启 DataKit

```
systemctl restart datakit
```

## 场景视图

<场景 - 新建仪表板 - 内置模板库 - Consul 监控视图>

## 检测库

暂无

## 指标详解

<[consul指标详情](../best-practices/insight/tag)>

## 常见问题排查

<[无数据上报排查](../datakit/why-no-data.md)>



