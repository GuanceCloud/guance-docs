# Switch Time Series Engine

## Introduction

This article will introduce how to switch the time series engine in Guance, specifically for switching from InfluxDB to GuanceDB.

## Prerequisites

- GuanceDB has been deployed. If not, please refer to [GuanceDB Installation](infra-metric.md#guancedb-install)

## Deployment Information

| Name                           | Content                                      |
| ------------------------------ | -------------------------------------------- |
| **guance-insert default address** | guancedb-cluster-guance-select.middleware   |
| **guance-insert default port**  | 8480                                         |
| **guance-select default address** | guancedb-cluster-guance-select.middleware   |
| **guance-select default port**  | 8481                                         |

## Switching Steps

### Backup Tables

```SQL
CREATE TABLE `main_workspace_bak` LIKE `main_workspace`;

INSERT INTO `main_workspace_bak` SELECT * FROM `main_workspace`;

CREATE TABLE `main_influx_db_bak` LIKE `main_influx_db`;

INSERT INTO `main_influx_db_bak` SELECT * FROM `main_influx_db`;
```

### Insert GuanceDB Information

- Log in to the df_core database of Guance and execute the following statements:

  ```sql
  INSERT INTO `main_influx_instance` (`uuid`, `host`, `authorization`, `configJSON`,`dbcount`, `user`, `pwd`, `dbType`, `priority`, `status`, `creator`, `updator`, `createAt`, `deleteAt`, `updateAt`)
    VALUES
      ('276f8404252347d18e469f65f5a1abdd', 'http://0.0.0.0', '{\"admin\": {\"password\": \"*\", \"username\": \"*\"}}','{"read": {"host": "http://guancedb-cluster-guance-select.middleware:8481"}, "write": {"host": "http://guancedb-cluster-guance-insert.middleware:8480"}}', 0, '', '', 'guancedb', 50, 0, '', '', UNIX_TIMESTAMP(), -1, UNIX_TIMESTAMP());
  
  ```

  Verification:
  
  ```shell
  select count(1) from main_influx_instance where uuid='276f8404252347d18e469f65f5a1abdd';
  
  +----------+
  | count(1) |
  +----------+
  |        1 |
  +----------+
  1 row in set (0.00 sec)
  ```

> The query result should be greater than or equal to 1 for successful execution.

### Replace InfluxDB Information with GuanceDB

- Change the status of InfluxDB

  ```sql
  update main_influx_instance set status=3 where status=0 and dbType='influxdb';
  ```

  Verification:

  ```sql
  select count(1) from main_influx_instance where status=3 and dbType='influxdb';

  +----------+
  | count(1) |
  +----------+
  |        1 |
  +----------+
  1 row in set (0.00 sec)
  ```

  > The query result should be greater than or equal to 1 for successful execution.

- Batch update all workspace-related time series database information

  ```sql
  update main_influx_db set influxInstanceUUID=(select uuid from main_influx_instance where status=0 and dbType='guancedb' order by priority desc limit 1), dbType='guancedb' where status=0;
  ```

  Verification:

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

  > The query result should be greater than or equal to 1 for successful execution.

- Batch update the `metric` value in the `datastore` field of the `main_workspace` table

  ```sql
  update main_workspace set datastore=JSON_SET(datastore, "$.metric", "guancedb") where status=0 and datastore ->> "$.metric" = "influxdb";
  ```

  Verification:

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

  > The query result should be greater than or equal to 1 for successful execution.

- Update DB ID

  ```sql
  UPDATE df_core.main_influx_db 
  SET df_core.main_influx_db.db =(
    SELECT df_core.main_workspace.id
    FROM df_core.main_workspace
    WHERE df_core.main_workspace.dbUUID = df_core.main_influx_db.UUID
  );
  ```

  Verification:

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

  > The query result should be greater than or equal to 1 for successful execution.

### Restart All Kodo Services

```shell
kubectl delete pods --all -n forethought-kodo
```

### Clear Redis

Choose one of the two methods:

- Restart Redis

  ```shell
  kubectl get po -n middleware | grep redis
  kubectl delete po -n middleware <redis pod name>
  ```

- Execute cache clearing commands

  ```shell
  # Delete all "dbinfo:*" cache records, run the following bulk delete command
  redis-cli -h <host> -p <port> -n 0 -a <password> keys dbinfo:* | xargs -r -t -n1 redis-cli -h <host> -p <port> -n 0 -a <password> del
  
  # Delete all "wkspInfo:*" cache records, run the following bulk delete command
  redis-cli -h <host> -p <port> -n 0 -a <password> keys wkspInfo:* | xargs -r -t -n1 redis-cli -h <host> -p <port> -n 0 -a <password> del
  
  # Delete all "tkn_info:*" cache records, run the following bulk command
  redis-cli -h <host> -p <port> -n 0 -a <password> keys tkn_info:* | xargs -r -t -n1 redis-cli -h <host> -p <port> -n 0 -a <password> del
  ```