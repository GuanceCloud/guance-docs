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


- Enable the kubelet client certificate



## Scan Frequency
- 0 */30 * * *

## Theoretical Basis


- This ensures that when its existing certificate expires, kubelet replaces its client certificate by creating a new CSR. This prevents cluster unavailability due to expired certificates and ensures certificate availability.



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
Set or add the parameter --RotateKubeletServerCertificate=true or remove --RotateKubeletServerCertificate=false



## Impact


- You must reset the certificate parameters to ensure the security and availability of kubelet operation.




## Default Value


- By default: --RotateKubeletServerCertificate=true




## References


- [kubelet](https://github.com/kubernetes/kubernetes/pull/41912)

- [kubelet-configuration](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet-tls-bootstrapping/#kubelet-configuration)



## CIS Control


- None