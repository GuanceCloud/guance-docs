---
title     : 'Nginx Tracing'
summary   : 'Collect Nginx trace information'
__int_icon: 'icon/nginx'
dashboard :
  - desc  : 'Not available'
    path  : '-'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# Nginx Tracing
<!-- markdownlint-enable -->


## Installation and Configuration {#config}

### Prerequisites

- [x] Install nginx (>=1.9.13)

***This module only supports the Linux operating system***


### Install the Nginx OpenTracing Plugin

The Nginx OpenTracing plugin is an open-source tracing plugin for OpenTracing, written in C++, and can work with `Jaeger`, `Zipkin`, `LightStep`, and `Datadog`.

- [Download](https://github.com/opentracing-contrib/nginx-opentracing/releases) the plugin corresponding to your current Nginx version. You can check your current Nginx version using the following command:

```shell
$ nginx -v
nginx version: nginx/1.18.0 (Ubuntu)
```

- Extract the archive

```shell
tar zxf linux-amd64-nginx-ot16-ngx_http_module.so.tgz -C /usr/lib/nginx/modules
```

- Configure the plugin

Add the following line at the top of the `nginx.conf` file:

```nginx
load_module modules/ngx_http_opentracing_module.so;
```


### Install the DDAgent Nginx OpenTracing Plugin

The DDAgent Nginx OpenTracing plugin is a vendor-specific implementation based on `Nginx OpenTracing`. Different APM providers have their own encoding and decoding implementations.

- [Download `dd-opentracing-cpp`](https://github.com/DataDog/dd-opentracing-cpp/releases/latest), either `libdd_opentracing.so` or `linux-amd64-libdd_opentracing_plugin.so.gz`

- Configure Nginx

```nginx
opentracing_load_tracer /etc/nginx/tracer/libdd_opentracing.so /etc/nginx/tracer/dd.json;
opentracing on; # Enable OpenTracing
opentracing_tag http_user_agent $http_user_agent;
opentracing_trace_locations off;
opentracing_propagate_context;
opentracing_operation_name nginx-$host;
```

`opentracing_load_tracer`: Loads the `OpenTracing` `APM` plugin path  
`opentracing_propagate_context;`: Indicates that context propagation is required along the trace

- Configure DDTrace

The `dd.json` file configures `ddtrace` settings such as `service`, `agent_host`, etc., with the following content:

```json
{
  "environment": "test",
  "service": "nginx",
  "operation_name_override": "nginx.handle",
  "agent_host": "localhost",
  "agent_port": 9529
}
```

- Nginx log configuration

Inject Trace information into Nginx logs. You can edit as follows:

```nginx
log_format with_trace_id '$remote_addr - $http_x_forwarded_user [$time_local] "$request" '
                         '$status $body_bytes_sent "$http_referer" '
                         '"$http_user_agent" "$http_x_forwarded_for" '
                         '"$opentracing_context_x_datadog_trace_id" "$opentracing_context_x_datadog_parent_id"';

access_log /var/log/nginx/access-with-trace.log with_trace_id;
```

> **Note:** The `log_format` keyword tells Nginx that a logging rule is defined here. `with_trace_id` is the name of the rule, which you can modify. Ensure that the same name is used when specifying the log path below to associate it with this logging rule. The path and filename in `access_log` can be changed. Typically, the original Nginx has its own logging rules configured. You can configure multiple logging rules and output different log formats to different files, thus keeping the original `access_log` rule and path unchanged while adding a new log rule with trace information named as a different log file for different log tools to read.

- Verify the plugin is working properly

Run the following command to verify:

```shell
$:/etc/nginx# nginx -t
info: DATADOG TRACER CONFIGURATION - {"agent_url":"http://localhost:9529","analytics_enabled":false,"analytics_sample_rate":null,"date":"2023-09-25T14:33:40+0800","enabled":true,"env":"prod","lang":"cpp","lang_version":"201402","operation_name_override":"nginx.handle","report_hostname":false,"sampling_rules":"[]","service":"nginx","version":"v1.3.7"}
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
```

`info: DATADOG TRACER CONFIGURATION` indicates that DDTrace has been successfully loaded.

### Service Trace Propagation

After Nginx generates trace information, it needs to forward relevant request header information to the backend to form a linked trace between Nginx and the backend.

> *If Nginx trace information does not match DDTrace, check if this step was performed correctly.*

Add the following configuration under the corresponding `server` block's `location`:

```nginx
location ^~ / {
    ...
    proxy_set_header X-datadog-trace-id $opentracing_context_x_datadog_trace_id;
    proxy_set_header X-datadog-parent-id $opentracing_context_x_datadog_parent_id;
    ...
    }
```

### Load Nginx Configuration

Run the following command to apply the Nginx configuration:

```shell
root@liurui:/etc/nginx/tracer# nginx -s reload
info: DATADOG TRACER CONFIGURATION - {"agent_url":"http://localhost:9529","analytics_enabled":false,"analytics_sample_rate":null,"date":"2023-09-25T11:30:10+0800","enabled":true,"env":"prod","lang":"cpp","lang_version":"201402","operation_name_override":"nginx.handle","report_hostname":false,"sampling_rules":"[]","service":"nginx","version":"v1.3.7"}
root@liurui:/etc/nginx/tracer# 
```

If you encounter the following error:

```shell
root@liurui:/etc/nginx/conf.d# nginx -s reload
info: DATADOG TRACER CONFIGURATION - {"agent_url":"http://localhost:9529","analytics_enabled":false,"analytics_sample_rate":null,"date":"2023-09-25T12:28:53+0800","enabled":true,"env":"prod","lang":"cpp","lang_version":"201402","operation_name_override":"nginx.handle","report_hostname":false,"sampling_rules":"[]","service":"nginx","version":"v1.3.7"}
nginx: [warn] could not build optimal proxy_headers_hash, you should increase either proxy_headers_hash_max_size: 512 or proxy_headers_hash_bucket_size: 64; ignoring proxy_headers_hash_bucket_size
```

You need to add the following configuration to the `http` section of the `nginx.conf` file:

```shell
http {

    ...
    proxy_headers_hash_max_size 1024;
    proxy_headers_hash_bucket_size 128;

    ...
}
```