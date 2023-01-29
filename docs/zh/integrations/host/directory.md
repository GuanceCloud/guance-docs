---
icon: octicons/file-directory-16
---
# Directory
---

## 视图预览

Directory 性能指标展示，包括目录数、文件数、目录文件大小等

![image](../imgs/input-directory-1.png)

## 版本支持

操作系统支持：Linux / Windows / Mac

## 前置条件

- 服务器 <[安装 DataKit](../../datakit/datakit-install.md)>

## 安装配置

说明：示例 Linux 版本为 CentOS Linux release 7.8.2003 (Core)

(Linux / Windows 环境相同)

### 指标采集 (必选)

1、 开启 Datakit Hostdir 插件，复制 sample 文件

```
cd /usr/local/datakit/conf.d/host/
cp hostdir.conf.sample hostdir.conf
```

2、 修改配置文件 `hostdir.conf`

参数说明

- interval：采集频率 (默认10s)
- dir：目录路径
- exclude_patterns：不包含的文件名后缀 (例如 *.exe、*.so等)

```
[[inputs.hostdir]]
  interval = "10s"
  dir = "/usr/local/datakit/"
  # exclude_patterns = []
```

3、 指标预览

![image](../imgs/input-directory-3.png)

### 插件标签 (非必选)

参数说明

- 该配置为自定义标签，可以填写任意 key-value 值
- 以下示例配置完成后，所有 hostdir 指标都会带有 `app = "oa"` 的标签，可以进行快速查询
- 相关文档 <[TAG在观测云中的最佳实践](../../best-practices/insight/tag.md)>

```
# 示例
[inputs.hostdir.tags]
   app = "oa"
```

重启 DataKit

```
systemctl restart datakit
```

## 场景视图

<场景 - 新建仪表板 - 模板库 - 系统视图 - Directory 监控视图>

## 检测库

暂无

## [指标详解](../../../datakit/hostdir#measurements)


## 常见问题排查

<[无数据上报排查](../../datakit/why-no-data.md)>

Q：如果想监控多个目录，怎么配置？<br />
A：需要填写多个 input 配置。

```
[[inputs.hostdir]]
  interval = "10s"
  dir = "/usr/local/datakit/"
[[inputs.hostdir]]
  interval = "10s"
  dir = "/usr/local/dataflux-func/"

```
## 进一步阅读

<[主机可观测最佳实践](../../best-practices/monitoring/host-linux.md)>
