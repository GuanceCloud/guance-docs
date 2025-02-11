# Ensure --rotate-certificates Parameter Is Not Set to False for 4211-k8s-kubelet-rotate
---

## Rule ID

- 4211-k8s-kubelet-rotate


## Category

- Container


## Level

- Info


## Compatible Versions

- Linux


## Description

- Enable kubelet client certificate rotation


## Scan Frequency

- 0 */30 * * *


## Theoretical Basis

- This ensures that the kubelet replaces its client certificate by creating a new CSR when its existing certificate expires, ensuring cluster availability and addressing certificate usability.


## Risk Items

- Container Security


## Audit Method

- Execute the following command to verify:
```bash
ps -ef | grep kubelet | grep rotate-certificates
```


## Remediation

- The kubelet version must be no lower than v1.16.0.
Execute the following command:
```bash
#> vim /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
```
Set or add the parameter `--rotate-certificates=true` or remove `--rotate-certificates=false`.


## Impact

- You must reset the certificate parameters to ensure the security and availability of the kubelet operation.


## Default Value

- By default: `--rotate-certificates=true`


## References

- [kubelet](https://github.com/kubernetes/kubernetes/pull/41912)

- [kubelet-configuration](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet-tls-bootstrapping/#kubelet-configuration)


## CIS Controls

- None