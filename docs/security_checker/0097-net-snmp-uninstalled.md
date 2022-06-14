# 0097-net-snmp-uninstalled-确保未安装net-snmp
---

## 规则ID

- 0097-net-snmp-uninstalled


## 类别

- system


## 级别

- warn


## 兼容版本


- Linux




## 说明


- SNMP服务器可以使用SNMPv1进行通信，SNMPv1以clear和clear格式传输数据
    执行命令不需要身份验证。SNMPv3取代了simple/clear
    SNMPv2中使用的文本密码共享，具有更安全的参数编码。如果的
    不需要SNMP服务，应删除net-snmp包以减少系统攻击面。



## 扫描频率
- 0 */30 * * *

## 理论基础


- SNMP (Simple Network Management Protocol)是一种广泛使用的网络监控协议
    健康福利网络设备、计算机设备和ups等设备。
    Net-SNMP是一套用于实现SNMPv1 (rfc1157)、SNMPv2 (RFC . Net-SNMP)的应用程序
    和同时使用IPv4和IPv6的SNMPv3 (rfc3411 -3418)。
    对SNMPv2经典版本的支持。“SNMPv2历史性的”(rfc1441 -1452)被丢弃
    UCD-snmp包4.0版本。
    SNMP (Simple Network Management Protocol)服务器用于监听SNMP
    命令，执行命令或收集
    信息，然后将结果发送回请求系统。SNMP (Simple Network Management Protocol)是一种广泛使用的网络监控协议
    健康福利网络设备、计算机设备和ups等设备。
    Net-SNMP是一套用于实现SNMPv1 (rfc1157)、SNMPv2 (RFC . Net-SNMP)的应用程序
    和同时使用IPv4和IPv6的SNMPv3 (rfc3411 -3418)。
    对SNMPv2经典版本的支持。“SNMPv2历史性的”(rfc1441 -1452)被丢弃
    UCD-snmp包4.0版本。
    SNMP (Simple Network Management Protocol)服务器用于监听SNMP
    命令，执行命令或收集
    信息，然后将结果发送回请求系统。






## 风险项


- 黑客渗透



- 数据泄露



- 网络安全



- 挖矿风险



- 肉机风险



## 审计方法
- 执行以下命令，验证是否安装了net-snmp。

```bash
# rpm -q net-snmp
package net-snmp is not installed
```



## 补救
- 运行命令移除net-snmp。
```bash
# yum remove net-snmp
```



## 影响


- 无




## 默认值



## 参考文献


## CIS 控制


- Version 7



- 2.6 处理未经批准的软件<br>
    确保未经授权的软件要么被删除，要么在及时更新。



- 9.2 确保只运行审批通过的端口、协议和业务<br>
    确保只有网络端口、协议和服务在系统上监听经过验证的业务需求，正在每个系统上运行。


