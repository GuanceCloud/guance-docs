# 4516-nginx-browserSecurity - It is recommended to add browser security configuration
---

## Rule ID

- 4516-nginx-browserSecurity


## Category

- nginx


## Level

- info


## Compatible Versions


- Linux




## Description


- The X-Frame-Options header should be set to allow specific websites or no websites to embed your site as an object within their own sites, depending on your organizational policy and application requirements.

- The X-Content-Type-Options header should be used to force supporting user agents to check the content type header of the HTTP response against the expected content from the request target.

- The X-XSS-Protection header allows you to leverage browser-based protection against cross-site scripting. This should be implemented on your web server to protect users and enhance trust in the site. Your policy should set this to blocking mode whenever possible to ensure that the browser blocks the page when cross-site scripting is detected.



## Scan Frequency
- 0 */30 * * *

## Theoretical Basis


- Setting X-Frame-Options, X-Content-Type-Options, and X-XSS-Protection helps secure your website. Please modify according to the actual program requirements!






## Risk Items


- nginx security



## Audit Method
- 
To verify the current settings of the X-Frame-Options, X-Content-Type-Options, and X-XSS-Protection headers:
```bash
grep -ir X-Xss-Protection /etc/nginx
# Output should include
add_header X-Xss-Protection "1; mode=block";

grep -ir X-Content-Type-Options /etc/nginx
# Output should include
add_header X-Content-Type-Options "nosniff";

grep -ir X-Frame-Options /etc/nginx
# Output should include
add_header X-Frame-Options "SAMEORIGIN";
```



## Remediation
- 
Locate the HTTP or server block in the nginx configuration and add the necessary headers based on the specific application and web system requirements:
```bash
# Prevent clickjacking
add_header X-Frame-Options DENY;
# Prevent MIME-type sniffing
add_header X-Content-Type-Options nosniff;
# Protect against XSS attacks
add_header X-XSS-Protection "1; mode=block";
```



## Impact


- If the browser security headers are not configured or not correctly configured, it can lead to vulnerabilities and attacks on the website.




## Default Value


- By default, these headers are not set.




## References


- None



## CIS Controls


- None