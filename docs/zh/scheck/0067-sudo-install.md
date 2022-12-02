# 0067-sudo-install-sudo 没有安装
---

## 规则ID

- 0067-sudo-install


## 类别

- system


## 级别

- warn


## 兼容版本


- Linux




## 说明


- sudo是linux系统管理指令，是允许系统管理员让普通用户执行一些或者全部的root命令的一个工具，如halt，reboot，su等等。这样不仅减少了root用户的登录 和管理时间，同样也提高了安全性。sudo不是对shell的一个代替，它是面向每个命令的。



- 注意：visudo以类似于vipw（8）的安全方式编辑sudoers文件。 visudo锁定sudoers文件以防止同时进行多次编辑，提供基本的完整性检查并检查解析错误。如果当前用户正在编辑sudoers文件，您将收到一条提示消息，稍后再试。



## 扫描频率
- 0 */30 * * *

## 理论基础


- 更好的分配用户权限，减少root用户的管理操作。提高了系统的安全性。






## 风险项


- root管理操作增加，系统安全性大大降低。



## 审计方法
- 验证是否已安装sudo。 运行以下命令：

``` bash
# rpm -q sudo
sudo-<VERSION>
```



## 补救
- 运行以下命令以安装sudo。

``` bash
# yum install sudo
```



## 影响


- 安装完成后，可以根据业务需求向普通用户给予业务权限，尽量避免root用户关系操作




## 默认值


- 默认情况安装了sudo




## 参考文献


- 无



## CIS 控制


- Version 7
    >   4 Controlled Use of Administrative Privileges
    >
    >   Controlled Use of Administrative Privileges


