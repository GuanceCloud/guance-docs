# ECS

---

## 视图预览

阿里云 ECS 指标展示，包括 CPU 负载、内存使用、磁盘读写、网络流量等。

![image](../imgs/input-aliyun-ecs-1.png)

## 版本支持

操作系统支持：Linux / Windows

## 前置条件

- 服务器 <[安装 DataKit](../../datakit/datakit-install.md)>
- 服务器 <[安装 DataFlux Func 携带版](../../dataflux-func/quick-start.md)>
- 阿里云 ECS 安装云监控
- 阿里云 RAM 访问控制账号授权

### 云监控安装

1、 登录阿里云监控控制台 [https://cloudmonitor.console.aliyun.com/](https://cloudmonitor.console.aliyun.com/)<br />

2、 「主机监控」 - 「点击安装」

-  建议勾选「新构 ECS 自动安装云监控」

![image](../imgs/input-aliyun-ecs-2.png)

### RAM 访问控制

1、 登录 RAM 控制台 [https://ram.console.aliyun.com/users](https://ram.console.aliyun.com/users)<br />

2、 新建用户：「人员管理」 - 「用户」 - 「创建用户」

![image](../imgs/input-aliyun-ecs-3.png)

3、 保存或下载 **AccessKey** **ID** 和 **AccessKey Secret** 的 CSV 文件 (配置文件会用到)<br />

4、 用户授权 「只读访问所有阿里云资源的权限」

![image](../imgs/input-aliyun-ecs-4.png)

## 安装配置

说明：

- 示例 Linux 版本为：CentOS Linux release 7.8.2003 (Core)
- 通过一台服务器采集所有阿里云 ECS 数据

### 部署实施

#### 脚本市场

1、 登录 DataFlux Func，地址 `http://ip:8088`

![image](../imgs/input-aliyun-ecs-5.png)

2、 开启脚本市场：「管理」 - 「实验性功能」 - 「开启脚本市场模块」

![image](../imgs/input-aliyun-ecs-6.png)

3、 **依次添加**三个脚本集<br />

（1）观测云集成（核心包）<br />
（2）观测云集成（阿里云 - 云监控）<br />
（3）观测云集成（阿里云 - ECS）

> **注意：**在安装核心包后，系统会提示安装第三方依赖包，按照正常步骤点击安装即可。

![image](../imgs/input-aliyun-ecs-7.png)

4、 脚本安装完成后，可以在「脚本库」中看到所有脚本集

![image](../imgs/input-aliyun-ecs-8.png)

#### 添加脚本

1、 「开发」 - 「脚本库」 - 「添加脚本集」

![image](../imgs/input-aliyun-ecs-9.png)

2、 点击上一步添加的「脚本集」 - 「添加脚本」

![image](../imgs/input-aliyun-ecs-10.png)

3、 创建 ID 为 main 的脚本

![image](../imgs/input-aliyun-ecs-11.png)

4、 添加代码

- 需要修改账号配置 `AccessKey ID` 、 `AccessKey Secret` 、 `Account Name`

```bash
from guance_integration__runner import Runner        # 引入启动器
import guance_aliyun_ecs__main as aliyun_ecs         # 引入阿里云ECS采集器
import guance_aliyun_monitor__main as aliyun_monitor # 引入阿里云云监控采集器

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
    # 采集器配置
    common_aliyun_configs = {
        'regions': [ 'cn-hangzhou' ], #阿里云ECS对应的地域
    }
    monitor_collector_configs = {
        'targets': [
            { 'namespace': 'acs_ecs_dashboard', 'metrics': ['cpu_cores','cpu_idle','cpu_system','cpu_user','cpu_wait','disk_readbytes','disk_readiops','disk_writebytes','disk_writeiops','diskusage_avail','diskusage_free','diskusage_total','diskusage_used','diskusage_utilization','fs_inodeutilization','load_15m','load_1m','load_5m','memory_freespace','memory_freeutilization','memory_totalspace','memory_usedspace','memory_usedutilization','net_tcpconnection','networkin_packages','networkin_rate','networkout_packages','networkout_rate'] },
        ],
    }

    # 创建采集器
    collectors = [
        aliyun_ecs.DataCollector(account, common_aliyun_configs),
        aliyun_monitor.DataCollector(account, monitor_collector_configs),
    ]

    # 启动执行
    Runner(collectors).run()
```

5、 「保存」 配置并 「发布」

![image](../imgs/input-aliyun-ecs-12.png)

#### 定时任务

1、 添加自动触发任务：「管理」 - 「自动触发配置」 - 「新建任务」

![image](../imgs/input-aliyun-ecs-13.png)

2、 自动触发配置：在「执行函数」中添加此脚本，执行频率为 **每分钟 \* \* \* \* \***

![image](../imgs/input-aliyun-ecs-14.png)

3、 指标预览

![image](../imgs/input-aliyun-ecs-15.png)

## 场景视图

<场景 - 新建仪表板 - 模板库 - 系统视图 - 阿里云 ECS 监控视图>

## 监控规则

<监控 - 模板新建 - 阿里云 ECS 检测库>

## 指标详解

<[阿里云 ECS 指标列表](https://help.aliyun.com/document_detail/162844.htm?spm=a2c4g.11186623.0.0.43b973c2g7MWB8#concept-2482301)>

## 常见问题排查

- 查看日志：DataFlux Func 日志路径 `/usr/local/dataflux-func/data/logs/dataflux-func.log`
- 代码调试：编辑模式选择主函数，直接运行 (可以看到脚本输出)

![image](../imgs/input-aliyun-ecs-16.png)

- 连接配置：DataFlux Func 无法连接 DataKit，请检查数据源配置 (DataKit 需要监听 0.0.0.0)

![image](../imgs/input-aliyun-ecs-17.png)

## 进一步阅读

<[DataFlux Func 阿里云-云监控配置手册](../../dataflux-func/script-market-guance-aliyun-monitor.md)>