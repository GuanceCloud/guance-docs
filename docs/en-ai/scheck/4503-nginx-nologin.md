# 4503-nginx-nologin - Ensure the NGINX service account shell is invalid
---

## Rule ID

- 4503-nginx-nologin


## Category

- nginx


## Level

- warn


## Compatible Versions


- Linux




## Description


- The nginx account should not be able to log in, so the shell for this account should be set to /sbin/nologin



## Scan Frequency
- 0 */30 * * *

## Rationale


- The account used for nginx should only be used for the nginx service and does not need login capability. This can prevent attackers from logging in using this account






## Risk Items


- nginx security



## Audit Method
- Run the following command to verify:

```bash
grep nginx /etc/passwd
```



## Remediation
- Execute the following command:
```bash
#> chsh -s /sbin/nologin nginx
```



## Impact


- This ensures that the nginx user account cannot be used by human users




## Default Value


- By default, the shell for the nginx user is /sbin/nologin




## References


- [nginx-user](http://nginx.org/en/docs/ngx_core_module.html#user)



## CIS Controls


- None