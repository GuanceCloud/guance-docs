# Conntrack

---

## 视图预览

Conntrack 性能指标展示，包括成功搜索条目数、插入的包数、连接数量等。

![image](../../imgs/input-conntracks-1.png)

## 版本支持

操作系统支持：Linux

## 前置条件

- 服务器 <[安装 DataKit](../../../datakit/datakit-install.md)>

## 安装配置

说明：示例 Linux 版本为 CentOS Linux release 7.8.2003 (Core)

### 指标采集 (默认)

1、 System 采集器会同时采集 System 和 Conntrack 指标。

2、 Conntrack 数据采集默认开启，对应配置文件 `/usr/local/datakit/conf.d/host/system.conf`

参数说明

- interval：数据采集频率

```
[[inputs.system]]
  interval = '10s'
```

3、 指标预览

![image](../../imgs/input-conntracks-3.png)

### 插件标签 (非必选)

参数说明

- 该配置为自定义标签，可以填写任意 key-value 值
- 以下示例配置完成后，所有 System 指标都会带有 `app = "oa"` 的标签，可以进行快速查询
- 相关文档 <[TAG 在观测云中的最佳实践](../../../best-practices/insight/tag.md)>

```
# 示例
[inputs.system.tags]
   app = "oa"
```

重启 DataKit

```
systemctl restart datakit
```

## 场景视图

<场景 - 新建仪表板 - 模板库 - 系统视图 - Conntrack 监控视图>

## 检测库

<监控 - 监控器 - 从模板新建 - 主机检测库>

## [指标详解](../../../../datakit/system#conntrack)

## 常见问题排查

<[无数据上报排查](../../../datakit/why-no-data.md)>

## 进一步阅读

<[主机可观测最佳实践](../../../best-practices/monitoring/host-linux.md)>
