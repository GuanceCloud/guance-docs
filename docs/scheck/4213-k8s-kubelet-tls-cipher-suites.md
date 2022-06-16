# 4213-k8s-kubelet-tls-cipher-suites-确保Kubelet被配置为只使用加强型加密密码
---

## 规则ID

- 4213-k8s-kubelet-tls-cipher-suites


## 类别

- container


## 级别

- info


## 兼容版本


- Linux




## 说明


- 确保Kubelet被配置为只使用强加密密码



## 扫描频率
- 0 */30 * * *

## 理论基础


- TLS密码有许多已知的漏洞和弱点，这样的防护不是很安全，kubernetes本身支持很多类型的加密方式和加密套件，可以加强保护程序安全






## 风险项


- 容器安全



## 审计方法
- 执行以下命令以验证：
```bash
ps -ef | grep kubelet | grep tls-cipher-suites
```



## 补救
- kubelet 版本要求不能低于v1.16.0
执行下面的命令：
```bash
#> vim /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
```
设置或添加参数 --tls-cipher-suites=TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305,TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305,TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384,TLS_RSA_WITH_AES_256_GCM_SHA384,TLS_RSA_WITH_AES_128_GCM_SHA256
如果是配置文件启动的 查看kubelet启动参数 -config 并修改文件中的tls-cipher-suites:TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
,TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305,TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
,TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305,TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
,TLS_RSA_WITH_AES_256_GCM_SHA384,TLS_RSA_WITH_AES_128_GCM_SHA256
设置完成后 重启服务：
```bash
systemctl daemon-reload
systemctl restart kubelet.service
```



## 影响


- 不能支持现代加密密码的Kubelet客户端将无法连接到KubeletAPI




## 默认值


- 默认情况下，KubernetesAPI服务器支持广泛的TLS密码




## 参考文献


- [kubelet](https://github.com/kubernetes/kubernetes/pull/41912)



## CIS 控制


- 无


