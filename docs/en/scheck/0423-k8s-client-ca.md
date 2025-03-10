# Ensure Client CA File Parameter is Set According to Needs for Kubelet

---

## Rule ID

- 0423-k8s-client-ca


## Category

- Container


## Level

- Info


## Compatible Versions

- Linux


## Description

- If using Kubelet, enable Kubelet authentication using certificates.


## Scan Frequency
- 0 */30 * * *


## Theoretical Basis

- By default, Kubelet allows all authenticated requests (even anonymous requests) without requiring explicit authorization checks from the sender. You should restrict this behavior, especially when running on untrusted and/or public networks.


## Risk Items

- Container Security


## Audit Method

- Execute the following command to verify:
```bash
ps -ef | grep kubelet |grep client-ca-file
```


## Remediation

- Execute the following commands:
```bash
#> vim /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
```
Set `--client-ca-file=<path/to/client-ca-file>`
Note: If the `--client-ca-file` parameter exists, set it to the corresponding CA file path.
If this parameter does not exist, check the configuration file specified by the `-config` parameter used to start Kubelet,
and ensure that the configuration item `authentication: x509: clientCAFile` is set to the correct file path.
For Kubelet servers started via command line, follow the configuration specified by `-config`.

After setting these parameters and ensuring they are correct, restart Kubelet:
```bash
systemctl daemon-reload
systemctl restart kubelet.service
```


## Impact

- You need to configure TLS on the API server. The certificate file path should theoretically be a local CA certificate, typically configured as: `/etc/kubernetes/pki/ca.crt`.


## Default Value

- By default, `--client-ca-file` is not set.


## References

- [kubelet](https://kubernetes.io/docs/admin/kubelet/)


## CIS Controls

- None