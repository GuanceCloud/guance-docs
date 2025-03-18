# 4513-nginx-header-session-pfs - It is recommended to disable session resumption to achieve perfect forward secrecy

---

## Rule ID

- 4513-nginx-header-session-pfs


## Category

- nginx


## Level

- info


## Compatible Versions

- Linux


## Description

- Session resumption for HTTPS sessions should be disabled to achieve Perfect Forward Secrecy (PFS). PFS ensures that past session keys cannot be compromised even if the server's private key is leaked.


## Scan Frequency

- 0 */30 * * *


## Theoretical Basis

- Perfect Forward Secrecy is an encryption mechanism that prevents past session keys from being compromised even if the server’s private key is exposed. If an attacker records and stores all traffic to the server, obtaining the private key without PFS would compromise all communications. With PFS, Diffie-Hellman generates a new session key for each user-initiated session, isolating any potential breach to just that communication session. Allowing session resumption breaks perfect forward secrecy; if an attacker can compromise previous sessions and communications with the server, it widens the scope of potential attacks.


## Risk Items

- Nginx security


## Audit Method

- Execute the following command to verify:

```bash
grep -ir ssl_session_tickets /etc/nginx
# Output should include the following content
ssl_session_tickets off;
```


## Remediation

- Edit the file `/etc/nginx/nginx.conf` or any files related to HTTPS configuration. Example:
```bash
ssl_session_tickets off;
```


## Impact

- None


## Default Value

- By default, Perfect Forward Secrecy is not enabled.


## References

- [imperialviolet](https://www.imperialviolet.org/2013/06/27/botchingpfs.html)

- [perfect-forward-secrecy](https://scotthelme.co.uk/perfect-forward-secrecy/)


## CIS Controls

- None