# 4132-k8s-apiserver-anonymous-禁用对apiserver的匿名请求
---

## 规则ID

- 4132-k8s-apiserver-anonymous


## 类别

- container


## 级别

- info


## 兼容版本


- Linux




## 说明


- 禁用对API服务器的匿名请求



## 扫描频率
- 0 */30 * * *

## 理论基础


- apiserver 应当依赖于身份验证。如果您正在使用RBAC授权，那么通常认为允许匿名访问API服务器以进行运行状况检查和发现的目的是合理的，但是也应当考虑匿名访问对服务会造成一定的风险






## 风险项


- 容器安全



## 审计方法
- 执行以下命令以验证：
```bash
ps -ef | grep kube-apiserver |grep anonymous-auth
```



## 补救
- kubelet 版本要求不能低于v1.16.0
执行下面的命令：
```bash
#> vim 	/etc/kubernetes/manifests/kube-apiserver.yaml
```
设置或添加参数 --anonymous-auth=false



## 影响


- 您必须重新调整内核参数以匹配kubelet参数




## 默认值


- 默认情况,是开启匿名访问的




## 参考文献


- [kube-apiserver](https://kubernetes.io/docs/admin/kube-apiserver/)



## CIS 控制


- 无


