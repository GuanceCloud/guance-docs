# 0038-sudoers-priv-sudoers文件权限是否变化
---

## 规则ID

- 0038-sudoers-priv


## 类别

- system


## 级别

- critical


## 兼容版本


- Linux




## 说明


- 监控主机文件/etc/sudoers权限是否被修改



## 扫描频率
- 0 */30 * * *

## 理论基础


- 主机文件/etc/sudoers允许特定用户像root用户一样使用各种各样的命令，而不需要root用户的密码。






## 风险项


- 功能不可用



## 审计方法
- 运行以下命令，并验证Uid和Gid均为0/ root，并且Access不授予组或其他权限：

```bash
stat /etc/sudoers
Access: (0440/-r--r-----) Uid: ( 0/root) Gid: ( 0/root)
```



## 补救
- 如果检测到/etc/sudoers文件权限已被变更，可通过root用户登录该服务器后将该权限进行修复，并审计本次变更。



## 影响


- 功能不可用




## 默认值


- 无




## 参考文献


- [黑客入侵应急排查思路&&流程（非官方）](https://www.sohu.com/a/236820450_99899618)



- [记录一次真实的挖矿 入侵排查分析（非官方）](https://www.cnblogs.com/zsl-find/articles/11688640.html)



## CIS 控制


- 无


