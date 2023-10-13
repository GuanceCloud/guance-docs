---
title     : '东方通 THS（TongHttpServer）'
summary   : '采集东方通 THS（TongHttpServer）运行指标信息'
__int_icon: 'icon/dongfangtong'
dashboard :
  - desc  : '东方通 THS（TongHttpServer）监控视图'
    path  : 'dashboard/zh/dongfangtong_ths'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# 东方通 THS（TongHttpServer）
<!-- markdownlint-enable -->

## 安装配置 {#config}

### 配置 api 监控接口

api 监控接口只需在一个虚拟主机中设置 ,`THS` 支持 HTTP 数据统计, 其他应用可根据`路由`名加`/http/monitor/format/json` 获取 `json`数据,集成到监控系统中。

默认调整 `httpserver.conf`

```nginx
    location /api {
        access_log off;
        api write=off;
        status_bypass on;
        allow 127.0.0.1;
        deny all;
    }
```


### 开启 Exporter

由于`THS` 自带的 API 接口返回数据为 `json` 格式，不符合 `metric` ，所以需要额外编写 `exporter` 进行转换，**期待官方能够自行转换**。

- 下载

下载地址 `https://github.com/lrwh/dongfangtong-ths-exporter/releases`

- 运行

**注意 `jdk` 版本，需要 `jdk1.8` 及以上版本**

```shell
java -jar dongfangtong-ths-exporter.jar --ths.url=http://localhost:8080/api/http/monitor/format/json
```


### DataKit 开启采集器

由于`dongfangtong-ths-exporter`能够直接暴露`metrics` url，所以可以直接通过[`prom`](./prom.md)采集器进行采集。



调整内容如下：

```toml

urls = ["http://localhost:8081/ths/metrics"]

source = "ths-prom"

interval = "10s"

```

<!-- markdownlint-disable MD033 -->
<font color="red">*其他配置按需调整*</font>
<!-- markdownlint-enable -->
，调整参数说明 ：

- urls：`prometheus`指标地址，这里填写对应组件暴露出来的指标 url
- source：采集器别名，建议做区分
- interval：采集间隔

### 重启 DataKit

[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service)

## 指标 {#metric}

| 指标 | 描述 |
| -- | -- |
| `ths_info_up` | 启动信息 |
| `ths_server_zone_response` | zone response |
| `ths_server_zone_request` | zone request |
| `ths_server_zone_traffic` | zone traffic |
| `ths_shared_zone_size` | zone size |
| `ths_server_zone_over_count` | zone over count|
| `ths_connections` | `ths` connects |


更多指标信息[参考文档](https://github.com/lrwh/dongfangtong-ths-exporter/blob/main/TongHttpServer%20v6.0%E7%94%A8%E6%88%B7%E6%89%8B%E5%86%8C.pdf)

