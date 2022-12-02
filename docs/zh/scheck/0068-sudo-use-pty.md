# 0068-sudo-use-pty-sudo命令未使用pty
---

## 规则ID

- 0068-sudo-use-pty


## 类别

- system


## 级别

- warn


## 兼容版本


- Linux




## 说明


- 攻击者可以使用sudo运行恶意程序（例如病毒或恶意软件），这将再次分叉保留在用户的终端设备上的后台进程，即使在主程序已经完成执行时。
>   
>   为了避免这种情况，您可以将sudo配置为仅使用use_pty参数从psuedo-pty运行其他命令，无论I /O日志是否已打开。



## 扫描频率
- 0 */30 * * *

## 理论基础


- 攻击者可以使用sudo运行恶意程序，该程序会再次启动一个后台进程，即使主程序执行完毕，该后台进程仍会保留。
>   可以通过将sudo配置为仅从伪pty运行其他命令来缓解这种情况。






## 风险项


- 被黑客利用sudo运行恶意程序



## 审计方法
- 验证sudo只能从伪pty运行其他命令运行以下命令：

``` bash
grep -Ei "^\s*Defaults\s+([^#]\S+,\s*)?use_pty\b" /etc/sudoers /etc/sudoers.d/*

Defaults use_pty
```



## 补救
- 使用visudo或visudo -f <PATH TO FILE>编辑文件/ etc/sudoers并添加以下行：默认为use_pty

``` bash
Defaults use_pty
```



## 影响


- 配置sudo使用pty后，可以有效解决被黑客利用sudo运行恶意程序




## 默认值


- 默认情况下没有配置




## 参考文献


- [Linux中设置’sudo’的5个小技巧（非官方）](https://jingyan.baidu.com/article/47a29f24753254c0142399df.html) 



## CIS 控制


- Version 7
>   4 Controlled Use of Administrative Privileges 
>
>   Controlled Use of Administrative Privileges


