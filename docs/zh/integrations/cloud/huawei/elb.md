# ELB

---

## 视图预览

示例为华为云 ELB 指标展示，包括连接数，网络数据包，异常主机数，带宽等。

![image.png](../imgs/huawei-elb-1.png)

![image.png](../imgs/huawei-elb-2.png)

## 版本支持

操作系统支持：Linux / Windows

## 前置条件

- 服务器 <[安装 DataKit](../../../datakit/datakit-install.md)>
- 服务器 <[安装 DataFlux Func 携带版](https://func.guance.com/doc/maintenance-guide-installation/)>
- 华为云访问管理进行授权

### 访问授权

1、 登录访问授权控制台 IAM [https://console.huaweicloud.com/iam](https://console.huaweicloud.com/iam/)

2、 创建用户

![image.png](../imgs/huawei-ecs-3.png)

3、 创建访问秘钥

![image.png](../imgs/huawei-ecs-4.png)

4、 保存或下载 **访问秘钥 ID** 和 **密码** (配置文件会用到）

## 安装配置

说明：

- 示例 Linux 版本为：CentOS Linux release 7.8.2003 (Core)
- 通过一台服务器采集所有华为云 ELB 数据
- DataFlux Func `1.x` 版本
### 1 脚本市场

1、 登录 DataFlux Func，地址 `http://ip:8088`

![image.png](../imgs/huawei-ecs-5.png)

2、 开启脚本市场：「管理」 - 「实验性功能」 - 「开启脚本市场模块」

![image.png](../imgs/huawei-ecs-6.png)

3、 **依次添加**三个脚本集

（1）观测云集成 (核心包)<br />
（2）观测云集成 (华为云-云监控)<br />
（3）观测云集成 (华为云-ELB)

> **注意：**在安装核心包后，系统会提示安装第三方依赖包，按照正常步骤点击安装即可。

![image.png](../imgs/huawei-ecs-7.png)

![image.png](../imgs/huawei-ecs-8.png)

![image.png](../imgs/huawei-elb-3.png)

4、 脚本安装完成后，可以在「脚本库」中看到所有脚本集

![image.png](../imgs/huawei-ecs-10.png)

### 2 添加脚本

1、 「开发」 - 「脚本库」 - 「添加脚本集」

![image.png](../imgs/huawei-ecs-11.png)

2、 点击上一步添加的「脚本集」 - 「添加脚本」

![image.png](../imgs/huawei-ecs-12.png)

3、 创建 ID 为 ELB 的脚本

![image.png](../imgs/huawei-elb-4.png)

4、 添加代码

- 需要修改账号配置 `AccessKey ID` 、 `Secret access key` 、 `Account Name` 、`Region` 、`Region_Projects`
- AccessKey ID：访问秘钥 ID
- Secret access key：访问秘钥密码
- Account Name：账号名称 (支持自定义)
- Region：地域 (项目)
- Region_Projects：[**如何获取项目 ID**](https://support.huaweicloud.com/api-ces/ces_03_0057.html)

```python
from guance_integration__runner import Runner
import guance_huaweicloud_elb__main as huawei_elb
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
                'namespace': 'SYS.ELB',
                'metrics'  : 'ALL',
            },
        ],
    }
    collectors = [
        huawei_elb.DataCollector(account, common_huaweiyun_configs),
        huawei_ces.DataCollector(account, monitor_collector_configs),
    ]

    Runner(collectors).run()
```

5、 「保存」 配置并 「发布」

![image.png](../imgs/huawei-ecs-14.png)

### 3 定时任务

1、 添加自动触发任务：「管理」 - 「自动触发配置」 - 「新建任务」

![image.png](../imgs/huawei-ecs-15.png)

2、 自动触发配置：在「执行函数」中添加此脚本，执行频率为 **5 分钟 _/5 _ \* \* \***

![image.png](../imgs/huawei-elb-5.png)

## 场景视图

<场景 - 新建仪表板 - 模板库 - 系统视图 - 华为云 ELB 监控视图>

## 指标详解

<[华为云 ELB 指标列表](https://support.huaweicloud.com/usermanual-elb/elb_ug_jk_0001.html)>

## 常见问题排查

- 查看日志：DataFlux Func 日志路径 `/usr/local/dataflux-func/data/logs/dataflux-func.log`
- 代码调试：编辑模式选择主函数，直接运行 (可以看到脚本输出)

![image.png](../imgs/huawei-ecs-17.png)

- 连接配置：DataFlux Func 无法连接 DataKit，请检查数据源配置 (DataKit 需要监听 0.0.0.0)

![image.png](../imgs/huawei-ecs-18.png)

## 进一步阅读

<[DataFlux Func 观测云集成简介](https://func.guance.com/doc/script-market-guance-integration/)>

<[DataFlux Func 华为云 ELB 配置手册](https://func.guance.com/doc/script-market-guance-huaweicloud-elb/)>
