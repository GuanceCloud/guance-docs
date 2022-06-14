# 0004-user-passwd-exist-主机/etc/passwd不存在
---

## 规则ID

- 0004-user-passwd-exist


## 类别

- system


## 级别

- critical


## 兼容版本


- Linux




## 说明


- 监控主机/etc/passwd是否存在



## 扫描频率
- 1 */5 * * *

## 理论基础


- 在Linux 中 /etc/passwd文件中每个用户都有一个对应的记录行，它记录了这个用户的一些基本属性。系统管理员经常会接触到这个文件的修改以完成对用户的管理工作。/etc/passwd被删除会造成主机无法登录，属于恶意破坏。






## 风险项


- 黑客渗透



- 数据泄露



## 审计方法
- 验证主机/etc/passwd是否存在。可以执行以下命令验证：

```bash
ls /etc/passwd
```



## 补救
- 如果/etc/passwd被删除后未重启系统，可以执行以下命令补救：
```bash
cp /etc/passwd
/etc/passwd
```
如果我们在删除文件后关闭了系统，打开的时候会发现进不去
>
>
在GRUB引导的时候按e进入编辑模式，linux16那一行的ro 修改为rw rd.break
>
>
ctrl+x执行
>
>
进入单用户模式后修改根路径，将引子程序拷进来
>
>     ```bash
>     chroot /sysroot
>
>     cp /etc/passwd
/etc/passwd
>     ```
>
>
因为拷贝进来文件的安全上下文和当亲目录不匹配，那么我们需要关闭selinux
>
>     ```bash
>     vim /etc/sysconfig/selinux
>
>     selinux = disabled
>     ```
>
>
两次exit退出现在的根并且重启主机，恢复正常



## 影响


- 无




## 默认值


- 无




## 参考文献


- [黑客入侵应急排查思路&&流程（非官方）](https://www.sohu.com/a/236820450_99899618)



- [记录一次真实的挖矿 入侵排查分析（非官方）](https://www.cnblogs.com/zsl-find/articles/11688640.html)



## CIS 控制


- 无


