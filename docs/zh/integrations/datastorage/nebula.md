---
icon: integrations/nebulagraph
---

# NebulaGraph

---

## 视图预览

NebulaGraph 性能指标展示，包括慢查询、心跳检测、活跃连接数、队列、查询错误等。

![image.png](../imgs/nebula-1.png)

## 版本支持

- 操作系统支持：Linux / Windows
- NebulaGraph 版本：ALL

## 前置条件

- 服务器 <[安装 DataKit](../../datakit/datakit-install.md)>

## 安装配置

说明：示例 NebulaGraph 版本为 3.1.2

### 指标采集 (必选)

NebulaGraph 通过 nebula-stats-exporter 采集相关指标。

1、 使用 netstat 命令查看 nebula-stats-exporter 的实际监听端口

```bash
netstat -tulnp|grep nebula-stats
```

![image.png](../imgs/nebula-3.png)

2、 开启 DataKit promtheus 插件

```shell
cd /usr/local/datakit/conf.d/prom/
cp prom.conf.sample prom.conf
```

3、 修改 `prom.conf` 配置文件

```
[[inputs.prom]]
    urls = ["http://127.0.0.1:9200/metrics"]
  ignore_req_err = false
  source = "prom"
  metric_types = ["counter", "gauge"]
  measurement_prefix = ""
  tls_open = false
  election = true
  [inputs.prom.ignore_tag_kv_match]
  [inputs.prom.http_headers]
  [inputs.prom.tags_rename]
    overwrite_exist_tags = false
    [inputs.prom.tags_rename.mapping]
  [inputs.prom.as_logging]
    enable = false
    service = "service_name"
  [inputs.prom.tags]
```

主要参数说明 ：

- urls：填写 nebula-stats-exporter 暴露出来的指标地址 l
- source：采集器别名
- interval：采集间隔
- metric_name_filter: 指标过滤，只采集需要的指标项
- tls_open：tls 配置
- metric_types：指标类型，如果为空，代表采集所有指标

4、 重启 DataKit

```shell
systemctl restart datakit
```

5、 NebulaGraph 指标采集验证，使用命令 `datakit monitor` 查看指标是否采集成功

![image.png](../imgs/nebula-2.png)

## 场景视图

<场景 - 新建仪表板 - 模板库 - 系统视图 - NebulaGraph 监控视图>

## 指标详解

<[NebulaGraph 监控指标](https://docs.nebula-graph.com.cn/3.3.0/6.monitor-and-metrics/1.query-performance-metrics/)>

## 常见问题排查

<[无数据上报排查](../../datakit/why-no-data.md)>
