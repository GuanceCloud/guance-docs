# 4507-nginx-servertoken - Ensure server_tokens Directive is Set to `off`
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


- Attackers can use these response headers to perform reconnaissance on the website and then conduct targeted attacks based on specific known vulnerabilities related to the underlying technology. Hiding this version information slows down attackers and prevents some potential attacks.



## Risk Items


- Nginx Security



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


- By default, the server_tokens directive is set to `on`




## References


- None



## CIS Controls


- None