# 0425-k8s-idle-timeout-确保流连接空闲超时 --streaming-connection-idle-timeout参数未设置为0
---

## 规则ID

- 0425-k8s-idle-timeout


## 类别

- container


## 级别

- info


## 兼容版本


- Linux




## 说明


- 不要禁用流媒体连接上的超时时间



## 扫描频率
- 0 */30 * * *

## 理论基础


- 设置空闲超时可以确保您免受拒绝服务攻击、非活动连接和短暂端口的耗尽






## 风险项


- 容器安全



## 审计方法
- 执行以下命令以验证：
```bash
ps -ef | grep kubelet |grep streaming-connection-idle-timeout
```



## 补救
- 
kubelet启动有两种形式
检查是否有配置文件：/etc/systemd/system/kubelet.service.d/10-kubeadm.conf，如果文件存在 将参数 --streaming-connection-idle-timeout=5m
如果文件不存在，检查kubelet启动参数 -config，
打开文件 检查是否存在参数streamingConnectionIdleTimeout 并设置成 0
设置完成之后 重启kubelet：
```bash
systemctl daemon-reload
systemctl restart kubelet.service
```



## 影响


- 长期使用的连接可能会被中断




## 默认值


- 默认情况下：--streaming-connection-idle-timeout是4小时




## 参考文献


- [kubelet](https://kubernetes.io/docs/admin/kubelet/)



## CIS 控制


- 无


