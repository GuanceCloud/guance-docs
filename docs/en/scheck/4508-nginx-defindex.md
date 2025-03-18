# 4508-nginx-defindex-nginx Reference to index Page Should Not Include nginx Field
---

## Rule ID

- 4508-nginx-defindex


## Category

- nginx


## Level

- info


## Compatible Versions


- Linux




## Description


- The default error and index.html pages of NGINX display that the server is running NGINX. These default pages should be deleted or modified so they do not advertise the underlying server infrastructure.



## Scan Frequency
- 0 */30 * * *

## Theoretical Basis


- By gathering information about the server, attackers can target known vulnerabilities. Removing pages that reveal the server is running NGINX helps reduce targeted attacks on the server.



## Risk Items


- nginx Security



## Audit Method
- Execute the following commands to verify:

```bash
grep -i nginx /usr/share/nginx/html/index.html
grep -i nginx /usr/share/nginx/html/50x.html
grep -i nginx /usr/share/nginx/html/404.html
# Output should not contain 'nginx' signature
```



## Remediation
- 
Edit these files:
/usr/share/nginx/html/index.html 
/usr/share/nginx/html/50x.html
/usr/share/nginx/html/404.html
Remove lines and fields related to nginx.



## Impact


- None




## Default Values


- By default, these files contain the nginx field.




## References


- None



## CIS Controls


- None