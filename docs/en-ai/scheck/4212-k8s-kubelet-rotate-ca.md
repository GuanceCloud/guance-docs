# 4212-k8s-kubelet-rotate-ca - Ensure kubelet starts with certificates set to auto-renew mode
---

## Rule ID

- 4212-k8s-kubelet-rotate-ca


## Category

- Container


## Level

- Info


## Compatible Versions


- Linux




## Description


- Enable the kubelet client certificate rotation



## Scan Frequency
- 0 */30 * * *

## Theory


- This ensures that kubelet replaces its client certificate by creating a new CSR when its existing certificate expires, ensuring that the cluster remains available and solving the issue of certificate expiration.



## Risk Items


- Container Security



## Audit Method
- Execute the following command to verify:
```bash
ps -ef | grep kubelet | grep RotateKubeletServerCertificate
```



## Remediation
- The kubelet version must be no lower than v1.16.0.
Execute the following command:
```bash
#> vim /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
```
Set or add the parameter `--RotateKubeletServerCertificate=true` or remove `--RotateKubeletServerCertificate=false`



## Impact


- You must reset the certificate parameters to ensure the security and availability of the kubelet operation




## Default Value


- By default: `--RotateKubeletServerCertificate=true`




## References


- [kubelet](https://github.com/kubernetes/kubernetes/pull/41912)

- [kubelet-configuration](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet-tls-bootstrapping/#kubelet-configuration)



## CIS Control


- None