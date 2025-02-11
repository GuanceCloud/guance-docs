# Quick Start with Pythond Collector Best Practices

---

Pythond is a complete solution that periodically triggers user-defined Python collection scripts. This article uses "reporting the number of users who log in each hour" as an example metric.

## Business Demonstration Introduction

The business process is roughly as follows: <br/>
Collect data from the database (Python script) -> Pythond collector periodically triggers this script to report data (datakit) -> View metrics on the web interface.

There is now a table called `customers` in the database, which contains the following fields:

- name: Name (string)
- last_logined_time: Login time (timestamp)

The table creation statement is as follows:

```sql
create table customers
(
  `id`                BIGINT(20)  not null AUTO_INCREMENT COMMENT 'Auto-increment ID',
  `last_logined_time` BIGINT(20)  not null DEFAULT 0      COMMENT 'Login time (timestamp)',
  `name`              VARCHAR(48) not null DEFAULT ''     COMMENT 'Name',

  primary key(`id`),
  key idx_last_logined_time(last_logined_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

Insert test data into the above table:

```sql
INSERT INTO customers (id, last_logined_time, name) VALUES (1, 1645600127, 'zhangsan');
INSERT INTO customers (id, last_logined_time, name) VALUES (2, 1645600127, 'lisi');
INSERT INTO customers (id, last_logined_time, name) VALUES (3, 1645600127, 'wangwu');
```

Use the following SQL statement to obtain "the number of users who logged in each hour":

```sql
select count(1) from customers where last_logined_time >= (unix_timestamp() - 3600);
```

Report the above data as metrics to the central server.

Below are the detailed steps to implement the above business requirements.

## Prerequisites

### Python Environment

Currently in alpha phase, **only compatible with Python 3+**. Tested versions:

- [x] 3.10.1

### Python Dependency Libraries

The following libraries need to be installed:

- requests (for network operations, used to report metrics)
- pymysql (for MySQL database operations, used to connect to the database and retrieve business data)

Installation method:

```shell
# python3
python3 -m pip install requests
python3 -m pip install pymysql
```

The above installation requires pip. If you do not have it, refer to the following method (source: [here](https://pip.pypa.io/en/stable/installation/)):

```shell
# Linux/MacOS
python3 -m ensurepip --upgrade

