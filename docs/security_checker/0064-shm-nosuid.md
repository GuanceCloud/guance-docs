# 0064-shm-nosuid-/dev/shm分区上没有设置nosuid选项
---

## 规则ID

- 0064-shm-nosuid


## 类别

- system


## 级别

- warn


## 兼容版本


- Linux




## 说明


- nosuid挂载选项指定文件系统不能包含setuid文件
>



- 注意：/dev/shm是由systemd自动挂载的。但即使/dev/shm已经在启动时被挂载，它依然需要在
    >
    >   /etc/fstab中 添加挂载选项。



## 扫描频率
- 0 */30 * * *

## 理论基础


- 在文件系统上设置此选项可以防止用户将特权程序引入系统，并允许非根用户执行这些程序






## 风险项


- 黑客渗透



- 数据泄露



- 挖矿风险



- 肉机风险



## 审计方法
- 运行如下命令查看是否设置了nosuid选项:

```bash
# mount | grep -E "\s/dev/shm\s" | grep -v nosuid
Nothing should be returned
```



## 补救
- 编辑/etc/fstab文件，将nosuid添加到/dev/shm分区挂载选项中的第四个字段。
有关更多信息，请参阅fstab(5)手册页。
执行如下命令重新挂载/dev/shm。
```bash
# mount -o remount,noexec,nodev,nosuid /dev/shm
```



## 影响


- 无




## 默认值



## 参考文献


## CIS 控制


- Version 7

> **5.1建立安全配置**
>
> 维护所有授权操作系统和软件的文档化、标准的安全配置标准。
>
> **13 数据保护**
>
> 数据保护


