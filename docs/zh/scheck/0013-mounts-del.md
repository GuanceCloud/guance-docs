# 0013-mounts-del-路径被卸载
---

## 规则ID

- 0013-mounts-del


## 类别

- storage


## 级别

- warn


## 兼容版本


- Linux




## 说明


- 监控主机路径被卸载



## 扫描频率
- 1 */5 * * *

## 理论基础


- 一个绑定挂载就是相关目录树的另外一个视图。典型情况下，挂载会为存储设备创建树状的视图。而绑定挂载则是把一个现有的目录树复制到另外一个挂载点下。通过绑定挂载得到的目录和文件与原始的目录和文件是一样的，无论从挂载目录还是原始目录执行的变更操作都会立即反映在另外一端。简单的说就是可以将任何一个挂载点、普通目录或者文件挂载到其它的地方。如果被恶意卸载，会造成数据不完整和服务不可用。






## 风险项


- 数据不一致



- 服务不可用



## 审计方法
- 验证路径被卸载。可以执行以下命令验证查看：

```bash
mount
```



## 补救
- 如果主新路径被恶意卸载，请勿必仔细查看主机环境，防止服务不可用。



## 影响


- 无




## 默认值


- 无




## 参考文献


- [黑客入侵应急排查思路&&流程（非官方）](https://www.sohu.com/a/236820450_99899618)



- [记录一次真实的挖矿 入侵排查分析（非官方）](https://www.cnblogs.com/zsl-find/articles/11688640.html)



## CIS 控制


- 无

