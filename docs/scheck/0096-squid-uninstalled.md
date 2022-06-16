# 0096-squid-uninstalled-确保未安装squid HTTP代理服务器
---

## 规则ID

- 0096-squid-uninstalled


## 类别

- system


## 级别

- warn


## 兼容版本


- Linux




## 说明


- Squid是一种标准的代理服务器，用于许多发行版和环境。



## 扫描频率
- 0 * * * *

## 理论基础


- 除非系统专门设置为充当代理服务器，否则建议删除squid包以减少潜在的攻击面。



- 注意：存在多个HTTP代理服务器。除非需要，否则应检查并移除这些。






## 风险项


- 黑客渗透



- 数据泄露



- 网络安全



- 挖矿风险



- 肉机风险



## 审计方法
- 执行以下命令，验证是否安装了squid。

```bash
# rpm -q squid
package squid is not installed
```



## 补救
- 运行命令移除squid。
```bash
#  yum remove squid
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


