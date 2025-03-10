# 4515-nginx-timeout - It is recommended to reset the timeout values for reading client headers and body

---

## Rule ID

- 4515-nginx-timeout


## Category

- nginx


## Level

- info


## Compatible Versions


- Linux




## Description


- The `client_header_timeout` and `client_body_timeout` directives define how long the server will wait for the client to send headers or a body. If no bytes are received from the client for 60 consecutive seconds, a 408 error is returned.



## Scan Frequency
- 0 */30 * * *

## Theoretical Basis


- Setting timeouts for client headers and bodies helps mitigate potential DDOS attacks. By timing out requests, the server can release resources that might be waiting for a body or header.





## Risk Items


- nginx security



## Audit Method
- 
To verify the current settings of the `client_body_timeout` and `client_header_timeout` directives, issue the following command. You should also manually check the nginx configuration to see if there are statements located outside the `/etc/nginx` directory. If they do not exist, set the value to the default.
```bash
grep -ir timeout /etc/nginx
# The output should include the following content
client_body_timeout 10;
client_header_timeout 10;
```



## Remediation
- 
Locate the HTTP or server block in the nginx configuration and add the `client_header_timeout` and `client_body_timeout` directives to this configuration. The following example sets the timeout to 10 seconds.
```bash
client_body_timeout 10;
client_header_timeout 10;
```



## Impact


- None




## Default Value


- By default, the timeout control is set to 60 seconds.




## References


- None



## CIS Controls


- None