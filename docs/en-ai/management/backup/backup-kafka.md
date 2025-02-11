# Data Forwarding to Kafka Message Queue
---

## Start Configuration

1. Address: `Host:Port`, multiple nodes are separated by commas.

2. Message Topic: i.e., the Topic name.

3. Security Protocol: On the Kafka side, SASL can use PLAINTEXT or SSL protocols as the transport layer, corresponding to using SASL_PLAINTEXT or SASL_SSL security protocols. If using the SASL_SSL security protocol, an SSL certificate must be configured.

4. Click **Test Connection**, if the above information is compliant, it will prompt that the test connection was successful. Click OK to save the current rule.
    
???+ warning "If the test fails:"

    You need to confirm:

    - Whether the address is correct;  
    - Whether the message topic name is correct;  
    - Whether the SSL certificate is correct;  
    - Whether the username is correct;  
    - Whether the password is correct.


### PLAINTEXT

No security verification is required, and you can directly test the connection.

### SASL_PLAINTEXT

The authentication method defaults to PLAIN, with options for SCRAM-SHA-256 and SCRAM-SHA-512.

Enter the username/password for Kafka-side security authentication, then test the connection.

![](../img/kafka-1.png)

### SASL_SSL

Here [you need to upload the SSL certificate](https://kafka.apachecn.org/documentation.html#security_ssl).

The authentication method defaults to PLAIN, with options for SCRAM-SHA-256 and SCRAM-SHA-512.

Enter the username/password for Kafka-side security authentication, then test the connection.

![](../img/kafka-2.png)