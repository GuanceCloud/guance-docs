# 4211-k8s-kubelet-rotate-确保--rotate-certificates参数没有设置为false
---

## 规则ID

- 4211-k8s-kubelet-rotate


## 类别

- container


## 级别

- info


## 兼容版本


- Linux




## 说明


- 启用kubelet客户端证书



## 扫描频率
- 0 */30 * * *

## 理论基础


- 会使kubelet在其现有证书到期时通过创建新的csr来替换其客户端证书，确保不会因为证书到期导致集群不可用，从而解决证书的可用性。






## 风险项


- 容器安全



## 审计方法
- 执行以下命令以验证：
```bash
ps -ef | grep kubelet | grep rotate-certificates
```



## 补救
- kubelet 版本要求不能低于v1.16.0
执行下面的命令：
```bash
#> vim /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
```
设置或添加参数 --rotate-certificates=true 或者删除 --rotate-certificates=false



## 影响


- 您必须重新设置证书参数以确保kubelet运行的安全性和可用性




## 默认值


- 默认情况下：--rotate-certificates=true




## 参考文献


- [kubelet](https://github.com/kubernetes/kubernetes/pull/41912)



- [kubelet-configuration](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet-tls-bootstrapping/#kubelet-configuration)



## CIS 控制


- 无


