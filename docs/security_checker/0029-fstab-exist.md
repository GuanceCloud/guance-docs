# 0029-fstab-exist-fstab 被删除
---

## 规则ID

- 0029-fstab-exist


## 类别

- system


## 级别

- critical


## 兼容版本


- Linux




## 说明


- 监控主机/etc/fstab 文件是否存在



## 扫描频率
- 1 */5 * * *

## 理论基础


- 文件/etc/fstab存放的是系统中的文件系统信息，如果/etc/fstab被删除改会造成主机无法启动。






## 风险项


- 服务不可用



## 审计方法
- 验证主机/etc/fstab。可以执行以下命令验证：

```bash
ls /etc/fstab
```



## 补救
- 如果/etc/fstab被删除后，请执行以下命令：
```bash
# blkid
/dev/sda1: UUID="a8fbf99f-407e-4f33-86c4-a983349aaf62" TYPE="xfs"
/dev/sda2: UUID="wB8keG-qwiy-ZAID-zW7M-tZfQ-0mR2-TiB3VD" TYPE="LVM2_member"
/dev/mapper/CentOS-root: UUID="280ae35c-e119-478c-b762-326a356f25e0" TYPE="xfs"
/dev/mapper/CentOS-swap: UUID="6f9182c7-9794-41d3-b01c-825c3274a964" TYPE="swap"
#touch /etc/fstab
#vim  /etc/fstab
/dev/mapper/CentOS-root /                       xfs     defaults        0 0
UUID=a8fbf99f-407e-4f33-86c4-a983349aaf62 /boot                   xfs     defaults        0 0
#reboot
 ```



## 影响


- 无




## 默认值


- 无




## 参考文献


- [黑客入侵应急排查思路&&流程（非官方）](https://www.sohu.com/a/236820450_99899618)



- [记录一次真实的挖矿 入侵排查分析（非官方）](https://www.cnblogs.com/zsl-find/articles/11688640.html)



## CIS 控制


- 无


