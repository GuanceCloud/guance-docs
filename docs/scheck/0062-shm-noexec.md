# 0062-shm-noexec-/dev/shm分区没有上设置noexec选项
---

## 规则ID

- 0062-shm-noexec


## 类别

- system


## 级别

- warn


## 兼容版本


- Linux




## 说明


- noexec挂载选项指定文件系统不能包含可执行二进制文件
>



- 注意：/dev/shm是由systemd自动挂载的。但即使/dev/shm已经在启动时被挂载，它依然需要在
    >
    >   /etc/fstab中 添加挂载选项。



## 扫描频率
- 0 */30 * * *

## 理论基础


- 在文件系统上设置此选项将阻止用户从共享内存中执行程序。
    >
    >   这可以阻止用户在系统上引入潜在的恶意软件






## 风险项


- 黑客渗透



- 数据泄露



- 挖矿风险



- 肉机风险



## 审计方法
- 运行如下命令查看是否设置了noexec选项:

```bash
# mount | grep -E "\s/dev/shm\s" | grep -v noexec
Nothing should be returned
```



## 补救
- 编辑/etc/fstab文件，将noexec添加到/dev/shm分区挂载选项中的第四个字段。
有关更多信息，请参阅fstab(5)手册页。
执行如下命令重新挂载/dev/shm。
```bash
# mount -o remount,noexec,nodev,nosuid /dev/shm
```



## 影响


- 无




## 默认值


- 无




## 参考文献


## CIS 控制


- Version 7

> 2.6 处理未经批准的软件
>
> 确保未经授权的软件被删除或目录被及时更新
>
> 13 数据保护
>
> 数据保护


