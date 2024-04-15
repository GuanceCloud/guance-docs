# 切换日志引擎

## 简介

本文将介绍观测云切换日志引擎，支持 6 种不同的引擎，包含原版开源的 Elasticsearch、原版开源的 OpenSearch、AWS 云上的托管 OpenSearch、华为云上的托管 Elasticsearch、aliyun 上的托管 Elasticsearch 日志增强版、aliyun 上的托管 Elasticsearch。此操作适用于 POC 切换生产日志引擎。

## 前提条件


- 准备日志引擎地址、账号密码
- 确认 analysis-ik 是否安装成功
- 是否关闭自动创建索引
- 准备观测云 MySQL 的地址、`df_core` 数据库的账号密码
  ![](switch-log-1.png)


## 切换步骤
### 步骤一：关闭 kodo-x 服务

```shell
kubectl scale -n forethought-kodo deploy kodo-x --replicas 0

```

### 步骤二：刷新配置

登录 `df_core` 数据库

1.备份表

   ```sql
   SQL> create table df_core.main_es_instance_copy select * from df_core.main_es_instance;
   ```

2.查询信息

   ```sql
   SQL> select authorization,configJSON,id,host from df_core.main_es_instance;
   ```

   结构：

   ```shell
   mysql> select id,host,authorization,configJSON from df_core.main_es_instance;
   +----+----------------------------------------+------------------------------------------------------------------------+-------------------------+
   | id | host                                   | authorization                                                          | configJSON              |
   +----+----------------------------------------+------------------------------------------------------------------------+-------------------------+
   |  1 | http://testing-ft-elastic.cloudcare.cn | {"admin": {"password": "xxxxx", "username": "elastic"}}                | {"provider": "elastic"} |
   +----+----------------------------------------+------------------------------------------------------------------------+-------------------------+
   1 rows in set (0.01 sec)
   ```

3.更新配置

   ```sql
   SQL> update df_core.main_es_instance a set a.authorization='{"admin": {"password": "xxxxx", "username": "elastic"}}',a.configJSON='{"provider": "elastic"}',a.host='http://elasticsearch-client-headless.middleware:9200' where id =1;
   ```

   **参数说明：**

   - `authorization` 为 es 用户名密码

   - `configJSON`为 es 的供应商，

     可选值：

     - elastic （原版开源的 Elasticsearch）
     - opensearch （原版开源的 OpenSearch）
     - aws_opensearch （AWS 云上的托管 OpenSearch）
     - huawei_opensearch （华为云上的托管 Elasticsearch）
     - aliyun_openstore （aliyun 上的托管 Elasticsearch 日志增强版）
     - aliyun_elasticsearch （aliyun 上的托管 Elasticsearch）

   - `host` 为 es 地址

   - `id` 为 第二步骤获取的 ES 实例 id

   

### 步骤三：重启服务

```shell
kubectl delete pods --all -n forethought-kodo
```

### 步骤四：初始化 es 模版

登录 `forethought-core` inner api 容器执行命令：

```shell
$ curl 'http://127.0.0.1:5000/api/v1/inner/es/init' -X 'POST'  -H 'Content-Type: application/json'
$ curl 'http://127.0.0.1:5000/api/v1/inner/es/init_subsequent' -X 'POST'  -H 'Content-Type: application/json'
```

### 步骤五：启动 kodo-x

```shell
kubectl scale -n forethought-kodo deploy kodo-x --replicas 3
```

### 步骤六：清空 redis 缓存

登录 redis 数据库：

```shell
flushall
```

### 步骤七：验证

请登录观测云控制台仔细查看基础设施和日志功能。


## FAQ {#FAQ}

### 页面查询 query failed

![](img/query-failed.png)
#### 前提条件

- 获取报错空间的空间 ID
- 可以访问 OpenSearch

#### 删除错误索引

```shell
curl -XDELETE -u "user:password" http://<OPenSearchHost>:9200/<工作空间ID>*
```

**那个\*不要省**
