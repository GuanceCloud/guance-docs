# 0094-dovecot-uninstalled-IMAP和POP3服务被安装
---

## 规则ID

- 0094-dovecot-uninstalled


## 类别

- system


## 级别

- warn


## 兼容版本


- Linux




## 说明


- 除非本系统提供POP3和/或IMAP服务器，否则推荐使用
    该包被删除，以减少潜在的攻击面。



## 扫描频率
- 0 */30 * * *

## 理论基础


- 除非本系统提供POP3和/或IMAP服务器，否则推荐使用
该包被删除，以减少潜在的攻击面。






## 风险项


- 黑客渗透



- 数据泄露



- 网络安全



- 挖矿风险



- 肉机风险



## 审计方法
- 执行以下命令，验证是否安装了dovecot。

```bash
# rpm -q dovecot
package dovecot is not installed
```



## 补救
- 运行命令移除dovecot。
```bash
# yum remove dovecot
```



## 影响


- 无




## 默认值


- 无




## 参考文献


- 无



## CIS 控制


- Version 7



- 9.2确保只运行审批通过的端口、协议和业务<br>
    确保只有网络端口、协议和服务在系统上监听经过验证的业务需求，正在每个系统上运行。


