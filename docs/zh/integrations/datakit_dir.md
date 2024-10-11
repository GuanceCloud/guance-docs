---
skip: 'reason: 不属于集成文档'
---

# DataKit 目录

## Windows

安装目录：`C:\Program Files\datakit`

日志目录：`C:\Program Files\datakit`

## Linux/MacOS

安装目录：`/usr/local/datakit`

日志目录：`/var/log/datakit`

## 日志

日志目录下主要有两个文件：`gin.log` 和 `log`

- `gin.log` ：是访问日志文件，也就是外部访问 DataKit 的日志记录，不包含 GRPC。
- `log`：是 DataKit 运行日志文件，主要记录采集器的启动和运行状况及数据上报信息。

## 采集器

采集器目录为 `conf.d`,里面内置了 200+ 以上种采集器配置,比如`conf.d/db`目录下就包含了 10 多种数据库采集器配置;`conf.d/host`也有十几种主机相关的采集器。

其中 `conf.d/datakit.conf` 为 DataKit 主采集器相关配置，比如 token、全局 tag 、资源、API 等相关配置。





