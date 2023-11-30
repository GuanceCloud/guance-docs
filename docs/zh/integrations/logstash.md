---
title     : 'Logstash'
summary   : '通过 Logstash 采集日志信息'
__int_icon: 'icon/logstash'
dashboard :
  - desc  : '暂无'
    path  : '-'
monitor   :
  - desc  : '暂无'
    path  : '-'
---


<!-- markdownlint-disable MD025 -->
# Logstash
<!-- markdownlint-enable -->

通过 Logstash 采集日志信息。

## 安装部署 {#config}

### DataKit 开启 `logstreaming` 采集器

- 开启 `logstreaming` 采集器

进入 DataKit 安装目录下的 `conf.d/log` 目录，复制 `logstreaming.conf.sample` 并命名为 `logstreaming.conf`。

```toml
[inputs.logstreaming]
  ignore_url_tags = true
```

关于 `logstreaming` 采集器详细介绍参考[官方文档](logstreaming.md)

- 重启 DataKit

    [重启 DataKit](../datakit/datakit-service-how-to.md#manage-service)

### Logstash 配置调整

DataKit 使用 `logstreaming` 采集器来采集 Logstash 上报的日志信息，所以 Logstash 需要将 `output` 地址指向 `logstreaming` 采集器的接收地址。

```yaml
    ....
## 将收集到的数据发送给 DataKit
output {  
    http {
        http_method => "post"
        format => "json"
        url => "http://127.0.0.1:9529/v1/write/logstreaming?source=nginx"
    }
}
```

- `url` ：地址为 DataKit 采集器地址，按实际情况调整。
- `source`：标识数据来源，即行协议的 `measurement`。例如 `nginx` 或者 `redis` (`/v1/write/logstreaming?source=nginx`)


关于 `logstreaming` 采集器参数介绍参考[官方文档](logstreaming.md#args)


调整完毕后，重启 Logstash 使之配置生效。

