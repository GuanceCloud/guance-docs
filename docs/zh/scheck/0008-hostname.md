# 0008-hostname-主机名被修改
---

## 规则ID

- 0008-hostname


## 类别

- system


## 级别

- warn


## 兼容版本


- Linux



- windows




## 说明


- 监控主机名发生变化



## 扫描频率
- 1 */5 * * *

## 理论基础


- Linux操作系统的hostname是一个kernel变量，可以通过hostname命令来查看本机的hostname。也可以直接cat /proc/sys/kernel/hostname查看。 
，如果主机名设置错误，可能会引起在线业务或应用不能正常访问，甚至会拒绝提供服务。如果主机名被恶意修改，会影响主机系统正常运行。






## 风险项


- 应用拒绝服务



## 审计方法
- 验证主机名是否非法被修改。可以执行以下命令验证：

```bash
hostname
```



## 补救
- 如果主机名被非法修改，使用`hostnamectl set-hostname` 恢复主机名，请勿必仔细查看主机环境，是否被入侵，并且修改主机用户密码。



## 影响


- 无




## 默认值


- 无




## 参考文献


- 无



## CIS 控制


- 无


