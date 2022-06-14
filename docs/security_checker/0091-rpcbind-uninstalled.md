# 0091-rpcbind-uninstalled-rpcbind被安装
---

## 规则ID

- 0091-rpcbind-uninstalled


## 类别

- system


## 级别

- warn


## 兼容版本


- Linux




## 说明


- rpcbind实用程序将RPC服务映射到它们侦听的端口。RPC进程在启动时通知rpcbind，注册他们正在侦听的端口以及他们希望提供服务的RPC程序编号。客户端系统然后用特定的RPC程序号联系服务器上的rpcbind。rpcbind服务将客户端重定向到正确的端口号，以便它可以与所请求的服务通信
> Portmapper是一个RPC服务，它总是侦听tcp和udp111，并用于映射其他RPC服务(如nfs、nlockmgr、quotad、mountd等)。到其在服务器上相应的端口号。当远程主机对该服务器进行RPC调用时，它首先咨询portmap以确定RPC服务器侦听的位置



## 扫描频率
- 0 */30 * * *

## 理论基础


- 发送到端口映射器的小请求（~82字节)会产生大响应(7倍到28倍放大），这使其成为DDoS攻击的合适工具。如果不需要rpcbind，则建议删除rpcbind软件包，以减少系统的攻击面。
> 注意：企业Linux虚拟化所使用的许多libvirt包和网络文件系统(NFS)所使用的nfs-utils包都依赖于rpcbind包。如果需要rpcbind作为依赖项，则应停止服务rpcbind.service和rpcbind.socket并进行屏蔽，以减少系统的攻击面。






## 风险项


- 增加被攻击风险



## 审计方法
- 运行以下命令以验证是否未安装对应组件：
```bash
# rpm -q rpcbind
package rpcbind is not installed
```
如果需要对应的软件包作为依赖项：运行以下命令以验证风险服务是否被屏蔽：
```bash
# systemctl is-enabled rpcbind
masked
# systemctl is-enabled rpcbind.socket
masked
```



## 补救
- 运行以下命令以删除对应的包：
```bash
# yum remove rpcbind
```
如果需要对应软件包作为依赖项：运行以下命令以停止并隐藏风险服务：
```bash
# systemctl --now mask rpcbind
# systemctl --now mask rpcbind.socket
```



## 影响


- 依赖该组件的进程可能发生异常。




## 默认值


- 无




## 参考文献


- 无



## CIS 控制


- Version 7
>    9.2确保仅经批准的端口、协议和服务正在运行  
>    确保每个系统上仅监听具有已验证的业务需求的系统的网络端口、协议和服务在运行。


