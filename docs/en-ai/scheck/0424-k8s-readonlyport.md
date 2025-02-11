# 0424-k8s-readonlyport-kubelet Verify if the Read-Only Port Parameter is Set to 0
---

## Rule ID

- 0424-k8s-readonlyport


## Category

- Container


## Level

- Info


## Compatible Versions


- Linux




## Description


- Disable the read-only port



## Scan Frequency
- 0 */30 * * *

## Theoretical Basis


- In addition to providing a primary Kubelet API, the Kubelet process also provides a read-only API. This read-only API allows unauthenticated access, which may retrieve potentially sensitive information about the cluster.



## Risk Items


- Container Security



## Audit Method
- Execute the following command to verify:
```bash
ps -ef | grep kubelet | grep read-only-port
```



## Remediation
- There are two ways to start kubelet:
Check if there is a configuration file: `/etc/systemd/system/kubelet.service.d/10-kubeadm.conf`. If the file exists, set the parameter `--read-only-port=0`.
If the file does not exist, check the kubelet startup parameter `-config`,
Open the file and check if the parameter `readOnlyPort` exists and set it to 0.
After completing the settings, restart kubelet:
```bash
systemctl daemon-reload
systemctl restart kubelet.service
```



## Impact


- None




## Default Value


- By default or if not set, the system defaults to: `read-only-port=10255/TCP`




## References


- [kubelet](https://kubernetes.io/docs/admin/kubelet/)



## CIS Control


- None