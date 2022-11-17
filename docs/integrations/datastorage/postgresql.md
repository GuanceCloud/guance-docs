---
icon: integrations/postgresql
---
# PostgreSQL
---

## 视图预览

PostgreSQL 性能指标展示，包括连接数、缓冲分配、计划检查点、脏块数等。

![image](../imgs/input-postgresql-1.png)

## 版本支持

操作系统支持：Linux / Windows / Mac

## 前置条件

- 服务器 <[安装 DataKit](../../datakit/datakit-install.md)>

## 安装配置

说明：示例 PostgreSQL 版本为 Linux 环境 PostgreSQL 9.2.24，Windows 版本请修改对应的配置文件。

### 部署实施

#### 指标采集 (必选)

1、 开启 DataKit PostgreSQL 插件，复制 sample 文件

```
cd /usr/local/datakit/conf.d/db
cp postgresql.conf.sample postgresql.conf
```

2、 修改 Postgresql 配置文件

```
vi postgresql.conf
```

参数说明

- address：服务连接地址
- ignored_databases：忽略采集的数据库
- databases：需要采集的数据库 (默认采集所有库)
- outputaddress：设置服务器标签
- interval：数据采集频率

```
[[inputs.postgresql]]
  address = "postgres://postgres@localhost/postgres?sslmode=disable"
  # ignored_databases = ["db1"]
  # databases = ["db1"]
  # outputaddress = "db01"
  interval = '10s'
```

3、 重启 DataKit (如果需要开启日志，请配置日志采集再重启)

```
systemctl restart datakit
```

4、 指标预览

![image](../imgs/input-postgresql-3.png)

#### 日志插件 (非必选)

参数说明

- files：日志文件路径
- pipeline：日志切割文件(内置)，实际文件路径 `/usr/local/datakit/pipeline/postgresql.p`
- 相关文档 <[ 文本数据处理（Pipeline）](../../datakit/pipeline.md)>

```
[inputs.postgresql.log]
files = ["/var/lib/pgsql/data/pg_log/postgresql-Mon.log"]
pipeline = "postgresql.p"
```

重启 Datakit (如果需要开启自定义标签，请配置插件标签再重启)

```
systemctl restart datakit
```

#### 插件标签 (非必选)

参数说明

- 该配置为自定义标签，可以填写任意 key-value 值
- 以下示例配置完成后，所有 PostgreSQL 指标都会带有 `app = "oa"` 的标签，可以进行快速查询。
- 相关文档 <[TAG 在观测云中的最佳实践](../../best-practices/insight/tag.md)>
- 
```
# 示例
[inputs.postgresql.tags]
   app = "oa"
```

重启 DataKit

```
systemctl restart datakit
```
## 场景视图

<场景 - 新建仪表板 - 模板库 - 系统视图 - PostgreSQL 监控视图>

## [指标详解](../../../datakit/postgresql#measurements)


## 常见问题排查

<[无数据上报排查](../../datakit/why-no-data.md)>

