# 0080-issue.net-priv-issue.net不是644
---

## 规则ID

- 0080-issue.net-priv


## 类别

- system


## 级别

- warn


## 兼容版本


- Linux




## 说明


- 在从配置的服务进行远程连接登录之前，/etc/issue.net文件的内容将显示给用户。



## 扫描频率
- 1 */5 * * *

## 理论基础


- 如果/etc/issue.net文件没有正确的所有权，则未经授权的用户可能会使用错误或误导性信息对其进行修改。






## 风险项


- 黑客渗透



- 数据泄露



- 挖矿风险



- 肉机风险



## 审计方法
- 运行以下命令并验证Uid和Gid均为0/root，Access为644：

```bash
 # stat /etc/issue.net
Access: (0644/-rw-r--r--) Uid: ( 0/ root) Gid: ( 0/ root)
```



## 补救
- 运行以下命令以设置对/etc/issue.net的权限：
```bash
 # chown root:root /etc/issue.net
# chmod u-x,go-wx /etc/issue.net
```



## 影响


- 无




## 默认值


- 无




## 参考文献


## CIS 控制


- Version 7
 14.6通过访问控制列表保护信息
    使用文件系统、网络共享、声明、应用程序或特定于数据库的访问控制列表保护存储在系统上的所有信息。这些控制措施将执行一项原则，即只有经授权的个人才有权访问作为其职责一部分的信息。


