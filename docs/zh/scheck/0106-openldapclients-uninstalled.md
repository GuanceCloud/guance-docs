# 0106-openldapclients-uninstalled-LDAP客户端被安装
---

## 规则ID

- 0106-openldapclients-uninstalled


## 类别

- system


## 级别

- warn


## 兼容版本


- Linux




## 说明


- 轻量级目录访问协议（LDAP）是作为NIS/YP的替代品引入的。它是一种提供从中央数据库中查找信息的方法的服务。



## 扫描频率
- 00 */30 * * *

## 理论基础


- 如果系统不需要充当LDAP客户端，建议删除该软件以减少潜在的攻击面。






## 风险项


- 黑客渗透



- 数据泄露



- 网络安全



- 挖矿风险



- 肉机风险



## 审计方法
- 运行以下命令以验证是否未安装openldap clients包：

```bash
 # rpm -q openldap-clients
package openldap-clients is not installed
```



## 补救
- 运行以下命令以删除openldap clients包：
```bash
# yum remove openldap-clients
```



## 影响


- 许多不安全的服务客户机被用作故障排除工具和测试环境。卸载它们会抑制测试和故障排除的能力。如果需要，建议在使用后移除客户端，以防止意外或故意误用。




## 默认值



## 参考文献


- [OpenLDAP documentation](http://www.openldap.org.)



## CIS 控制


- Version 7
   9.2确保只运行经批准的端口、协议和服务
确保每个系统上只运行在具有已验证业务需求的系统上侦听的网络端口、协议和服务。


