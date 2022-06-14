# 0101-telnetserver-uninstalled-telnet服务端被安装
---

## 规则ID

- 0101-telnetserver-uninstalled


## 类别

- system


## 级别

- warn


## 兼容版本


- Linux




## 说明


- telnet-server软件包包含telnet守护程序，该守护程序通过telnet协议接受来自其他系统的用户的连接，该软件采用的是不安全的传输协议，会有安全风险。



## 扫描频率
- * * */1 * *

## 理论基础


- telnet协议不安全且未加密。 使用未加密的传输介质可以使有权访问嗅探网络流量的用户能够窃取凭据。 ssh软件包提供了加密的会话和更强的安全性。






## 风险项


- 黑客渗透



- 数据泄露



- 网络安全



- 挖矿风险



- 肉机风险



## 审计方法
- 执行以下命令，验证是否安装了telnet-server。

```bash
# rpm -q telnet-server
package telnet-server is not installed
```



## 补救
- 运行命令移除ypserv。
```bash
# yum remove telnet-server
```



## 影响


- 无




## 默认值


- 无




## 参考文献


- 无



## CIS 控制


- Version 7<br>



- 2.6 处理未经批准的软件<br>
  确保未经授权的软件被删除或目录被及时更新



- 9.2 确保只运行审批通过的端口、协议和业务<br>
    确保只有网络端口、协议和服务在系统上监听经过验证的业务需求，正在每个系统上运行。


