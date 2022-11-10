# Git同步配置满足大规模容器部署下的datakit管理
---

## 概述：

企业级的应用一般都比较复杂，需求也会不断的变化，传统的瀑布开发模式已经不能满足这种应用开发的需要，于是新的开发模型“敏捷开发”被越来越多的企业运用。 为了满足敏捷开发，实现快速迭代，快速部署，应用常被拆分成多个微服务，并使用容器化部署。为了方便管理容器，实现自动化部署，kubernetes 作为工业级的容器编排平台越来越被更多的企业接受。

使用容器化部署后，随着业务变化产生的扩缩容，使得我们对应用及应用依赖的环境的观测越来越难以把握，观测云帮助越来越多的企业解决了观测难的难题。使用观测云需要在企业的云服务器或者虚机上安装 datakit，再开启不同的采集器，针对服务器少的客户，不同的 datakit 开启不同的采集器没什么问题，那些拥有成千上万台服务器的企业，一个一个的管理这些配置已不合时宜。git 同步配置就是统一管理这些配置的，datakit 定时拉取配置，管理人员只需要维护一个 git 仓库就可以了。

## 前置条件：

- 您需要先创建一个 [观测云账号](https://www.guance.com)，并在您的主机上 [安装 DataKit](../../datakit/datakit-install.md) ，或者在kubernetes集群 [安装 DataKit](../../datakit/datakit-daemonset-deploy) ，开启相关集成的运行，进行数据采集。
- 您拥有一个 gitlab 并有权限创建项目。

## 使用场景

### 为多台部署了docker的云服务器同步配置

云服务部署 datakit 时需要使用 DK_GIT_URL 参数指定 git 的 repo 地址，详情可参考 [安装 DataKit](../../datakit/datakit-install.md) ，datakit 会按照指定时间，默认一分钟拉取 git 仓库的配置，并存放到 `/usr/local/datakit/gitrepos/` 目录。git 仓库中的配置文件要以 `.conf` 为扩展名，配置也支持 `.p` 为扩展名的 pipeline 文件。比如仓库中有个 `redis.conf` 的文件，文件如下，那么使用了此仓库的 datakit，同一时间会通过选举模式，有一台 datakit 采集 redis 的指标数据，此时主机数据的采集还是通过云服务器上安装的 datakit 来上报数据到观测云。

```python
[[inputs.redis]]
    host = "192.168.1.100"
    port = 6379
    password = "xxxxxx
    interval = "15s"
    slowlog-max-len = 128
    
    [inputs.redis.log]
    # required, glob logfiles
    #files = ["/var/log/redis/redis.log"]

    # glob filteer
    ignore = [""]

    # grok pipeline script path
    pipeline = "redis.p"    
    character_encoding = ""
    match = '''^\S.*'''

    [inputs.tailf.tags]
    # tags1 = "value1"

    [inputs.redis.tags]
    # tag1 = val1
    # tag2 = val2

```

### 为kubernetes集群同步配置

kubernetes 集群安装 datakit 是通过 [DaemonSet](../../datakit/datakit-daemonset-deploy.md) 方式来部署的，采集器的配置是通过 ConfigMap 配置 `.conf` 文件，然后挂载到容器中，如果新增采集器需要修改 yaml 文件，然后重新部署 datakit。使用git管理配置，简化 yaml 文件的维护成本，不需要重新部署 datakit，集群节点越多，越彰显优势。

## 示例说明

现有 1 个 master 节点，2 个 node 节点的 kubernets 集群，这三个节点都装有 kubelet，现在要采集 kubelet 指标到观测云，并且开启采集器的配置要存放到 git 仓库。

### 1. 创建git仓库

登录 gitlab，点击【New project】，点击【Create blank project】，project name 输入【datakit-conf-demo】，Visibility  Level 选择 Private，选中 Initialize repository with a README。点击【Create project】。

![](../img/9.datakit_git_1.png)

新建 master 分支，然后依次创建 `conf.d/prom` 文件夹，最后创建 `k8s_prom_kubelet1.conf`、`k8s_prom_kubelet2.conf`、`k8s_prom_kubelet3.conf`。这三个文件是采集 kubelet 指标。

![](../img/9.datakit_git_2.png)

`k8s_prom_kubelet1.conf` 内容如下，另外两个文件只是 url 不同：

```python
[[inputs.prom]]
  ## Exporter 地址
  url = "https://172.16.0.231:10250/metrics"
  source = "prom_kubelet1"
  metric_types = ["counter", "gauge"]
  measurement_prefix = ""
  measurement_name = "prom_metrics"
  interval = "10s"
  tls_open = true
  [inputs.prom.auth]
    type = "bearer_token"
    token = "eyJhbGciOiJSUzI1NiIsImtaZCI6IkdsbGp3RjAzTVNjX0V1d3QyeU1cR1ZZVXJfqnlLMk0thVd5b0hjYmtoV1kifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlLXN5c3RlbSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJtb25pdG9yaW5nLXNlY3JldC10b2tlbiIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50Lm5hbWUiOiJtb25pdG9yaW5nIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQudWlkIjoiMjA0ZmYxZjgtYzAxMi00YzVlLWJlNDEtMmZlOGY2N2U5NzVlIiwic3ViIjoic3lzdGVtOnNlcnZpY2VhY2NvdW50Omt1YmUtc3lzdGVtOm1vbml0b3JpbmcifQ.VsNVNSJaaZrdQtwL-TsBUKAN2hrIwBGMYnK6EKV8HqaTiVEjl7BSMYbZ0KQ6YaSW8g84P2EbYA7AirAm8aue7DodKPkot5Om90N4Pi9GRJrQbsWacLYkPJuAlxQgHY7IB9s1AFtEQlcbB8ZQ9F91ZKW6biMW5VY5oWVCQGFkB4HrDG-RWSYQLz0bNgMGW2iE1VBtLCsaEs-ZjmeNlx35cWIR0iYp0BsXGWex26PtZ_IO8DYWMDSK88jp9W7c5Reu8VvII2Rt-ngkmhb04elIcvcMMXSqkrbYgQQa0c4uZVkZITIEc97gkVEFiDKCwcBlOpU8kp0JU9S2H5JeqPa8MA"
  # token_file = "/tmp/token"

  ## 自定义Tags
  [inputs.prom.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"

```

### 2. kubernetes安装DataKit

在 kubernetes 集群使用 DaemonSet [安装 DataKit](../../datakit/datakit-daemonset-deploy.md)，并指定环境变量。

```python
        - name: ENV_GIT_URL
          value: http://test:123456@10.92.22.168/root/datakit-conf-demo.git
        - name: ENV_GIT_BRANCH
          value: master
        - name: ENV_GIT_INTERVAL
          value: 10s
```

参数说明

- ENV_GIT_URL：git repo地址。
- ENV_GIT_BRANCH:  指定拉取分支。
- ENV_GIT_INTERVAL：拉取频率，默认1m即1分钟。

datakit部署成功。

![](../img/9.datakit_git_3.png)

### 3.  查看采集器运行情况

浏览器输入 [http://172.16.0.231:9529/monitor](http://8.136.207.182:9529/monitor) ，其中172.16.0.231是部署了datakit 的一个节点，这是集群中的 datakit 选举了此服务器上的 datakit 来进行数据上报。  

![](../img/9.datakit_git_4.png)

### 4. 查看采集到的指标

登录观测云，点击【指标】->【prom_metrics】，查看采集到的指标。

![](../img/9.datakit_git_5.png)
