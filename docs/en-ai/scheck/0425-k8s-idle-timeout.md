# 0425-k8s-idle-timeout - Ensure streaming connection idle timeout --streaming-connection-idle-timeout parameter is not set to 0
---

## Rule ID

- 0425-k8s-idle-timeout


## Category

- Container


## Level

- Info


## Compatible Versions


- Linux




## Description


- Do not disable the timeout on streaming connections



## Scan Frequency
- 0 */30 * * *

## Theoretical Basis


- Setting an idle timeout ensures protection against denial of service attacks, inactive connections, and exhaustion of ephemeral ports






## Risk Items


- Container Security



## Audit Method
- Execute the following command to verify:
```bash
ps -ef | grep kubelet |grep streaming-connection-idle-timeout
```



## Remediation
- 
kubelet can be started in two ways:
Check if there is a configuration file: /etc/systemd/system/kubelet.service.d/10-kubeadm.conf. If the file exists, set the parameter --streaming-connection-idle-timeout=5m.
If the file does not exist, check the kubelet startup parameter -config,
Open the file and check if the parameter streamingConnectionIdleTimeout exists and set it to 0.
After setting, restart kubelet:
```bash
systemctl daemon-reload
systemctl restart kubelet.service
```



## Impact


- Long-lived connections may be interrupted




## Default Value


- By default: --streaming-connection-idle-timeout is 4 hours




## References


- [kubelet](https://kubernetes.io/docs/admin/kubelet/)



## CIS Controls


- None