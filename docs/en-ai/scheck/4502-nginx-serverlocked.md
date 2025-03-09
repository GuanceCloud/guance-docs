# 4502-nginx-serverlocked - Ensure NGINX service account is locked
---

## Rule ID

- 4502-nginx-serverlocked


## Category

- nginx


## Level

- warn


## Compatible Versions


- Linux




## Description


- The NGINX user account should have a valid password, but the account should be locked to prevent login and unauthorized access.



## Scan Frequency
- 0 */30 * * *

## Rationale


- As a defense-in-depth measure, the NGINX user account should be locked to prevent login and prevent anyone from switching users to NGINX using a password. Generally, no one needs to su as NGINX; sudo should be used instead when necessary, which does not require the NGINX account password.



## Risk Items


- NGINX security



## Audit Method
- Run the following command to verify that the file and group are owned by NGINX:

```bash
passwd -S nginx
## It should resemble one of the following results:
# nginx LK 2010-01-28 0 99999 7 -1 (Password locked.)
# or
# nginx L 07/02/2012 -1 -1 -1 -1
```



## Remediation
- Run the following command to lock the user:
```bash
#> passwd -l nginx
```



## Impact


- This ensures that the NGINX user account cannot be used by human users.




## Default Value


- By default, the NGINX user account is typically locked.




## References


- [NGINX User](http://nginx.org/en/docs/ngx_core_module.html#user)



## CIS Controls


- None