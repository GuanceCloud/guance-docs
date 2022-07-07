
# 采集器配置
---

- DataKit 版本：1.4.6
- 操作系统支持：全平台

启动一个 HTTP Server，接收日志文本数据，上报到观测云。

HTTP URL 固定为：`/v1/write/logstreaming`，即 `http://Datakit_IP:PORT/v1/write/logstreaming`

注：如果 DataKit 以 daemonset 方式部署在 Kubernetes 中，可以使用 Service 方式访问，地址为 `http://datakit-service.datakit:9529`

## 配置

进入 DataKit 安装目录下的 `conf.d/log` 目录，复制 `logstreaming.conf.sample` 并命名为 `logstreaming.conf`。示例如下：

``` toml

[inputs.logstreaming]
  ignore_url_tags = true
 
```

配置好后，重启 DataKit 即可。

### 支持参数 {#args}

logstreaming 支持在 HTTP URL 中添加参数，对日志数据进行操作。参数列表如下：

- `type`：数据格式，目前只支持 `influxdb`。
  - 当 `type` 为 `inflxudb` 时（`/v1/write/logstreaming?type=influxdb`），说明数据本身就是行协议格式（默认 precision 是 `s`），将只添加内置 Tags，不再做其他操作
  - 当此值为空时，会对数据做分行和 pipeline 等处理
- `source`：标识数据来源，即行协议的 measurement。例如 `nginx` 或者 `redis`（`/v1/write/logstreaming?source=nginx`）
  - 当 `type` 是 `influxdb` 时，此值无效
  - 默认为 `default`
- `service`：添加 service 标签字段，例如（`/v1/write/logstreaming?service=nginx_service`）
  - 默认为 `source` 参数值。
- `pipeline`：指定数据需要使用的 pipeline 名称，例如 `nginx.p`（`/v1/write/logstreaming?pipeline=nginx.p`）
- `tags`：添加自定义 tag，以英文逗号 `,` 分割，例如 `key1=value1` 和 `key2=value2`（`/v1/write/logstreaming?tags=key1=value1,key2=value2`）


### 使用方式

- Fluentd 使用 Influxdb Output [文档](https://github.com/fangli/fluent-plugin-influxdb){:target="_blank"}
- Fluentd 使用 HTTP Output [文档](https://docs.fluentd.org/output/http){:target="_blank"}
- Logstash 使用 Influxdb Output [文档](https://www.elastic.co/guide/en/logstash/current/plugins-outputs-influxdb.html){:target="_blank"}
- Logstash 使用 HTTP Output [文档](https://www.elastic.co/guide/en/logstash/current/plugins-outputs-http.html){:target="_blank"}

只需要将 Output Host 配置为 logstreaming URL （`http://Datakit_IP:PORT/v1/write/logstreaming`）并添加对应参数即可。

## 指标集



### `logstreaming 日志接收`

非行协议数据格式时，使用 URL 中的 `source` 参数，如果该值为空，则默认为 `default`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`ip_or_hostname`|request IP or hostname|
|`service`|service 名称，对应 URL 中的 `service` 参数|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`message`|日志正文，默认存在，可以使用 pipeline 删除此字段|string|-|

 
