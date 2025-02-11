# 4132-k8s-apiserver-anonymous - Disable Anonymous Requests to API Server
---

## Rule ID

- 4132-k8s-apiserver-anonymous


## Category

- Container


## Level

- Info


## Compatible Versions


- Linux




## Description


- Disable anonymous requests to the API server



## Scan Frequency
- 0 */30 * * *

## Theoretical Basis


- The API server should rely on authentication. If you are using RBAC authorization, it is generally considered reasonable to allow anonymous access to the API server for health checks and discovery purposes. However, the risks that anonymous access poses to the service should also be considered.



## Risk Items


- Container Security



## Audit Method
- Execute the following command to verify:
```bash
ps -ef | grep kube-apiserver |grep anonymous-auth
```



## Remediation
- The kubelet version must not be lower than v1.16.0.
Execute the following command:
```bash
#> vim /etc/kubernetes/manifests/kube-apiserver.yaml
```
Set or add the parameter --anonymous-auth=false



## Impact


- You must readjust the kernel parameters to match the kubelet parameters




## Default Value


- By default, anonymous access is enabled.




## References


- [kube-apiserver](https://kubernetes.io/docs/admin/kube-apiserver/)



## CIS Controls


- None