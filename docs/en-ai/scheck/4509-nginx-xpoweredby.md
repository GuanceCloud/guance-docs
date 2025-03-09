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

- The `server` and `x-powered-by` headers can specify the underlying technology used by the application. Without explicit instructions, NGINX reverse proxy may pass these headers. To remove them, appropriate configurations should be made.


## Scan Frequency

- 0 */30 * * *


## Theoretical Basis

- Attackers can use these response headers to perform reconnaissance on websites and then target attacks based on specific known vulnerabilities related to the underlying technology. Removing these headers will reduce the likelihood of targeted attacks.


## Risk Items

- NGINX Security


## Audit Method

- Execute the following command to verify:

```bash
grep proxy_hide_header /etc/nginx/nginx.conf
# It should display:
proxy_hide_header X-Powered-By;
# If not present, it is recommended to add it.
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