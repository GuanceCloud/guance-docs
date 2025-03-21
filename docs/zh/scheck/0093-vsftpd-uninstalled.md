# 0093-vsftpd-uninstalled-vsftpd被安装
---

## 规则ID

- 0093-vsftpd-uninstalled


## 类别

- system


## 级别

- warn


## 兼容版本


- Linux




## 说明


- FTP（文件传输协议)是一种传统的和广泛使用的标准工具，用于通过网络在服务器和客户端之间传输文件，特别是在不需要身份验证的情况下(允许匿名用户连接到服务器）。



## 扫描频率
- 0 */30 * * *

## 理论基础


- FTP不保护数据或身份验证凭据的机密性。如果需要文件传输，建议使用SFTP。除非需要作为FTP服务器运行系统（例如，允许匿名下载），否则建议删除该包以减少潜在的攻击面。
> 注意：还存在其他FTP服务器，如果不需要，则应删除。






## 风险项


- 增加被攻击风险



## 审计方法
- 运行以下命令以验证是否未安装对应组件：
```bash
# rpm -q vsftpd
package vsftpd is not installed
```



## 补救
- 运行以下命令以删除对应的包：
```bash
# yum remove vsftpd
```



## 影响


- 您的如果正在使用该服务器做FTP，有使用到ftp该服务的应用可能会失去数据存储。




## 默认值


- 无




## 参考文献


- 无



## CIS 控制


- Version 7
  9.2确保仅经批准的端口、协议和服务正在运行  
  确保每个系统上仅监听具有已验证的业务需求的系统的网络端口、协议和服务在运行。


