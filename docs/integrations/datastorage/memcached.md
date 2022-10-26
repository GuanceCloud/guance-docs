
# Memcached
---

## 视图预览
Memcached 性能指标展示，包括连接数、命令数、网络流量、线程数、命中率信息等。

![image](../imgs/input-memcached-1.png)

## 版本支持

操作系统支持：Linux / Windows / Mac

## 前置条件

- 服务器 <[安装 DataKit](../../datakit/datakit-install.md)>

## 安装配置

说明：示例 Memcached 版本为 Linux 环境 memcached 1.4.15，Windows 版本请修改对应的配置文件。

### 部署实施

#### 指标采集 (必选)

1、 开启 DataKit Memcache 插件，复制 sample 文件

```
cd /usr/local/datakit/conf.d/db
cp memcached.conf.sample memcached.conf
```

2、 修改 Memcached 配置文件

```
vi memcached.conf
```

参数说明

- servers：服务连接地址
- unix_sockets：socket 文件路径
- interval：数据采集频率

```
[[inputs.memcached]]
  servers = ["localhost:11211"]
  # unix_sockets = ["/var/run/memcached.sock"]
  interval = '10s'
```

3、 Memcached 指标采集验证  `/usr/local/datakit/datakit -M |egrep "最近采集|memcached"`

![image](../imgs/input-memcached-2.png)

指标预览

![image](../imgs/input-memcached-3.png)

#### 插件标签 (非必选)

参数说明

- 该配置为自定义标签，可以填写任意 key-value 值
- 以下示例配置完成后，所有 Memcached 指标都会带有 `app = "oa"` 的标签，可以进行快速查询。
- 相关文档 <[TAG 在观测云中的最佳实践](../../best-practices/insight/tag.md)>

```
# 示例
[inputs.memcached.tags]
   app = "oa"
```

重启 DataKit

```
systemctl restart datakit
```

## 场景视图

<场景 - 新建仪表板 - 模板库 - 系统视图 - Memcached 监控视图>

## 监控规则

暂无

## [指标详解](../../../datakit/memcached/#measurements)


## 常见问题排查

<[无数据上报排查](../../datakit/why-no-data.md)>
