# Kubernetes下 Stdout 日志白名单最佳实践

---

## 环境准备

已有Kubernetes环境（简称K8），本实践基于自建Kubernetesv1.23.1，观测云Datakit版本1.2.13，Nginx1.17。Datakit已经部署好，Datakit配置文件container.conf通过ConfigMap方式管理。

注：（阿里云容器服务（Alibaba Cloud Container Service for Kubernetes）或其他云服务商的Kubernetes配置原理类似。_

## 前置条件
Nginx日志在K8环境中的输出为Stdout方式，而非文件方式。观测云Datakit以DaemonSet部署后，默认采集K8内部所有Stdout日志输出，包括集群内部组件的Stdout输出方式，如CoreDNS（需开启日志）。本文涉及的日志均为Stdout方式输出。

注：Stdout是开发工程师写代码时，选择日志控制台的输出方式，如：

```
<appender name="console" class="ch.qos.logback.core.ConsoleAppender">
```
## 白名单需求

Datakit部署完成后，按需采集指定的业务Pod日志、K8集群组件的日志，后续新增的未指定的业务Pod日志不会采集，另外对同一个Pod里的多容器日志采集只采集其中一个或多个。<br />本文通过观测云采集器Datakit不同的日志过滤方法来实现，使用给日志加Annotation标注（包括过滤Pod内部其他容器产生的日志）和container.conf中的container_include_log = []组合来实现。<br />更详细日志处理原理见[《Datakit日志处理综述》](../../integrations/datakit-logging-how.md) 一文。

## 实现方式

### 方式一 使用 container_include_log = []

只采集集群组件coredns和nginx日志，container_include_log用正则语法编写image的名称，具体见[《根据容器 image 配置指标和日志采集》](../../integrations/container.md)

```toml
      [inputs.container]
        docker_endpoint = "unix:///var/run/docker.sock"
        containerd_address = "/var/run/containerd/containerd.sock"

        enable_container_metric = true
        enable_k8s_metric = true
        enable_pod_metric = true

        ## Containers logs to include and exclude, default collect all containers. Globs accepted.
        container_include_log = ["image:*coredns*","image:*nginx*"]
        container_exclude_log = ["image:pubrepo.jiagouyun.com/datakit/logfwd*", "image:pubrepo.jiagouyun.com/datakit/datakit*"]

        exclude_pause_container = true

        ## Removes ANSI escape codes from text strings
        logging_remove_ansi_escape_codes = false

        kubernetes_url = "https://kubernetes.default:443"

        ## Authorization level:
        ##   bearer_token -> bearer_token_string -> TLS
        ## Use bearer token for authorization. ('bearer_token' takes priority)
        ## linux at:   /run/secrets/kubernetes.io/serviceaccount/token
        ## windows at: C:\var\run\secrets\kubernetes.io\serviceaccount\token
        bearer_token = "/run/secrets/kubernetes.io/serviceaccount/token"
        # bearer_token_string = "<your-token-string>"

        [inputs.container.tags]
          # some_tag = "some_value"
          # more_tag = "some_other_value"
```

#### 实现效果

这样就按需采集指定image名称的Pod日志，如下图：

![image](../images/stdout-log/1.png)

### 方式二 组合 container_include_log = []和 Annotation 标记

只采集集群组件coredns和nginx日志，同时通过Annotation对nginx标记，当然未在container_include_log中开启的白名单，比如：另外的镜像busybox，也可以通过Annotation方式标记后采集上来。这是由于Annotation标记的方式优先级高。详细见日志处理原理[《Datakit日志处理综述》](../../integrations/datakit-logging-how.md) 一文。<br />Nginx的Annotation标记

```bash
      labels:
         app: nginx-pod
      annotations:
        datakit/logs: |
          [
            {
              "disable": false,
              "source": "nginx-source",
              "service": "nginx-source",
              "pipeline": "",
              "multiline_match": ""
            }
          ]
    spec: 
```

```toml
[inputs.container]
  docker_endpoint = "unix:///var/run/docker.sock"
  containerd_address = "/var/run/containerd/containerd.sock"

  ## Containers metrics to include and exclude, default not collect. Globs accepted.
  container_include_metric = []
  container_exclude_metric = ["image:*"]

  ## Containers logs to include and exclude, default collect all containers. Globs accepted.
  container_include_log = ["image:*coredns*","image:*nginx*"]
  container_exclude_log = []

  exclude_pause_container = true

  ## Removes ANSI escape codes from text strings
  logging_remove_ansi_escape_codes = false
  ## Maximum length of logging, default 32766 bytes.
  max_logging_length = 32766

  kubernetes_url = "https://kubernetes.default:443"

  ## Authorization level:
  ##   bearer_token -> bearer_token_string -> TLS
  ## Use bearer token for authorization. ('bearer_token' takes priority)
  ## linux at:   /run/secrets/kubernetes.io/serviceaccount/token
  ## windows at: C:\var\run\secrets\kubernetes.io\serviceaccount\token
  bearer_token = "/run/secrets/kubernetes.io/serviceaccount/token"
  # bearer_token_string = "<your-token-string>"

  [inputs.container.tags]
    # some_tag = "some_value"
    # more_tag = "some_other_value"
```

#### 实现效果

![image](../images/stdout-log/2.png)

### 方式三 过滤Pod中的某容器日志

只采集集群组件coredns和nginx日志，同时通过Annotation对nginx标记里的"only_images" 字段开启只需要容器的image，也就是在Pod内部也有个白名单策略。

#### 开启Pod内白名单前

如下图，nginx和busybox日志均采集<br />

![image](../images/stdout-log/3.png)

#### 开启Pod内白名单

```bash
      labels:
         app: nginx-pod
      annotations:
        datakit/logs: |
          [
            {
              "disable": false,
              "source": "nginx-source",
              "service": "nginx-source",
              "pipeline": "",
              "only_images": ["image:*nginx*"],
              "multiline_match": ""
            }
          ]
    spec: 
```

#### 实现效果

仅保留Pod内Nginx日志<br />

![image](../images/stdout-log/4.png)

## 总结

其实不建议开启白名单策略，白名单可能会造成很多问题，且不好调试，白名单可能会有无法预期的效果，比如开发打个日志没看到，实际上是没加某个 Tag。要过滤日志来源，黑名单失效最差情况是数据采集上来，黑名单过滤比如在Datakit采集器container.conf中的

```bash
container_exclude_log = ["image:pubrepo.jiagouyun.com/datakit/logfwd*"]
```

方式一是没有使用Annotation标记，而是用采集器container.conf中内置的过滤方式，更偏向底层的方式实现。但是这种方式不如方式二，因为标记的方式可以对日志的来源做更好的Tag，未来分析问题，做筛选方便些，另外也更灵活点，标记是在业务Pod上，可以做到，同一批业务Image进行精细化的日志过滤管控。<br />方式三结合具体的业务场景，过滤掉一些不必要的Sidecar等日志，可以过滤掉不必要的日志，达到日志采集降噪的效果。