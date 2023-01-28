# DataKit

---

## 视图预览

DataKit 性能指标展示，包括 CPU 使用率、内存信息、运行时间、日志记录等。

![image](../../imgs/input-datakit-1.png)

## 版本支持

操作系统支持：Linux / Windows / Mac

## 前置条件

- 服务器 <[安装 DataKit](../../../datakit/datakit-install.md)>

## 安装配置

说明：示例 Linux 版本为 CentOS Linux release 7.8.2003 (Core)，Windows 版本请修改对应的配置文件。

### 指标采集 (默认)

DataKit 数据采集默认开启 (无法关闭)

指标预览

![image](../../imgs/input-datakit-2.png)

### 日志采集 (默认)

DataKit 日志采集默认开启，主配置文件 `/usr/local/datakit/conf.d/datakit.conf` 默认路径

```
log = "/var/log/datakit/log"
gin_log = "/var/log/datakit/gin.log"
```

日志预览

![image](../../imgs/input-datakit-3.png)

## 场景视图

<场景 - 新建仪表板 - 模板库 - 系统视图 - DataKit 监控视图>

## 检测库

暂无

## [指标详解](../../../../../datakit/self#measurements)

## 常见问题排查

<[无数据上报排查](../../../datakit/why-no-data.md)>

## 进一步阅读

<[主机可观测最佳实践](../../../best-practices/monitoring/host-linux.md)>
