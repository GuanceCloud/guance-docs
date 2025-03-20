---
title     : 'Zabbix Data Ingestion'
summary   : 'Zabbix realTime data ingestion'
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

Collecting Zabbix service real-time data and sending it to the Guance center.

Zabbix versions from 4.0 to 7.0 support writing real-time data to files. There are three types of real-time data formats: `events/history/trends`, where `history` and `trends` are displayed in Metrics form. However, `events` can be sent to Guance via [Webhook](https://www.zabbix.com/documentation/5.4/en/manual/config/notifications/media/webhook?hl=Webhook%2Cwebhook){:target="_blank"} method.

## Configuration {#config}

### Prerequisites {#requirements}

Modify the configuration file, usually located at */etc/zabbix/zabbix_server.conf* :

```toml
  ### Option: ExportDir
  #       Directory for real time export of events, history and trends in newline delimited JSON format.
  #       If set, enables real time export.
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
  #       List of comma delimited types of real time export - allows to control export entities by their
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

Note: The configuration file size should be measured according to the HOST configuration. Too large files may easily cause insufficient disk space. `.old` files should also be deleted regularly. Here, setting it to 32M takes into account the excessive load on the file system.

After configuration, restart the service:

```shell
systemctl restart zabbix-server
```

### Collector Configuration {#input-config}

Enter the `conf.d/zabbix_exporter` directory under the DataKit installation directory, copy `zabbix_exporter.conf.sample` and rename it to `zabbix_exporter.conf`. Example as follows:

```toml
       
    [[inputs.zabbix_exporter]]
      ## zabbix server web.
      localhostAddr = "http://localhost/zabbix/api_jsonrpc.php"
      user_name = "Admin"
      user_pw = "zabbix"
      
      ## measurement yaml Dir
      measurement_config_dir = "/data/zbx/yaml"
    
      ## exporting object.default is item. all is <trigger,item,trends>. 
      objects = "item"
    
      ## update items and interface data.
      ## like this: All data is updated at 2 o'clock every day.
      crontab = "0 2 * * *"
    
      # [inputs.zabbix_exporter.tags]
        # key1 = "value1"
        # key2 = "value2"
        # ...
    
      ## mysql database:zabbix , tables: items,interface.
      #[inputs.zabbix_exporter.mysql]
      #  db_host = "192.168.10.12"
      #  db_port = "3306"
      #  user = "root"
      #  pw = "123456"
    
      # Zabbix server version 4.x - 7.x
      [inputs.zabbix_exporter.export_v5]
        # zabbix realTime exportDir path
        export_dir = "/data/zbx/datakit/"
        # 4.0~4.9 is v4
        # 5.0~7.x is v5
        module_version = "v5"
    
```

Configuration notes:

1. Since the data in the collection files must be from the local machine, the zabbix server should be configured as `localhost`
2. `measurement_config_dir` is YAML configuration
3. `objects`: Zabbix exports three types of data, currently only `item` has the most complete integration
4. `crontab`: Required field, full update data time expression
5. `mysql`: Required field, needs to obtain full ITEM table data from the database
6. `module_version`: Required field, versions 5.0 to 7.0+ are `v5`, Zabbix versions below 5.0 are: `v4`

After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

## Data Cache {#cache}

1 Fetch all items table data from MySQL, store them in memory. After exporting data from zabbix, you need to query using item id from items, so the full table data uses `map[itemid]itemc` for storage.

```text
mysql> select itemid,name,type,key_,hostid,units from items where itemid=29167;
+--------+--------------------+--------+-----------------------------+--------+-------+
| itemid | name               |   type | key_                        | hostid | units |
+--------+--------------------+--------+-----------------------------+--------+-------+
|  29167 | CPU interrupt time |   4    | system.cpu.util[,interrupt] |  10084 | %     |
+--------+--------------------+--------+-----------------------------+--------+-------+
```

type has a mapping table. Use `item_type` as the key for tags.

2 Fetch the interface table from MySQL and store it in memory.

```text
mysql> select * from zabbix.interface;
+-------------+--------+------+------+-------+---------------+-----+-------+
| interfaceid | hostid | main | type | useip | ip            | dns | port  |
+-------------+--------+------+------+-------+---------------+-----+-------+
|           1 |  10084 |    1 |    1 |     1 | 127.0.0.1     |     | 10050 |
|           2 |  10438 |    1 |    1 |     1 | 10.200.14.226 |     | 10050 |
+-------------+--------+------+------+-------+---------------+-----+-------+

Field meanings
main 0: default network card, 1: non-default network card
type 1: "Agent", 2: "SNMP", 3: "IPMI", 4: "JMX",
```

According to the host id, the IP address can be retrieved, so the storage format for the interface table is `map[hostid]interfaceC`

type also has a mapping table.

3 Measurement cache

Read all YAML files ending with .yaml in the `measurement_config_dir` directory and load them into memory.

## Data Assembly {#Assembly}

***The following example uses itemid = 29167***

A line of data obtained from the exporter file is as follows:

```json
{"host":{"host":"Zabbix server","name":"Zabbix server"},"groups":["Zabbix servers"],"applications":["CPU"],"itemid":29167,"name":"CPU interrupt time","clock":1728611707,"ns":570308079,"value":0.000000,"type":0}
```

Data fetched from the items table:

```text
itemid , name , key_ , units
29167,CPU interrupt time,"system.cpu.util[,interrupt]",%
```

Assembly steps:

Query and retrieve name, key_, units through item id from the items table (already cached in memory). At this point: name="CPU interrupt time" key_ = "system.cpu.util[,interrupt]" units=%(percentage format)

Then retrieve the data for this name from the measurement table:

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

Based on the key string after removing brackets from the item table, find this data in the measurement. According to the corresponding relationship in the brackets, we know the following tags: `cpu=""` , `type="interrupt"` , `mode="avg1"` , `logical_or_physical="logical"`

Finally: the final form of this Metric is:

```text
Measurement zabbix_server
Metric name: system_cpu_util Value is 0.000000 and has the following tags:

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

Request data through the API interface exposed by Zabbix.

Step one, first get the token through the login interface. The token is the authentication for subsequent requests.

Step two, get the `name`, `key_`, `type`, `hostid`, `unit` information for the item via `itemid`, returned data are all in string format. They need to be converted into the corresponding formats.

Note: The returned format is not **fixed**. If it returns a single item, it's in string format; if requesting multiple items, it's in array format.

## Reference Documents {#documents}

- Official configuration document: [5.0 Data Export Configuration](https://www.zabbix.com/documentation/5.0/en/manual/appendix/install/real_time_export?hl=export){:target="_blank"}
- [6.0 Data Export](https://www.zabbix.com/documentation/6.0/en/manual/appendix/install/real_time_export){:target="_blank"}
- [7.0 Data Export](https://www.zabbix.com/documentation/current/en/manual/config/export/files){:target="_blank"}