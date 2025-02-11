# 0426-k8s-protect-kernel - Ensure Kernel Protection Parameters Are Set to True by Default
---

## Rule ID

- 0426-k8s-protect-kernel


## Category

- Container


## Level

- Info


## Compatible Versions


- Linux




## Description


- Ensure that the kernel parameters for protection are not overwritten by kubelet's default kernel parameter values.



## Scan Frequency
- 0 */30 * * *

## Theoretical Basis


- Kernel parameters are typically adjusted and hardened by system administrators before a system is put into production. These parameters can protect the entire kernel and system. The kubelet kernel defaults, which depend on these parameters, should be properly set to match the required secure system state. Ignoring this may result in running pods with undesirable kernel behavior.


## Risk Items


- Container Security



## Audit Method
- Execute the following command to verify:
```bash
ps -ef | grep kubelet
```



## Remediation
- 
kubelet can start in two ways:
Check if there is a configuration file: `/etc/systemd/system/kubelet.service.d/10-kubeadm.conf`. If the file exists, set the parameter `--protect-kernel-defaults=true`.
If the file does not exist, then kubelet starts via command line, check the kubelet startup parameter `-config`,
Open the file and check if the parameter `protectKernelDefaults` exists and set it to true.
After setting, restart kubelet:
```bash
systemctl daemon-reload
systemctl restart kubelet.service
```



## Impact


- You must reconfigure the kernel parameters to match the kubelet parameters.




## Default Value


- By default, `protect-kernel-defaults=true`




## References


- [kubelet](https://kubernetes.io/docs/admin/kubelet/)



## CIS Controls


- None