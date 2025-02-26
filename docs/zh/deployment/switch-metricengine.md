# 切换时序引擎

## 简介

本文将介绍{{{ custom_key.brand_name }}}切换时序引擎，此操作适用于 InfluxDB 切换 GuanceDB。

## 前提条件

- 已部署 GuanceDB，未部署可参考 [GuanceDB 安装](infra-metric.md#guancedb-install) 

## 部署信息

| 名称                       | 内容                                      |
| -------------------------- | ----------------------------------------- |
| **guance-insert 默认地址** | guancedb-cluster-guance-select.middleware |
| **guance-insert默认端口**  | 8480                                      |
| **guance-select 默认地址** | guancedb-cluster-guance-select.middleware |
| **guance-select 默认端口** | 8481                                      |

## 切换步骤

### 备份表

```SQL

CREATE TABLE `main_workspace_bak` LIKE `main_workspace`;
 

INSERT INTO  `main_workspace_bak` SELECT * FROM `main_workspace`;


CREATE TABLE `main_influx_db_bak` LIKE `main_influx_db`;
 

INSERT INTO  `main_influx_db_bak` SELECT * FROM `main_influx_db`;

```

### 插入 GuanceDB 信息

- 登录{{{ custom_key.brand_name }}} df_core 数据库，执行以下语句：

  ```sql
  INSERT INTO `main_influx_instance` (`uuid`, `host`, `authorization`, `configJSON`,`dbcount`, `user`, `pwd`, `dbType`, `priority`, `status`, `creator`, `updator`, `createAt`, `deleteAt`, `updateAt`)
    VALUES
      ('276f8404252347d18e469f65f5a1abdd', 'http://0.0.0.0', '{\"admin\": {\"password\": \"*\", \"username\": \"*\"}}','{"read": {"host": "http://guancedb-cluster-guance-select.middleware:8481"}, "write": {"host": "http://guancedb-cluster-guance-insert.middleware:8480"}}', 0, '', '', 'guancedb', 50, 0, '', '', UNIX_TIMESTAMP(), -1, UNIX_TIMESTAMP());
  
  ```
  
  验证：
  
  ```shell
  select count(1) from main_influx_instance where uuid='276f8404252347d18e469f65f5a1abdd';
  
  +----------+
  | count(1) |
  +----------+
  |        1 |
  +----------+
  1 row in set (0.00 sec)
  ```

>    查询结果大等于1，为执行成功

### GuanceDB 替换 InfluxDB 信息

- 更改 InfluxDB 状态

  ```sql
  update main_influx_instance set status=3 where status=0 and dbType='influxdb';
  ```

  验证：

  ```sql
  select count(1) from main_influx_instance where status=3 and dbType='influxdb';
  
  +----------+
  | count(1) |
  +----------+
  |        1 |
  +----------+
  1 row in set (0.00 sec)
  ```

  > 查询结果大于等于1，为执行成功

- 批量更新所有工作空间对应的 时序数据库信息

  ```sql
  update main_influx_db set influxInstanceUUID=(select uuid from main_influx_instance where status=0 and dbType='guancedb' order by priority desc limit 1) , dbType='guancedb' where status=0;
  ```

  验证：

  ```shell
  SELECT count(1)
  FROM main_influx_db AS db
  JOIN main_influx_instance AS instance ON db.influxInstanceUUID = instance.uuid
  WHERE db.status = 0
    AND db.dbType = 'guancedb';
  
  +----------+
  | count(1) |
  +----------+
  |       26 |
  +----------+
  1 row in set (0.01 sec)
  
  ```

  > 查询结果大于等于1，为执行成功

-  批量更新`main_workspace`表中的`datastore`中的`metric`值

  ```sql
  update main_workspace set datastore=JSON_SET(datastore, "$.metric", "guancedb") where status=0 and datastore ->> "$.metric" = "influxdb";
  ```

  验证：

  ```shell
  SELECT count(1)
  FROM main_workspace
  WHERE status = 0
    AND datastore ->> "$.metric" = "guancedb";
    
  +----------+
  | count(1) |
  +----------+
  |       26 |
  +----------+
  1 row in set (0.00 sec)
  ```

  > 查询结果大于等于1，为执行成功

- 更换 DB ID

  ```sql
  UPDATE df_core.main_influx_db 
  SET df_core.main_influx_db.db =(
    SELECT df_core.main_workspace.id
    FROM df_core.main_workspace
    WHERE df_core.main_workspace.dbUUID = df_core.main_influx_db.UUID
  );
  ```

  验证：

  ```sql
  SELECT count(1)
  FROM df_core.main_influx_db AS db
  JOIN df_core.main_workspace AS ws ON ws.dbUUID = db.UUID;
  
  +----------+
  | count(1) |
  +----------+
  |       26 |
  +----------+
  1 row in set (0.00 sec)
  ```

  > 查询结果大于等于1，为执行成功

### 重启 Kodo 所有服务

```shell
kubectl delete pods --all -n forethought-kodo
```

### 清空 Redis

两种方法二选一：

- 重启 Redis

  ```shell
  kubectl get po -n middleware | grep redis
  kubectl delete po -n middleware <redis pod 名字>	
  ```

- 执行清空缓存命令

  ```shell
  # 删除所有的 "dbinfo:*" 缓存记录，执行如下批量删除命令
  redis-cli -h <host> -p <端口> -n 0 -a <密码> keys dbinfo:* | xargs -r -t -n1 redis-cli -h <host> -p <端口> -n 0 -a <密码> del
   
  # 删除所有的 "wkspInfo:*" 缓存记录，执行如下批量删除命令
  redis-cli -h <host> -p <端口> -n 0 -a <密码> keys wkspInfo:* | xargs -r -t -n1 redis-cli -h <host> -p <端口> -n 0 -a <密码> del
   
  # 删除所有的 "tkn_info:*" 缓存记录，执行如下批量命令
  redis-cli -h <host> -p <端口> -n 0 -a <密码> keys tkn_info:* | xargs -r -t -n1 redis-cli -h <host> -p <端口> -n 0 -a <密码> del
  ```

  