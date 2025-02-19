# 安装 Datakit Operator
---

## 概念先解

| 字段    | 描述        |
| ----------- | ---------- |
| `namespaces`、`selectors`    | `enabled_namespaces` 和 `enabled_labelselectors` 是 ddtrace 专属，它们是对象数组，需要指定 `namespace` 和 `language`。数组之间是“或”的关系。目前语言仅支持 `java`。<br />如果一个 Pod 既满足 `enabled_namespaces` 规则，又满足 `enabled_labelselectors`，以 `enabled_labelselectors` 配置为准。        |


## 开启 DDTrace 采集器

修改 datakit.yaml 文件，在默认开启的采集器配置中，追加 DDTrace。

```
 - name: ENV_DEFAULT_ENABLED_INPUTS
   value: cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,container,ddtrace
```

重启应用：

```
kubectl apply -f datakit.yam
```

## 安装 DataKit Operator

Datakit Operator 能够自动化部署应用程序和服务，自动注入 DDTrace SDK，并在它们启动时进行检测。


点击下载最新的 `datakit-operator.yaml` 文件：

```
$ kubectl create namespace datakit
$ wget https://static.guance.com/datakit-operator/datakit-operator.yaml
```

### 更新配置文件

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
              "DD_SERVICE": "{fieldRef:metadata.labels['app']}",
              "DD_TAGS": "pod_name:$(POD_NAME),pod_namespace:$(POD_NAMESPACE),host:$(NODE_NAME)"
            }
        },
        "logfwd": {
            "options": {
                "reuse_exist_volume": "false"
            },
            "images": {
                "logfwd_image": "pubrepo.guance.com/datakit/logfwd:1.28.1"
            }
        }
    }
}
```

参数配置：

1. `service`：服务名；
2. `env`：应用服务的环境信息；
3. 自定义 DataKit 监听地址，若不设置则跟随默认地址；
4. 收集 Profiling 数据：开启后可以看到更多应用程序运行时的信息；
5. 配置 `namespaces`；
6. 配置 `selectors`。

### 执行安装指令

```
kubectl apply -f datakit-operator.yaml
```


## 重启应用


安装完成后，重启应用 Pod 即可。