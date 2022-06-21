{{.CSS}}
# MySQL
---

- DataKit 版本：{{.Version}}
- 操作系统支持：`{{.AvailableArchs}}`

MySQL 指标采集，收集以下数据：

- MySQL global status 基础数据采集
- Scheam 相关数据
- InnoDB 相关指标
- 支持自定义查询数据采集

## 前置条件

- MySQL 版本 5.7+
- 创建监控账号（一般情况，需用 MySQL `root` 账号登陆才能创建 MySQL 用户）

```sql
CREATE USER 'datakit'@'localhost' IDENTIFIED BY '<UNIQUEPASSWORD>';

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
```

以上创建、授权操作，均限定了 `datakit` 这个用户的只能在 MySQL 主机上（`localhost`）访问 MySQL，如果对 MySQL 进行远程采集，建议将 `localhost` 替换成 `%`（表示 DataKit 可以在任意机器上访问 MySQL），也可用特定的 DataKit 安装机器地址。

> 注意，如用 `localhost` 时发现采集器有如下报错，需要将上面的 `localhost` 换成 `::1`

```
Error 1045: Access denied for user 'datakit'@'::1' (using password: YES)
```

## 配置

进入 DataKit 安装目录下的 `conf.d/{{.Catalog}}` 目录，复制 `{{.InputName}}.conf.sample` 并命名为 `{{.InputName}}.conf`。示例如下：

```toml
{{.InputSample}}
```

