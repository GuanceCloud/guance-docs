# 0090-ldap-uninstalled-LDAP被安装
---

## 规则ID

- 0090-ldap-uninstalled


## 类别

- system


## 级别

- warn


## 兼容版本


- Linux




## 说明


- 引入了轻型目录访问协议(LDAP)作为NIS/YP的替代品。它是一种提供了从中央数据库中查找信息的方法的服务。



## 扫描频率
- 0 */30 * * *

## 理论基础


- 如果系统不需要充当LDAP服务器，则建议删除该软件，以减少潜在的攻击面。






## 风险项


- 增加被攻击风险



## 审计方法
- 运行以下命令以验证是否未安装对应组件：
```bash
# rpm -q openldap-servers
package openldap-servers is not installed
```



## 补救
- 运行以下命令以删除对应的包：
```bash
# yum remove openldap-servers
```



## 影响


- 有关OpenLDAP的更多详细文档，请访问项目主页：http://www.openldap.org.




## 默认值


- 无




## 参考文献


- 无



## CIS 控制


- Version 7
>    9.2确保仅经批准的端口、协议和服务正在运行  
>    确保每个系统上仅监听具有已验证的业务需求的系统的网络端口、协议和服务在运行。


