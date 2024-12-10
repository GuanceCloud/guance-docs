# 安装 Helm
---

## 安装最新的 Helm 仓库

**前提条件**：Kubernetes >= 1.14、Helm >= 3.0+。

```
$ helm -n datakit get values datakit-operator -a -o yaml > values.yaml
$ helm upgrade datakit-operator datakit-operator \
    --repo https://pubrepo.guance.com/chartrepo/datakit-operator \
    -n datakit \
    -f values.yaml
```

## 更新配置文件

Datakit Operator 配置是 JSON 格式，在 Kubernetes 中单独以 ConfigMap 存放，以环境变量方式加载到容器中。

```
{
    "server_listen": "0.0.0.0:9543",
    "log_level":     "info",
    "admission_inject": {
        "ddtrace": { 
           "enabled_namespaces":     [],
           "enabled_labelselectors": [],
           "images": {
                "java_agent_image":   "pubrepo.guance.com/datakit-operator/dd-lib-java-init:v1.30.1-guance"
            },
            "envs": {
              "DD_JMXFETCH_STATSD_HOST": "datakit-service.datakit.svc",
              "DD_JMXFETCH_STATSD_PORT": "8125",
              "POD_NAME": "{fieldRef:metadata.name}",
              "POD_NAMESPACE": "{fieldRef:metadata.namespace}",
              "NODE_NAME": "{fieldRef:spec.nodeName}",
              "DD_TAGS": "pod_name:$(POD_NAME),pod_namespace:$(POD_NAMESPACE),host:$(NODE_NAME)"
              "DD_SERVICE": "{fieldRef:metadata.labels['service']}",
            }
        },
        "logfwd": {
            "options": {
                "reuse_exist_volume": "false"
            },
            "images": {
                "logfwd_image": "pubrepo.guance.com/datakit/logfwd:1.28.1"
            }
        },
    }
}
```

参数配置：

1. `service.name`：服务名；
2. `env`：应用服务的环境信息；
3. `version`：版本号；
4. 自定义 DataKit 监听地址，若不设置则跟随默认地址；
5. 设置采样率：开启后，可降低实际产生的数据量；数字范围从 0.0(0%) ~ 1.0(100%)；
6. 收集 Profiling 数据：开启后可以看到更多应用程序运行时的信息；
7. 开启 JVM 指标采集：需要同步开启 [statsd 采集器](../../../integrations/jvm.md)。