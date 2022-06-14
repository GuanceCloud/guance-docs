# 0027-ssh-tunnel-存在ssh隧道
---

## 规则ID

- 0027-ssh-tunnel


## 类别

- network


## 级别

- critical


## 兼容版本


- Linux




## 说明


- 监控主机是否存在ssh隧道



## 扫描频率
- 1 */5 * * *

## 理论基础


- SSH隧道即SSH端口转发，在SSH客户端与SSH服务端之间建立一个隧道，将网络数据通过该隧道转发至指定端口，从而进行网络通信。SSH隧道自动提供了相应的加密及解密服务，保证了数据传输的安全性。如果主机存在未知的ssh隧道，主机会面临数据泄露的危险，所以应该在审计范围内。






## 风险项


- 黑客渗透



- 数据泄露



- 网络安全



- 挖矿风险



- 肉机风险



## 审计方法
- 验证主机进程列表，是否存在cmdline 为 sshd: root@notty的 进程。可以执行以下命令验证：

```bash
ps -ef | grep -v grep| grep "sshd: root@notty"
```



## 补救
- 如果存在 未知的cmdline 为 sshd: root@notty的 进程，请执行`kill -9 隧道pid`，关闭危险进程。



## 影响


- 无




## 默认值


- 默认情况下，不允许存在cmdline 为 sshd: root@notty的 进程。




## 参考文献


- [黑客入侵应急排查思路&&流程（非官方）](https://www.sohu.com/a/236820450_99899618)



- [记录一次真实的挖矿 入侵排查分析（非官方）](https://www.cnblogs.com/zsl-find/articles/11688640.html)



## CIS 控制


- 无


