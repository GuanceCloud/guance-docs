---
title     : 'Nginx Tracing'
summary   : '采集 Nginx 链路信息'
__int_icon: 'icon/nginx'
dashboard :
  - desc  : '暂无'
    path  : '-'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# Nginx Tracing
<!-- markdownlint-enable -->


## 安装配置 {#config}

### 前提条件

- [x] 安装 nginx (>=1.9.13)

***该模块只支持 linux 操作系统***


### 安装 Nginx OpenTracing 插件

Nginx OpenTracing 插件是 OpenTracing 开源的链路追踪插件，基于 C++ 编写，可以工作于 `Jaeger`、`Zipkin`、`LightStep`、`Datadog`.

- [下载](https://github.com/opentracing-contrib/nginx-opentracing/releases) 与当前 Nginx 版本对应的插件，通过以下命令可以查看当前 Nginx 版本

```shell
$ nginx -v
nginx version: nginx/1.18.0 (Ubuntu)
```

- 解压

```shell
tar zxf linux-amd64-nginx-ot16-ngx_http_module.so.tgz -C /usr/lib/nginx/modules
```

- 配置插件

在 `nginx.conf` 文件最上面新增以下信息

```nginx
load_module modules/ngx_http_opentracing_module.so;
```


### 安装 DDAgent Nginx OpenTracing 插件

DDAgent Nginx OpenTracing 插件是基于`Nginx OpenTracing` 的一套厂商的实现，不同的 APM 会有各自的编解码实现。

- [下载 `dd-opentracing-cpp`](https://github.com/DataDog/dd-opentracing-cpp/releases/latest),`libdd_opentracing.so` 或者 `linux-amd64-libdd_opentracing_plugin.so.gz`

- 配置 Nginx

```nginx

opentracing_load_tracer /etc/nginx/tracer/libdd_opentracing.so /etc/nginx/tracer/dd.json;
opentracing on; # Enable OpenTracing
opentracing_tag http_user_agent $http_user_agent;
opentracing_trace_locations off;
opentracing_propagate_context;
opentracing_operation_name nginx-$host;

```

`opentracing_load_tracer` ： 加载 `opentracing` 的 `apm` 插件路径
`opentracing_propagate_context;` : 表示链路上下文需要进行传递

- 配置 DDTrace

`dd.json` 用于配置 `ddtrace` 信息，如：`service`、`agent_host` 等，内容如下：

```json
{
  "environment": "test",
  "service": "nginx",
  "operation_name_override": "nginx.handle",
  "agent_host": "localhost",
  "agent_port": 9529
}
```

- nginx 日志配置

将 Trace 信息注入到 Nginx 日志中。可按如下示例编辑：

```nginx
log_format with_trace_id '$remote_addr - $http_x_forwarded_user [$time_local] "$request" '
                         '$status $body_bytes_sent "$http_referer" '
                         '"$http_user_agent" "$http_x_forwarded_for" '
                         '"$opentracing_context_x_datadog_trace_id" "$opentracing_context_x_datadog_parent_id"';

access_log /var/log/nginx/access-with-trace.log with_trace_id;
```

> **说明：**`log_format` 关键字告诉 Nginx 这里定义了一套日志规则， `with_trace_id` 是规则名，可以自己修改，注意在下方指定日志路径时要用一样的名字来关联该日志的规则。`access_log` 中的路径和文件名可以更换。通常情况下原 Nginx 是配有日志规则的，我们可以配置多条规则，并将不同的日志格式输出到不同的文件，即保留原 `access_log` 规则及路径不变，新增一个包含 trace 信息的日志规则，命名为不同的日志文件，供不同的日志工具读取。

- 验证插件是否正常使用


执行以下命令进行校验

```shell
$:/etc/nginx# nginx -t
info: DATADOG TRACER CONFIGURATION - {"agent_url":"http://localhost:9529","analytics_enabled":false,"analytics_sample_rate":null,"date":"2023-09-25T14:33:40+0800","enabled":true,"env":"prod","lang":"cpp","lang_version":"201402","operation_name_override":"nginx.handle","report_hostname":false,"sampling_rules":"[]","service":"nginx","version":"v1.3.7"}
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
```

`info: DATADOG TRACER CONFIGURATION` 表示已经成功加载了 DDTrace 。

### 服务链路转发

Nginx 产生链路信息后，需要将相关请求头信息转发给后端，可以形成 Nginx 与后端的链路串联操作。

> *如果出现 Nginx 链路信息与 DDTrace 不匹配，则需要检查这一步是否规范操作。*

需要在对应的 `server` 下的 `location` 添加以下配置

```nginx
location ^~ / {
    ...
    proxy_set_header X-datadog-trace-id $opentracing_context_x_datadog_trace_id;
    proxy_set_header X-datadog-parent-id $opentracing_context_x_datadog_parent_id;
    ...
    }

```

### 加载 Nginx 配置

执行以下命令使 Nginx 配置生效：

```shell
root@liurui:/etc/nginx/tracer# nginx -s reload
info: DATADOG TRACER CONFIGURATION - {"agent_url":"http://localhost:9529","analytics_enabled":false,"analytics_sample_rate":null,"date":"2023-09-25T11:30:10+0800","enabled":true,"env":"prod","lang":"cpp","lang_version":"201402","operation_name_override":"nginx.handle","report_hostname":false,"sampling_rules":"[]","service":"nginx","version":"v1.3.7"}
root@liurui:/etc/nginx/tracer# 
```


如果出现以下错误：

```shell
root@liurui:/etc/nginx/conf.d# nginx -s reload
info: DATADOG TRACER CONFIGURATION - {"agent_url":"http://localhost:9529","analytics_enabled":false,"analytics_sample_rate":null,"date":"2023-09-25T12:28:53+0800","enabled":true,"env":"prod","lang":"cpp","lang_version":"201402","operation_name_override":"nginx.handle","report_hostname":false,"sampling_rules":"[]","service":"nginx","version":"v1.3.7"}
nginx: [warn] could not build optimal proxy_headers_hash, you should increase either proxy_headers_hash_max_size: 512 or proxy_headers_hash_bucket_size: 64; ignoring proxy_headers_hash_bucket_size

```

则需要在 `nginx.conf` 的 `http` 模块追加以下配置：

```shell
http {

    ...
    proxy_headers_hash_max_size 1024;
    proxy_headers_hash_bucket_size 128;

    ...
}

```

