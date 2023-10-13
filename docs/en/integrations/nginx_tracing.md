---
title     : 'Nginx Tracing'
summary   : 'Collect Nginx tracing information'
__int_icon: 'icon/nginx'
dashboard :
  - desc  : 'No'
    path  : '-'
monitor   :
  - desc  : 'No'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# Nginx Tracing
<!-- markdownlint-enable -->


## Install Configuration{#config}

### Pre-Condition

- [x] Install nginx (>=1.9.13)

***This module only supports the Linux operating system***


### Install Nginx OpenTracing Plugin

The Nginx OpenTracing plugin is an open-source link tracking plugin for `OpenTracing`, written in C++，It's work for `Jaeger`、`Zipkin`、`LightStep`、`Datadog`.

- [Download](https://github.com/opentracing-contrib/nginx-opentracing/releases) the plugin corresponding to the current Nginx version, and use the following command to view the current Nginx version

```shell
$ nginx -v
nginx version: nginx/1.18.0 (Ubuntu)
```

- Extract

```shell
tar zxf linux-amd64-nginx-ot16-ngx_http_module.so.tgz -C /usr/lib/nginx/modules
```

- Install plugin

Add the following information at the top of the `nginx.conf` file

```nginx
load_module modules/ngx_http_opentracing_module.so;
```


### Install DDAgent Nginx OpenTracing plugin

The DDAgent Nginx OpenTracing plugin is a set of vendor implementations based on `Nginx OpenTracing`, with different APMs having their own encoding and decoding implementations.

- [Download `dd-opentracing-cpp`](https://github.com/DataDog/dd-opentracing-cpp/releases/latest),`libdd_opentracing.so` or `linux-amd64-libdd_opentracing_plugin.so.gz`

- Configure Nginx

```nginx

opentracing_load_tracer /etc/nginx/tracer/libdd_opentracing.so /etc/nginx/tracer/dd.json;
opentracing on; # Enable OpenTracing
opentracing_tag http_user_agent $http_user_agent;
opentracing_trace_locations off;
opentracing_propagate_context;
opentracing_operation_name nginx-$host;

```

`opentracing_load_tracer` ： load `opentracing` tracer
`opentracing_propagate_context;` : Indicates that the link context needs to be passed

- Configure DDTrace

`dd.json` is used to configure `ddtrace` ，such as：`service`、`agent_host`, etc., the content is as follows：

```json
{
  "environment": "test",
  "service": "nginx",
  "operation_name_override": "nginx.handle",
  "agent_host": "localhost",
  "agent_port": 9529
}
```

- Nginx logging configuration

Inject Trace information into Nginx logs. You can edit as follows:

```nginx
log_format with_trace_id '$remote_addr - $http_x_forwarded_user [$time_local] "$request" '
                         '$status $body_bytes_sent "$http_referer" '
                         '"$http_user_agent" "$http_x_forwarded_for" '
                         '"$opentracing_context_x_datadog_trace_id" "$opentracing_context_x_datadog_parent_id"';

access_log /var/log/nginx/access-with-trace.log with_trace_id;
```

> **Note:** The `log_format` keyword tells Nginx that there is a set of logging rules defined here, The `with_trace_id` is the rule name and can be modified by yourself. Please use the same name to associate the rules of the log when specifying the log path below  The path and file name in `access_log` can be changed. Usually, the original Nginx is equipped with log rules. We can configure multiple rules and output different log formats to different files, that is, keep the original  The `access_log` rule and path remain unchanged, and a new log rule containing trace information is added, named as a different log file for different logging tools to read.

- Verify whether the plugin is working properly


Execute the following command to verify

```shell
$:/etc/nginx# nginx -t
info: DATADOG TRACER CONFIGURATION - {"agent_url":"http://localhost:9529","analytics_enabled":false,"analytics_sample_rate":null,"date":"2023-09-25T14:33:40+0800","enabled":true,"env":"prod","lang":"cpp","lang_version":"201402","operation_name_override":"nginx.handle","report_hostname":false,"sampling_rules":"[]","service":"nginx","version":"v1.3.7"}
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
```

`info: DATADOG TRACER CONFIGURATION` Indicates that DDTrace has been successfully loaded 。

### Service tracing propagate

After Nginx generates link information, it needs to forward the relevant request header information to the backend, which can form a link concatenation operation between Nginx and the backend.

> *If there is a mismatch between Nginx link information and DDTrace, it is necessary to check if this step is standardized.*

The following configuration needs to be added to the `location` under the corresponding `server`

```nginx
location ^~ / {
    ...
    proxy_set_header X-datadog-trace-id $opentracing_context_x_datadog_trace_id;
    proxy_set_header X-datadog-parent-id $opentracing_context_x_datadog_parent_id;
    ...
    }

```

### Load nginx configure

Execute the following command to make the Nginx configuration effective:

```shell
root@liurui:/etc/nginx/tracer# nginx -s reload
info: DATADOG TRACER CONFIGURATION - {"agent_url":"http://localhost:9529","analytics_enabled":false,"analytics_sample_rate":null,"date":"2023-09-25T11:30:10+0800","enabled":true,"env":"prod","lang":"cpp","lang_version":"201402","operation_name_override":"nginx.handle","report_hostname":false,"sampling_rules":"[]","service":"nginx","version":"v1.3.7"}
root@liurui:/etc/nginx/tracer# 
```


If the following error occurs:

```shell
root@liurui:/etc/nginx/conf.d# nginx -s reload
info: DATADOG TRACER CONFIGURATION - {"agent_url":"http://localhost:9529","analytics_enabled":false,"analytics_sample_rate":null,"date":"2023-09-25T12:28:53+0800","enabled":true,"env":"prod","lang":"cpp","lang_version":"201402","operation_name_override":"nginx.handle","report_hostname":false,"sampling_rules":"[]","service":"nginx","version":"v1.3.7"}
nginx: [warn] could not build optimal proxy_headers_hash, you should increase either proxy_headers_hash_max_size: 512 or proxy_headers_hash_bucket_size: 64; ignoring proxy_headers_hash_bucket_size

```

The following configuration needs to be added to the `http` module of `nginx.conf`:

```shell
http {

    ...
    proxy_headers_hash_max_size 1024;
    proxy_headers_hash_bucket_size 128;

    ...
}

```

