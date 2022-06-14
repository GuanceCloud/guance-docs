# 4122-k8s-etcd-dir-ownership-k8s-etcd文件所有权没有设置为etcd:etcd
---

## 规则ID

- 4122-k8s-etcd-dir-ownership


## 类别

- container


## 级别

- warn


## 兼容版本


- Linux




## 说明


- 如果在使用systemd管理服务的计算机上使用k8s-etcd，请验证k8s-etcd文件所有权和组所有权是否正确设置为etcd。



## 扫描频率
- 0 */30 * * *

## 理论基础


- k8s-etcd文件包含可能更改k8s-etcd守护程序行为的敏感参数。因此，它应该由root拥有，组应该由root拥有，以保持文件的完整性。






## 风险项


- 容器安全



## 审计方法
- 执行以下命令以验证文件和组是否归root所有：

```bash
stat -c %U:%G /var/lib/etcd
```
上述命令不应返回任何内容。



## 补救
- 执行下面的命令：
```bash
#> chown etcd:etcd /var/lib/etcd
```
这会将文件的所有权和组所有权设置为root。



## 影响


- 无




## 默认值


- 系统上可能不存在此文件。在这种情况下，本建议不适用。默认情况下，如果文件存在，则此文件的所有权和组所有权将正确设置为root:root




## 参考文献


- [etcd](https://coreos.com/etcd)



- [kubernetes-etcd](https://kubernetes.io/docs/admin/etcd/)



## CIS 控制


- 无


