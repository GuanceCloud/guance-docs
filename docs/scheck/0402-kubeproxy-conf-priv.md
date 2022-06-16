# 0402-kubeproxy-conf-priv-proxy kubeconfig file权限没有设置为644或更高
---

## 规则ID

- 0402-kubeproxy-conf-priv


## 类别

- container


## 级别

- warn


## 兼容版本


- Linux




## 说明


- 如果您在使用systemd管理服务的计算机上使用kube-proxy，请验证proxy kubeconfig file文件权限是否正确设置为644或更严格。



## 扫描频率
- 0 */30 * * *

## 理论基础


- kube-proxy文件包含可能更改kube-proxy守护程序行为的敏感参数。因此，除了root之外的任何其他用户都不应该写它来维护文件的完整性。






## 风险项


- 容器安全



## 审计方法
- 执行以下命令以验证文件权限是否设置为“644”或更严格：

```bash
stat -c %a /var/lib/kube-proxy/config.conf
```



## 补救
- 执行下面的命令：
```bash
#> chmod 644 /var/lib/kube-proxy/config.conf
```
这会将文件权限设置为“644”。



## 影响


- 无




## 默认值


- 系统上可能不存在此文件。在这种情况下，本建议不适用。默认情况下，如果文件存在，则文件权限将正确设置为644。




## 参考文献


- [kube-proxy](https://kubernetes.io/docs/admin/kube-proxy/)



## CIS 控制


- 无


