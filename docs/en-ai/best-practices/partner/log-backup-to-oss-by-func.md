# Best Practices for Backing Up Log Data to OSS (Function)

---

## Prerequisites

### Install Datakit

1. Click the [**Integration**] module, [_Datakit_], and select the appropriate installation command based on your operating system and system type.

![image.png](../images/log-backup-to-oss-by-func-1.png)

2. Copy the Datakit installation command and run it directly on the server that needs to be monitored.

- Installation directory: `/usr/local/datakit/`
- Log directory: `/var/log/datakit/`
- Main configuration file: `/usr/local/datakit/conf.d/datakit.conf`
- Plugin configuration directory: `/usr/local/datakit/conf.d/`

### Install Function

1. Click the [**Integration**] module, [_Function_], download the installation package, and execute the installation command.

![image.png](../images/log-backup-to-oss-by-func-2.png)

2. After installation, use a browser to access `http://server IP address:8088` to initialize the operation interface.

![image.png](../images/log-backup-to-oss-by-func-3.png)

3. Log in to the system using the default username/password: admin

![image.png](../images/log-backup-to-oss-by-func-4.png)

### RAM Access Control

1. Log in to the RAM console [https://ram.console.aliyun.com/users](https://ram.console.aliyun.com/users)

2. Create a new user: User Management - Users - Create User

![image.png](../images/log-backup-to-oss-by-func-5.png)

3. Save or download the CSV file containing the AccessKey ID and AccessKey Secret (required for configuration).

4. Authorize the user (grant Object Storage Service (OSS) permissions)

![image.png](../images/log-backup-to-oss-by-func-6.png)

## Script Development

### Log Backup to OSS

1. Management - Experimental Features - Enable PIP Tool Module

![image.png](../images/log-backup-to-oss-by-func-7.png)

2. Install the Alibaba Cloud SDK dependency package (oss2)

![image.png](../images/log-backup-to-oss-by-func-8.png)

3. Create a new script set and add a script

![image.png](../images/log-backup-to-oss-by-func-9.png)

4. Write the code, filling in the AccessKey ID, AccessKey Secret, Bucket Name, and Filename.

Refer to the documentation:

- <[Simple Upload to OSS](https://help.aliyun.com/document_detail/88426.html)>
- <[Function Development Guide - DataKit.Query](https://function.dataflux.cn/#/read?q=development-guide.md)>

```python
import time
import json
import oss2

@DFF.API('Run DQL via DataKit')
def run_dql_via_datakit():
    datakit = DFF.SRC('datakit')
    # Use the time_range parameter to limit data to the last 10 minutes
    time_range = [
        int(time.time() - 600) * 1000,
        int(time.time()) * 1000,
    ]
    # DQL query statement
    status_code, result = datakit.query(dql='L::`apache`', time_range=time_range, raw=True)
    result = json.dumps(result, indent=2)
    # Configure OSS information
    auth = oss2.Auth('AccessKey ID', 'AccessKey Secret')
    bucket = oss2.Bucket(auth, 'https://oss-cn-hangzhou.aliyuncs.com', 'Bucket Name')
    file = bucket.put_object('Filename.txt', result)
```

5. Log in to the OSS console to view the file

![image.png](../images/log-backup-to-oss-by-func-10.png)