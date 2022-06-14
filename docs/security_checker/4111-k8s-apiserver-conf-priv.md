# 4111-k8s-apiserver-conf-priv-apiserver 配置文件权限没有设置为644或更高
---

## 规则ID

- 4111-k8s-apiserver-conf-priv


## 类别

- container


## 级别

- warn


## 兼容版本


- Linux




## 说明


- 如果您在使用systemd管理服务的计算机上使用kubernetes的apiserver，请验证kubernetes.service文件权限是否正确设置为644或更严格。



## 扫描频率
- 0 */30 * * *

## 理论基础


- kubernetes.apiserver文件包含可能更改kubernetes守护程序行为的敏感参数。因此，除了root之外的任何其他用户都不应该写它来维护文件的完整性。






## 风险项


- 容器安全



## 审计方法
- 执行以下命令以验证文件权限是否设置为“644”或更严格：

```bash
stat -c %a /etc/kubernetes/manifests/kube-apiserver.yaml
```



## 补救
- 执行下面的命令修改三个配置文件的权限：
```bash
#> chmod 644 /etc/kubernetes/manifests/kube-apiserver.yaml
```
这会将文件权限设置为“644”。



## 影响


- 无




## 默认值


- 默认情况下 kube-apiserver.yaml 权限是640




## 参考文献


- [kubernetes-apiserver](https://kubernetes.io/docs/admin/kube-apiserver/)



## CIS 控制


- 无


