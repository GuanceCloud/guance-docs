# 4511-nginx-errorlog - Ensure NGINX Enables Error Access Logging
---

## Rule ID

- 4511-nginx-errorlog


## Category

- nginx


## Level

- info


## Compatible Versions


- Linux




## Description


- NGINX should log all error logs. It is enabled by default.



## Scan Frequency
- 0 */30 * * *

## Theoretical Basis


- Error logging can be used to identify attackers attempting to exploit the system and recreate the steps taken by the attacker. Error logging also helps identify issues that may arise in the application






## Risk Items


- NGINX security



## Audit Method
- Execute the following command to verify:

```bash
grep error_log /etc/nginx/nginx.conf
# The output should be
error_log /var/log/nginx/error.log info;

```



## Remediation
- 
Edit the file /etc/nginx/nginx.conf as follows:
```bash
error_log /var/log/nginx/error.log info;
```



## Impact


- None




## Default Value


- By default, access logging is enabled




## References


- None



## CIS Controls


- None