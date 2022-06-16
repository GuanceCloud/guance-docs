# 0426-k8s-protect-kernel-确保保护内核默认参数设置为true
---

## 规则ID

- 0426-k8s-protect-kernel


## 类别

- container


## 级别

- info


## 兼容版本


- Linux




## 说明


- 保护调优的内核参数不受重写kubelet默认内核参数值



## 扫描频率
- 0 */30 * * *

## 理论基础


- 内核参数通常在将系统投入生产之前，由系统管理员进行调整和硬化。这些参数可以保护整个内核和系统。依赖于这些参数的kubelet内核默认值应该被适当地设置，以匹配所需的安全系统状态。忽略这一点可能会导致运行具有不需要的内核行为的pod






## 风险项


- 容器安全



## 审计方法
- 执行以下命令以验证：
```bash
ps -ef | grep kubelet
```



## 补救
- 
kubelet启动有两种形式
检查是否有配置文件：/etc/systemd/system/kubelet.service.d/10-kubeadm.conf，如果文件存在 将参数 --protect-kernel-defaults=true
如果文件不存在，则kubelet是以命令行形式启动的，检查kubelet启动参数 -config，
打开文件 检查是否存在参数protectKernelDefaults 并设置成 true
设置完成之后 重启kubelet：
```bash
systemctl daemon-reload
systemctl restart kubelet.service
```



## 影响


- 您必须重新调整内核参数以匹配kubelet参数




## 默认值


- 默认情况,protect-kernel-defaults=true




## 参考文献


- [kubelet](https://kubernetes.io/docs/admin/kubelet/)



## CIS 控制


- 无


