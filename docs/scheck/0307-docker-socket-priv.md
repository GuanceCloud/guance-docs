# 0307-docker-socket-priv-docker.socket文件权限没有设置为644或更严格
---

## 规则ID

- 0307-docker-socket-priv


## 类别

- container


## 级别

- warn


## 兼容版本


- Linux




## 说明


- 如果在使用systemd管理服务的计算机上使用Docker，请验证'Docker.socket'文件所有权和组所有权是否正确设置为'root'。



## 扫描频率
- 0 */30 * * *

## 理论基础


- docker.socket文件包含可能改变docker远程API行为的敏感参数。因此，它应该只能由root写入，以保持文件的完整性。






## 风险项


- 容器安全



## 审计方法
- 执行以下命令以验证文件权限是否正确设置为“644”或更严格：

```bash
stat -c %a /usr/lib/systemd/system/docker.socket
```
上述命令不应返回任何内容。



## 补救
- 执行下面的命令：
```bash
#> chmod 644 /usr/lib/systemd/system/docker.socket
```
这会将此文件的文件权限设置为“644”。



## 影响


- 无




## 默认值


- 系统上可能不存在此文件。在这种情况下，本建议不适用。默认情况下，如果文件存在，则此文件的文件权限将正确设置为'644'。




## 参考文献


- [docker-unix-socket](https://docs.docker.com/articles/basics/#bind-docker-to-another-hostport-or-a-unix-socket)



- [docker-fedora-atomic-packer](https://github.com/YungSang/fedora-atomic-packer/blob/master/oem/docker.socket)



- [docker-on-boot](http://daviddaeschler.com/2014/12/14/centos-7rhel-7-and-docker-containers-on-boot/)



## CIS 控制


- 无


