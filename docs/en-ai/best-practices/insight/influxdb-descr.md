# InfluxDB Time Series Analysis

---

## Software Overview

InfluxDB is an open-source distributed time-series and metrics database, written in Go.

## Industry Position

InfluxDB consistently holds the top position, with the latest time-series database rankings showing InfluxDB leading the second-place Kdb+ by a margin equivalent to three Prometheus distances.

![image.png](../images/influxdb-descr-1.png)

## Basic Concepts

- **Database**: Database

- **Measurement**: Data table, analogous to a table in MySQL.
- **Field**: Key-value pairs that record actual data in InfluxDB (mandatory, not indexed).
- **Field Set**: A collection of Field key-value pairs.
   - **Field Key**: The key part of the Field key-value pair.
   - **Field Value**: The value part of the Field key-value pair (the actual data).
- **Tag**: Key-value pairs used to describe Fields (optional, indexed).
- **Tag Set**: A collection of Tag key-value pairs.
   - **Tag Key**: The key part of the Tag key-value pair.
   - **Tag Value**: The value part of the Tag key-value pair.
- **Timestamp**: The date and time associated with a data point.

## Advanced Concepts

- **Retention Policy**: Data storage duration (default is `autogen`, meaning permanent storage).

- **Series**: A time series composed of Retention Policy, Measurement, and Tag Set.

| **Series Number** | **Retention Policy** | **Measurement** | **Tag Set** |
| --- | --- | --- | --- |
| Time Series 1 | autogen | Weather | Province=Zhejiang, City=Wenzhou |
| Time Series 2 | autogen | Weather | Province=Zhejiang, City=Shaoxing |
| Time Series 3 | autogen | Weather | Province=Jiangsu, City=Changzhou |
| Time Series 4 | autogen | Weather | Province=Jiangsu, City=Wuxi |

- **Point**: A set of Fields with the same Timestamp within a Series, which can be understood as a row of data in a table.

| **Timestamp** | **Measurement** | **Tag Set** | **Field Set** |
| --- | --- | --- | --- |
| 2021-12-12T00:00:00Z | Disk | Host=a, Path=/ | Free = 40836976, Used = 20836976 |

- **Line Protocol**: A text format for writing data points into InfluxDB.

```
# Converting the above Point into Line Protocol
disk,host=a,path=/ free=40836976,used=20836976 1639238400000000000
```

## Practical Operations

### 1. Software Installation

Add the Influxdata yum repository

```
cat <<EOF | tee /etc/yum.repos.d/influxdb.repo
[influxdb]
name = InfluxDB Repository - RHEL \$releasever
baseurl = https://repos.influxdata.com/rhel/\$releasever/\$basearch/stable
enabled = 1
gpgcheck = 1
gpgkey = https://repos.influxdata.com/influxdb.key
EOF
```

Install Telegraf / InfluxDB

```
yum -y install telegraf influxdb
```

Start the software

```
systemctl start influxdb
systemctl start telegraf
```

### 2. Data Query

Since it's a local installation, use the `influx` command to directly enter the database (for more parameters, see `influx -h`).

```
influx
```

Select the `telegraf` database and query data using the `select` command (query language is InfluxQL).

```
use telegraf
select * from system limit 3
```

The image shows 3 Points, each composed of 4 parts (measurement, timestamp, tag set, field set).

![image.png](../images/influxdb-descr-2.png)

- **Measurement**

  - name = system

- **Timestamp**

  - time = 1637744500000000000 (nanoseconds)

- **Tag Set**

  - host = df-solution-ecs-018

- **Field Set**

  - load = 0, load15 = 0, load5 = 0.01, n_cpus = 4, n_users = 5, uptime = 1106990, uptime_format = 12days,19:29

### 3. Viewing Time Series

Use the `show series` command to view time series.

```
show series from cpu
```

You can see that the time series for the measurement `cpu` has 5 entries (cpu-total, cpu0, cpu1, cpu2, cpu3, all hosts are the same).

![image.png](../images/influxdb-descr-3.png)

### 4. Time Series Testing

#### 4.1 Adding `inputs.tags` (Plugin Tags)

Edit the main configuration file `/etc/telegraf/telegraf.conf` to add `inputs.cpu.tags`.

```
[[inputs.cpu]]
  percpu = true
  totalcpu = true
  collect_cpu_time = false
  report_active = false
[inputs.cpu.tags]
  cloud = 'aliyun'
```

Restart Telegraf

```
systemctl restart telegraf
```

Use the `show series` command to view the time series.

```
show series from cpu
```

You can see that the time series for the measurement `cpu` increases from 5 to 10 entries.

![image.png](../images/influxdb-descr-4.png)

#### 4.2 Deleting a Measurement

Use the `drop` command to delete a measurement.

```
drop measurement cpu
```

Use the `show series` command again to view the time series.

```
show series from cpu
```

You can see that the time series for the measurement `cpu` returns to 5 entries (cpu-total, cpu0, cpu1, cpu2, cpu3, all hosts/clouds are the same).

![image.png](../images/influxdb-descr-5.png)

#### 4.3 Adding `global_tags` (Global Tags)

Edit the main configuration file `/etc/telegraf/telegraf.conf` to add `global_tags`.

```
[global_tags]
  user = 'admin'
```

Restart Telegraf

```
systemctl restart telegraf
```

Use the `show series` command to view the time series.

```
show series from cpu
```

You can see that the time series for the measurement `cpu` increases from 5 to 10 entries again.

![image.png](../images/influxdb-descr-6.png)

Use the `show series` command to view the time series for other measurements.

```
show series from mem
```

You can see that the time series for the measurement `mem` increases from 1 to 2 entries.

![image.png](../images/influxdb-descr-7.png)

## Simple Analysis

- **Retention Policy** remains unchanged:
   - Using plugin tags doubles the number of time series for that measurement.
   - Using global tags doubles the number of time series for that database.
   - If the measurement also remains unchanged, more tag combinations result in more time series.

- **Measurement**:
   - Once deleted, all time series under that measurement are cleared.

- **Tag**:
   - Typically enumerable, such as hostname, status.
   - Should not be random values like container IDs or source IPs, as this can lead to a large number of time series.