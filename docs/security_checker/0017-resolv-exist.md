# 0017-resolv-exist-Dns resolv 文件被删除
---

## 规则ID

- 0017-resolv-exist


## 类别

- system


## 级别

- critical


## 兼容版本


- Linux




## 说明


- 监控主机/etc/group是否存在



## 扫描频率
- disable

## 理论基础


- /etc/resolv.conf它是DNS客户机配置文件，用于设置DNS服务器的IP地址及DNS域名，还包含了主机的域名搜索顺序。该文件是由域名解析 器（resolver，一个根据主机名解析IP地址的库）使用的配置文件。它的格式很简单，每行以一个关键字开头，后接一个或多个由空格隔开的参数。如果这个文件被删除，会造成服务不可用或dns无法解析。






## 风险项


- 服务不可用



## 审计方法
- 验证主机/etc/resolv.conf。可以执行以下命令验证：

```bash
ls /etc/resolv.conf
```



## 补救
- 如果/etc/resolv.conf被删除后，请执行`touch /etc/resolv.conf` 命令添加/etc/resolv.conf。



## 影响


- 无




## 默认值


- 无




## 参考文献


- [黑客入侵应急排查思路&&流程（非官方）](https://www.sohu.com/a/236820450_99899618)



- [记录一次真实的挖矿 入侵排查分析（非官方）](https://www.cnblogs.com/zsl-find/articles/11688640.html)



## CIS 控制


- 无


