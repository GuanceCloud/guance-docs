# Docker

---

## 视图预览

Docker 性能指标展示，包括 CPU 使用率、内存使用率、内存可用总量、容器网络流量、容器文件系统读写等。

![image](../imgs/input-docker-1.png)

## 版本支持

操作系统支持：Linux

## 安装部署

说明：示例 Docker 版本为 20.10.7(CentOS)，各个不同版本指标可能存在差异。

### 前置条件

- Docker 所在服务器 <[安装 DataKit](../../datakit/datakit-install.md)>

### 配置实施

#### 指标采集 (必选)

1、 开启 Container 插件，复制 sample 文件

```
cd /usr/local/datakit/conf.d/container
cp container.conf.sample container.conf
```

2、 修改 `container.conf` 配置文件

```
vi container.conf
```

参数说明

- enable_container_metric：是否开启 container 指标采集，请设置为 true。
- enable_k8s_metric：是否开启 kubernetes 指标采集。
- enable_pod_metric：是否开启 Pod 指标采集。
- container_include_log：须要采集的容器日志。
- container_exclude_log：不须要采集的容器日志。

`container_include_log` 和 `container_exclude_log` 必须以 `image` 开头，格式为 `"image:<glob规则>"`，表示 glob 规则是针对容器 image 生效。<br />
[Glob 规则](<https://en.wikipedia.org/wiki/Glob_(programming)>)是一种轻量级的正则表达式，支持 `*` `?` 等基本匹配单元。

```
      [inputs.container]
        docker_endpoint = "unix:///var/run/docker.sock"
        containerd_address = "/var/run/containerd/containerd.sock"

        enable_container_metric = true
        enable_k8s_metric = false
        enable_pod_metric = false

        ## Containers logs to include and exclude, default collect all containers. Globs accepted.
        container_include_log = []
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

3、 重启 DataKit (如果需要开启日志，请配置日志采集再重启)

```
systemctl restart datakit
```

指标预览

![image](../imgs/input-docker-2.png)

#### 日志采集 (非必选)

查看 `/usr/local/datakit/conf.d/container/container.conf` ，如下的配置默认采集除了 DataKit 外所有容器输出到 stdout 的日志。

```
   container_include_log = []
   container_exclude_log = ["image:pubrepo.jiagouyun.com/datakit/logfwd*", "image:pubrepo.jiagouyun.com/datakit/datakit*"]

```

日志预览

![image](../imgs/input-docker-3.png)

#### 插件标签 (非必选)

参数说明

- 该配置为自定义标签，可以填写任意 key-value 值
- 以下示例配置完成后，所有 docker_containers 指标都会带有 `app = "oa"` 的标签，可以进行快速查询
- 相关文档 <[TAG 在观测云中的最佳实践](../../best-practices/insight/tag.md)>

```
vi /usr/local/datakit/conf.d/container/container.conf
```

```
  [inputs.container.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
```

重启 DataKit

```
systemctl restart datakit
```

## 场景视图

<场景 - 新建仪表板 - 模板库 - 系统视图 - Docker 监控视图>

## 检测库

暂无

## [指标详解](../../../datakit/container#docker_containers)


## 最佳实践

暂无

## 故障排查

<[无数据上报排查](../../datakit/why-no-data.md)>
