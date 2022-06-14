# 0423-k8s-client-ca-kubelet 确保根据需要设置了客户端ca文件参数
---

## 规则ID

- 0423-k8s-client-ca


## 类别

- container


## 级别

- info


## 兼容版本


- Linux




## 说明


- 如果使用Kubelet，使用证书启用Kubelet身份验证



## 扫描频率
- 0 */30 * * *

## 理论基础


- 默认情况下，Kubelet允许所有经过身份验证的请求（甚至是匿名请求），而不需要从发送者进行显式授权检查。您应该限制此行为，因为在不信任和/或公共网络上运行不安全






## 风险项


- 容器安全



## 审计方法
- 执行以下命令以验证：
```bash
ps -ef | grep kubelet |grep client-ca-file
```



## 补救
- 执行下面的命令：
```bash
#> vim /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
```
设置 --client-ca-file=<path/to/client-ca-file>
注意：如果存在--client-ca-file参数 请设置成对应的ca文件路径。
如果不存在这个参数，请检查启动kubelet的参数-config所配置的文件，
并且检查文件中的配置项：authentication: x509: clientCAFile 设置成对应的文件路径。
使用命令行形式启动的kubelet server则 以-config配置的为准

设置完这些参数后并保证无误后 重启kubelet：
```bash
systemctl daemon-reload
systemctl restart kubelet.service
```



## 影响


- 您需要在apiserver上配置TLS。证书文件路径理论上应当是本地的ca证书，一般配置为：/etc/kubernetes/pki/ca.crt




## 默认值


- 默认情况下，--client-ca-file 是没有设置的




## 参考文献


- [kubelet](https://kubernetes.io/docs/admin/kubelet/)



## CIS 控制


- 无


