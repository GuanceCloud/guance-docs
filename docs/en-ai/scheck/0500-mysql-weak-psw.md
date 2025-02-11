# 0500-mysql-weak-psw-Exist MySQL Weak Password
---

## Rule ID

- 0500-mysql-weak-psw


## Category

- db


## Level

- warn


## Compatible Versions

- Linux


## Description

- MySQL is one of the best relational database management systems (RDBMS) and is widely used in web applications. Due to simple password settings for the MySQL root account, it is easy to be cracked, allowing intruders to obtain the password and gain high privileges.


## Scanning Frequency

- 1 1 1 * *


## Theoretical Basis

- If the password for the MySQL root account is too simple and lacks complexity, it can be easily cracked. If not detected and handled in time, this can lead to data breaches and other issues.


## Risk Items

- Data leakage

- Data ransom


## Audit Method

- Run the following command to verify:
```bash
mysql -u root -p
```


## Remediation

- Run the following commands to change the password:
```bash
mysql -u root
mysql> SET PASSWORD FOR "root"@"localhost" = PASSWORD("newpass");
```


## Impact

- None.


## Default Values

- None.


## References

- [Reproduction and Exploitation of MySQL Weak Password Vulnerability](https://www.freebuf.com/162036.html)

- [Best Practices for Enhancing Login Password Security](https://tech.antfin.com/docs/2/184613)


## CIS Controls

- None