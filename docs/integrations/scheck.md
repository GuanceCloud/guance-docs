
# Scheck (安全巡检)
---

## 视图预览

安全检测指标展示，包括系统，网络，数据库，存储等

![image](imgs/input-scheck-1.png)

![image](imgs/input-scheck-2.png)

## 版本支持

操作系统支持：Linux

## 前置条件

- 服务器 <[安装 DataKit](../datakit/datakit-install.md)>

## 安装配置

说明：示例 Linux 版本为：CentOS Linux release 7.8.2003 (Core)

### 部署实施

#### 安装服务

```
bash -c "$(curl https://static.dataflux.cn/security-checker/install.sh)"
```

软件目录

- 安装目录：/usr/local/scheck
- 日志路径：/usr/local/scheck/log
- 主配置文件：/usr/local/scheck/scheck.conf
- 检测规则目录：/usr/local/scheck/rules.d

#### 配置文件

1、主配置文件：/usr/local/scheck/scheck.conf
参数说明

- rule_dir：检测规则目录
- output：输出地址(默认为 DataKit API)
- cron：定时任务(默认10s)
- log：日志文件路径
- log_level：日志级别
- disable_log：是否关闭日志 (默认开启)

```
rule_dir='/usr/local/scheck/rules.d'
output='http://127.0.0.1:9529/v1/write/security'
#cron='*/10 * * * *'
log='/usr/local/scheck/log'
log_level='info'
#disable_log=false
```

2、启动服务

```
systemctl start scheck
```

3、规则测试

```
/usr/local/scheck/scheck --test /usr/local/scheck/rules.d/0068-sudo-use-pty
```

有数据返回说明存在异常

![image](imgs/input-scheck-3.png)

<br />进入安全巡检模块<br />

![image](imgs/input-scheck-4.png)

点击查看详情以及解决方案

![image](imgs/input-scheck-5.png)

## 常见问题排查

<[无数据上报排查](../datakit/why-no-data.md)>

## 进一步阅读

<[Security Checker 最佳实践](../scheck/best-practices)>

<[Security Checker 函数清单](../scheck/funcs)>

