# 0081-gdm-config-GDM没有被删除或没有配置登录
---

## 规则ID

- 0081-gdm-config


## 类别

- system


## 级别

- warn


## 兼容版本


- Linux




## 说明


- GDM是GNOME显示管理器，用于处理基于GNOME的系统的图形登录。



## 扫描频率
- 1 */5 * * *

## 理论基础


- 如果不需要图形化登录，则应将其删除以减少系统的攻击面。如果需要图形化登录，则应禁用上次登录的用户显示，并配置警告横幅。
显示上次登录的用户可以消除未经授权的用户需要登录的用户ID/密码等式的一半。
警告消息通知试图登录到系统的用户其有关系统的法律状态，并且必须包括拥有该系统的组织的名称和任何已实施的监视策略。
笔记：
其他选项和部分可能出现在/etc/dconf/db/gdm.d/01-banner-message文件中。
如果正在使用其他GUI登录服务，并且系统上需要该服务，请参阅文档以禁用显示上次登录的用户并应用等效的横幅。






## 风险项


- 网络安全



## 审计方法
- 运行以下命令以验证系统上未安装gdm：
```bash
 # rpm -q gdm
package gdm is not installed
```
或者
如果需要GDM：
验证/etc/dconf/profile/gdm是否存在，并包括以下内容：
```bash
user-db:user
system-db:gdm file-db:/usr/share/gdm/greeter-dconf-defaults
```
验证文件是否存在于/etc/dconf/db/gdm.d/中，并包含以下内容：（这通常是/etc/dconf/db/gdm.d/01-banner-message）
```bash
[org/gnome/login-screen]
banner-message-enable=true
banner-message-text='<banner message>'
```
验证文件是否存在于/etc/dconf/db/gdm.d/中，并包含以下内容：（这通常是/etc/dconf/db/gdm.d/00-login-screen）
```bash
[org/gnome/login-screen]
disable-user-list=true
```



## 补救
- 运行以下命令删除gdm
```bash
# yum remove gdm
```
或者
如果需要GDM：
编辑或创建文件/etc/dconf/profile/gdm并添加以下内容：
```bash
user-db:user
system-db:gdm
file-db:/usr/share/gdm/greeter-dconf-defaults
```
编辑或创建文件/etc/dconf/db/gdm.d/，并添加以下内容：（这通常是/etc/dconf/db/gdm.d/01-banner-message）
```bash
 [org/gnome/login-screen]
banner-message-enable=true
banner-message-text='<banner message>'
```
示例横幅文本：“仅授权使用。编辑或创建文件/etc/dconf/db/gdm.d/，并添加以下内容：（这通常是/etc/dconf/db/gdm.d/00-login-screen）
```bash
[org/gnome/login-screen]
# Do not show the user list
disable-user-list=true
```
运行以下命令以更新系统数据库：
```bash
# dconf update
```



## 影响


- 无




## 默认值



## 参考文献


- 无



## CIS 控制


- 版本7
5.1建立安全配置
为所有授权的操作系统和软件维护文档化的标准安全配置标准。


