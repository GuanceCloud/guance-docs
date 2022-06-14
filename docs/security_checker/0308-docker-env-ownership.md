# 0308-docker-env-ownership-docker环境文件所有权没有设置为root:root
---

## 规则ID

- 0308-docker-env-ownership


## 类别

- container


## 级别

- warn


## 兼容版本


- Linux




## 说明


- docker守护程序利用Docker环境文件设置Docker守护程序运行时环境。如果在使用systemd管理服务的计算机上使用Docker，则文件为/etc/sysconfig/Docker。在其他系统上，环境文件为/etc/default/docker。验证环境文件所有权和组所有权是否正确设置为root”。



## 扫描频率
- 0 */30 * * *

## 理论基础


- docker环境文件包含敏感参数，这些参数可能会在运行时改变Docker守护程序的行为。因此，它应该由root”拥有，组应该由root”拥有，以保持文件的完整性。






## 风险项


- 容器安全



## 审计方法
- 执行以下命令以验证环境文件是否为root”所有，组是否为root”所有：

```bash
stat -c %U:%G /etc/sysconfig/docker | grep -v root:root
```
上述命令不应返回任何内容。



## 补救
- 执行下面的命令：
```bash
#> chown root:root /etc/sysconfig/docker
```
这会将环境文件的所有权和组所有权设置为root”。



## 影响


- 无




## 默认值


- 默认情况下，此文件的所有权和组所有权正确设置为root。




## 参考文献


- [systemd](https://docs.docker.com/articles/systemd/)



## CIS 控制


- 无


