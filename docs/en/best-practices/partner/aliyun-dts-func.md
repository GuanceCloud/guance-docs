# Best Practices for Alibaba Cloud DTS Incremental Data Migration (Function)

---

## Prerequisites

### Install Datakit

1. Click the [**Integration**] module, [_Datakit_], and choose the appropriate installation command based on your operating system and system type.

![image.png](../images/aliyun-dts-func-1.png)

2. Copy the Datakit installation command and run it directly on the server that needs to be monitored.
- Installation directory: `/usr/local/datakit/`
- Log directory: `/var/log/datakit/`
- Main configuration file: `/usr/local/datakit/conf.d/datakit.conf`
- Plugin configuration directory: `/usr/local/datakit/conf.d/`

### Install Function

1. Click the [**Integration**] module, [_Funciton_], download the installation package, and execute the installation command.

![image.png](../images/aliyun-dts-func-2.png)

2. After installation is complete, use a browser to access `http://Server IP Address:8088` to perform initialization operations.

![image.png](../images/aliyun-dts-func-3.png)

3. Log in with the default username/password: admin

![image.png](../images/aliyun-dts-func-4.png)

### RAM Access Control

1. Log in to the RAM console [https://ram.console.aliyun.com/users](https://ram.console.aliyun.com/users)

2. Create a new user: User Management - Users - Create User

![image.png](../images/aliyun-dts-func-5.png)

3. Save or download the AccessKey ID and AccessKey Secret CSV file (this will be used in the configuration).

4. Authorize the user (read-only access to Data Transmission Service (DTS))

![image.png](../images/aliyun-dts-func-6.png)

## Script Development

### Alibaba Cloud DTS Incremental Data Migration

1. Visit [[Alibaba Cloud DTS Product Documentation - New API - Query DTS Task Details](https://help.aliyun.com/document_detail/209702.html?spm=a2c4g.11186623.6.1002.d97c6436S5LXrz)], enter debug mode.

2. Find SDK dependency information - New SDK, copy the SDK installation command.

![image.png](../images/aliyun-dts-func-7.png)

3. Management - Experimental Features - Enable PIP Tool Module

![image.png](../images/aliyun-dts-func-8.png)

4. Install Alibaba Cloud SDK dependencies

![image.png](../images/aliyun-dts-func-9.png)

5. Create a new script set, add script

![image.png](../images/aliyun-dts-func-10.png)

6. Write code, fill in AccessKey ID, AccessKey Secret, Region

Reference Documents:

- [Alibaba Cloud DTS Product Documentation - New API - Query DTS Task Details](https://help.aliyun.com/document_detail/209702.html?spm=a2c4g.11186623.6.1002.d97c6436S5LXrz)
- [Function DataKit Data Integration](/dataflux-func/development-guide/)

```python
# -*- coding: utf-8 -*-

import sys
import json
from typing import List

from alibabacloud_dts20200101.client import Client as Dts20200101Client
from alibabacloud_tea_openapi import models as open_api_models
from alibabacloud_dts20200101 import models as dts_20200101_models

# Alibaba Cloud SDK
class Sample:
    def __init__(self):
        pass

    @staticmethod
    def create_client(
        access_key_id: str,
        access_key_secret: str,
    ) -> Dts20200101Client:
        """
        Initialize account Client using AK&SK
        @param access_key_id:
        @param access_key_secret:
        @return: Client
        @throws Exception
        """
        config = open_api_models.Config(
            # Your AccessKey ID,
            access_key_id=access_key_id,
            # Your AccessKey Secret,
            access_key_secret=access_key_secret
        )
        # Domain to access
        config.endpoint = 'dts.cn-hangzhou.aliyuncs.com'
        return Dts20200101Client(config)

    @staticmethod
    def main(
        args: List[str],
    ) -> None:
        client = Sample.create_client('accessKeyId', 'accessKeySecret')
        describe_dts_jobs_request = dts_20200101_models.DescribeDtsJobsRequest(region='cn-hangzhou')
        client.describe_dts_jobs(describe_dts_jobs_request)

@DFF.API('dts_demo', timeout=300)
def dts_demo():
    # Instantiate sample
    sample = Sample()
    client = sample.create_client(
        access_key_id="AccessKey ID",
        access_key_secret="AccessKey Secret"
    )
    describe_dts_jobs_request = dts_20200101_models.DescribeDtsJobsRequest(
    # Type of DTS instance task. MIGRATION; SYNC; SUBSCRIBE.
            region='region', job_type='MIGRATION'
        )
    response = client.describe_dts_jobs(describe_dts_jobs_request).to_map()
    dtsjoblist = response['body']['DtsJobList'][0]
    dts_instanceid = dtsjoblist['DtsInstanceID']
    dts_jobname = dtsjoblist['DtsJobName']
    # Status metrics for incremental data migration or synchronization
    datasynchronization = response['body']['DtsJobList'][0]['DataSynchronizationStatus']
    dts_status = datasynchronization['Status']
    dts_percent = datasynchronization['Percent']

    # Line protocol data
    points = [
        {'measurement': 'aliyun_api_dts',
         'tags': {'instanceId': dts_instanceid, 'jobname': dts_jobname}, 
         'fields': {'dts_status': dts_status, 'dts_percent': dts_percent}
        }
    ]
    write_metrics(points)

def write_metrics(points: list):
    datakit = DFF.SRC('datakit')
    res = datakit.write_metric_many(points)
```

7. Add a decorator before the main function (export the function as an HTTP API interface)

```python
@DFF.API('name', timeout=300)
```

8. Publish the script

![image.png](../images/aliyun-dts-func-11.png)

9. Add a scheduled task (data collection frequency), Management - Automatic Trigger Configuration - Select scheduled time

![image.png](../images/aliyun-dts-func-12.png)

10. After adding, you can view all scheduled tasks

![image.png](../images/aliyun-dts-func-13.png)

11. View Metrics - DataFlux - [_Metrics_]

![image.png](../images/aliyun-dts-func-14.png)

12. Add _[Incident Library]_ - DTS Migration Incident Rules

![image.png](../images/aliyun-dts-func-15.png)

13. Trigger an incident event when Alibaba Cloud DTS incremental data migration fails

![image.png](../images/aliyun-dts-func-16.png)