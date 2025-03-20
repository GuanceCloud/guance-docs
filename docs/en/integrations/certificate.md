---
skip: 'not-searchable-on-index-page'
title: 'OpenSSL Generate Self-Signed Certificates'
---

This article describes how to generate self-signed certificates via OpenSSL cli for enabling a secure connection layer (ssl).

## Generation Steps {#certificate-gen-steps}

- step1: Generate private key, the private key is used for encryption and authentication

  ```shell
  openssl genrsa -out domain.key 2048
  ```

    - `genrsa`: Generate RSA keys
    - `out`: Private key file
    - `2048`: Number of bits

- step2: Generate certificate signing request, the certificate signing request (CSR) is used to initiate the signing of the certificate. The file includes public key information and necessary information for generating the certificate.

  ```shell
  openssl req -key domain.key -new -out domain.csr
  ```

    - `req`: Certificate request command
    - `key`: Private key file
    - `new`: Create new
    - `out`: CSR file

  The generation process will be interactive through commands, as follows:

  ```shell
  Enter pass phrase for domain.key:
  You are about to be asked to enter information that will be incorporated
  into your certificate request.
  What you are about to enter is what is called a Distinguished Name or a DN.
  There are quite a few fields but you can leave some blank
  For some fields there will be a default value,
  If you enter '.', the field will be left blank.
  -----
  Country Name (2 letter code) [AU]:AU
  State or Province Name (full name) [Some-State]:stateA
  Locality Name (eg, city) []:cityA
  Organization Name (eg, company) [Internet Widgits Pty Ltd]:companyA
  Organizational Unit Name (eg, section) []:sectionA
  Common Name (e.g. server FQDN or YOUR name) []:domain
  Email Address []:email@email.com

  Please enter the following 'extra' attributes
  to be sent with your certificate request
  A challenge password []:
  An optional company name []:
  ```

  > Note: Input the actual valid domain name at the Common Name prompt.

- step3: Generate self-signed certificate, in environments where no certification chain check is required, you can directly generate a self-signed certificate for enabling certificate service.

  ```shell
  openssl x509 -signkey domain.key -in domain.csr -req -days 365 -out domain.crt
  ```

    - `x509`: Generate an X.509 standard certificate
    - `signkey`: Private key file
    - `in`: Input CSR file
    - `days`: Validity period
    - `out`: Certificate file

- step4: Generate self-signed CA

  Generate root CA certificate and private key

  ```shell
  openssl req -x509 -sha256 -days 1825 -newkey rsa:2048 -keyout rootCA.key -out rootCA.crt
  ```

    - `req`: Certificate request command
    - `x509`: Generate an X.509 standard certificate
    - `sha256`: SHA256 hash algorithm
    - `days`: Expiration days
    - `newkey`: Create new key
    - `rsa:2048`: RSA encryption algorithm with 2048 bits
    - `keyout`: Private key file
    - `out`: Certificate file

  Sign the certificate using the root CA

  Create ext file

  > Note: Input the actual valid domain name at the domain location.

  ```shell
  authorityKeyIdentifier=keyid,issuer
  basicConstraints=CA:FALSE
  subjectAltName = @alt_names
  [alt_names]
  DNS.1 = domain
  ```

  Sign the certificate using the root certificate and private key

  ```shell
  openssl x509 -req -CA rootCA.crt -CAkey rootCA.key -in domain.csr -out domain.crt -days 365 -CAcreateserial -extfile domain.ext
  ```

## References {#certificate-references}

- [Generating Private Key](https://www.herongyang.com/Cryptography/keytool-Import-Key-openssl-genrsa-Command.html){:target="_blank"}
- [Certificate With OpenSSL](https://www.baeldung.com/openssl-self-signed-cert){:target="_blank"}