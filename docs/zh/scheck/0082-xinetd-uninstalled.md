# 0082-xinetd-uninstalled-xinetd被安装
---

## 规则ID

- 0082-xinetd-uninstalled


## 类别

- system


## 级别

- warn


## 兼容版本


- Linux




## 说明


- 扩展的互联网守护进程(xinetd)是一个开源的超级守护程序，它取代了原来的inetd守护进程。xinetd守护进程侦听已知的服务，并分派适当的守护进程以正确响应服务请求。



## 扫描频率
- 0 */30 * * *

## 理论基础


- 如果不需要网络服务，建议删除软件包以减少系统的攻击面。



- 注：如果需要网络服务或服务，请确保停止并禁用任何不需要的服务






## 风险项


- 数据泄露



## 审计方法
- 运行以下命令以验证是否未安装xinetd包：
```bash
# rpm -q xinetd
package xinetd is not installed
```



## 补救
- 运行以下命令以删除openldap clients包：
```bash
# yum remove xinetd
```



## 影响


- 对xinted有依赖的服务可能会遇到异常，或者进程终止




## 默认值



## 参考文献


- 无



## CIS 控制


- Version 7
    2.6 地址未经批准的软件
    确保删除未经授权的软件，或库存及时更新



- 9.2 确保只有已批准的端口、协议和服务在运行
    确保在具有已验证业务需求的系统上只有网络端口、协议和服务在每个系统上运行。


