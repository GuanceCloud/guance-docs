# Redis 内存版

---

## 视图预览

腾讯云 Redis 内存版指标展示，包括 CPU、内存、连接数、Key、网络流量、时延等。

![image](../imgs/tencent-redis-mem-1.png)

![image](../imgs/tencent-redis-mem-2.png)

![image](../imgs/tencent-redis-mem-3.png)

![image](../imgs/tencent-redis-mem-4.png)

## 版本支持

操作系统支持：Linux / Windows

## 前置条件

- 服务器 <[安装 DataKit](../../../datakit/datakit-install.md)>
- 服务器 <[安装 DataFlux Func 携带版](https://func.guance.com/doc/maintenance-guide-installation/)>
- 腾讯云访问管理进行授权

### 访问授权

1、 登录访问授权控制台 [https://console.cloud.tencent.com/cam](https://console.cloud.tencent.com/cam)

2、 新建用户：「用户」 - 「用户列表」 - 「新建用户」<br />
（1）访问方式：控制台访问 & 编程访问<br />
（2）用户权限：ReadOnlyAccess

![image](../imgs/tencent-redis-mem-5.png)

3、 新建秘钥：「选择该用户」 - 「API 秘钥」 - 「新建秘钥」(**SecretId** 和 **SecretKey** 配置文件会用到)

![image](../imgs/tencent-redis-mem-6.png)

## 安装配置

说明：

- 示例 Linux 版本为：CentOS Linux release 7.8.2003 (Core)
- 通过一台服务器采集所有腾讯云 Redis 数据
- DataFlux Func `1.x` 版本

### 1 脚本市场

1、 登录 DataFlux Func ，地址 `http://ip:8088`

![image](../imgs/tencent-redis-mem-7.png)

2、 开启脚本市场：「管理」- 「实验性功能」 - 「开启脚本市场模块」

![image](../imgs/tencent-redis-mem-8.png)

3、 **依次添加**三个脚本集<br />
（1）观测云集成 (核心包)<br />
（2）观测云集成 (腾讯云-云监控)<br />
（3）观测云集成 (腾讯云-Redis)<br />

_注：在安装「核心包」后，系统会提示安装第三方依赖包，按照正常步骤点击安装即可_

![image](../imgs/tencent-redis-mem-9.png)

![image](../imgs/tencent-redis-mem-10.png)

![image](../imgs/tencent-redis-mem-11.png)

4、 脚本安装完成后，可以在脚本库中看到所有脚本集

![image](../imgs/tencent-redis-mem-12.png)

### 2 添加脚本

1、 「开发」 - 「脚本库」 - 「添加脚本集」

![image](../imgs/tencent-redis-mem-13.png)

2、 点击上一步添加的「脚本集」 - 「添加脚本」

![image](../imgs/tencent-redis-mem-14.png)

3、 创建 ID 为 main 的脚本

![image](../imgs/tencent-redis-mem-15.png)

4、 添加代码

- 需要修改账号配置 **SecretId / SecretKey /Account Name / Regions**

- Regions 取值可以参考 [**地域列表**](https://cloud.tencent.com/document/api/248/30346)，示例：ap-shanghai

```
from guance_integration__runner import Runner
import guance_tencentcloud_redis__main as tencentcloud_redis
import guance_tencentcloud_monitor__main as tencentcloud_monitor

# 账号配置
account = {
    'ak_id'     : 'SecretId',
    'ak_secret' : 'SecretKey',
    'extra_tags': {
        'account_name': 'Account Name',
    }
}

@DFF.API('执行云资产同步', timeout=300)
def run():
    regions = ['Regions']

    # 采集器配置
    redis_configs = {
        'regions': regions,
    }
    monitor_configs = {
        'regions': regions,
        'targets': [
            {
                'namespace': 'QCE/REDIS_MEM',
                'metrics'  : 'ALL',
            },
        ],
    }
    collectors = [
        tencentcloud_redis.DataCollector(account, redis_configs),
        tencentcloud_monitor.DataCollector(account, monitor_configs),
    ]

    # 启动执行
    Runner(collectors).run()
```

5、 「保存」 配置并 「发布」

![image](../imgs/tencent-redis-mem-16.png)


### 3 定时任务

1、 添加自动触发任务：「管理」 - 「自动触发配置」 - 「新建任务」

![mage](../imgs/tencent-redis-mem-17.png)

2、 自动触发配置：在「执行函数」中添加此脚本，执行频率默认为 5分钟

![image](../imgs/tencent-redis-mem-18.png)



## 场景视图

<场景 - 新建仪表板 - 模板库 - 系统视图 - 腾讯云 Redis 内存版>

## 指标详解

<[腾讯云 Redis 内存版指标列表](https://cloud.tencent.com/document/product/248/49729)>

## 常见问题排查

- 查看日志：DataFlux Func 日志路径 `/usr/local/dataflux-func/data/logs/dataflux-func.log`
- 代码调试：编辑模式选择主函数，直接运行 (可以看到脚本输出)

![image](../imgs/tencent-redis-mem-19.png)

- 连接配置：DataFlux Func 无法连接 DataKit，请检查数据源配置 (DataKit 需要监听 0.0.0.0)

![image](../imgs/tencent-redis-mem-20.png)

## 进一步阅读

<[DataFlux Func 腾讯云-云监控 配置手册](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/)>