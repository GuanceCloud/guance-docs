---
title     : 'External'
summary   : '启动外部程序进行采集'
__int_icon      : 'icon/external'
dashboard :
  - desc  : '暂无'
    path  : '-'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# External
<!-- markdownlint-enable -->

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

External 采集器可以启动外部程序进行采集。

## 配置 {#config}

### 前置条件 {#requirements}

- 启动命令的程序及其运行环境的依赖完备。比如用 Python 去启动外部 Python 脚本，则该脚本运行所需的引用包等依赖必须要有。

### 采集器配置 {#input-config}

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/external` 目录，复制 `external.conf.sample` 并命名为 `external.conf`。示例如下：
    
    ```toml
        
    [[inputs.external]]
    
        # Collector's name.
        name = 'some-external-inputs'  # required
    
        # Whether or not to run the external program in the background.
        daemon = false
    
        # If the external program running in a Non-daemon mode,
        #     runs it in every this interval time.
        #interval = '10s'
    
        # The environment variables running the external program.
        #envs = ['LD_LIBRARY_PATH=/path/to/lib:$LD_LIBRARY_PATH',]
    
        # The external program' full path. Filling in absolute path whenever possible.
        cmd = "python" # required
    
        # Filling "true" if this collecor is involved in the election.
        # Note: The external program must running in a daemon mode if involving the election.
        election = false
        args = []
    
        [[inputs.external.tags]]
            # tag1 = "val1"
            # tag2 = "val2"
    
    ```
    
    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting)来开启采集器。

<!-- markdownlint-enable -->
