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

- The nginx account should not be able to log in, so the shell for this account should be set to /sbin/nologin.


## Scan Frequency

- 0 */30 * * *


## Theoretical Basis

- The account used for nginx should only be used for the nginx service and does not need login capabilities. This can prevent attackers from using the account to log in.


## Risk Items

- nginx security


## Audit Method

- Execute the following command to verify:

```bash
grep nginx /etc/passwd
```


## Remediation

- Execute the following command:
```bash
#> chsh -s /sbin/nologin nginx
```


## Impact

- This ensures that the nginx user account cannot be used by human users.


## Default Value

- By default, the shell for the nginx user is /sbin/nologin.


## References

- [nginx-user](http://nginx.org/en/docs/ngx_core_module.html#user)


## CIS Controls

- None