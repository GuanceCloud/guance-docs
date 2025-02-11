# 4509-nginx-xpoweredby - Ensure NGINX Reverse Proxy Does Not Enable Information Disclosure
---

## Rule ID

- 4509-nginx-xpoweredby


## Category

- nginx


## Level

- info


## Compatible Versions

- Linux


## Description

- The headers `server` and `x-powered-by` can specify the underlying technology used by the application. If not explicitly configured, an NGINX reverse proxy might pass these headers. To prevent this, they should be removed.


## Scan Frequency

- 0 */30 * * *


## Theoretical Basis

- Attackers can use these response headers to gather information about the website and then target known vulnerabilities associated with the underlying technology. Removing these headers reduces the likelihood of targeted attacks.


## Risk Items

- nginx security


## Audit Method

- Execute the following command to verify:

```bash
grep proxy_hide_header /etc/nginx/nginx.conf
# It should display
proxy_hide_header X-Powered-By;
# If it does not exist, it is recommended to add it.
```


## Remediation

- 
Edit the file `/etc/nginx/nginx.conf` and add the header information as shown below:
```bash
location /docs {
....
proxy_hide_header X-Powered-By;
proxy_hide_header Server;
....
}
```


## Impact

- None


## Default Value

- By default, this configuration does not exist.


## References

- None


## CIS Controls

- None