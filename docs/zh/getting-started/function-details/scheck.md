# 使用Scheck实现安全巡检
---

## 概述
观测云为用户提供了一键发现恶意程序、系统漏洞、安全缺陷的安全巡检功能。即通过「安全巡检」，您不但可以及时的发现主机、系统、容器、网络等存在的漏洞和异常，还可以发现一些日常管理问题（例如：将数据通过网络 IO 泄露给外部）

本文将为您介绍观测云是如何使用 Scheck 实现安全巡检。

## 前置条件

您需要先创建一个 [观测云账号](https://www.guance.com)，并在您的主机上 [安装 DataKit](../../datakit/datakit-install.md) ，以及 [安装Scheck](../../scheck/scheck-install.md) 。

## 安全可观测

### 模拟黑客入侵操作

-  登录主机终端

![](../img/8.scheck_1.png)

-  模拟添加用户和添加crontab记录  
```python
useradd xlsm
crontab -e
```

### 登录观测云查看安全巡检信息并分析
可以看到12/19 18:52 添加了一个用户，遇到这个问题，我们该如何处理？

![](../img/8.scheck_2.png)

点击记录查看建议进行主机补救

![](../img/8.scheck_3.png)

在主机控制台执行命令：

```powershell
userdel xlsm
```