配置好后，重启 DataKit 即可。

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.{{.InputName}}.tags]` 指定其它标签：

```toml
 [inputs.{{.InputName}}.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

### Binlog 开启

默认情况下，MySQL binlog 是不开启的。如果要统计 binlog 大小，需要开启 MySQL 对应 binlog 功能：

```sql
-- ON:开启, OFF:关闭
SHOW VARIABLES LIKE 'log_bin';
```

binlog 开启，参见[这个问答](https://stackoverflow.com/questions/40682381/how-do-i-enable-mysql-binary-logging)，或者[这个问答](https://serverfault.com/questions/706699/enable-binlog-in-mysql-on-ubuntu)

### 数据库性能指标采集

数据库性能指标来源于 MySQL 的内置数据库 `performance_schema`, 该数据库提供了一个能够在运行时获取服务器内部执行情况的方法。通过该数据库，DataKit 能够采集历史查询语句的各种指标统计和查询语句的执行计划，以及其他相关性能指标。

**配置**

如需开启，需要执行以下步骤。

- 修改配置文件，开启监控采集

```toml
[[inputs.mysql]]

## 开启数据库性能指标采集
dbm = true

...

## 监控指标配置
[inputs.mysql.dbm_metric]
  enabled = true
  
## 监控采样配置
[inputs.mysql.dbm_sample]
  enabled = true  
...

```

- MySQL配置

修改配置文件(如`mysql.conf`)，开启 `MySQL Performance Schema`， 并配置相关参数：

```
[mysqld]
performance_schema = on
max_digest_length = 4096
performance_schema_max_digest_length = 4096
performance_schema_max_sql_text_length = 4096
performance-schema-consumer-events-statements-current = on
performance-schema-consumer-events-statements-history-long = on
performance-schema-consumer-events-statements-history = on

```

- 账号配置

账号授权

```
GRANT REPLICATION CLIENT ON *.* TO datakit@'%' WITH MAX_USER_CONNECTIONS 5;
GRANT PROCESS ON *.* TO datakit@'%';
```

创建数据库

```
CREATE SCHEMA IF NOT EXISTS datakit;
GRANT EXECUTE ON datakit.* to datakit@'%';
GRANT CREATE TEMPORARY TABLES ON datakit.* TO datakit@'%';
```

创建存储过程 `explain_statement`，用于获取 sql 执行计划

```
DELIMITER $$
CREATE PROCEDURE datakit.explain_statement(IN query TEXT)
    SQL SECURITY DEFINER
BEGIN
    SET @explain := CONCAT('EXPLAIN FORMAT=json ', query);
    PREPARE stmt FROM @explain;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END $$
DELIMITER ;
```

为需要采集执行计划的数据库单独创建存储过程（可选）

```
DELIMITER $$
CREATE PROCEDURE <数据库名称>.explain_statement(IN query TEXT)
    SQL SECURITY DEFINER
BEGIN
    SET @explain := CONCAT('EXPLAIN FORMAT=json ', query);
    PREPARE stmt FROM @explain;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END $$
DELIMITER ;
GRANT EXECUTE ON PROCEDURE <数据库名称>.explain_statement TO datakit@'%';
```

- `consumers`配置

方法一（推荐）：通过 `DataKit` 动态配置 `performance_schema.events_statements_*`，需要创建以下存储过程：

```
DELIMITER $$
CREATE PROCEDURE datakit.enable_events_statements_consumers()
    SQL SECURITY DEFINER
BEGIN
    UPDATE performance_schema.setup_consumers SET enabled='YES' WHERE name LIKE 'events_statements_%';
END $$
DELIMITER ;

GRANT EXECUTE ON PROCEDURE datakit.enable_events_statements_consumers TO datakit@'%';
```

方法二：手动配置 `consumers`

```
UPDATE performance_schema.setup_consumers SET enabled='YES' WHERE name LIKE 'events_statements_%';
```

**采集的指标**

性能指标根据`service`划分为两类，即`mysql_dbm_metric`和`mysql_dbm_sample`，存储在【日志】中，具体介绍见后续指标列表部分。

## 视图预览

MySQL 观测场景主要展示了 MySQL 的基础信息、链接信息、存储空间信息、innoDB 信息、性能信息、锁信息以及日志信息。

![image](imgs/input-mysql-1.png)

![image](imgs/input-mysql-2.png)

![image](imgs/input-mysql-3.png)

## 安装部署

MySQL 指标采集，收集以下数据：

- MySQL global status 基础数据采集
- Scheam 相关数据
- InnoDB 相关指标
- 支持自定义查询数据采集

说明：示例 MySQL 版本为：MySQL 5.7(CentOS)，各个不同版本指标可能存在差异

### 前置条件

- MySQL 版本 5.7+ <[安装 Datakit](../datakit/datakit-install.md)>
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

1、开启 Datakit MySQL 插件，复制 sample 文件

```bash
cd /usr/local/datakit/conf.d/db/
cp mysql.conf.sample mysql.conf
```

2、修改 `mysql.conf` 配置文件

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

3、重启 Datakit (如果需要开启日志，请配置日志采集再重启)

```bash
systemctl restart datakit
```

4、MySQL 指标采集验证 `/usr/local/datakit/datakit -M |egrep "最近采集|mysql"`

![image](imgs/input-mysql-4.png)

5、指标预览

![image](imgs/input-mysql-5.png)

#### 日志采集 (非必选)

1、如需采集 MySQL 的日志，将配置中 log 相关的配置打开，如需要开启 MySQL 慢查询日志，需要开启慢查询日志，在 MySQL 中执行以下语句：

```sql
SET GLOBAL slow_query_log = 'ON';

-- 未使用索引的查询也认为是一个可能的慢查询
set global log_queries_not_using_indexes = 'ON';
```

> 注意：在使用日志采集时，需要将 DataKit 安装在 MySQL 服务同一台主机中，或使用其它方式将日志挂载到 DataKit 所在机器

2、修改 `mysql.conf` 配置文件

参数说明

- files：日志文件路径 (通常填写访问日志和错误日志)
- ignore：过滤 *.log 中不想被采集的日志(默认全采)
- character_encoding：日志文件的字符集(默认 utf-8)
- match：该配置为多行日志采集规则配置，开启 MySQL 慢查询日志请打开注释
- pipeline：日志切割文件(内置)，实际文件路径 /usr/local/datakit/pipeline/mysql.p
- 相关文档 <[DataFlux pipeline 文本数据处理](/datakit/pipeline.md)>

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

3、重启 Datakit (如果需要开启自定义标签，请配置插件标签再重启)

```
systemctl restart datakit
```

4、MySQL 日志采集验证  /usr/local/datakit/datakit -M |egrep "最近采集|mysql_log"

![image](imgs/input-mysql-6.png)

5、日志预览

![image](imgs/input-mysql-7.png)

#### 插件标签 (非必选)
参数说明

- 该配置为自定义标签，可以填写任意 key-value 值
- 以下示例配置完成后，所有 MySQL 指标都会带有 service = "MySQL" 的标签，可以进行快速查询
- 相关文档 <[DataFlux Tag 应用最佳实践](../best-practices/guance-skill/tag.m)>
```
# 示例
[inputs.mysql.tags]
        service = "MySQL"
        some_tag = "some_value"
        more_tag = "some_other_value"
```

重启 Datakit

```
systemctl restart datakit
```

## 场景视图

场景 - 新建场景 - MySQL 监控场景 

![image](imgs/input-mysql-8.png)

## 异常检测

异常检测库 - 新建检测库 - MySQL 检测库

| 序号 | 规则名称 | 触发条件 | 级别 | 检测频率 |
| --- | --- | --- | --- | --- |
|  |  |  |  |  |

## 指标详解

{{ range $i, $m := .Measurements }}

{{if or (eq $m.Type "metric") (eq $m.Type "")}}

### `{{$m.Name}}`

{{$m.Desc}}

- 标签

{{$m.TagsMarkdownTable}}

- 指标列表

{{$m.FieldsMarkdownTable}}
{{end}}

{{ end }}

## 日志

如需采集 MySQL 的日志，将配置中 log 相关的配置打开，如需要开启 MySQL 慢查询日志，需要开启慢查询日志，在 MySQL 中执行以下语句

```sql
SET GLOBAL slow_query_log = 'ON';

-- 未使用索引的查询也认为是一个可能的慢查询
set global log_queries_not_using_indexes = 'ON';
```

```python
[inputs.mysql.log]
    # 填入绝对路径
    files = ["/var/log/mysql/*.log"]
```

> 注意：在使用日志采集时，需要将 DataKit 安装在 MySQL 服务同一台主机中，或使用其它方式将日志挂载到 DataKit 所在机器

MySQL 日志分为普通日志和慢日志两种。

### MySQL 普通日志

日志原文：

```
2017-12-29T12:33:33.095243Z         2 Query     SELECT TABLE_SCHEMA, TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE CREATE_OPTIONS LIKE '%partitioned%';
```

切割后的字段列表如下：

| 字段名   | 字段值                                                   | 说明                         |
| -------- | -------------------------------------------------------- | ---------------------------- |
| `status` | `Warning`                                                | 日志级别                     |
| `msg`    | `System table 'plugin' is expected to be transactional.` | 日志内容                     |
| `time`   | `1514520249954078000`                                    | 纳秒时间戳（作为行协议时间） |

### MySQL 慢查询日志

日志原文：

```
# Time: 2019-11-27T10:43:13.460744Z
# User@Host: root[root] @ localhost [1.2.3.4]  Id:    35
# Query_time: 0.214922  Lock_time: 0.000184 Rows_sent: 248832  Rows_examined: 72
# Thread_id: 55   Killed: 0  Errno: 0
# Bytes_sent: 123456   Bytes_received: 0
SET timestamp=1574851393;
SELECT * FROM fruit f1, fruit f2, fruit f3, fruit f4, fruit f5
```

切割后的字段列表如下：

| 字段名              | 字段值                                                                                      | 说明                           |
| ------------------- | ------------------------------------------------------------------------------------------- | ------------------------------ |
| `bytes_sent`        | `123456`                                                                                    | 发送字节数                     |
| `db_host`           | `localhost`                                                                                 | hostname                       |
| `db_ip`             | `1.2.3.4`                                                                                   | ip                             |
| `db_slow_statement` | `SET timestamp=1574851393;\nSELECT * FROM fruit f1, fruit f2, fruit f3, fruit f4, fruit f5` | 慢查询 sql                     |
| `db_user`           | `root[root]`                                                                                | 用户                           |
| `lock_time`         | `0.000184`                                                                                  | 锁时间                         |
| `query_id`          | `35`                                                                                        | 查询 id                        |
| `query_time`        | `0.2l4922`                                                                                  | SQL 执行所消耗的时间           |
| `rows_examined`     | `72`                                                                                        | 为了返回查询的数据所读取的行数 |
| `rows_sent`         | `248832`                                                                                    | 查询返回的行数                 |
| `thread_id`         | `55`                                                                                        | 线程 id                        |
| `time`              | `1514520249954078000`                                                                       | 纳秒时间戳（作为行协议时间）   |


## 故障排查
<[无数据上报排查](why-no-data.md)>
