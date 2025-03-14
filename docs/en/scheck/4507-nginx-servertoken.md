# 4507-nginx-servertoken - Ensure server_tokens Directive Is Set to `off`
---

## Rule ID

- 4507-nginx-servertoken


## Category

- nginx


## Level

- info


## Compatible Versions

- Linux


## Description

- The server_tokens directive controls the display of the NGINX version number and operating system version in error pages and the Server HTTP response header field. This information should not be exposed.


## Scan Frequency
- 0 */30 * * *


## Rationale

- Attackers can use these response headers to perform reconnaissance on the website and then target attacks based on specific known vulnerabilities related to the underlying technology. Hiding this version information can slow down and deter some potential attackers.


## Risk Items

- nginx security


## Audit Method
- Execute the following command to verify:

```bash
curl -I 127.0.0.1 | grep -i server
# If the result is as follows, it is recommended to turn off server_token
Server: nginx/1.14.0
```


## Remediation
- Execute the following commands:
To disable the server_tokens directive, set it to `off` within the server block in nginx.conf:
```bash
server {
 ...
 server_tokens off;
 ...
}
```


## Impact

- None


## Default Value

- By default, server_tokens is enabled.


## References

- None


## CIS Controls

- None