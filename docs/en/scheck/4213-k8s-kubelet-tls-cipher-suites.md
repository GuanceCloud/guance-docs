# 4213-k8s-kubelet-tls-cipher-suites - Ensure Kubelet is configured to use only strengthened encryption ciphers
---

## Rule ID

- 4213-k8s-kubelet-tls-cipher-suites


## Category

- container


## Level

- info


## Compatible Versions


- Linux




## Description


- Ensure Kubelet is configured to use only strong encryption ciphers



## Scan Frequency
- 0 */30 * * *

## Theoretical Basis


- TLS ciphers have many known vulnerabilities and weaknesses, which do not provide robust security. Kubernetes supports various types of encryption methods and cipher suites that can enhance the security of applications.



## Risk Items


- Container Security



## Audit Method
- Execute the following command to verify:
```bash
ps -ef | grep kubelet | grep tls-cipher-suites
```



## Remediation
- The kubelet version must be no lower than v1.16.0.
Execute the following commands:
```bash
#> vim /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
```
Set or add the parameter --tls-cipher-suites=TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305,TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305,TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384,TLS_RSA_WITH_AES_256_GCM_SHA384,TLS_RSA_WITH_AES_128_GCM_SHA256
If it is started via a configuration file, check the kubelet startup parameter -config and modify the tls-cipher-suites in the file: TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305,TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305,TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384,TLS_RSA_WITH_AES_256_GCM_SHA384,TLS_RSA_WITH_AES_128_GCM_SHA256
After setting, restart the service:
```bash
systemctl daemon-reload
systemctl restart kubelet.service
```



## Impact


- Kubelet clients that do not support modern encryption ciphers will be unable to connect to the Kubelet API



## Default Value


- By default, the Kubernetes API server supports a wide range of TLS ciphers



## References


- [kubelet](https://github.com/kubernetes/kubernetes/pull/41912)



## CIS Controls


- None