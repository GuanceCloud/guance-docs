# 0022-sshd-restart-sshd 服务被重启
---

## 规则ID

- 0022-sshd-restart


## 类别

- system


## 级别

- critical


## 兼容版本


- Linux




## 说明


- 监控sshd服务被重启



## 扫描频率
- disable

## 理论基础


- 在linux系统操作中，经常需要连接其他的主机，连接其他主机的服务是openssh-server，它的功能是让远程主机可以通过网络访问sshd服务。sshd服务被重启，可能被恶意修改了sshd配置。






## 风险项


- 黑客渗透



- 数据泄露



- 网络安全



- 挖矿风险



- 肉机风险



## 审计方法
- 验证主机sshd服务被重启。可以执行以下命令验证：

```bash
systemctl status sshd
```



## 补救
- 如果sshd服务被重启，查看/etc/ssh 下所有配置文件，请勿必仔细查看主机环境，是否被入侵，并且修改主机用户密码。



## 影响


- 无




## 默认值


- 无




## 参考文献


- 无



## CIS 控制


- 无


