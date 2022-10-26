
# MongoDB
---

## 视图预览

MongoDB 性能指标展示，包括每秒查询操作、文档操作、TTL 索引、游标、队列信息等

![image](../imgs/input-mongodb-1.png)

![image](../imgs/input-mongodb-2.png)

## 版本支持

操作系统支持：Linux / Windows / Mac

## 前置条件

- 服务器 <[安装 DataKit](../../datakit/datakit-install.md)>
- MongoDB 用户授权 (使用超级账户执行)

3.4 + 版本

```
> use admin
> db.createUser(
  {
    user: "user",
    pwd: "password",
    roles: [ { role: "clusterMonitor", db: "admin" } ]
  }
)
```

3.4 - 版本

```
> use admin
> db.createUser(
  {
    user: "user",
    pwd: "password"
  }
> db.grantRolesToUser("user", [{role: "read", actions: "find", db: "local"}])
)
```

## 安装配置

说明：示例 MongoDB 版本为 Linux 环境 db version v4.0.22，Windows 版本请修改对应的配置文件。

### 部署实施

#### 指标采集 (必选)

1、 开启 DataKit MongoDB 插件，复制 sample 文件

```
cd /usr/local/datakit/conf.d/db/mongodb
cp mongodb.conf.sample mongodb.conf
```

2、 修改 MongoDB 配置文件

```
vi mongodb.conf
```

参数说明

- interval：数据采集频率
- servers：服务连接地址 (user:passwd)
- gather_replica_set_stats：是否开启副本集状态采集
- gather_cluster_stats：是否开启集群状态采集
- gather_per_db_stats：是否开启每个数据库状态采集
- gather_per_col_stats：是否开启数据库表状态采集
- col_stats_dbs：数据库表筛选 (如果为空，代表都选择)
- gather_top_stat：命令行状态采集
- enable_tls：是否开启 tls 验证

```
[[inputs.mongodb]]
  interval = "10s"
  servers = ["mongodb://user:passwd@127.0.0.1:27017"]
  # gather_replica_set_stats = false
  # gather_cluster_stats = false
  # gather_per_db_stats = true
  # gather_per_col_stats = true
  # col_stats_dbs = []
  # gather_top_stat = true
  # enable_tls = false
```

3、 MongoDB 指标采集验证  `/usr/local/datakit/datakit -M |egrep "最近采集|mongodb"`

![image](../imgs/input-mongodb-3.png)

4、 重启 DataKit (如果需要开启日志，请配置日志采集再重启)

```
systemctl restart datakit
```
指标预览

![image](../imgs/input-mongodb-4.png)

#### 安全认证 (非必选)

参数说明

- ca_certs：ca 证书
- cert：openssl 证书
- cert_key：openssl 私钥
- insecure_skip_verify：是否忽略 tls 认证
- server_name：服务名称 (自定义)

```
    [inputs.mongodb.tlsconf]
    # ca_certs = ["/etc/ssl/certs/mongod.cert.pem"]
    # cert = "/etc/ssl/certs/mongo.cert.pem"
    # cert_key = "/etc/ssl/certs/mongo.key.pem"
    # insecure_skip_verify = true
    # server_name = ""
```

#### 日志插件 (非必选)

参数说明

- files：日志文件路径
- pipeline：日志切割文件(内置)，实际文件路径 `/usr/local/datakit/pipeline/mongod.p`
- 相关文档 <[ 文本数据处理（Pipeline）](../../datakit/pipeline.md)>

```
[inputs.mongodb.log]
files = ["/var/log/mongodb/mongod.log"]
pipeline = "mongod.p"
```

重启 DataKit (如果需要开启自定义标签，请配置插件标签再重启)

```
systemctl restart datakit
```

MongoDB 日志采集验证  `/usr/local/datakit/datakit -M |egrep "最近采集|mongodb_log"`

![image](../imgs/input-mongodb-5.png)

#### 插件标签 (非必选)

参数说明

- 该配置为自定义标签，可以填写任意 key-value 值
- 以下示例配置完成后，所有 MongoDB 指标都会带有 `app = "oa"` 的标签，可以进行快速查询。
- 相关文档 <[TAG 在观测云中的最佳实践](../../best-practices/insight/tag.md)>

```
# 示例
[inputs.mongodb.tags]
   app = "oa"
```

重启 DataKit

```
systemctl restart datakit
```

## 场景视图

<场景 - 新建仪表板 - 模板库 - 系统视图 - MongoDB 监控视图>

## [指标详解](../../../datakit/mongodb#measurements)


## 常见问题排查

<[无数据上报排查](../../datakit/why-no-data.md)>
