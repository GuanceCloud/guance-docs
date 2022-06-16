# 4210-k8s-kubelet-tls-在kubernetes系统上设置TLS连接
---

## 规则ID

- 4210-k8s-kubelet-tls


## 类别

- container


## 级别

- warn


## 兼容版本


- Linux




## 说明


- 无



## 扫描频率
- 0 */30 * * *

## 理论基础


- 未设置tls连接会导致在不信任和/或公共网络运行不安全，容易受到中间人攻击。您可设置 --tls-cert-file=<path/to/tls-certificate-file> --tls-private-key-file=<path/to/tls-key-file>






## 风险项


- 容器安全



## 审计方法
- 执行以下命令以验证：
```bash
ps -ef | grep kubelet
```



## 补救
- kubelet 版本要求不能低于v1.16.0
执行下面的命令：
```bash
#> vim /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
```
设置或添加参数 --tls-cert-file 和 --tls-private-key-file
注意：如果存在--tls-cert-file参数 请设置成对应的ca文件路径。
如果不存在这个参数，请检查启动kubelet的参数-config所配置的文件，
并且检查文件中的配置项：tlsCertFile和tlsPrivateKeyFile 设置成对应的文件路径。
如果使用命令行形式启动的kubelet server则， 以-config配置的为准

设置完这些参数后并保证无误后 重启kubelet 示例：
```bash
systemctl daemon-reload
systemctl restart kubelet.service



## 影响


- 无




## 默认值


- 默认情况下：不会配置证书位置




## 参考文献


- [kubelet](https://kubernetes.io/docs/admin/kubelet/)



## CIS 控制


- 无


