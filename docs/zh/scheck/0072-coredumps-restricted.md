# 0072-coredumps-restricted-堆芯转储受到限制
---

## 规则ID

- 0072-coredumps-restricted


## 类别

- system


## 级别

- warn


## 兼容版本


- Linux




## 说明


- 核心转储是可执行程序的内存。通常用于确定程序为何中止。它也可以用于从核心文件中收集机密信息。该系统提供了为核心转储设置软限制的功能，但是用户可以忽略此限制。



## 扫描频率
- 0 */30 * * *

## 理论基础


- 对核心转储设置硬限制可防止用户覆盖软变量。如果需要核心转储，请考虑为用户组设置限制。另外，将fs.suid_dumpable变量设置为0将防止setuid程序转储内核。
>






## 风险项


- 限制用户覆盖软变量



## 审计方法
- 运行以下命令并验证输出是否匹配：

```bash
# grep -E "^\s*\*\s+hard\s+core" /etc/security/limits.conf /etc/security/limits.d/*
* hard core 0
# sysctl fs.suid_dumpable
fs.suid_dumpable = 0
# grep "fs\.suid_dumpable" /etc/sysctl.conf /etc/sysctl.d/*
fs.suid_dumpable = 0
```

运行以下命令，检查是否安装了systemd-coredump：

``` bash
# systemctl is-enabled coredump.service
```

如果返回启用或禁用，则安装systemd-coredump



## 补救
- 将以下行添加到/etc/security/limits.conf或/etc/security/limits.d/*文件中：

``` bash
* hard core 0
```
在/etc/sysctl.conf或/etc/sysctl.d/*文件中设置以下参数：
>

``` bash
fs.suid_dumpable = 0
```
运行以下命令来设置活动内核参数：
>

``` bash
# sysctl -w fs.suid_dumpable=0
```
如果已安装systemd-coredump：
>
编辑/etc/systemd/coredump.conf并添加/修改以下行：

``` bash
Storage=none
ProcessSizeMax=0
```

> 运行命令：

``` bash
systemctl daemon-reload
```



## 影响


- 对核心转储设置硬限制可防止用户覆盖软变量




## 默认值


- 默认情况下，没有配置。




## 参考文献


- 无



## CIS 控制


- Version 7
>   5.1 Establish Secure Configurations 
>
>   Maintain documented, standard security configuration standards for all authorized operating systems and software.


