---
title     : 'Zabbix Data Ingestion'
summary   : 'Zabbix real-time data ingestion'
tags:
  - 'External Data Ingestion'
__int_icon      : 'icon/zabbix'
dashboard :
  - desc  : 'Not available'
    path  : '-'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---

:fontawesome-brands-linux:

---

[:octicons-tag-24: Version-1.37.0](../datakit/changelog.md#cl-1.37.0)

---

Collect real-time data from the Zabbix service and send it to the Guance center.

Zabbix versions from 4.0 to 7.0 support writing real-time data to files. There are three types of data formats in real-time data: `events/history/trends`, where `history` and `trends` are displayed as Metrics. The `events` can be sent to Guance via [Webhook](https://www.zabbix.com/documentation/5.4/en/manual/config/notifications/media/webhook?hl=Webhook%2Cwebhook){:target="_blank"}.

## Configuration {#config}

### Prerequisites {#requirements}

Modify the configuration file, typically located at */etc/zabbix/zabbix_server.conf* :

```toml
  ### Option: ExportDir
  #       Directory for real-time export of events, history, and trends in newline-delimited JSON format.
  #       If set, enables real-time export.
  #
  # Mandatory: no
  ExportDir=/data/zbx/datakit
  
  ### Option: ExportFileSize
  #       Maximum size per export file in bytes.
  #       Only used for rotation if ExportDir is set.
  #
  # Mandatory: no
  # Range: 1M-1G
  ExportFileSize=32M

  ### Option: ExportType
  #       List of comma-delimited types of real-time export - allows control over export entities by their
  #       type (events, history, trends) individually.
  #       Valid only if ExportDir is set.
  #
  # Mandatory: no
  # Default:
  # ExportType=events,history,trends
```

Modify the configuration items as follows:

```toml
ExportDir=/data/zbx/datakit
ExportFileSize=32M
```

Change the file permissions:

```shell
mkdir -p /data/zbx/datakit
chown zabbix:zabbix -R /data/zbx/datakit
chmod u+rw -R /data/zbx/datakit/
```

Note: When setting the file size, consider the host configuration to avoid excessive disk space usage. Old `.old` files should be deleted periodically. Setting this to 32M considers the file system load.

After configuration, restart the service:

```shell
systemctl restart zabbix-server
```

### Collector Configuration {#input-config}

Navigate to the `conf.d/zabbix_exporter` directory under the DataKit installation directory, copy `zabbix_exporter.conf.sample` and rename it to `zabbix_exporter.conf`. Example:

```toml
       
    [[inputs.zabbix_exporter]]
      ## Zabbix server web address.
      localhostAddr = "http://localhost/zabbix/api_jsonrpc.php"
      user_name = "Admin"
      user_pw = "zabbix"
      
      ## measurement YAML directory
      measurement_config_dir = "/data/zbx/yaml"
    
      ## exporting object. Default is item. All options are <trigger,item,trends>. 
      objects = "item"
    
      ## update items and interface data.
      ## For example: All data is updated at 2 AM every day.
      crontab = "0 2 * * *"
    
      # [inputs.zabbix_exporter.tags]
        # key1 = "value1"
        # key2 = "value2"
        # ...
    
      ## MySQL database: zabbix, tables: items,interface.
      #[inputs.zabbix_exporter.mysql]
      #  db_host = "192.168.10.12"
      #  db_port = "3306"
      #  user = "root"
      #  pw = "123456"
    
      # Zabbix server version 4.x - 7.x
      [inputs.zabbix_exporter.export_v5]
        # Zabbix real-time exportDir path
        export_dir = "/data/zbx/datakit/"
        # 4.0~4.9 is v4
        # 5.0~7.x is v5
        module_version = "v5"
    
```

Configuration notes:

1. Since the data in the collection file must be local, the Zabbix server should be configured as `localhost`.
2. `measurement_config_dir` is for YAML configuration.
3. `objects`: Zabbix exports three types of data; currently, only `item` is fully supported.
4. `crontab`: Required field, specifying the cron expression for full data updates.
5. `mysql`: Required field, fetches all item table data from the database.
6. `module_version`: Required field, versions 5.0 to 7.0+ are `v5`; Zabbix versions below 5.0 are `v4`.

After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

## Data Caching {#cache}

<!-- markdownlint-disable MD029 -->

1. Fetch the entire `items` table from MySQL and store it in memory. After exporting data from Zabbix, use the `itemid` to query the `items` table, so the entire table is stored using `map[itemid]itemc`.

```text
mysql> select itemid,name,type,key_,hostid,units from items where itemid=29167;
+--------+--------------------+--------+-----------------------------+--------+-------+
| itemid | name               |   type | key_                        | hostid | units |
+--------+--------------------+--------+-----------------------------+--------+-------+
|  29167 | CPU interrupt time |   4    | system.cpu.util[,interrupt] |  10084 | %     |
+--------+--------------------+--------+-----------------------------+--------+-------+
```

The `type` has a mapping table. Use `item_type` as the tag key.

2. Fetch the `interface` table from MySQL and store it in memory.

```text
mysql> select * from zabbix.interface;
+-------------+--------+------+------+-------+---------------+-----+-------+
| interfaceid | hostid | main | type | useip | ip            | dns | port  |
+-------------+--------+------+------+-------+---------------+-----+-------+
|           1 |  10084 |    1 |    1 |     1 | 127.0.0.1     |     | 10050 |
|           2 |  10438 |    1 |    1 |     1 | 10.200.14.226 |     | 10050 |
+-------------+--------+------+------+-------+---------------+-----+-------+

Field meanings:
main 0: default network card, 1: non-default network card
type 1: "Agent", 2: "SNMP", 3: "IPMI", 4: "JMX",
```

Based on the host ID, the IP can be retrieved, so the storage format for the `interface` table is `map[hostid]interfaceC`.

`type` also has a mapping table.

3. Measurement caching

Read all YAML files from the `measurement_config_dir` directory and load them into memory.

## Data Assembly {#Assembly}

***Using `itemid = 29167` as an example***

A line of data fetched from the exporter file looks like this:

```json
{"host":{"host":"Zabbix server","name":"Zabbix server"},"groups":["Zabbix servers"],"applications":["CPU"],"itemid":29167,"name":"CPU interrupt time","clock":1728611707,"ns":570308079,"value":0.000000,"type":0}
```

Data fetched from the `items` table:

```text
itemid , name , key_ , units
29167,CPU interrupt time,"system.cpu.util[,interrupt]",%
```

Assembly steps:

Query the `items` table (already cached in memory) using the `itemid` to obtain `name`, `key_`, and `units`. At this point: `name="CPU interrupt time"`, `key_ = "system.cpu.util[,interrupt]"`, `units=%` (percentage format).

Retrieve the data for this `name` from the `measurement` table:

```yaml
- measurement: System
  metric: system_cpu_util
  key: system.cpu.util
  params:
    - cpu
    - type
    - mode
    - logical_or_physical
  values:
    - ''
    - user
    - avg1
    - logical
```

Based on the string after removing the brackets from the `key` in the `item` table, find this data in the `measurement`. According to the corresponding relationship within the brackets, the following tags are obtained: `cpu=""`, `type="interrupt"`, `mode="avg1"`, `logical_or_physical="logical"`.

Finally, the final form of this metric is:

```text
Measurement Set zabbix_server
Metric Name: system_cpu_util Value: 0.000000 Tags:

cpu=""
type="interrupt"
mode="avg1"
logical_or_physical="logical"
measurement="System"
applications="CPU"
groups="Zabbix servers"
host="Zabbix server"
item_type = "Zabbix agent"
interface_type = "Agent"
interface_main = "default"
ip = "127.0.0.1"
hostname="Zabbix server"
time=1728611707570308079
```

## Zabbix Service API {#api}

Request data through the API exposed by Zabbix.

Step one, obtain a token through the login interface. The token is required for authentication in subsequent requests.

Step two, retrieve the `name`, `key_`, `type`, `hostid`, and `unit` information for the item using the `itemid`. The returned data is in string format and needs to be converted to the appropriate format.

Note: The return format is **not fixed**. If a single item is returned, it will be in string format. If multiple items are requested, it will be in array format.

## Reference Documentation {#documents}

- Official configuration documentation: [5.0 Data Export Configuration](https://www.zabbix.com/documentation/5.0/en/manual/appendix/install/real_time_export?hl=export){:target="_blank"}
- [6.0 Data Export](https://www.zabbix.com/documentation/6.0/en/manual/appendix/install/real_time_export){:target="_blank"}
- [7.0 Data Export](https://www.zabbix.com/documentation/current/en/manual/config/export/files){:target="_blank"}
