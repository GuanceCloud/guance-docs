# 0424-k8s-readonlyport-kubelet 验证只读端口参数是否设置为0
---

## 规则ID

- 0424-k8s-readonlyport


## 类别

- container


## 级别

- info


## 兼容版本


- Linux




## 说明


- 禁用只读端口



## 扫描频率
- 0 */30 * * *

## 理论基础


- Kubelet过程除了提供了一个主要的KubeletAPI外，还提供了一个只读API。对此只读API提供了未经身份验证的访问权限，它可能会检索到有关集群的潜在敏感信息






## 风险项


- 容器安全



## 审计方法
- 执行以下命令以验证：
```bash
ps -ef | grep kubelet |grep read-only-port
```



## 补救
- kubelet启动有两种形式
检查是否有配置文件：/etc/systemd/system/kubelet.service.d/10-kubeadm.conf，如果文件存在 将参数 --read-only-port=0
如果文件不存在，检查kubelet启动参数 -config，
打开文件 检查是否存在参数readOnlyPort 并设置成 0
设置完成之后 重启kubelet：
```bash
systemctl daemon-reload
systemctl restart kubelet.service
```



## 影响


- 无




## 默认值


- 默认情况下或没有设置，系统默认为：read-only-port=10255/TCP




## 参考文献


- [kubelet](https://kubernetes.io/docs/admin/kubelet/)



## CIS 控制


- 无


