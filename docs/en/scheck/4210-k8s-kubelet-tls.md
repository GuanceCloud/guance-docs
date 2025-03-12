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


- None



## Scan Frequency
- 0 */30 * * *

## Theoretical Basis


- Not setting up a TLS connection can lead to insecure operations on untrusted and/or public networks, making it susceptible to man-in-the-middle attacks. You should set --tls-cert-file=<path/to/tls-certificate-file> --tls-private-key-file=<path/to/tls-key-file>






## Risk Items


- Container Security



## Audit Method
- Execute the following command to verify:
```bash
ps -ef | grep kubelet
```



## Remediation
- The kubelet version must not be lower than v1.16.0.
Execute the following command:
```bash
#> vim /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
```
Set or add parameters --tls-cert-file and --tls-private-key-file.
Note: If the --tls-cert-file parameter exists, set it to the corresponding CA file path.
If this parameter does not exist, check the configuration file specified by the -config parameter used to start kubelet,
and ensure that the tlsCertFile and tlsPrivateKeyFile settings in the file are set to the correct file paths.
If the kubelet server is started via command line, follow the configuration specified by -config.

After setting these parameters and ensuring they are correct, restart kubelet as shown below:
```bash
systemctl daemon-reload
systemctl restart kubelet.service



## Impact


- None




## Default Value


- By default: certificate locations are not configured.




## References


- [kubelet](https://kubernetes.io/docs/admin/kubelet/)



## CIS Controls


- None