# Windows
py -m ensurepip --upgrade
```

## Installation and Deployment

### 1 Writing User-defined Scripts

Users need to inherit the `DataKitFramework` class and then override the `run` method. The source code file for the `DataKitFramework` class is `datakit_framework.py`, located at `datakit/python.d/core/datakit_framework.py`.

> For specific usage, refer to the source code file `datakit/python.d/core/demo.py`

Here is an example Python script based on the above requirements, named `hellopythond.py`:

??? quote "hellopythond.py"

    ```python
    from datakit_framework import DataKitFramework
    import pymysql
    import re
    import logging

    class MysqlConn():
        def __init__(self, logger, config):
            self.logger = logger
            self.config = config
            self.re_errno = re.compile(r'^\((\d+),')

            try:
                self.conn = pymysql.Connect(**self.config)
                self.logger.info("pymysql.Connect() ok, {0}".format(id(self.conn)))
            except Exception as e:
                raise e

        def __del__(self):
            self.close()

        def close(self):
            if self.conn:
                self.logger.info("conn.close() {0}".format(id(self.conn)))
                self.conn.close()


        def execute_query(self, sql_str, sql_params=(), first=True):
            res_list = None
            cur = None
            try:
                cur = self.conn.cursor()
                cur.execute(sql_str, sql_params)
                res_list = cur.fetchall()
            except Exception as e:
                err = str(e)
                self.logger.error('execute_query: {0}'.format(err))
                if first:
                    retry = self._deal_with_network_exception(err)
                    if retry:
                        return self.execute_query(sql_str, sql_params, False)
            finally:
                if cur is not None:
                    cur.close()
            return res_list

        def execute_write(self, sql_str, sql_params=(), first=True):
            cur = None
            n = None
            err = None
            try:
                cur = self.conn.cursor()
                n = cur.execute(sql_str, sql_params)
            except Exception as e:
                err = str(e)
                self.logger.error('execute_query: {0}'.format(err))
                if first:
                    retry = self._deal_with_network_exception(err)
                    if retry:
                        return self.execute_write(sql_str, sql_params, False)
            finally:
                if cur is not None:
                    cur.close()
            return n, err

        def _deal_with_network_exception(self, stre):
            errno_str = self._get_errorno_str(stre)
            if errno_str != '2006' and errno_str != '2013' and errno_str != '0':
                return False
            try:
                self.conn.ping()
            except Exception as e:
                return False
            return True

        def _get_errorno_str(self, stre):
            searchObj = self.re_errno.search(stre)
            if searchObj:
                errno_str = searchObj.group(1)
            else:
                errno_str = '-1'
            return errno_str

        def _is_duplicated(self, stre):
            errno_str = self._get_errorno_str(stre)
            # 1062: Duplicate field value, insert failed
            # 1169: Duplicate field value, update failed
            if errno_str == "1062" or errno_str == "1169":
                return True
            return False

    class HelloPythond(DataKitFramework):
        __name = 'HelloPythond'
        interval = 10 # Collect and report every 10 seconds. Adjust according to actual business needs; this is just for demonstration.

        # If your datakit IP is 127.0.0.1 and port is 9529, you don't need to use this,
        # just comment it out.
        # def __init__(self, **kwargs):
        #     super().__init__(ip = '127.0.0.1', port = 9529)

        def run(self):
            config = {
                "host": "172.16.2.203",
                "port": 30080,
                "user": "root",
                "password": "Kx2ADer7",
                "db": "df_core",
                "autocommit": True,
                # "cursorclass": pymysql.cursors.DictCursor,
                "charset": "utf8mb4"
            }

            mysql_conn = MysqlConn(logging.getLogger(''), config)
            query_str = "select count(1) from customers where last_logined_time >= (unix_timestamp() - %s)"
            sql_params = ('3600')
            n = mysql_conn.execute_query(query_str, sql_params)

            data = [
            {
                "measurement": "hour_logined_customers_count", # Metric name.
                "tags": {
                    "tag_name": "tag_value", # Custom tag, fill in according to what you want to mark; this is just an example.
                },
                "fields": {
                    "count": n[0][0], # Metric, the number of users who logged in each hour.
                },
            },
            ]

            in_data = {
                'M':data,
                'input': "pyfromgit"
            }

            return self.report(in_data) # You must call self.report here
    ```

### 2 Place the Custom Script in the Correct Location

Create a new folder named `hellopythond` under the `python.d` directory in the Datakit installation directory. This folder name should match the class name defined above, i.e., `hellopythond`.

Then place the script `hellopythond.py` in this folder. The final directory structure should look like this:

```
├── ...
├── datakit
└── python.d
    ├── core
    │   ├── datakit_framework.py
    │   └── demo.py
    └── hellopythond
        └── hellopythond.py
```

> **Note:** The `core` folder is the core folder for Pythond, do not modify it.

The above structure applies when the `gitrepos` feature is not enabled. If `gitrepos` is enabled, the directory structure would be:

```
├── ...
├── datakit
├── python.d
├── gitrepos
│   └── yourproject
│       ├── conf.d
│       ├── pipeline
│       └── python.d
│           └── hellopythond
│               └── hellopythond.py
```

### 3 Enable Pythond Configuration File

Copy the Pythond configuration file.<br/>
In the `conf.d/pythond` directory, copy `pythond.conf.sample` to `pythond.conf`, and configure it as follows:

```toml
[[inputs.pythond]]

	# Name of the Python collector
	name = 'some-python-inputs'  # required

	# Environment variables needed to run the Python collector
	#envs = ['LD_LIBRARY_PATH=/path/to/lib:$LD_LIBRARY_PATH',]

	# Path to the Python executable (preferably use absolute path)
	cmd = "python3" # required. python3 is recommended.

	# Relative path to the user script directory (fill in the folder name; all modules and py files in the subdirectory will be applied)
	dirs = ["hellopythond"] # Fill in the folder name, i.e., the class name
```

### 4 Restart DataKit

```shell
sudo datakit --restart
```

## Effect Demonstration

If everything goes smoothly, within about 1 minute, we should see the metric chart on the central interface.

![14.pythond.png](../images/pythond-1.png)

## Reference Documents

<[Official Manual: Developing Custom Collectors with Python](../../integrations/ddtrace-python.md)>

<[Official Manual: Managing Configuration Files via Git](../../datakit/git-config-how-to.md)>