# MEM

---

## 视图预览

内存性能指标展示，包括内存使用率、内存大小、缓存、缓冲等。

![image](../../imgs/input-mem-1.png)

## 版本支持

操作系统支持：Linux / Windows / Mac

## 前置条件

- 服务器 <[安装 DataKit](../../../datakit/datakit-install.md)>

## 安装配置

说明：示例 Linux 版本为 CentOS Linux release 7.8.2003 (Core)，Windows 版本请修改对应的配置文件。

### 部署实施

(Linux / Windows 环境相同)

#### 指标采集 (默认)

1、 MEM 数据采集默认开启，对应配置文件 `/usr/local/datakit/conf.d/host/mem.conf`

参数说明

- interval：数据采集频率

```
[[inputs.mem]]
  interval = '10s'
```

2、 MEM 指标采集验证 `/usr/local/datakit/datakit -M |egrep "最近采集|mem"`

![image](../../imgs/input-mem-2.png)

指标预览

![image](../../imgs/input-mem-3.png)

#### 插件标签 (非必选)

参数说明

- 该配置为自定义标签，可以填写任意 key-value 值
- 以下示例配置完成后，所有 MEM 指标都会带有 `app = "oa"` 的标签，可以进行快速查询
- 相关文档 <[TAG 在观测云中的最佳实践](../../../best-practices/insight/tag.md)>

```
# 示例
[inputs.mem.tags]
   app = "oa"
```

重启 DataKit

```
systemctl restart datakit
```

## 场景视图

<场景 - 新建仪表板 - 模板库 - 系统视图 - Memory 监控视图>

## 监控规则

<监控 - 监控器 - 从模板新建 - 主机检测库>

## [指标详解](../../../../datakit/mem#measurements)

## 常见问题排查

<[无数据上报排查](../../../datakit/why-no-data.md)>

## 进一步阅读

<[主机可观测最佳实践](../../../best-practices/monitoring/host-linux.md)>
