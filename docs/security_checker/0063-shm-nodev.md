# 0063-shm-nodev-确保在/dev/shm分区上设置nodev选项
---

## 规则ID

- 0063-shm-nodev


## 类别

- system


## 级别

- warn


## 兼容版本


- Linux




## 说明


- nodev挂载选项指定文件系统不能包含特殊设备。



- 注意：/dev/shm是由systemd自动挂载的。但即使/dev/shm已经在启动时被挂载，它依然需要在/etc/fstab中 添加挂载选项。



## 扫描频率
- 0 */30 * * *

## 理论基础


- 因为/dev/shm文件系统并非意在用于支持设备，所以设置此选项以确保用户不能尝试在/dev/shm分区中创建特殊的设备






## 风险项


- 黑客渗透



- 数据泄露



- 挖矿风险



- 肉机风险



## 审计方法
- 运行如下命令查看是否设置了nodev选项:

```bash
# mount | grep -E "\s/dev/shm\s" | grep -v nodev
Nothing should be returned
```



## 补救
- 编辑/etc/fstab文件，将nodev添加到/dev/shm分区挂载选项中的第四个字段。
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
  **5.1建立安全配置**
  维护所有授权操作系统和软件的文档化、标准的安全配置标准。
  **13 数据保护**
  数据保护


