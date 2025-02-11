# 4504-nginx-ownership-/etc/nginx Directory and Its Files Should Be Owned by Root
---

## Rule ID

- 4504-nginx-ownership


## Category

- nginx


## Level

- warn


## Compatible Versions

- Linux


## Description

- The nginx account should not be able to log in, so the account should be set to /sbin/nologin.


## Scan Frequency

- 0 */30 * * *


## Rationale

- The account used for nginx should only be used for the nginx service and should not have the ability to log in. This prevents attackers from using the account to log in.


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