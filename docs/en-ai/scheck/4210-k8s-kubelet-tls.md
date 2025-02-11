# 4210-k8s-kubelet-tls - Setting up TLS Connections on Kubernetes Systems
---

## Rule ID

- 4210-k8s-kubelet-tls


## Category

- Container


## Level

- Warn


## Compatible Versions


- Linux




## Description


- N/A



## Scan Frequency
- 0 */30 * * *

## Theoretical Basis


- Not setting up a TLS connection can lead to insecure operation on untrusted and/or public networks, making it susceptible to man-in-the-middle attacks. You can set `--tls-cert-file=<path/to/tls-certificate-file>` and `--tls-private-key-file=<path/to/tls-key-file>`.



## Risk Items


- Container Security



## Audit Method
- Execute the following command to verify:
```bash
ps -ef | grep kubelet
```



## Remediation
- The kubelet version must be no lower than v1.16.0.
Execute the following commands:
```bash
#> vim /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
```
Set or add parameters `--tls-cert-file` and `--tls-private-key-file`.
Note: If the `--tls-cert-file` parameter exists, set it to the corresponding CA file path.
If this parameter does not exist, check the configuration file specified by the `-config` parameter used to start kubelet,
and ensure that the `tlsCertFile` and `tlsPrivateKeyFile` settings are set to the appropriate file paths.
If the kubelet server is started via command line, follow the configurations specified by `-config`.

After setting these parameters and ensuring they are correct, restart kubelet as follows:
```bash
systemctl daemon-reload
systemctl restart kubelet.service



## Impact


- N/A




## Default Values


- By default: certificate locations are not configured.




## References


- [kubelet](https://kubernetes.io/docs/admin/kubelet/)



## CIS Controls


- N/A