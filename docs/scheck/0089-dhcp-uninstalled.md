# 0089-dhcp-uninstalled-DHCP被安装
---

## 规则ID

- 0089-dhcp-uninstalled


## 类别

- system


## 级别

- warn


## 兼容版本


- Linux




## 说明


- 动态主机配置协议(DHCP)是一种允许为计算机动态分配IP地址的服务。



## 扫描频率
- 0 */30 * * *

## 理论基础


- 除非系统被专门设置为充当DHCP服务器，否则建议删除dhcp软件包，以减少潜在的攻击面






## 风险项


- 增加被攻击风险



## 审计方法
- 运行以下命令以验证是否未安装对应组件：
```bash
# rpm -q dhcp
package dhcp is not installed
```



## 补救
- 运行以下命令以删除对应的包：
```bash
# yum remove dhcp
```



## 影响


- 集群内服务器有一定风险无法自动获得服务器分配的IP地址和子网掩码。




## 默认值


- 无




## 参考文献


- 无



## CIS 控制


- Version 7
    2.6 地址未经批准的软件
    确保删除未经授权的软件，或库存及时更新


