# 华为云产品集成简介

---

## 基本概述

华为云产品众多，通常使用华为云-云监控对华为云资源和互联网应用进行监控，但是云监控的指标数据有限，更多内容需要通过编写代码的方式才能够获取。<br/>
观测云使用 DataFlux Func 脚本市场，可以非常快速地接入更为丰富的华为云数据指标 (**华为云-云监控 API & 华为云产品 API**)，为系统稳定、定位问题提供技术支撑。

本篇是**观测云对接华为云产品**的通用集成文档，不同产品会有所区别，具体产品的详细指引在左侧目录中查询。


## 前置条件

### 1 服务器[安装 DataKit](../../../datakit/datakit-install.md)

登录观测云，点击「集成」 - 「DataKit」，复制安装命令至服务器运行即可

> **注意：**其中 `token` 是该工作空间的唯一标识

![imgs](../../imgs/aliyun-prod-func-1.png)

### 2 服务器[安装 Func 携带版](https://func.guance.com/doc/maintenance-guide-installation/)

登录观测云，点击「集成」 - 「Func」，下载脚本并执行安装命令即可

![imgs](../../imgs/aliyun-prod-func-2.png)

### 3 华为云访问管理进行授权

1、 登录访问授权控制台 IAM [https://console.huaweicloud.com/iam](https://console.cloud.tencent.com/cam)

2、 创建用户

![image.png](../imgs/huawei-ecs-3.png)

3、 创建访问秘钥

![image.png](../imgs/huawei-ecs-4.png)

4、 保存或下载 **访问秘钥 ID** 和 **密码** (配置文件会用到）



## 安装配置

???+ attention

    本篇示例文章使用的是 DataFlux Func `1.x` 版本。<br/>
    若实际使用的是 DataFlux Func `2.x` 版本，部分功能按钮可能会与本文示例有所差异，请以实际使用情况为准。
    
### 1 脚本市场

1、 登录 DataFlux Func，地址 `http://ip:8088` (默认密码 admin/admin，请自行修改)

![imgs](../../imgs/aliyun-prod-func-5.png)  

2、 开启脚本市场：「管理」- 「实验性功能」 - 「开启脚本市场模块」

![imgs](../../imgs/aliyun-prod-func-6.png)

3、 依次添加脚本集<br/>
(1)观测云集成（核心包）<br/>
(2)观测云集成（华为云-云监控）<br/>
(3)观测云集成（华为云-产品 xxx）

> **注意：**在安装「核心包」后，系统会提示安装第三方依赖包 pip，按照正常步骤点击安装即可

![imgs](../imgs/huawei-ecs-7.png)

4、 脚本安装完成后，可以在「脚本库」中看到所有脚本集

![imgs](../imgs/huawei-ecs-10.png)

### 2 添加脚本

1、 「开发」 - 「脚本库」 - 「添加脚本集」

![imgs](../imgs/huawei-ecs-11.png)

2、 点击上一步添加的「脚本集」 - 「添加脚本」

![imgs](../imgs/huawei-ecs-12.png)

3、 创建 ID 为 main 的脚本

![imgs](../../imgs/huawei-prod-func-1.png)

4、 添加代码

- 需要修改账号配置 `AccessKey ID` 、 `Secret access key` 、 `Account Name` 、`Region` 、`Region_Projects`
- AccessKey ID：访问秘钥 ID
- Secret access key：访问秘钥密码
- Account Name：账号名称 (支持自定义)
- Region：地域 (项目)
- Region_Projects：[**如何获取项目 ID**](https://support.huaweicloud.com/api-ces/ces_03_0057.html)

> **注意：**华为云-云监控采集器必须写在末尾 (huawei_ces.DataCollector)

```python
from guance_integration__runner import Runner
import guance_huaweicloud_ecs__main as huawei_ecs
import guance_huaweicloud_elb__main as huawei_elb
import guance_huaweicloud_dcs__main as huawei_dcs
import guance_huaweicloud_ces__main as huawei_ces

account = {
    'ak_id'  :  'AccessKey ID',
    'ak_secret' : 'Secret access key',

    'extra_tags': {
        'account_name': 'Account Name',
    }
}

@DFF.API('执行云资产同步', timeout=300)
def run():
    region_projects = {
        'Region':['Region_Projects']
        # 示例：'cn-north-4':['c698f042454d4ecda45f253c62d82512']
    }

    # 采集器配置
    common_huaweiyun_configs = {
        'region_projects': region_projects,
    }
    monitor_collector_configs = {
        'region_projects': region_projects,
        'targets': [
            {
                'namespace': 'SYS.ECS',
                'metrics'  : 'ALL',
            },
            {
                'namespace': 'AGT.ECS',
                'metrics'  : 'ALL',
            },
            {
                'namespace': 'SYS.ELB',
                'metrics'  : 'ALL',
            },
            {
                'namespace': 'SYS.DCS',
                'metrics'  : 'ALL',
            },
        ],
    }
    collectors = [
        huawei_elb.DataCollector(account, common_huaweiyun_configs),
        huawei_ecs.DataCollector(account, common_huaweiyun_configs),
        huawei_dcs.DataCollector(account, common_huaweiyun_configs),
        huawei_ces.DataCollector(account, monitor_collector_configs),
    ]

    Runner(collectors).run()
```

5、 「保存」 配置并 「发布」，发布后才能添加定时任务

![imgs](../imgs/huawei-ecs-14.png)

### 3 定时任务

1、 添加自动触发任务：「管理」 - 「自动触发配置」 - 「新建任务」

![imgs](../imgs/huawei-ecs-15.png)

2、 自动触发配置：在「执行函数」中添加此脚本，执行频率默认为 **五分钟 _/5 _ \* \* \***

![imgs](../../imgs/huawei-prod-func-2.png)


## 场景视图

<场景 - 新建仪表板 - 模板库 - 系统视图 - 华为云产品 xxx 监控视图>，可添加对应场景视图模板

- 示例为 华为云 DCS

![image.png](../imgs/huawei-dcs-1.png)

![image.png](../imgs/huawei-dcs-2.png)

![image.png](../imgs/huawei-dcs-3.png)

![image.png](../imgs/huawei-dcs-4.png)

![image.png](../imgs/huawei-dcs-5.png)


## 进一步阅读

- <[华为云-云监控指标概览](https://support.huaweicloud.com/usermanual-ces/zh-cn_topic_0202622212.html)>

- <[DataFlux Func 观测云集成简介](https://func.guance.com/doc/script-market-guance-integration/)>

- <[DataFlux Func 华为云 CES 配置手册](https://func.guance.com/doc/script-market-guance-huaweicloud-ces/)>

