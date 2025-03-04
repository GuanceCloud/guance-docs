# <<< custom_key.brand_name >>>采集 Amazon ECS 日志

---

## 简介

Amazon Elastic Container Service (Amazon ECS) 是一项高度可扩展的快速容器管理服务，可以使用它轻松运行、停止和管理群集上的容器。这些容器可以运行在自己的 EC2 服务器上，也可以运行在由 AWS Fargate 托管的无服务器基础设施。<br/>
针对任务使用 Fargate 的启动类型，需要启动容器的 [awslogs 日志驱动程序](https://docs.aws.amazon.com/zh_cn/AmazonECS/latest/developerguide/using_awslogs.html)，运行在容器中的应用以 STDOUT 和 STDERR I/O 流的方式输出的日志，会被发送到 CloudWatch Logs 的日志组中，再通过 Func 采集这些日志，Func 再把日志通过 EC2 上部署的 DataKit 写入<<< custom_key.brand_name >>>中。

本文的日志采集就是针对 AWS Fargate 托管的容器。

![image](../images/ecs/ecs-log-1.png)

## 前置条件

- 需要先创建一个[<<< custom_key.brand_name >>>账号](https://www.guance.com/)
- [安装 DataKit](../../datakit/datakit-install.md)
- [安装 Func 携带版](https://func.guance.com/doc/maintenance-guide-installation/)
- 已经拥有运行在 ECS 的 Java 应用

这里使用到的 ECS 集群名称是 cluster-docker，下面查看示例的日志及日志组。登录「[AWS](https://www.amazonaws.cn/)」，进入「Elastic Container Service」 - 点击「集群」 - 「cluster-docker」。

![image](../images/ecs/ecs-log-2.png)

点击「服务名称」

![image](../images/ecs/ecs-log-3.png)

进入任务

![image](../images/ecs/ecs-log-4.png)

在详细信息标签的容器下面找到日志配置。

![image](../images/ecs/ecs-log-5.png)

点击「日志标签」，里面是应用的日志，接下来采集这些日志。

![image](../images/ecs/ecs-log-6.png)

## 操作步骤

???+ warning

    示例所使用的版本为 DataKit 1.4.18

### 步骤 1 AWS 配置

#### 1.1 用户密钥 {#1.1}

使用部署 ECS 用到的账号，AWS 创建该用户时提供的 `Access key ID` 和 `Secret access key` 后面会使用到。

#### 1.2 设置 AWS 用户权限

登录 AWS 的 IAM 控制台，在用户下面找到 ECS 所在的「用户」- 点击「添加权限」。

![image](../images/ecs/ecs-log-7.png)

点击「直接附加现有策略」，「筛选策略」选中 `CloudWatchLogsReadOnlyAccess`、`CloudWatchEventsReadOnlyAccess`，然后点击「下一步：审核」。

![image](../images/ecs/ecs-log-8.png)

### 步骤 2 Func 配置

#### 2.1 配置环境变量 {#2.1}

登录「Func」 - 「开发」 - 「环境变量」 - 「添加环境变量」。这里添加 3 个环境变量：

- `AWS_LOG_KEY` 值对应[步骤 1.1](#1.1) 中 AWS 用户的 `Access key ID`
- `AWS_LOG_SECRET_ACCESS_KEY` 值对应[步骤 1.1](#1.1)中 AWS 用户的 `Secret access key`
- `AWS_REGION_NAME` 值对应 AWS 用户所在的 `REGION`。

![image](../images/ecs/ecs-log-9.png)

#### 2.2 配置连接器

登录「Func」 - 「开发」 - 「连接器」 - 「添加连接器」。<br/>
这里 ID 必须填 DataKit，主机对应已安装 DataKit 的地址，端口是 DataKit 的端口。(本示例直接用 IP，所以协议填 HTTP)<br/>
点击「测试连通性」，有:white_check_mark:返回，说明 DataKit 可用。

![image](../images/ecs/ecs-log-10.png)

#### 2.3 PIP 工具配置

登录「Func」 - 「管理」 - 「实验性功能」，右侧选中「开启 PIP 工具模块」。

![image](../images/ecs/ecs-log-11.png)

点击左侧的「PIP 工具」 - 选择「阿里云镜像」 - 输入 `boto3` - 点击「安装」。

![image](../images/ecs/ecs-log-12.png)

#### 2.4 脚本库

登录「Func」 - 「开发」 - 「脚本库」 - 「添加脚本集」，ID 可以自定义，点击「保存」。

![image](../images/ecs/ecs-log-13.png)

找到「AWS 日志采集」 - 点击「添加脚本」。

![image](../images/ecs/ecs-log-14.png)

输入 ID ，示例这里定义为 `aws_ecs__log`，点击「保存」。

![image](../images/ecs/ecs-log-15.png)

点击「编辑」。

![image](../images/ecs/ecs-log-16.png)

输入如下内容：

??? quote "输入内容"

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

    - 上述内容第4行的 `ecs_log` ，需要确保同一个 Func 中唯一，可以改成其它字母。<br/>
    - 第6行的 `awc_ecs` 即是刚才添加的脚本集 ID<br/>
    - 第 40、41、42 行中的 `AWS_LOG_KEY`、`AWS_LOG_SECRET_ACCESS_KEY`、`AWS_REGION_NAME` 对应[步骤 2.1](#2.1) 中的环境变量名，如果环境变量名变了，需要做对应修改。

#### 2.5 测试脚本

如下图选择「run」，第二个红框所示内容中：

- `measurement` 的值输入 `ecs_log_source`，这个值对应<<< custom_key.brand_name >>>日志中的日志来源；
- `logGroupName` 的值对应**前置条件**的日志配置中查到的 `awslogs-group`;
- `interval` 的值对应采集频率，示例这里是 60 秒。

![image](../images/ecs/ecs-log-17.png)

点击「执行」，输出`total 8`，即上报八条日志。

![image](../images/ecs/ecs-log-18.png)

登录「[<<< custom_key.brand_name >>>](https://console.guance.com/)」，进入「日志」模块，数据源选择「ecs_log_source」，即可看到日志。

![image](../images/ecs/ecs-log-19.png)

点击右上角的「发布」

![image](../images/ecs/ecs-log-20.png)

点击右上角「结束编辑」

![image](../images/ecs/ecs-log-21.png)

#### 2.6 自动采集日志

登录「Func」 - 「管理」 - 「自动触发配置」 - 「新建」，参数输入刚才执行的内容。

```json
{
  "measurement": "ecs_log_source",
  "logGroupName": "/ecs/demo-task",
  "interval": 60
}
```

![image](../images/ecs/ecs-log-22.png)

时间选择每分钟或者每 5 分钟，点击「保存」

![image](../images/ecs/ecs-log-23.png)

在「自动触发配置」列表中存在「aws_ecs log」的记录

![image](../images/ecs/ecs-log-24.png)

点击「近期执行」查看执行情况

![image](../images/ecs/ecs-log-25.png)
