# ELB

---

## 视图预览

示例为 AWS Network ELB 指标展示、包括网络数据包、活跃连接、 TCP 连接等。

![image.png](../../imgs/aws-elb-1.png)

![image.png](../../imgs/aws-elb-2.png)

## 版本支持

操作系统支持：Linux / Windows

## 前置条件

- 服务器 <[安装 DataKit](../../../datakit/datakit-install.md)>
- 服务器 <[安装 DataFlux Func 携带版](../../../dataflux-func/quick-start.md)>
- AWS 访问管理进行授权

### 访问授权

1、 登录访问授权控制台 IAM [https://console.amazonaws.cn/iamv2](https://console.amazonaws.cn/iamv2)

2、 添加用户

![image.png](../../imgs/aws-elb-3.png)

3、 用户授权：「ReadOnlyAccess」

![image.png](../../imgs/aws-elb-4.png)

4、 保存或下载 **Access key ID** 和 **Secret access key** 的 CSV 文件（配置文件会用到）

![image.png](../../imgs/aws-elb-5.png)

## 安装配置

说明：

- 示例 Linux 版本为：CentOS Linux release 7.8.2003 (Core)
- 通过一台服务器采集所有 AWS ELB 数据

### 部署实施

#### 脚本市场

1、 登录 DataFlux Func，地址 `http://ip:8088`

![image.png](../../imgs/aws-elb-6.png)

2、 开启脚本市场：「管理」 - 「实验性功能」 - 「开启脚本市场模块」

![image.png](../../imgs/aws-elb-7.png)

3、 **依次添加**三个脚本集

（1）观测云集成 (核心包)<br />
（2）观测云集成 (AWS-CloudWatch)<br />
（3）观测云集成 (AWS-ELB)

> **注意：**在安装核心包后，系统会提示安装第三方依赖包，按照正常步骤点击安装即可。

![image.png](../../imgs/aws-elb-8.png)

![image.png](../../imgs/aws-elb-9.png)

![image.png](../../imgs/aws-elb-10.png)

4、 脚本安装完成后，可以在「脚本库」中看到所有脚本集

![image.png](../../imgs/aws-elb-11.png)

#### 添加脚本

1、 「开发」 - 「脚本库」 - 「添加脚本集」

![image.png](../../imgs/aws-elb-12.png)

2、 点击上一步添加的「脚本集」 - 「添加脚本」

![image.png](../../imgs/aws-elb-13.png)

3、 创建 ID 为 ELB 的脚本

![image.png](../../imgs/aws-elb-14.png)

4、 添加代码

- 需要修改账号配置 `AccessKey ID` 、 `Secret access key` 、 `Account Name` 、 `Regions`

- regions 取值可以参考 [**地域列表**](https://docs.aws.amazon.com/zh_cn/documentdb/latest/developerguide/regions-and-azs.html)，示例：cn-northwest-1
- namespace (可选 AWS/ApplicationELB、AWS/GatewayELB、AWS/NetworkELB)

```python
from guance_integration__runner import Runner
import guance_aws_elb__main as aws_elb
import guance_aws_cloudwatch__main as aws_cloudwatch

# 账号配置
account = {
    'ak_id'     : 'Access key  ID',
    'ak_secret' : 'Secret access key',
    'extra_tags': {
        'account_name': 'Account Name',
    }
}

@DFF.API('执行云资产同步', timeout=300)
def run():
    regions = ['Regions']

    # 采集器配置
    elb_configs = {
        'regions': regions,
    }
    cloudwatch_configs = {
        'regions': regions,
        'targets': [
            {
                'namespace': 'AWS/ApplicationELB',
                'metrics'  : 'ALL',
            },
        ],
    }
    collectors = [
        aws_elb.DataCollector(account, elb_configs),
        aws_cloudwatch.DataCollector(account, cloudwatch_configs),
    ]

    # 启动执行
    Runner(collectors).run()

```

5、 「保存」 配置并 「发布」

![image.png](../../imgs/aws-elb-15.png)

#### 定时任务

1、 添加自动触发任务，管理 - 自动触发配置 - 新建任务

![image.png](../../imgs/aws-elb-16.png)

2、 自动触发配置：在「执行函数」中添加此脚本，执行频率为 **5 分钟 _/5 _ \* \* \***

![image.png](../../imgs/aws-elb-17.png)

## 场景视图

<场景 - 新建仪表板 - 模板库 - 系统视图 - AWS Network ELB 监控视图>

<场景 - 新建仪表板 - 模板库 - 系统视图 - AWS Application ELB 监控视图>

## 指标详解

<[AWS Application ELB 指标列表](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-cloudwatch-metrics.html)>

## 常见问题排查

- 查看日志：DataFlux Func 日志路径 `/usr/local/dataflux-func/data/logs/dataflux-func.log`
- 代码调试：编辑模式选择主函数，直接运行 (可以看到脚本输出)

![image.png](../../imgs/aws-elb-18.png)

- 连接配置：DataFlux Func 无法连接 DataKit，请检查数据源配置 (DataKit 需要监听 0.0.0.0)

![image.png](../../imgs/aws-elb-19.png)

## 进一步阅读

<[DataFlux Func 观测云集成简介](../../../dataflux-func/script-market-guance-integration.md)>

<[DataFlux Func AWS-CloudWatch 配置手册](../../../dataflux-func/script-market-guance-aws-cloudwatch.md)>
