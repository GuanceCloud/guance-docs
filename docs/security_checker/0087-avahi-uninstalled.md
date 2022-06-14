# 0087-avahi-uninstalled-Avahi被安装
---

## 规则ID

- 0087-avahi-uninstalled


## 类别

- system


## 级别

- warn


## 兼容版本


- Linux




## 说明


- Avahi是一个免费的零通信实现，包括一个用于多播DNS/DNS-SD服务发现的系统。Avahi允许程序发布和发现运行在本地网络上的服务和主机。例如，用户可以将计算机插入网络，Avahi会自动找到要打印的打印机、要查看的文件和要交谈的人，以及在机器上运行的网络服务。



## 扫描频率
- 0 */30 * * *

## 理论基础


- 系统功能通常不需要自动发现网络服务。建议删除此软件包，以减少潜在的攻击面。






## 风险项


- 增加攻击面



## 审计方法
- 运行以下命令以验证是否未安装对应组件：
```bash
# rpm -q avahi-autoipd avahi
package avahi-autoipd is not installed
package avahi is not installed
```



## 补救
- 运行以下命令以删除对应的包：
```bash
# systemctl stop avahi-daemon.socket avahi-daemon.service
# yum remove avahi-autoipd avahi
```



## 影响


- 对于依赖avahi替代DNS的系统可能会失去域名解析支持




## 默认值


- 无




## 参考文献


- 无



## CIS 控制


- Version 7
    2.6 地址未经批准的软件
    确保删除未经授权的软件，或库存及时更新


