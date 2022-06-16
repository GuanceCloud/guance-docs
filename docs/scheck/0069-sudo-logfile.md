# 0069-sudo-logfile-sudo日志未配置或被删除
---

## 规则ID

- 0069-sudo-logfile


## 类别

- system


## 级别

- warn


## 兼容版本


- Linux




## 说明


- sudo可以使用自定义日志文件，用来记录各用户都运行了那些命令。
>   注意：visudo以类似于vipw（8）的安全方式编辑sudoers文件。 visudo锁定sudoers文件以防止同时进行多次编辑，提供基本的完整性检查并检查解析错误。如果当前用户正在编辑sudoers文件，您将收到一条提示消息，稍后再试。



## 扫描频率
- disable

## 理论基础


- 用来记录用户运行的命令






## 风险项


- 无法发现哪个用户执行的非法命令



## 审计方法
- 验证sudo是否配置了自定义日志文件。运行以下命令：

``` bash
grep -Ei "^\s*Defaults\s+([^#;]+,\s*)?logfile\s*=\s*(")?[^#;]+(")?" /etc/sudoers
or
grep -Ei '^\s*Defaults\s+([^#;]+,\s*)?logfile\s*=\s*(")?[^#;]+(")?' /etc/sudoers.d/*
# 应当输出如下信息，如果没有 建议添加sudo.log配置
logfile ="/var/log/sudo.log"
```



## 补救
- 使用visudo或visudo -f <PATH TO FILE>编辑文件/etc/sudoers

``` bash
logfile="/var/log/sudo.log"
```



## 影响


- 配置sudo日志后，可以详细的查看用户执行了那些命令，包括执行的时间，登录的时间，登录点。




## 默认值


- 默认情况下没有配置




## 参考文献


- [sudo命令用法及日志管理（非官方）](https://blog.51cto.com/lifeng/976879) 



## CIS 控制


- Version 7
   6.3 Enable Detailed Logging
   Enable system logging to include detailed information such as an event source, date, user, timestamp, source addresses, destination addresses, and other useful elements.


