# 0009-kernel-version-主机内核版本发生改变
---

## 规则ID

- 0009-kernel-version


## 类别

- system


## 级别

- critical


## 兼容版本


- Linux




## 说明


- 监控内核版本发生改变



## 扫描频率
- 1 */5 * * *

## 理论基础


- 内核由一系列程序组成，包括负责响应中断的中断服务程序、负责管理多个进程从而分享处理器时间的调度程序、负责管理地址空间的内存管理程序、网络、进程间通信的系统服务程序等。内核负责管理系统的硬件设备。内核版本修改会造成系统服务的不稳定性和安全性。






## 风险项


- 应用拒绝服务



## 审计方法
- 验证内核版本发生改变。可以执行以下命令验证：

```bash
uname -srm
```



## 补救
- 如果内核版本被非法修改，请勿必仔细查看主机环境，是否被入侵，并且修改主机用户密码。



## 影响


- 无




## 默认值


- 无




## 参考文献


- 无



## CIS 控制


- 无

