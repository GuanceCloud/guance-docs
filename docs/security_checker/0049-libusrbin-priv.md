# 0049-libusrbin-priv-/usr/bin目录下有文件权限被修改
---

## 规则ID

- 0049-libusrbin-priv


## 类别

- system


## 级别

- warn


## 兼容版本


- Linux




## 说明


- 监控主机目录/usr/bin下的文件权限是否被修改



## 扫描频率
- disable

## 理论基础


- /usr/bin目录放置的是系统基本的关键命令的可执行文件，如果权限发生改变，可能会导致命令无法执行，对系统造成影响。






## 风险项


- 功能不可用



## 审计方法
- 对指定文件运行以下命令，这里以users文件为例，并验证Uid和Gid均为0/ root，权限为755：

```bash
stat /usr/bin/users
Access: (0755/-rwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
```



## 补救
- 如果检测到/usr/bin目录下文件权限已被变更，可通过root用户登录该服务器后将该权限进行修复，并审计本次变更。



## 影响


- 无




## 默认值


- 无




## 参考文献


- 无



## CIS 控制


- 无


