# 4508-nginx-defindex-nginx reference to index page should not mention nginx field
---

## Rule ID

- 4508-nginx-defindex


## Category

- NGINX


## Level

- info


## Compatible Versions


- Linux




## Description


- The default error and index.html pages of NGINX indicate that the server is running NGINX. These default pages should be deleted or modified so that they do not advertise the underlying infrastructure of the server.



## Scan Frequency
- 0 */30 * * *

## Theoretical Basis


- By gathering information about the server, attackers can launch attacks targeting known vulnerabilities. Removing pages that reveal the server is running NGINX helps reduce targeted attacks on the server.



## Risk Items


- NGINX security



## Audit Method
- Execute the following commands to verify:

```bash
grep -i nginx /usr/share/nginx/html/index.html
grep -i nginx /usr/share/nginx/html/50x.html
grep -i nginx /usr/share/nginx/html/404.html
# There should be no 'nginx' signature
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


- By default, these files contain nginx fields.




## References


- None



## CIS Controls


- None