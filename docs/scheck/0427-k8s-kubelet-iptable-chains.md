# 0427-k8s-kubelet-iptable-chains-允许Kubelet管理信息iptables
---

## 规则ID

- 0427-k8s-kubelet-iptable-chains


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


- Kubelets可以根据您如何为pod选择您的网络选项，自动管理对信息表所需的更改。建议让kubelet对iptables进行更改。这确保表配置与pod网络配置保持同步。您自己配置可能对ip表规则限制太严格或太开放






## 风险项


- 容器安全



## 审计方法
- 执行以下命令以验证：
```bash
ps -ef | grep kubelet
```



## 补救
- kubelet启动有两种形式
检查是否有配置文件：/etc/systemd/system/kubelet.service.d/10-kubeadm.conf，如果文件存在 将参数 --make-iptables-util-chains=true
如果文件不存在，则kubelet是以命令行形式启动的，检查kubelet启动参数 -config，
打开文件 检查是否存在参数makeIPTablesUtilChains 并设置成 true

设置完成之后 重启kubelet：
```bash
systemctl daemon-reload
systemctl restart kubelet.service
```



## 影响


- 避免和您设置的iptable造成冲突，也可让kubernetes对iptable进行管理




## 默认值


- 默认情况下：--make-iptables-util-chains=ture




## 参考文献


- [kubelet](https://kubernetes.io/docs/admin/kubelet/)



## CIS 控制


- 无


