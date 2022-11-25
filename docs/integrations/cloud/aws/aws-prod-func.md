# AWS 产品集成简介

---

## 基本概述

AWS 产品众多，通常使用 CloudWatch 对 AWS 资源和互联网应用进行监控，但是 CloudWatch 的指标数据有限，更多内容需要通过编写代码的方式才能够获取。<br/>
观测云使用 DataFlux Func 脚本市场可以，非常快速地接入更为丰富的 AWS 数据指标 (**CloudWatch API & AWS 产品 API**)，为系统稳定、定位问题提供更强大的技术支撑。

本篇是**观测云**对接 AWS 产品的通用集成文档，不同产品会有所区别，具体产品的详细指引可参考对应的<[AWS 集成文档](./index.md)>。

## 前置条件

### 1 服务器[安装 DataKit](../../../datakit/datakit-install.md)

登录观测云，点击「集成」 - 「DataKit」，复制安装命令至服务器运行即可

> **注意：**其中 `token` 是该工作空间的唯一标识

![imgs](../../imgs/aws-prod-func-1.png)

### 2 服务器[安装 Func 携带版](../../../dataflux-func/quick-start.md)

登录观测云，点击「集成」 - 「Func」，下载脚本并执行安装命令即可

![imgs](../../imgs/aws-prod-func-2.png)

### 3 AWS 访问管理进行授权

1、 登录访问授权控制台 IAM [https://console.amazonaws.cn/iamv2 ](https://console.amazonaws.cn/iamv2)

2、 添加用户

![imgs](../../imgs/aws-prod-func-3.png)

3、 用户授权 (ReadOnlyAccess)

![imgs](../../imgs/aws-prod-func-4.png)

4、 保存或下载 **Access key ID** 和 **AccessKey Secret** 的 CSV 文件 (配置文件会用到)

![imgs](../../imgs/aws-prod-func-5.png)

## 安装配置

### 1 脚本市场

1、 登录 DataFlux Func，地址 `http://ip:8088`

> 默认账号/密码：admin/admin（请自行修改）

![imgs](../../imgs/aws-prod-func-6.png)

2、 开启脚本市场：「管理」 - 「实验性功能」 - 「开启脚本市场模块」

![imgs](../../imgs/aws-prod-func-7.png)

3、 **依次添加**脚本集<br/>
（1）观测云集成（核心包）<br/>
（2）观测云集成（AWS-CloudWatch 采集）<br/>
（3）观测云集成（AWS-产品 xxx）

> **注意：**在安装「核心包」后，系统会提示安装第三方依赖包 pip，按照正常步骤点击安装即可

![imgs](../../imgs/aws-prod-func-8.png)
![imgs](../../imgs/aws-prod-func-9.png)

4、 脚本安装完成后，可以在「脚本库」中看到所有脚本集

![imgs](../../imgs/aws-prod-func-10.png)

### 2 添加脚本

1、 「开发」 - 「脚本库」 - 「添加脚本集」

![imgs](../../imgs/aws-prod-func-11.png)

2、 点击上一步添加的「脚本集」 - 「添加脚本」

![imgs](../../imgs/aws-prod-func-12.png)

3、 创建 ID 为 main 的脚本

![imgs](../../imgs/aws-prod-func-13.png)

4、 添加数据采集代码

主要参数说明：

- import guance_aliyun_xxx：引入脚本市场里的脚本集
- ak_id：访问管理里的 Access key ID
- ak_secret：访问管理里的 AccessKey Secret
- account_name：自定义的账号名称 (最终会作为指标标签 tag，用于筛选)
- regions：AWS 产品对应的 [地域](https://docs.aws.amazon.com/zh_cn/documentdb/latest/developerguide/regions-and-azs.html) (可以填写多个地域)
- namespace：CloudWatch 官方定义，用于区分产品
- metrics：CloudWatch 指标 (可以填写 ALL，或者自定义指标)
- collectors：对象采集器 (AWS 产品 API 获取)

> **注意：**CloudWatch 采集器必须写在末尾 (aws_cloudwatch.DataCollector)

```python
from guance_integration__runner import Runner                      # 引入启动器
import guance_aws_ec2__main as aws_ec2                             # 引入 aws ec2 采集器
import guance_aws_rds__main as aws_rds                             # 引入 aws rds 采集器
import guance_aws_s3__main as aws_s3                               # 引入 aws s3 采集器
import guance_aws_elb__main as aws_elb                             # 引入 aws elb 采集器
import guance_aws_cloudwatch__main as aws_cloudwatch               # 引入 cloudwatch 采集器

# 账号配置
account = {
    'ak_id'     : 'AccessKey ID',
    'ak_secret' : 'AccessKey Secret',
    'extra_tags': {
        'account_name': 'Account Name',
    }
}

# 由于采集数据较多，此处需要为函数指定更大的超时时间（单位秒）
@DFF.API('执行云资产同步', timeout=300)
def run():
    regions = ['Regions']

    # 采集器配置
    common_cloudwatch_configs = {
        'regions': regions,
    }

    monitor_collector_configs = {
        'regions': regions,
        'targets': [
            {
                'namespace': 'AWS/EC2',
                'metrics'  : 'ALL',
            },
            {
                'namespace': 'AWS/RDS',
                'metrics'  : 'ALL',
            },
            {
                'namespace': 'AWS/NetworkELB',
                'metrics'  : 'ALL',
            },
            {
                'namespace': 'AWS/ApplicationELB',
                'metrics'  : 'ALL',
            },
            {
                'namespace': 'AWS/S3',
                'metrics'  : 'ALL',
            },
        ],
    }

    # 创建采集器
    collectors = [
        aws_ec2.DataCollector(account, common_cloudwatch_configs),
        aws_rds.DataCollector(account, common_cloudwatch_configs),
        aws_s3.DataCollector(account, common_cloudwatch_configs),
        aws_elb.DataCollector(account, common_cloudwatch_configs),
        aws_cloudwatch.DataCollector(account, monitor_collector_configs),
    ]

    # 启动执行
    Runner(collectors).run()
```

5、 「保存」 配置并 「发布」，发布后才能添加定时任务

![imgs](../../imgs/aws-prod-func-14.png)

### 3 定时任务

1、 添加自动触发任务：「管理」 - 「自动触发配置」 - 「新建任务」

![imgs](../../imgs/aws-prod-func-15.png)

2、 自动触发配置：在「执行函数」中添加此脚本，执行频率默认为 **五分钟 _/5 _ \* \* \***

![imgs](../../imgs/aws-prod-func-16.png)

## 场景视图

<场景 - 新建仪表板 - 模板库 - 系统视图 - AWS xxx 监控视图>，可添加对应场景视图模板

- 示例为 AWS RDS MySQL

![imgs](../../imgs/aws-prod-func-17.png)
![imgs](../../imgs/aws-prod-func-18.png)
![imgs](../../imgs/aws-prod-func-19.png)

## 进一步阅读

- <[CloudWatch 指标概览](https://docs.aws.amazon.com/zh_cn/AmazonCloudWatch/latest/monitoring/aws-services-cloudwatch-metrics.html)>

- <[DataFlux Func 观测云集成简介](../../../dataflux-func/script-market-guance-integration.md)>

- <[DataFlux Func CloudWatch 配置手册](../../../dataflux-func/script-market-guance-aws-cloudwatch.md)>
