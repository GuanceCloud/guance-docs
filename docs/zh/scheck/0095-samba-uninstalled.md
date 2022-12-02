# 0095-samba-uninstalled-确保未安装Samba
---

## 规则ID

- 0095-samba-uninstalled


## 类别

- system


## 级别

- warn


## 兼容版本


- Linux




## 说明


- Samba守护进程允许系统管理员配置他们的Linux系统以共享
    文件系统和目录与Windows桌面。Samba将发布文件系统
    和目录通过服务器消息块(SMB)协议。Windows桌面用户将
    能够将这些目录和文件系统作为字母驱动器挂载到它们的系统上。



## 扫描频率
- 0 * * * *

## 理论基础





## 风险项


- 黑客渗透



- 数据泄露



- 网络安全



- 挖矿风险



- 肉机风险



## 审计方法
- 执行以下命令，验证是否安装了samba。

```bash
# rpm -q samba
package samba is not installed
```



## 补救
- 运行命令移除samba。
```bash
# # yum remove samba
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


