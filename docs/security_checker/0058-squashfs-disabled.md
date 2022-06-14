# 0058-squashfs-disabled-squashfs 被启用
---

## 规则ID

- 0058-squashfs-disabled


## 类别

- storage


## 级别

- warn


## 兼容版本


- Linux




## 说明


- 监控主机确保squashfs不被启用



## 扫描频率
- 1 */5 * * *

## 理论基础


- 取消对不需要的文件系统类型的支持可以减少系统的本地攻击面。如果不需要此文件系统类型，请禁用它。






## 风险项


- 黑客渗透



- 数据泄露



## 审计方法
- 验证主机squashfs是否被启用。可以执行一下命令验证：

```bash
lsmod | grep squashfs
```



## 补救
- 


## 影响



## 默认值


- 无




## 参考文献


- 无



## CIS 控制


- 无


