# LDAP Single Sign-On

LDAP (Lightweight Directory Access Protocol) is a protocol used for accessing various directory services. Microsoft Entra ID supports this mode through Microsoft Entra Domain Services (AD DS).

The Guance Deployment Plan supports users with existing LDAP services to log in via this protocol with one click. The following are some necessary configuration fields:

| Field          | Description                                                                 |
| --------------- | ---------------------------------------------------------------------------- |
| `host`         | LDAP server domain name, supported formats:<br /><li>Domain name <br /><li>Address with protocol: ldap://xxx & ldaps://xxx                          |
| `port`         | Service port, the port in `host` overrides this parameter by default.                           |
| `baseDN`       | Base directory location. *Refer to [Field Concept Supplement]*                |
| `bindDN`       | Username information (DN interface) used for authentication when establishing a connection with the LDAP service.       |
| `searchAttribute` | Entry name used to filter accounts when searching for other accounts. This entry name will form a DIT entry information together with the username entered by the user. (This value can uniquely identify a user based on the username)                 |
| `bindPassword` | Password information used for authentication when establishing a connection with the LDAP service.                          |
| `mapping`      | Attribute field mapping information that needs to be mapped from account attributes to Guance.<br /><br />Account attributes provided by LDAP generally correspond to lists of attribute values; if the attribute value is an array/list structure in Guance, it defaults to taking the first element as the value. *Refer to [Field Concept Supplement > 2. Account Attribute Fields]*                          |

???- abstract "Field Concept Supplement"

    1. Directory Information Tree (DIT): DIT is a hierarchical structure similar to a file system. To identify an entry, you must specify its path in the DIT, starting from the leaf representing the entry all the way up to the top of the tree. This path is called the distinguished name (DN) of the entry;

        - Distinguished Name (DN) of an entry: Composed of key-value pairs of the entry's name and value (separated by commas), forming a path from the leaf to the top of the tree. The DN of an entry is unique throughout the DIT and only changes if the entry is moved to another container within the DIT.

    2. Account Attribute Fields:

    | Account Attributes in Guance | Field Description in Guance | Account attributes provided by the LDAP service, converted by ldap3 (default fields)    |
    | ----------- | ------------------------- |--------------------- |
    | `username`  | Email field name for login accounts in the authentication service, required     |           `mail`            |
    | `email`     | Username field name for login accounts in the authentication service, required, if the value does not exist, take `email`	|          `uid`  |
    | `mobile`    | Phone number field name for login accounts in the authentication service, optional      |    `mobile`                   |
    | `exterId`   | Unique identifier field name for login accounts in the authentication service, required |              `uid`         |

## Configuration Details

Add the following configuration in the Guance Launcher namespace: forethought-core > core, making sure to adjust the configuration variable values:

