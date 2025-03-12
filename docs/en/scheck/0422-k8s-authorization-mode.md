# 0422-k8s-authorization-mode-kubelet Ensure Authorization Mode Parameter Is Not Set to: AlwaysAllow
---

## Rule ID

- 0422-k8s-authorization-mode


## Category

- Container


## Level

- Warn


## Compatible Versions

- Linux


## Description

- If using a Kubelet configuration file, edit the file to set the authorization mode to Webhook.


## Scan Frequency
- 0 */30 * * *

## Theoretical Basis

- By default, Kubelets allow all authenticated requests (even anonymous requests) without requiring explicit authorization checks from the sender. You should restrict this behavior and only allow explicitly authorized requests.


## Risk Items

- Container Security


## Audit Method
- Execute the following command to verify:
```bash
ps -ef | grep kubelet |grep authorization-mode
```


## Remediation
- Execute the following commands:
```bash
#> vim /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
```
Set --authorization-mode=Webhook.
Note: If the --authorization-mode parameter exists, set it to Webhook. If this parameter does not exist, check the file configured by the -config parameter when starting kubelet, and ensure the configuration item: authorization: mode is set to Webhook.
After setting these parameters and ensuring they are correct, restart kubelet:
```bash
systemctl daemon-reload
systemctl restart kubelet.service
```


## Impact

- None


## Default Value

- By default, the --authorization-mode parameter is set to AlwaysAllow.


## References

- [kubelet](https://kubernetes.io/docs/admin/kubelet/)


## CIS Controls

- None