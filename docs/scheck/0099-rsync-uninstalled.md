# 0099-rsync-uninstalled-rsync被安装或rsyncd服务未屏蔽
---

## 规则ID

- 0099-rsync-uninstalled


## 类别

- system


## 级别

- warn


## 兼容版本


- Linux




## 说明


- 除非需要，否则应该删除rsync包以减少攻击表面积
    这个系统。
    rsyncd服务存在安全风险，因为它使用未加密的协议
    沟通。
    注意:如果rsync包存在一个必需的依赖项，但是rsyncd服务没有
    必需的，服务应该被屏蔽。



## 扫描频率
- 0 */30 * * *

## 理论基础


- syncd服务可用于通过网络链接在系统之间同步文件。






## 风险项


- 黑客渗透



- 数据泄露



- 网络安全



- 挖矿风险



- 肉机风险



## 审计方法
- 执行以下命令，验证是否安装了rsync。

```bash
# rpm -q rsync
package rsync is not installed
```



## 补救
- 运行命令移除rsync。
```bash
# yum remove rsync
```



## 影响


- 无




## 默认值



## 参考文献


- 无



## CIS 控制


- Version 7<br>
    9.2确保只运行审批通过的端口、协议和业务<br>
    确保只有网络端口、协议和服务在系统上监听经过验证的业务需求，正在每个系统上运行。


