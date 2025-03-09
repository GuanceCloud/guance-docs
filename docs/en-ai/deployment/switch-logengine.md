# Switch Log Engine

## Introduction

This document will introduce how to switch the log engine in <<< custom_key.brand_name >>>. It supports 6 different engines, including the original open-source Elasticsearch, the original open-source OpenSearch, AWS cloud-hosted OpenSearch, Huawei Cloud-hosted Elasticsearch, Alibaba Cloud托管 Elasticsearch Log Enhanced Edition, and Alibaba Cloud-hosted Elasticsearch. This operation is suitable for switching production log engines from POC.

## Prerequisites

- Prepare the log engine address, account, and password.
- Confirm whether analysis-ik is successfully installed.
- Determine if auto-index creation is disabled.
- Prepare the <<< custom_key.brand_name >>> MySQL address and `df_core` database account and password.
  ![](switch-log-1.png)

## Switching Steps
### Step One: Stop kodo-x Service

```shell
kubectl scale -n forethought-kodo deploy kodo-x --replicas 0
```

### Step Two: Refresh Configuration

Log in to the `df_core` database.

1. Backup the table

   ```sql
   SQL> create table df_core.main_es_instance_copy select * from df_core.main_es_instance;
   ```

2. Query information

   ```sql
   SQL> select authorization, configJSON, id, host from df_core.main_es_instance;
   ```

   Structure:

   ```shell
   mysql> select id, host, authorization, configJSON from df_core.main_es_instance;
   +----+----------------------------------------+------------------------------------------------------------------------+-------------------------+
   | id | host                                   | authorization                                                          | configJSON              |
   +----+----------------------------------------+------------------------------------------------------------------------+-------------------------+
   |  1 | http://testing-ft-elastic.cloudcare.cn | {"admin": {"password": "xxxxx", "username": "elastic"}}                | {"provider": "elastic"} |
   +----+----------------------------------------+------------------------------------------------------------------------+-------------------------+
   1 rows in set (0.01 sec)
   ```

3. Update configuration

   ```sql
   SQL> update df_core.main_es_instance a set a.authorization='{"admin": {"password": "xxxxx", "username": "elastic"}}', a.configJSON='{"provider": "elastic"}', a.host='http://elasticsearch-client-headless.middleware:9200' where id =1;
   ```

   **Parameter Explanation:**

   - `authorization`: ES username and password
   - `configJSON`: ES provider,
     Possible values:
     - elastic (original open-source Elasticsearch)
     - opensearch (original open-source OpenSearch)
     - aws_opensearch (AWS cloud-hosted OpenSearch)
     - huawei_elasticsearch (Huawei Cloud-hosted Elasticsearch)
     - aliyun_openstore (Alibaba Cloud-hosted Elasticsearch Log Enhanced Edition)
     - aliyun_elasticsearch (Alibaba Cloud-hosted Elasticsearch)
   - `host`: ES address
   - `id`: The ES instance ID obtained in step two

### Step Three: Restart Services

```shell
kubectl delete pods --all -n forethought-kodo
```

### Step Four: Initialize ES Templates

Log in to the `forethought-core` inner API container and execute the following commands:

```shell
$ curl 'http://127.0.0.1:5000/api/v1/inner/es/init' -X 'POST'  -H 'Content-Type: application/json'
$ curl 'http://127.0.0.1:5000/api/v1/inner/es/init_subsequent' -X 'POST'  -H 'Content-Type: application/json'
```

### Step Five: Start kodo-x

```shell
kubectl scale -n forethought-kodo deploy kodo-x --replicas 3
```

### Step Six: Clear Redis Cache

Log in to the Redis database:

```shell
flushall
```

### Step Seven: Verification

Please log in to the <<< custom_key.brand_name >>> console and carefully check the infrastructure and log functionality.

## FAQ {#FAQ}

### Page Query Failed

![](img/query-failed.png)
#### Prerequisites

- Obtain the space ID of the error space.
- Ensure access to OpenSearch.

#### Delete Incorrect Index

```shell
curl -XDELETE -u "user:password" http://<OPenSearchHost>:9200/<workspaceID>*
```

**Do not omit the asterisk (*)**