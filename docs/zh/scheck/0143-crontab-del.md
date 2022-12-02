# 0143-crontab-del-crontab定时任务被删除
---

## 规则ID

- 0143-crontab-del


## 类别

- system


## 级别

- warn


## 兼容版本


- Linux




## 说明


- crontab定时任务被删除



## 扫描频率
- disable

## 理论基础


- 主机是否删除crontab定时任务，如果主机删除未知crontab定时任务，会造成主机的信息安全泄露，所以需要在审计范围内






## 风险项


- 黑客渗透



- 数据泄露



- 网络安全



- 挖矿风险



- 肉机风险



## 审计方法
- 验证主机是否删除crontab定时任务。可以执行以下命令验证：

```bash
cat /etc/passwd | cut -f 1 -d : |xargs -I {} crontab -l -u {}
```



## 补救
- 如果主机删除crontab定时任务，请勿必仔细查看用户crontab定时任务，如果存在可疑crontab定时任务，请删除。
```bash
crontab -e
```



## 影响


- 无




## 默认值


- 无




## 参考文献


- 无



## CIS 控制


- 无


