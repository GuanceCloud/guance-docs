# 0301-docker-lxc-notuse-容器不允许使用lxc执行驱动程序
---

## 规则ID

- 0301-docker-lxc-notuse


## 类别

- container


## 级别

- warn


## 兼容版本


- Linux




## 说明


- 默认Docker执行驱动程序是'libcontainer'。LXC作为一个执行驱动程序是可选的，只是有遗留的支持。



## 扫描频率
- 1 */5 * * *

## 理论基础


- 早于3.10的内核缺少运行Docker容器所需的一些功能。众所周知，这些较旧的版本存在bug，这些bug会导致数据丢失，并且在某些情况下会频繁出现死机。因此，建议使用3.10（或更新的维护版本）Linux内核的最新次要版本（3.x.y）。此外，使用更新的Linux内核可以确保修复之前发现的关键内核错误。






## 风险项


- 容器安全



## 审计方法
- 执行下面的命令，找出Linux内核版本：

```bash
uname -r
```
确保找到的内核版本是3.10或更新版本。



## 补救
- 查看Docker内核和操作系统需求，并适当地选择您的内核和操作系统。



## 影响


- 无




## 默认值


- 无




## 参考文献


- [check-kernel-dependencies](https://docs.docker.com/installation/binaries/#check-kernel-dependencies)



- [installation-list](https://docs.docker.com/installation/#installation-list)



## CIS 控制


- 无


