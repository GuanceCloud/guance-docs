# <<< custom_key.brand_name >>> Collection of Amazon ECS Logs

---

## Introduction

Amazon Elastic Container Service (Amazon ECS) is a highly scalable and fast container management service that can easily run, stop, and manage containers on clusters. These containers can run on their own EC2 servers or on serverless infrastructure managed by AWS Fargate.<br/>
For tasks using the Fargate launch type, it is necessary to start the [awslogs log driver](https://docs.aws.amazon.com/zh_cn/AmazonECS/latest/developerguide/using_awslogs.html). The logs output by applications running in the container via STDOUT and STDERR I/O streams will be sent to the log group in CloudWatch Logs, then these logs are collected through Func. Func then writes the logs into <<< custom_key.brand_name >>> via DataKit deployed on EC2.

This article focuses on collecting logs from containers managed by AWS Fargate.

![image](../images/ecs/ecs-log-1.png)

## Prerequisites

- First, create a [<<< custom_key.brand_name >>> account](https://<<< custom_key.brand_main_domain >>>/)
- [Install DataKit](../../datakit/datakit-install.md)
- [Install Func portable version](https://<<< custom_key.func_domain >>>/doc/maintenance-guide-installation/)
- Already have a Java application running on ECS

The ECS cluster name used here is cluster-docker. Below, we check the example logs and log groups. Log in to «[AWS](https://www.amazonaws.cn/)», enter «Elastic Container Service» - click «Clusters» - «cluster-docker».

![image](../images/ecs/ecs-log-2.png)

Click «Service Name»

![image](../images/ecs/ecs-log-3.png)

Enter the task

![image](../images/ecs/ecs-log-4.png)

Find the log configuration under the Containers section in the Details tab.

![image](../images/ecs/ecs-log-5.png)

Click «Log Tags». Inside are the application logs; next, we collect these logs.

![image](../images/ecs/ecs-log-6.png)

## Procedures

???+ warning

    The version used in the example is DataKit 1.4.18

### Step 1 AWS Configuration

#### 1.1 User Key {#1.1}

Use the account deploying ECS, provided during AWS user creation `Access key ID` and `Secret access key` will be used later.

#### 1.2 Set AWS User Permissions

Log in to the AWS IAM console, find the ECS «User» under Users - click «Add Permissions».

![image](../images/ecs/ecs-log-7.png)

Click «Directly Attach Existing Policies», select `CloudWatchLogsReadOnlyAccess`, `CloudWatchEventsReadOnlyAccess`, then click «Next: Review».

![image](../images/ecs/ecs-log-8.png)

### Step 2 Func Configuration

#### 2.1 Configure Environment Variables {#2.1}

Log in to «Func» - «Development» - «Environment Variables» - «Add Environment Variable». Add three environment variables here:

- `AWS_LOG_KEY` corresponds to [Step 1.1](#1.1) AWS user's `Access key ID`
- `AWS_LOG_SECRET_ACCESS_KEY` corresponds to [Step 1.1](#1.1) AWS user's `Secret access key`
- `AWS_REGION_NAME` corresponds to the `REGION` where the AWS user is located.

![image](../images/ecs/ecs-log-9.png)

#### 2.2 Configure Connector

Log in to «Func» - «Development» - «Connectors» - «Add Connector». <br/>
Here, the ID must be DataKit, the host corresponds to the address where DataKit is installed, and the port is DataKit's port. (In this example, IP is directly used, so the protocol is HTTP)<br/>
Click «Test Connectivity», if :white_check_mark: returns, it indicates DataKit is available.

![image](../images/ecs/ecs-log-10.png)

#### 2.3 PIP Tool Configuration

Log in to «Func» - «Management» - «Experimental Features», select «Enable PIP Tool Module» on the right side.

![image](../images/ecs/ecs-log-11.png)

Click «PIP Tool» on the left - choose «Alibaba Cloud Mirror» - input `boto3` - click «Install».

![image](../images/ecs/ecs-log-12.png)

#### 2.4 Script Library

Log in to «Func» - «Development» - «Script Library» - «Add Script Set», the ID can be customized, click «Save».

![image](../images/ecs/ecs-log-13.png)

Find «AWS Log Collection» - click «Add Script».

![image](../images/ecs/ecs-log-14.png)

Input ID, for this example define as `aws_ecs__log`, click «Save».

![image](../images/ecs/ecs-log-15.png)

Click «Edit».

![image](../images/ecs/ecs-log-16.png)

Input the following content:

??? quote "Input Content"

    ```python
        import boto3
        import json
        import time
        scope_id='ecs_log'

        @DFF.API('aws_ecs log', timeout=500, api_timeout=180)
        def run(measurement, logGroupName, interval):
            print(measurement, logGroupName, interval)
            get_log_data(measurement, logGroupName, interval)
            # if data is not None:
            #     push_log(data)
            # else:
            #     print("None")


        def get_cron_time(interval, measurement):
            cache = DFF.CACHE.get('last_time_%s' %measurement,scope=scope_id)
            if cache == None:
                currentTime = int(round(time.time() * 1000))
                startTime = currentTime - int(interval) * 1000
                endTime = currentTime
            else:
                currentTime = int(round(time.time() * 1000))
                if currentTime - int(cache) > 10 * 60 * 1000:
                    startTime = currentTime - int(interval) * 1000
                    endTime = currentTime
                else:
                    startTime = int(cache) + 1
                    endTime = currentTime
            print(startTime, endTime)
            return  startTime, endTime

        def get_log_data(measurement, logGroupName, interval):
            logTime = get_cron_time(interval, measurement)
            startTime = logTime[0]
            endTime = logTime[1]
            isPush = False
            client = boto3.client(
                'logs',
                aws_access_key_id=DFF.ENV('AWS_LOG_KEY'),
                aws_secret_access_key=DFF.ENV('AWS_LOG_SECRET_ACCESS_KEY'),
                region_name=DFF.ENV('AWS_REGION_NAME')
            )# print(client.meta.config)
            try:
                nextToken = 'frist'
                logData = []
                while nextToken != '':
                    if nextToken == 'frist':
                        nextToken = ''
                        response = client.filter_log_events(
                            logGroupName=logGroupName,
                            startTime=startTime,
                            endTime=endTime,
                            limit=1000,
                            #filterPattern="?ERROR ?WARN ?error ?warn",
                            interleaved=False
                        )
                    else:
                        response = client.filter_log_events(
                            logGroupName=logGroupName,
                            startTime=startTime,
                            endTime=endTime,
                            nextToken=nextToken,
                            limit=1000,
                            #filterPattern="?ERROR ?WARN ?error ?warn",
                            interleaved=False
                        )
                    try:
                        if len(response['events']) > 0:
                            data = []
                            lastTimeList = []
                            for i in response['events']:
                                # print("hii", i['logStreamName'])
                                log = {
                                    'measurement': measurement,
                                    'tags': {
                                        'logGroupName': logGroupName,
                                        'logStreamName': i['logStreamName'],
                                        'host': '127.0.0.1'
                                    },
                                    'fields': {
                                        'message': i['message'],
                                        'time': i['timestamp']
                                    }
                                }
                                data.append(log)
                                lastTimeList.append(i['timestamp'])
                            push_log(data)
                            print("max %s"  % max(lastTimeList))
                            DFF.CACHE.set('last_time_%s' % measurement, max(lastTimeList), scope=scope_id, expire=None)
                            isPush = True
                        else:
                            DFF.CACHE.set('last_time_%s' % measurement, endTime , scope=scope_id, expire=None)
                        nextToken = response['nextToken']
                    except:
                        nextToken = ''
            except Exception as  e:
                print('Error: %s' % e )
                return None
            if not isPush:
                DFF.CACHE.set('last_time_%s' % measurement, endTime , scope=scope_id, expire=None)

        def push_log(data):
            datakit = DFF.SRC('datakit')
            status_code, result = datakit.write_logging_many(data=data)
            if status_code == 200:
                print("total %d"  % len(data))
                print(status_code, result)
    ```

???+ warning

    - Ensure the `ecs_log` on line 4 of the above content is unique within the same Func; it can be changed to other letters.<br/>
    - Line 6's `awc_ecs` is the script set ID added earlier.<br/>
    - Lines 40, 41, and 42's `AWS_LOG_KEY`, `AWS_LOG_SECRET_ACCESS_KEY`, and `AWS_REGION_NAME` correspond to the environment variable names in [Step 2.1](#2.1). If the environment variable names change, corresponding modifications are required.

#### 2.5 Test Script

As shown below, select «run». In the second red box:

- Input `ecs_log_source` for `measurement`; this value corresponds to the log source in <<< custom_key.brand_name >>> logs;
- Input the value for `logGroupName` corresponding to the `awslogs-group` found in the «Prerequisites» log configuration;
- Input the value for `interval` corresponding to the collection frequency; in this example, it is 60 seconds.

![image](../images/ecs/ecs-log-17.png)

Click «Execute», the output `total 8` indicates eight logs reported.

![image](../images/ecs/ecs-log-18.png)

Log in to «[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)», enter the «Logs» module, select «ecs_log_source» as the data source, and you can see the logs.

![image](../images/ecs/ecs-log-19.png)

Click the «Publish» button at the top right corner

![image](../images/ecs/ecs-log-20.png)

Click «End Editing» at the top right corner

![image](../images/ecs/ecs-log-21.png)

#### 2.6 Automatically Collect Logs

Log in to «Func» - «Management» - «Automatic Trigger Configuration» - «Create», input the parameters executed earlier.

```json
{
  "measurement": "ecs_log_source",
  "logGroupName": "/ecs/demo-task",
  "interval": 60
}
```

![image](../images/ecs/ecs-log-22.png)

Choose every minute or every 5 minutes, click «Save»

![image](../images/ecs/ecs-log-23.png)

In the «Automatic Trigger Configuration» list, there is a record for «aws_ecs log»

![image](../images/ecs/ecs-log-24.png)

Click «Recent Execution» to view execution details

![image](../images/ecs/ecs-log-25.png)