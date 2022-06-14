# 0034-ssh-keys-authorized_keys公钥差异变化
---

## 规则ID

- 0034-ssh-keys


## 类别

- system


## 级别

- warn


## 兼容版本


- Linux




## 说明


- 监控主机authorized_keys公钥差异变化



## 扫描频率
- 0 */30 * * *

## 理论基础


- authorized_keys 是ssh 免密登录的关键文件，如果被恶意添加key，会造成数据泄露或黑客渗透。






## 风险项


- 黑客渗透



- 数据泄露



- 网络安全



- 挖矿风险



- 肉机风险



## 审计方法
- 验证主机authorized_keys是否非法被修改。可以执行以下命令验证：

```bash
ls /root/.ssh/authorized_keys && ls /home/*/.ssh/authorized_keys
```



## 补救
- 如果主机authorized_keys被非法修改，请勿必仔细查看主机环境，是否被入侵，并且修改主机用户密码。



## 影响


- 无




## 默认值


- 无




## 参考文献


- [黑客入侵应急排查思路&&流程（非官方）](https://www.sohu.com/a/236820450_99899618)



- [记录一次真实的挖矿 入侵排查分析（非官方）](https://www.cnblogs.com/zsl-find/articles/11688640.html)



## CIS 控制


- 无


