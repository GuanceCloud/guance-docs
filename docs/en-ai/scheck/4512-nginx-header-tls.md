# 4512-nginx-header-tls - It is recommended to use only modern TLS protocols

---

## Rule ID

- 4512-nginx-header-tls


## Category

- nginx


## Level

- info


## Compatible Versions

- Linux


## Description

- For all client connections and upstream connections, only modern TLS protocols should be enabled in NGINX. Removing legacy TLS and SSL protocols (SSL3.0, TLS1.0, and 1.1) and enabling emerging and stable TLS protocols (TLS1.2) can ensure that users can leverage robust security features and protect themselves from the risks associated with insecure legacy protocols.


## Scan Frequency
- 0 */30 * * *

## Theoretical Basis

- **Why Disable SSL3.0**: The POODLE vulnerability allows attackers to exploit vulnerabilities in CBC and use SSL3.0 to obtain plaintext information. SSL3.0 no longer complies with the FIPS140-2 standard.

- **Why Disable TLS1.0**: TLS1.0 is prohibited when PCI DSS compliance requires it not to be used in any application processing credit card numbers. TLS1.0 does not use modern protection features, and almost all user agents that do not support TLS1.2 or higher versions are no longer supported by their vendors.

- **Why Disable TLS1.1**: Due to the increased security associated with higher versions of TLS, TLS1.1 should be disabled. Modern browsers will start marking TLS1.1 as insecure starting early 2019.

- **Why Enable TLS1.2**: TLS1.2 utilizes several security features, including modern cipher suites, perfect forward secrecy, and authenticated encryption.


## Risk Items

- NGINX Security


## Audit Method

- Execute the following command to verify:

```bash
grep -ir ssl_protocol /etc/nginx
```


## Remediation

Edit the file `/etc/nginx/nginx.conf`. Example:
```bash
# WEB
sed -i "s/ssl_protocols[^;]*;/ssl_protocols TLSv1.2;/" /etc/nginx/nginx.conf
# proxy
sed -i "s/proxy_ssl_protocols[^;]*;/proxy_ssl_protocols TLSv1.2;/" /etc/nginx/nginx.conf
# If not configured before, pay attention to the location:
# web
server {
 ssl_protocols TLSv1.2;
}

# proxy
location / {
 proxy_ssl_protocols TLSv1.2;
 }
```


## Impact

- Disabling certain TLS protocols may prevent legacy user agents from connecting to your server. Disabling negotiation of specific protocols with backend servers may also limit your ability to connect to old servers. When selecting TLS protocols, you should always consider whether you need to support legacy user agents or servers.


## Default Value

- By default, NGINX does not specify TLS protocols and accepts all TLS versions.


## References

- [webkit.org-blog](https://webkit.org/blog/8462/deprecation-of-legacy-tls-1-0-and-1-1-versions/)


## CIS Controls

- None