# 0028-fstab-fstab 被修改
---

## 规则ID

- 0028-fstab


## 类别

- system


## 级别

- warn


## 兼容版本


- Linux




## 说明


- 监控主机fstab 文件被修改



## 扫描频率
- disable

## 理论基础


- 文件/etc/fstab存放的是系统中的文件系统信息，如果配置错误，或恶意修改会造成主机无法启动。






## 风险项


- 服务不可用



## 审计方法
- 验证主机/etc/fstab 是否非法被修改。可以执行以下命令验证：

```bash
ls -l /etc/fstab
```



## 补救
- 如果主机/etc/fstab被非法修改，请勿必仔细查看主机环境，是否被入侵，并且修改主机用户密码。
/etc/fstab文件出错,无法进入Linux系统，进入救援模式，修改/etc/fstab文件。



## 影响


- 无




## 默认值


- 无




## 参考文献


- 无



## CIS 控制


- 无


