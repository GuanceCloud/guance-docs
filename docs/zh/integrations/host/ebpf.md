---
icon: integrations/ebpf
---
# eBPF
---

## 视图预览

网络接口指标展示，包括 发送/接收字节数、 TCP 延迟、 TCP 连接数、 TCP 重传次数等

![image](../imgs/input-ebpf-1.png)

## 版本支持

操作系统支持：Linux <br/>
内核版本要求：CentOS 7.6+ ，Ubuntu 16.04 +，其他发行版本需要 Linux 内核版本高于 4.0.0

## 前置条件

- 服务器 <[安装 DataKit](../../datakit/datakit-install.md)>

## 安装配置

说明：示例 Linux 版本为：CentOS Linux release 7.8.2003 (Core)

### 指标采集 (必选)

1、 DataKit 安装之后，<[安装 eBPF 采集器](../../../datakit/ebpf#requirements)>


2、 开启 eBPF 采集器，复制 sample 文件

```
cd /usr/local/datakit/conf.d/host
cp ebpf.conf.sample ebpf.conf
```

3、 修改 eBPF 配置文件

```
vi ebpf.conf
```

参数说明

- daemon：是否以守护进程启动
- name：插件名称
- cmd：ebpf 二进制程序路径
- args：datakit api 接口地址 (默认 9529 端口)
- enabled_plugins：开启的插件 (默认 ebpf-net，可选 ebpf-bash)

```
[[inputs.ebpf]]
  daemon = true
  name = 'ebpf'
  cmd = "/usr/local/datakit/externals/datakit-ebpf"
  args = ["--datakit-apiserver", "0.0.0.0:9529"]
  enabled_plugins = ["ebpf-net"]
```
### 插件标签 (非必选)

参数说明

- 该配置为自定义标签，可以填写任意 key-value 值
- 以下示例配置完成后，所有 eBPF 指标都会带有 app = oa 的标签，可以进行快速查询
- 相关文档 <[TAG在观测云中的最佳实践](../../best-practices/insight/tag.md)>

```
# 示例
[inputs.ebpf.tags]
   app = "oa"
```

重启 DataKit

```
systemctl restart datakit
```

## [指标详解](../../../datakit/ebpf#measurements)

## 常见问题排查

<[无数据上报排查](../../datakit/why-no-data.md)>

## 进一步阅读
<[主机可观测最佳实践](../../best-practices/monitoring/host-linux.md)>

