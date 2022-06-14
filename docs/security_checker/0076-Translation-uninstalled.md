# 0076-Translation-uninstalled-mcstrans服务 被安装了
---

## 规则ID

- 0076-Translation-uninstalled


## 类别

- system


## 级别

- warn


## 兼容版本


- Linux




## 说明


- mcstransd守护进程向请求信息的客户端进程提供类别标签信息。标签翻译在/etc/selinux/targeted/setrans.conf中定义



## 扫描频率
- 1 */5 * * *

## 理论基础


- 由于不经常使用此服务，请删除它以减少系统上运行的潜在易受攻击的代码量。






## 风险项


- 黑客渗透



- 数据泄露



- 挖矿风险



- 肉机风险



## 审计方法
- 验证是否未安装mcstrans。运行以下命令：

```bash
 # rpm -q mcstrans
package mcstrans is not installed
```



## 补救
- 运行以下命令卸载mcstrans：
```bash
# yum remove mcstrans
```



## 影响


- 无




## 默认值


- 无




## 参考文献


## CIS 控制


- Version 7
9.2确保只运行经批准的端口、协议和服务
确保每个系统上只运行在具有已验证业务需求的系统上侦听的网络端口、协议和服务。


