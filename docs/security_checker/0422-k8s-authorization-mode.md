# 0422-k8s-authorization-mode-kubelet 确保授权模式参数设置的不是：AlwaysAllow
---

## 规则ID

- 0422-k8s-authorization-mode


## 类别

- container


## 级别

- warn


## 兼容版本


- Linux




## 说明


- 如果使用Kubelet配置文件，请编辑该文件以将授权：模式设置为Webhook



## 扫描频率
- 0 */30 * * *

## 理论基础


- 默认情况下，Kubelets允许所有经过身份验证的请求（甚至是匿名请求），而不需要从发送者进行显式授权检查。您应该限制此行为，并且只允许显式授权的请求






## 风险项


- 容器安全



## 审计方法
- 执行以下命令以验证：
```bash
ps -ef | grep kubelet |grep authorization-mode
```



## 补救
- 执行下面的命令：
```bash
#> vim /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
```
设置 --authorization-mode=Webhook
注意：如果存在--authorization-mode参数 请设置成Webhook。
如果不存在这个参数，请检查启动kubelet的参数-config所配置的文件，
并且检查文件中的配置项：authorization: mode 检查并设置成Webhook。
设置完这些参数后并保证无误后 重启kubelet：
```bash
systemctl daemon-reload
systemctl restart kubelet.service
```



## 影响


- 无




## 默认值


- 默认情况下，--authorization-mode 参数设置为AlwaysAllow




## 参考文献


- [kubelet](https://kubernetes.io/docs/admin/kubelet/)



## CIS 控制


- 无


