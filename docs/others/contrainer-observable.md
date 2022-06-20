# 如何采集容器对象
---

## 简介

“观测云” 支持采集 container 指标数据、对象数据和容器日志，以及当前主机上的 kubelet Pod 指标和对象数据。在DataKit 中开启容器数据接受服务后，您可以通过「基础设施」、「指标」、「日志」快速查看和分析容器的健康状况、CPU，内存资源，以及网络流量的使用情况等。

## 前置条件

- 安装 Docker v17.04 及以上版本（[docker 官方链接](https://www.docker.com/get-started)）
- 安装 DataKit（[DataKit 安装文档](https://www.yuque.com/dataflux/datakit/datakit-install)）
- 操作系统仅支持：`linux`

## 方法/步骤

通过开启容器数据的接受服务，您可以通过「基础设施」、「指标」、「日志」快速查看和分析容器的健康状况、CPU，内存资源，以及网络流量的使用情况等。

### Step1：开启容器数据的接受服务

1. 进入 DataKit 安装目录下的 `conf.d/container` 目录
1. 复制 `container.conf.sample` 并命名为 `container.conf`
1. 打开 `container.conf`，确认开启input。示例如下：

```toml

[inputs.container]
  endpoint = "unix:///var/run/docker.sock"
  
  enable_metric = false  
  enable_object = true   
  enable_logging = true  
  
  metric_interval = "10s"

  drop_tags = ["contaienr_id"]

  ## Examples:
  ##    '''nginx*'''
  ignore_image_name = []
  ignore_container_name = []
  
  ## TLS Config
  # tls_ca = "/path/to/ca.pem"
  # tls_cert = "/path/to/cert.pem"
  # tls_key = "/path/to/key.pem"
  ## Use TLS but skip chain & host verification
  # insecure_skip_verify = false
  
  [inputs.container.kubelet]
    kubelet_url = "http://127.0.0.1:10255"
    ignore_pod_name = []

    ## Use bearer token for authorization. ('bearer_token' takes priority)
    ## If both of these are empty, we'll use the default serviceaccount:
    ## at: /run/secrets/kubernetes.io/serviceaccount/token
    # bearer_token = "/path/to/bearer/token"
    ## OR
    # bearer_token_string = "abc_123"

    ## Optional TLS Config
    # tls_ca = /path/to/ca.pem
    # tls_cert = /path/to/cert.pem
    # tls_key = /path/to/key.pem
    ## Use TLS but skip chain & host verification
    # insecure_skip_verify = false
  
  #[[inputs.container.logfilter]]
  #  filter_message = [
  #    '''<this-is-message-regexp''',
  #    '''<this-is-another-message-regexp''',
  #  ]
  #  source = "<your-source-name>"
  #  service = "<your-service-name>"
  #  pipeline = "<pipeline.p>"
  
  [inputs.container.tags]
    # some_tag = "some_value"
    # more_tag = "some_other_value"
```

4. 配置完成后， 使用命令 datakit --restart, 重启datakit 即可生效

### Step2：开启容器的指标采集

DataKit 容器采集服务默认不开启指标采集。如有需要，请在`container.conf`中将 `enable_metric` 改为 `true` 并重启 DataKit。

## 其他

更多详细的容器对象采集的配置和说明，可查看更详情见[容器数据采集](https://www.yuque.com/dataflux/datakit/container#852abae7)。。


![logo_2.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1642756203853-c10f3e9e-ec48-40a1-a54e-e945a16e7e7e.png#clientId=u706a9bb6-065b-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=uaaf00b89&margin=%5Bobject%20Object%5D&name=logo_2.png&originHeight=169&originWidth=746&originalType=binary&ratio=1&rotation=0&showTitle=false&size=139415&status=done&style=none&taskId=uf7a9bc7e-36b8-4c80-86d8-1076f2b2366&title=)
