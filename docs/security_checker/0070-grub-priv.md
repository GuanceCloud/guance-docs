# 0070-grub-priv-确保已配置引导加载程序配置的权限(-rw-------)
---

## 规则ID

- 0070-grub-priv


## 类别

- system


## 级别

- warn


## 兼容版本


- Linux




## 说明


- GRUB是一个来自GNU项目的多操作系统启动程序。GRUB是多启动规范的实现，它允许用户可以在计算机内同时拥有多个操作系统，并在计算机启动时选择希望运行的操作系统。GRUB可用于选择操作系统分区上的不同内核，也可用于向这些内核传递启动参数。
>



## 扫描频率
- disable

## 理论基础


- grub配置文件包含有关引导设置的信息以及用于解锁引导选项的密码。 grub2配置通常是存储在/boot/grub2/中的grub.cfg。






## 风险项


- 被黑客利用，强行进入系统



## 审计方法
- 运行以下命令，并验证Uid和Gid均为0/ root，并且Access不授予组或其他权限：
>

``` bash
stat /boot/grub2/grub.cfg Access: (0600/-rw-------)
Uid: ( 0/root)
Gid: ( 0/root)
```



## 补救
- 运行以下命令来设置grub配置的所有权和权限：
>

``` bash
chown root:root /boot/grub2/grub.cfg
chmod 600 /boot/grub2/grub.cfg
```



## 影响


- 配置权限后，仅超级用户可以读取该文件。




## 默认值


- 默认情况下，权限是root:root  -rw-------




## 参考文献


- 无



## CIS 控制


- Version 7
>   5.1 Establish Secure Configurations 
>
>   Maintain documented, standard security configuration standards for all authorized operating systems and software.


