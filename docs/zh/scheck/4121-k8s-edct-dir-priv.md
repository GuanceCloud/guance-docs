# 4121-k8s-edct-dir-priv-etcd 数据目录权限没有设置为700或更高
---

## 规则ID

- 4121-k8s-edct-dir-priv


## 类别

- container


## 级别

- info


## 兼容版本


- Linux




## 说明


- 确保etcd数据目录具有700或更多的限制性权限



## 扫描频率
- 0 */30 * * *

## 理论基础


- Etcd是一个高度可用的密钥值存储，Kubernetes部署用于持久存储其所有RESTAPI对象。此数据目录应免受任何未经授权的读写的保护






## 风险项


- 容器安全



## 审计方法
- 执行以下命令以验证文件权限是否设置为“644”或更严格：

```bash
stat -c %a /var/lib/etcd
```



## 补救
- 执行下面的命令修改三个配置文件的权限：
```bash
#> chmod 700 /var/lib/etcd
```
这会将目录权限设置为“700”。



## 影响


- 无




## 默认值


- 默认情况下 /var/lib/etcd 权限是755




## 参考文献


- [kubernetes-etcd](https://kubernetes.io/docs/admin/etcd/)



- [etcd](https://coreos.com/etcd/docs/latest/op-guide/configuration.html#data-dir)



## CIS 控制


- 无


