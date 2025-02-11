# 4514-nginx-openhttp2 - Recommendation to Enable HTTP/2.0 (Suggestions that do not affect security)

---

## Rule ID

- 4514-nginx-openhttp2


## Category

- nginx


## Level

- info


## Compatible Versions

- Linux


## Description

- Session resumption for HTTPS sessions should be disabled to achieve Perfect forward secrecy (PFS). This ensures stronger encryption and security benefits.


## Scan Frequency

- 0 */30 * * *


## Theoretical Basis

- HTTP/2.0, through full multiplexing, not only improves performance but also enhances security. HTTP/2.0 updates the requirements and blacklists of cipher suites. It also disables session renegotiation and TLS compression, which helps prevent vulnerabilities such as CRIME and ensures stronger encryption capabilities.


## Risk Items

- nginx security


## Audit Method

- Execute the following command to verify:

```bash
grep -ir http2 /etc/nginx
# Output should include the following content
listen 443 ssl http2;
```


## Remediation

- 
Edit the file `/etc/nginx/nginx.conf` or any other file related to HTTPS configuration. Example:
```bash
server {
 listen 443 ssl http2;
}
```


## Impact

- None


## Default Value

- By default, the highest enabled protocol is HTTP/1.1


## References

- [server-side-tls](https://mozilla.github.io/server-side-tls/ssl-config-generator/)


## CIS Controls

- None