```
# LDAP client configuration (refer to: https://ldap3.readthedocs.io/en/latest/server.html)
LDAPClientSet:
  # Whether to enable LDAP, default is not enabled
  enable: false
  # Server parameter format follows https://ldap3.readthedocs.io/en/latest/server.html
  server:
    # LDAP server domain name, can be a domain name or ldap://xxx or ldaps://xxx
    host: "ipa.demo1.freeipa.org"
    # Connection timeout
    connect_timeout: 6
    # Control whether SSL is enabled
    use_ssl: false
    # Specify whether server schema and server-specific information must be read (default is SCHEMA). Optional values explained at https://ldap3.readthedocs.io/en/latest/server.html#server-object
    get_info: "SCHEMA"
    tls:
      # Default is none; file path containing the client private key
      local_private_key_file:
      # Default is none; file path containing the server certificate
      local_certificate_file:
      # Default is none; file path containing CA certificates
      ca_certs_file:
      # Default is none; string specifying which ciphers must be used. It applies to the latest Python interpreters, allowing changes to the SSLContext or wrap_socket() method ciphers in old versions, ignored by default
      ciphers:
      # Specify whether the server certificate must be validated, options: CERT_NONE (ignore certificate), CERT_OPTIONAL (not required but validate if provided), CERT_REQUIRED (required and validate)
      validate: "CERT_REQUIRED"
      # SSL or TLS version to use, can be one of: SSLv2, SSLv3, SSLv23, TLSv1 (depending on Python 3.3. Version list may differ in other Python versions), current default is TLS 1.2
      version: "PROTOCOL_TLSv1_2"
  connection:
    # Default is none; access Active Directory: using ldap3, you can also use the NTLM v2 protocol to connect to Active Directory servers, set to NTLM here
    authentication:
    # authentication, sasl_mechanism, and sasl_credentials should follow https://ldap3.readthedocs.io/en/latest/bind.html?highlight=Active%20Directory#digest-md5
    # Default is none; when accessing Active Directory, sasl_mechanism can be DIGEST_MD5; default is none
    sasl_mechanism:
    # When accessing Active Directory, need
    # To use the DIGEST-MD5 mechanism, you must pass a 4-tuple or 5-tuple as sasl_credentials: (realm, user, password, authz_id, enable_signing). If not used, you can pass None for 'realm', 'authz_id', and 'enable_signing':
    sasl_credentials:
  # Whether to enable TLS on top of the standard connection; if true, check and enable TLS after establishing the LDAP connection,
  startTls: false
  baseDN: "dc=demo1,dc=freeipa,dc=org"
  bindDN: "uid=admin,cn=users,cn=accounts,dc=demo1,dc=freeipa,dc=org"
  bindPassword: "Secret123"
  # Attribute used for searching accounts; Method one: `searchAttribute: uid` marks only the attribute field name; Method two: `searchAttribute: "(uid={username})"` custom filter statement, brackets and curly braces with username are required.
  # Note: for AD users, generally set to sAMAccountName
  searchAttribute: "uid"
  # Class name corresponding to account information when searching for accounts. Note: if connecting to Microsoft AD's LDAP, this should be person;
  # Confirmation method: install `ldapsearch` (third-party LDAP link tool), execute command `ldapsearch -x -H ldap://xxx.cn:389 -D "bindDN information" -w "bindPassword information" -b "baseDN content" "(cn=target user)"`, the objectClass in the returned result is the selectable list
  personObjectClass: "inetOrgPerson"
  mapping:
    # Username field name for login accounts in the authentication service, required, if the value does not exist, take email
    username: uid
    # Email field name for login accounts in the authentication service, required
    email: mail
    # Phone number field name for login accounts in the authentication service, optional
    mobile: mobile
    # Unique identifier field name for login accounts in the authentication service, required
    exterId: uid
```

Example configuration for accessing LDAP service without SSL in the internal network:

```
# LDAP client configuration (refer to: https://ldap3.readthedocs.io/en/latest/server.html)
LDAPClientSet:
  # Whether to enable LDAP, default is not enabled
  enable: true
  # Server parameter format follows https://ldap3.readthedocs.io/en/latest/server.html
  server:
    # LDAP server domain name, can be a domain name or ldap://xxx or ldaps://xxx
    # Local development address bound to hosts: 172.16.211.111 openldap-server
    host: "<domain name, protocol+domain name+port>"
    # Specify whether server schema and server-specific information must be read (default is SCHEMA). Optional values explained at https://ldap3.readthedocs.io/en/latest/server.html#server-object
    get_info: "ALL"
  # Base DN information
  baseDN: "<base DN>"
  # DN used by the client to establish a connection
  bindDN: "<client connection DN>"
  # Password corresponding to bindDN
  bindPassword: "<password corresponding to bindDN>"
  # Attribute used for searching accounts
  searchAttribute: cn
  # Class name corresponding to account information when searching for accounts. Note: if connecting to Microsoft AD's LDAP, this should be person;
  # Confirmation method: install `ldapsearch` (third-party LDAP link tool), execute command `ldapsearch -x -H ldap://xxx.cn:389 -D "bindDN information" -w "bindPassword information" -b "baseDN content" "(cn=target user)"`, the objectClass in the returned result is the selectable list
  personObjectClass: "inetOrgPerson"
  # If account attributes do not match the table below, adjustments are needed
  mapping:
    # Username field name for login accounts in the authentication service, required, if the value does not exist, take email
    username: cn
    # Email field name for login accounts in the authentication service, required
    email: mail
    # Phone number field name for login accounts in the authentication service, optional
    mobile: mobile
    # Unique identifier field name for login accounts in the authentication service, required
    exterId: cn
```


## Using LDAP Single Sign-On to Log into Guance

![](img/ldap-1.png)

After completing the above configuration, you can use LDAP single sign-on to log into Guance.

1) Open the login URL of the Guance Deployment Plan, select **LDAP Login** on the login page;

2) Enter the username and password used in the LDAP server;

3) Log in to the corresponding workspace in Guance.


## Further Reading


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Using Microsoft Entra ID for LDAP Authentication**</font>](https://learn.microsoft.com/en-us/entra/architecture/auth-ldap)

</div>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **How to Assign Permissions After Successful Single Sign-On?**</font>](./setting.md#mapping)

</div>