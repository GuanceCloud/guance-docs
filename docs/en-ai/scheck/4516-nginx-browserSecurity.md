# 4516-nginx-browserSecurity - Recommendation to Add Browser Security Configuration
---

## Rule ID

- 4516-nginx-browserSecurity


## Category

- Nginx


## Level

- Info


## Compatible Versions

- Linux


## Description

- The `X-Frame-Options` header should be set to allow or disallow specific websites from embedding your site as an object within their own sites, depending on your organization's policy and application requirements.

- The `X-Content-Type-Options` header is used to force supporting user agents to respect the content type specified in the HTTP response headers rather than inferring it from the request target.

- The `X-XSS-Protection` header allows you to leverage browser-based protection against cross-site scripting (XSS). This should be implemented on your web server to protect users and enhance trust in the site. Your policy should set this to blocking mode whenever possible to ensure that the browser blocks the page when XSS is detected.


## Scan Frequency

- 0 */30 * * *


## Theoretical Basis

- Setting `X-Frame-Options`, `X-Content-Type-Options`, and `X-XSS-Protection` helps secure your website. Please modify according to the actual needs of your application!


## Risk Items

- Nginx Security


## Audit Method

To verify the current settings for the `X-Frame-Options`, `X-Content-Type-Options`, and `X-XSS-Protection` headers:
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

Locate the HTTP or server block in the Nginx configuration and add the following headers based on your application and web system requirements:
```bash
# Prevent clickjacking
add_header X-Frame-Options DENY;
# Prevent MIME-type sniffing
add_header X-Content-Type-Options nosniff;
# Protect against XSS attacks
add_header X-Xss-Protection "1; mode=block";
```


## Impact

- If browser security headers are not configured or incorrectly configured, it can lead to vulnerabilities and attacks on the website.


## Default Value

- By default, these headers are not set.


## References

- None


## CIS Controls

- None