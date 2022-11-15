# MySQL
---

## 视图预览

MySQL 指标展示，包括 MySQL 的基础信息、链接信息、存储空间信息、innoDB 信息、性能信息、锁信息以及日志信息等。

![image](../imgs/input-mysql-1.png)

![image](../imgs/input-mysql-2.png)

![image](../imgs/input-mysql-3.png)

## 版本支持

操作系统支持：Windows/AMD 64, Windows/386, Linux/ARM, Linux/ARM 64, Linux/386, Linux/AMD 64, Darwin/AMD 64

## 安装部署

MySQL 指标采集，收集以下数据：

- MySQL global status 基础数据采集
- Scheam 相关数据
- InnoDB 相关指标
- 支持自定义查询数据采集

说明：示例 MySQL 版本为 MySQL 5.7(CentOS)，各个不同版本指标可能存在差异。

### 前置条件

- MySQL 版本 5.7+ <[安装 DataKit](../../datakit/datakit-install.md)>
- 创建监控账号（一般情况，需用 MySQL `root` 账号登陆才能创建 MySQL 用户）

```sql
CREATE USER 'datakit'@'localhost' IDENTIFIED BY '<UNIQUEPASSWORD>';
FLUSH PRIVILEGES;

-- MySQL 8.0+ create the datakit user with the native password hashing method
CREATE USER 'datakit'@'localhost' IDENTIFIED WITH mysql_native_password by '<UNIQUEPASSWORD>';
```

- 授权

```sql
GRANT PROCESS ON *.* TO 'datakit'@'localhost';
show databases like 'performance_schema';
GRANT SELECT ON performance_schema.* TO 'datakit'@'localhost';
GRANT SELECT ON mysql.user TO 'datakit'@'localhost';
GRANT replication client on *.*  to 'datakit'@'localhost';
FLUSH PRIVILEGES;
```

以上创建、授权操作，均限定了 `datakit` 这个用户的只能在 MySQL 主机上（`localhost`）访问 MySQL，如果对 MySQL 进行远程采集，建议将 `localhost` 替换成 `%`（表示 DataKit 可以在任意机器上访问 MySQL），也可用特定的 DataKit 安装机器地址。

> 注意，如用 `localhost` 时发现采集器有如下报错，需要将上面的 `localhost` 换成 `::1`


```
Error 1045: Access denied for user 'datakit'@'::1' (using password: YES)
```

### 配置实施

#### 指标采集 (必选)

1、 开启 DataKit MySQL 插件，复制 sample 文件

```bash
cd /usr/local/datakit/conf.d/db/
cp mysql.conf.sample mysql.conf
```

2、 修改 `mysql.conf` 配置文件

```bash
vi mysql.conf
```
参数说明

- host：要采集的 MySQL 所在的服务器
- user：MySQL 数据库用户名(填写前置条件中创建的用户名)
- pass：MySQL 数据库密码 (填写前置条件中创建的用户密码)
- port：MySQL 数据库链接端口
- sock：MySQL 数据库安全认证文件
- charset：MySQL 数据字符集(默认 utf8 可以不做修改)
- connect_timeout：链接超时时间
- interval：指标采集频率
- innodb：开启 innodb 采集
- tables：想要采集 table 的名称(默认不填写全部采集)
- users：想要采集的用户名称(默认不填写全部采集)

```yaml
[[inputs.mysql]]
    host = "localhost"
    user = "datakit"
    pass = "<PASS>"
    port = 3306
    # sock = "<SOCK>"
    # charset = "utf8"

    ## @param connect_timeout - number - optional - default: 10s
    # connect_timeout = "10s"

    ## Deprecated
    # service = "<SERVICE>"

    interval = "10s"

    ## @param inno_db
    innodb = true

    ## table_schema
    tables = []

    ## user
    users = []
```

-  Binlog 开启

默认情况下，MySQL binlog 是不开启的。如果要统计 binlog 大小，需要开启 MySQL 对应 binlog 功能：

```sql
-- ON:开启, OFF:关闭
SHOW VARIABLES LIKE 'log_bin';
```

3、 重启 DataKit (如果需要开启日志，请配置日志采集再重启)

```bash
systemctl restart datakit
```

4、 指标预览

![image](../imgs/input-mysql-5.png)

#### 日志采集 (非必选)

1、 如需采集 MySQL 的日志，将配置中 log 相关的配置打开，如需要开启 MySQL 慢查询日志，需要开启慢查询日志，在 MySQL 中执行以下语句：

```sql
SET GLOBAL slow_query_log = 'ON';

-- 未使用索引的查询也认为是一个可能的慢查询
set global log_queries_not_using_indexes = 'ON';
```

> 注意：在使用日志采集时，需要将 DataKit 安装在 MySQL 服务同一台主机中，或使用其它方式将日志挂载到 DataKit 所在机器

2、 修改 `mysql.conf` 配置文件

参数说明

- files：日志文件路径 (通常填写访问日志和错误日志)
- ignore：过滤 *.log 中不想被采集的日志(默认全采)
- character_encoding：日志文件的字符集(默认 utf-8)
- match：该配置为多行日志采集规则配置，开启 MySQL 慢查询日志请打开注释
- pipeline：日志切割文件(内置)，实际文件路径 /usr/local/datakit/pipeline/mysql.p
- 相关文档 <[Pipeline 文本数据处理](../../datakit/pipeline.md)>

```
[inputs.mysql.log]
    ## required, glob logfiles
    files = ["/var/log/mysql/*.log"]

    ## glob filteer
    #ignore = [""]

    ## optional encodings:
    ##    "utf-8", "utf-16le", "utf-16le", "gbk", "gb18030" or ""
    #character_encoding = ""

    ## The pattern should be a regexp. Note the use of '''this regexp'''
    ## regexp link: https://golang.org/pkg/regexp/syntax/#hdr-Syntax
    match = '''^(# Time|\d{4}-\d{2}-\d{2}|\d{6}\s+\d{2}:\d{2}:\d{2}).*'''

    ## grok pipeline script path
    pipeline = "mysql.p"

```

3、 重启 DataKit (如果需要开启自定义标签，请配置插件标签再重启)

```
systemctl restart datakit
```

4、 日志预览

![image](../imgs/input-mysql-7.png)

#### 插件标签 (非必选)

参数说明

- 该配置为自定义标签，可以填写任意 key-value 值
- 以下示例配置完成后，所有 MySQL 指标都会带有 `service = "MySQL"` 的标签，可以进行快速查询。
- 相关文档 <[TAG 在观测云中的最佳实践](../../best-practices/insight/tag.md)>

```
# 示例
[inputs.mysql.tags]
        service = "MySQL"
        some_tag = "some_value"
        more_tag = "some_other_value"
```

重启 DataKit

```
systemctl restart datakit
```

## 场景视图

<场景 - 新建仪表板 - 模板库 - 系统视图 - MySQL 监控视图>

## 监控规则

<监控 - 监控器 - 从模板新建 - MySQL 检测库>

## [指标详解](../../../datakit/mysql#measurement)


## 故障排查

<[无数据上报排查](../../datakit/why-no-data.md)>

