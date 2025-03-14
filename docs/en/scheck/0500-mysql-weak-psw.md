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

- MySQL is one of the best relational database management systems and is among the most popular RDBMS used in web applications. Due to the simple password setting for the MySQL root account, it can be easily cracked, allowing intruders to obtain the password and gain high privileges.


## Scan Frequency

- 1 1 1 * *


## Theoretical Basis

- The password for the MySQL root account is too simple and lacks complexity, making it easy to crack. If not detected and handled in time, this can lead to data breaches and other issues.


## Risk Items

- Data Breach

- Data Extortion


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