# 0310-docker-runlike-获取docker 运行时的run参数
---

## 规则ID

- 0310-docker-runlike


## 类别

- container


## 级别

- warn


## 兼容版本


- Linux




## 说明


- Docker守护程序利用Docker环境文件设置Docker守护程序运行时环境。如果在使用systemd管理服务的计算机上使用Docker，则文件为/etc/sysconfig/Docker。在其他系统上，环境文件为/etc/default/docker。验证环境文件权限是否正确设置为“644”或更严格。



## 扫描频率
- 0 */30 * * *

## 理论基础


- Docker环境文件包含敏感参数，这些参数可能会在运行时改变Docker守护程序的行为。因此，它应该只能由“root”写入，以保持文件的完整性。






## 风险项


- 容器安全



## 审计方法
- 执行以下命令以验证环境文件权限是否设置为“644”或更严格：

```bash
stat -c %a /etc/sysconfig/docker
```



## 补救
- 执行下面的命令：
```bash
#> chmod 644 /etc/sysconfig/docker
```
这会将环境文件的文件权限设置为“644”。



## 影响


- 无




## 默认值


- 默认情况下，此文件的文件权限正确设置为“644”。




## 参考文献


- [systemd](https://docs.docker.com/articles/systemd/)



## CIS 控制


- 无


