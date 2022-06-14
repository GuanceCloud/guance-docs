# 0073-addressspac-randomization-enable-确保已启用地址空间布局随机化（ASLR）
---

## 规则ID

- 0073-addressspac-randomization-enable


## 类别

- system


## 级别

- warn


## 兼容版本


- Linux




## 说明


- 地址空间布局随机化（ASLR）是一种利用漏洞缓解技术，它将进程中关键数据区域的地址空间进行随机排列。



## 扫描频率
- 0 */30 * * *

## 理论基础


- 随机放置虚拟内存区域将使写入内存页攻击变得困难，因为内存位置将不断变化。
>






## 风险项


- 服务不可用



## 审计方法
- 运行以下命令并验证输出是否匹配：

```bash
# sysctl kernel.randomize_va_space
kernel.randomize_va_space = 2
# grep "kernel\.randomize_va_space" /etc/sysctl.conf /etc/sysctl.d/*
kernel.randomize_va_space = 2
```




## 补救
- 将以下行添加到/etc/security/limits.conf或/etc/security/limits.d/*文件中：

``` bash
kernel.randomize_va_space = 2
```
运行以下命令设置活动内核参数：
``` bash
sysctl -w kernel.randomize_va_space=2
```



## 影响


- 无




## 默认值


- 无




## 参考文献


- 无



## CIS 控制


- Version 7
>   8.3启用操作系统反攻击功能/部署反攻击技术
    启用操作系统中可用的反攻击功能，如数据执行预防（DEP）或地址空间布局随机化（ASLR），或部署适当的工具包，这些工具包可配置为对更广泛的应用程序和可执行文件集应用保护。


