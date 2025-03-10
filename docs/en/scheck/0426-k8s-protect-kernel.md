# 0426-k8s-protect-kernel - Ensure Protect Kernel Defaults is set to true
---

## Rule ID

- 0426-k8s-protect-kernel


## Category

- container


## Level

- info


## Compatible Versions


- Linux




## Description


- Ensure that the kernel parameters protected by tuning are not overwritten by kubelet default kernel parameter values.



## Scan Frequency
- 0 */30 * * *

## Theoretical Basis


- Kernel parameters are typically adjusted and hardened by system administrators before putting the system into production. These parameters can protect the entire kernel and system. The kubelet kernel defaults that depend on these parameters should be properly set to match the desired secure system state. Ignoring this may result in running pods with undesirable kernel behavior.


## Risk Items


- Container Security



## Audit Method
- Execute the following command to verify:
```bash
ps -ef | grep kubelet
```



## Remediation
- 
kubelet can be started in two ways:
Check if there is a configuration file: /etc/systemd/system/kubelet.service.d/10-kubeadm.conf, if the file exists, set the parameter --protect-kernel-defaults=true.
If the file does not exist, then kubelet is started via command line, check the kubelet startup parameter -config,
open the file and check if the parameter protectKernelDefaults exists and set it to true.
After setting, restart kubelet:
```bash
systemctl daemon-reload
systemctl restart kubelet.service
```



## Impact


- You must readjust the kernel parameters to match the kubelet parameters.




## Default Value


- By default, protect-kernel-defaults=true.




## References


- [kubelet](https://kubernetes.io/docs/admin/kubelet/)



## CIS Controls


- None