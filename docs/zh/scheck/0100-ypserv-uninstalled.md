# 0100-ypserv-uninstalled-NIS服务被安装
---

## 规则ID

- 0100-ypserv-uninstalled


## 类别

- system


## 级别

- warn


## 兼容版本


- Linux




## 说明


- NIS服务本质上是一个不安全的系统，容易受到DOS攻击，
    缓冲区溢出，并且在查询NIS映射时身份验证很差。NIS通常
    已被轻量级目录访问协议(LDAP)等协议所取代。它是
    建议删除ypserv包，如果需要更安全的服务
    被使用。



## 扫描频率
- 0 */30 * * *

## 理论基础


- ypserv包提供NIS (Network Information Service)服务。这种服务,正式
    黄页是一种用于分发系统的客户机-服务器目录服务协议
    配置文件。NIS服务器是允许分发的程序的集合
    的配置文件。






## 风险项


- 黑客渗透



- 数据泄露



- 网络安全



- 挖矿风险



- 肉机风险



## 审计方法
- 执行以下命令，验证是否安装了ypserv。

```bash
# rpm -q ypserv
package ypserv is not installed
```



## 补救
- 运行命令移除ypserv。
```bash
# # yum remove ypserv
```



## 影响


- 无




## 默认值


- 无




## 参考文献


- 无



## CIS 控制


- Version 7<br>
    9.2确保只运行审批通过的端口、协议和业务<br>
    确保只有网络端口、协议和服务在系统上监听经过验证的业务需求，正在每个系统上运行。


