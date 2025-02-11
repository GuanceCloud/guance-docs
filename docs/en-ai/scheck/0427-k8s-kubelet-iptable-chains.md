# 0427-k8s-kubelet-iptable-chains-Allow Kubelet to Manage Information iptables
---

## Rule ID

- 0427-k8s-kubelet-iptable-chains


## Category

- Container


## Level

- Info


## Compatible Versions


- Linux




## Description


- Protect tuned kernel parameters from being overwritten by default Kubelet kernel parameter values



## Scan Frequency
- 0 */30 * * *

## Theoretical Basis


- Kubelets can automatically manage the required changes to the information table based on how you choose your network options for pods. It is recommended to allow kubelet to make changes to iptables. This ensures that table configurations remain synchronized with pod network configurations. Configuring it yourself may result in iptable rules that are either too restrictive or too permissive






## Risk Items


- Container Security



## Audit Method
- Execute the following command to verify:
```bash
ps -ef | grep kubelet
```



## Remediation
- There are two ways to start kubelet:
Check if there is a configuration file: /etc/systemd/system/kubelet.service.d/10-kubeadm.conf. If the file exists, set the parameter --make-iptables-util-chains=true.
If the file does not exist, then kubelet was started via command line, check the kubelet startup parameter -config,
Open the file and check if the parameter makeIPTablesUtilChains exists and set it to true.

After setting, restart kubelet:
```bash
systemctl daemon-reload
systemctl restart kubelet.service
```



## Impact


- Avoid conflicts with iptables settings you have configured and allow Kubernetes to manage iptables



## Default Value


- By default: --make-iptables-util-chains=true




## References


- [kubelet](https://kubernetes.io/docs/admin/kubelet/)



## CIS Control


- None