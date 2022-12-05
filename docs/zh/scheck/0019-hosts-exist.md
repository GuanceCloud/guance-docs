# 0019-hosts-exist-hosts 被删除
---

## 规则ID

- 0019-hosts-exist


## 类别

- system


## 级别

- critical


## 兼容版本


- Linux




## 说明


- 监控主机/etc/hosts 是否存在



## 扫描频率
- 1 */5 * * *

## 理论基础


- hosts文件是Linux系统中一个负责IP地址与域名快速解析的文件，以ASCII格式保存在“/etc”目录下，文件名为“hosts”。
  hosts文件包含了IP地址和主机名之间的映射，还包括主机名的别名。在没有域名服务器的情况下，系统上的所有网络程序都通过查询该文件来解析对应于某个主机名的IP地址，否则就需要使用DNS服务程序来解决。通常可以将常用的域名和IP地址映射加入到hosts文件中，实现快速方便的访问。
  hosts 文件被恶意删除会造成服务不可用。






## 风险项


- 服务不可用



## 审计方法
- 验证主机/etc/hosts。可以执行以下命令验证：

```bash
ls /etc/hosts
```



## 补救
- 如果/etc/hosts被删除后，请执行`touch /etc/hosts` 命令添加/etc/hosts。



## 影响


- 无




## 默认值


- 无




## 参考文献


- [黑客入侵应急排查思路&&流程（非官方）](https://www.sohu.com/a/236820450_99899618)



- [记录一次真实的挖矿 入侵排查分析（非官方）](https://www.cnblogs.com/zsl-find/articles/11688640.html)



## CIS 控制


- 无


