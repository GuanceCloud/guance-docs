# 4510-nginx-accesslog - Ensure NGINX Enables Access Log Recording
---

## Rule ID

- 4510-nginx-accesslog


## Category

- nginx


## Level

- info


## Compatible Versions


- Linux




## Description


- Each core site should have an access_log directive. It is enabled by default.



## Scan Frequency
- 0 */30 * * *

## Theoretical Basis


- Access log recording allows incident responders and auditors to investigate system access permissions when events occur






## Risk Items


- NGINX security



## Audit Method
- Execute the following command to verify:

```bash
grep -ir access_log /etc/nginx
# The output should be
access_log /var/log/nginx/host.access.log main;
# If the output is as follows, it is recommended to close and add a log path
access_log off;

```



## Remediation
- 
Edit the file /etc/nginx/nginx.conf example:
```bash
access_log /var/log/nginx/host.access.log main;
```



## Impact


- None




## Default Value


- By default, access logging is enabled




## References


- None



## CIS Controls


- None