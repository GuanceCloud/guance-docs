# 在主机上部署
---

## 安装 DataKit Agent

进行系统和应用程序的链路数据分析之前，需要在每个目标主机上[部署观测云 DataKit 采集器](../../../datakit/datakit-install.md)，以收集必要的链路数据。


在安装指令前添加此命令 `DK_APM_INSTRUMENTATION_ENABLED=host` 开启 APM 自动注入。

如果已经安装了 DataKit，则只需要升级即可，使用下面的命令进行升级操作。

```
DK_APM_INSTRUMENTATION_ENABLED=host DK_DEF_INPUTS="ddtrace" DK_UPGRADE=1 bash -c "$(curl -L https://static.guance.com/datakit/install.sh)"
```

## 检验

执行以下命令进行检验，如果 `instrumentation_enabled` 值为空，需要手动调整为 `host`：

```
$ cat /usr/local/datakit/conf.d/datakit.conf | grep instru
instrumentation_enabled = "host"
```

然后重启 DataKit：

```
datakit service -R
```

## 重启应用

安装完成后，重启应用程序即可。以下是 Java 应用重启的示例：

```
java -jar  springboot-server.jar
```