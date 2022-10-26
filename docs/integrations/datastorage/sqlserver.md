
# SQLServer
---

## 视图预览

SQLServer 性能指标展示，包括CPU、内存、事务、日志、临时表、物理文件 IO、备份、任务调度等。

![image](../imgs/input-sqlserver-1.png)

![image](../imgs/input-sqlserver-2.png)

![image](../imgs/input-sqlserver-3.png)

![image](../imgs/input-sqlserver-4.png)

![image](../imgs/input-sqlserver-5.png)

## 版本支持

操作系统支持：Linux / Windows

## 前置条件

- 服务器 <[安装 DataKit](../../datakit/datakit-install.md)>
- 创建监控用户 (Public 权限)

```
USE master;
GO
CREATE LOGIN [user] WITH PASSWORD = N'password';
GO
GRANT VIEW SERVER STATE TO [user];
GO
GRANT VIEW ANY DEFINITION TO [user];
GO
```

## 安装配置

说明：示例 SQLServer 版本为 Microsoft SQL Server 2016 (RTM) - 13.0.1601.5 (X64)

### 部署实施

#### 指标采集 (必选)

1、 开启 DataKit SQLServer 插件，复制 sample 文件

```
进入 C:\Program Files\datakit\conf.d\db
复制 sqlserver.conf.sample 为 sqlserver.conf
```

2、 修改 `sqlserver.conf` 配置文件

参数说明

- host：服务连接地址
- user：用户名
- password：密码
- interval：数据采集频率
```
[[inputs.sqlserver]]
  host = "host"
  user = "user"
  password = "password"
  interval = "10s"
```

3、 重启 DataKit (如果需要开启日志，请配置日志采集再重启)

```
services.msc 找到 datakit 重新启动
```

指标预览

![image](../imgs/input-sqlserver-6.png)

#### 日志采集 (非必选)

参数说明

- files：日志文件路径 (通常填写访问日志和错误日志)
- Pipeline：日志切割文件(内置)，实际文件路径 `/usr/local/datakit/pipeline/sqlserver.p`
- 相关文档 <[ 文本数据处理（Pipeline）](../../datakit/pipeline.md)>

```
[inputs.sqlserver.log]
files = ["C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\Log\ERRORLOG"]
pipeline = "sqlserver.p"
```

重启 DataKit (如果需要开启自定义标签，请配置插件标签再重启)

```
systemctl restart datakit
```
#### 插件标签 (非必选)

参数说明

- 该配置为自定义标签，可以填写任意 key-value 值
- 以下示例配置完成后，所有 SQLServer 指标都会带有 `app = "oa"` 的标签，可以进行快速查询。
- 相关文档 <[TAG在观测云中的最佳实践](../../best-practices/insight/tag.md)>
- 
```
# 示例
[inputs.sqlserver.tags]
   app = "oa"
```

重启 DataKit

```
systemctl restart datakit
```

## 场景视图

<场景 - 新建仪表板 - 模板库 - 系统视图 - SQLServer 监控视图> 

## [指标详解](../../../datakit/sqlserver#measurements)


## 常见问题排查

<[无数据上报排查](../../datakit/why-no-data.md)>

