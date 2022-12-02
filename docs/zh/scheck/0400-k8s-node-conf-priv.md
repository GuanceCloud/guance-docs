# 0400-k8s-node-conf-priv-kubernetes 配置文件权限没有设置为644或更高
---

## 规则ID

- 0400-k8s-node-conf-priv


## 类别

- container


## 级别

- warn


## 兼容版本


- Linux




## 说明


- 如果您在使用systemd管理服务的计算机上使用kubernetes的node节点，请验证kubernetes.service文件权限是否正确设置为644或更严格。



## 扫描频率
- 0 */30 * * *

## 理论基础


- kubernetes.service文件包含可能更改kubernetes守护程序行为的敏感参数。因此，除了root之外的任何其他用户都不应该写它来维护文件的完整性。






## 风险项


- 容器安全



## 审计方法
- 执行以下命令以验证文件权限是否设置为“644”或更严格：

```bash
stat -c %a /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
stat -c %a /etc/kubernetes/kubelet.conf
stat -c %a /var/lib/kubelet/config.yaml
```



## 补救
- 执行下面的命令修改三个配置文件的权限：
```bash
#> chmod 644 /etc/systemd/system/kubelet.service.d/10-kubeadm.conf /etc/kubernetes/kubelet.conf /var/lib/kubelet/config.yaml
```
这会将文件权限设置为“644”。



## 影响


- 无




## 默认值


- 系统上可能不存在此文件。在这种情况下，本建议不适用。默认情况下，如果文件存在，则文件权限将正确设置为644。




## 参考文献


- [kubernetes-kubelet](https://https://kubernetes.io/docs/admin/kubelet/)



## CIS 控制


- 无


