# 0500-mysql-weak-psw-存在mysql弱密码
---

## 规则ID

- 0500-mysql-weak-psw


## 类别

- db


## 级别

- warn


## 兼容版本


- Linux




## 说明


- MySQL是最好的关系型数据库管理系统，是最流行的关系型数据库管理系统之一，在web应用方面MySQL是最好的RDBMS应用软件。由于MySQL root账户的password设置简单，很容易被爆破成功，从而很容易被入侵者获得密码，并获得高权限



## 扫描频率
- 1 1 1 * *

## 理论基础


- MySQL的root账户的密码过于简单，复杂度不够，很容易被破解。如果，不及时发现和处理，会造成数据泄露等问题。






## 风险项


- 数据泄露



- 数据勒索



## 审计方法
- 运行以下命令以验证：
```bash
mysql -u root -p
```



## 补救
- 运行以下命令修改密码：
```bash
mysql -u root
mysql> SET PASSWORD FOR "root"@"localhost" = PASSWORD("newpass");
```



## 影响


- 无。




## 默认值


- 无




## 参考文献


- [MySQL弱口令漏洞的重现和利用](https://www.freebuf.com/162036.html)



- [提升登录口令安全最佳实践](https://tech.antfin.com/docs/2/184613)



## CIS 控制


- 无


