
# logfwdserver
---

- 操作系统支持：:fontawesome-brands-linux:

## 介绍

logfwdserver 会开启 websocket 功能，和 logfwd 配套使用，负责接收和处理 logfwd 发送的数据。

logfwd 的使用参见[这里](logfwd.md)。

## DataKit 配置

进入 DataKit 安装目录下的 `conf.d/log` 目录，复制 `logfwdserver.conf.sample` 并命名为 `logfwdserver.conf`。示例如下：

``` toml
[inputs.logfwdserver]
  ## logfwd 接收端监听地址和端口
  address = "0.0.0.0:9533"

  [inputs.logfwdserver.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
```

配置好后，重启 DataKit 即可。

???+ attention

    如果 DataKit 是以 daemonset 方式部署，此段配置需要添加到 `ConfigMap` 并通过 `volumeMounts` 挂载，详见 DataKit daemonset 安装[文档](../datakit/datakit-daemonset-deploy.md)。
