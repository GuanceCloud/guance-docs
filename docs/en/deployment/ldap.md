# LDAP Single Sign-On

LDAP (Lightweight Directory Access Protocol) is an application protocol used for handling various directory services. Microsoft Entra ID supports this mode through Microsoft Entra Domain Services (AD DS).

The <<< custom_key.brand_name >>> Deployment Plan supports users with existing LDAP services to log in with a single click via this protocol. The following are some necessary configuration fields:

| Field            | Description                                                                                   |
| ------------------ | ------------------------------------------------------------------------------------------------- |
| `host`           | LDAP server domain name, supported formats:<br /><li>Domain name <br /><li>Address with protocol: ldap://xxx & ldaps://xxx                          |
| `port`           | Service port, the port in `host` overrides this parameter by default.                             |
| `baseDN`         | Base directory location. *Refer to [Field Concept Supplement]*                                    |
| `bindDN`         | Username information (DN interface) used for authentication when establishing a connection with the LDAP service. |
| `searchAttribute`| Entry name used to filter accounts when searching for other accounts. This entry name will form a DIT entry with the username entered by the user. (This value uniquely identifies a user based on the username) |
| `bindPassword`   | Password information used for authentication when establishing a connection with the LDAP service. |
| `mapping`        | Mapping information of account attributes that need to be mapped to <<< custom_key.brand_name >>>.<br /><br />Account attributes provided by LDAP generally correspond to lists; if the attribute value is an array/list structure in <<< custom_key.brand_name >>>, the first element is taken as the value by default. *Refer to [Field Concept Supplement > 2.Account Attribute Fields]* |

???- abstract "Field Concept Supplement"

    1. Directory Information Tree (DIT): DIT is a hierarchical structure similar to a file system. To identify an entry, you must specify its path in the DIT, starting from the leaf representing the entry up to the top of the tree. This path is called the Distinguished Name (DN) of the entry;
        
        - Distinguished Name (DN) of an entry: It is composed of key-value pairs of the entry's name and value (separated by commas), forming a path from the leaf to the top of the tree. The DN of an entry is unique within the entire DIT and only changes when the entry moves to another container within the DIT.

    2. Account Attribute Fields:
  
    | Account Attributes in <<< custom_key.brand_name >>>      | Field Description on <<< custom_key.brand_name >>> Side      | Account Attributes Provided by LDAP Service, Converted by ldap3 (Default Fields)    |
    | ----------- | ------------------------- |--------------------- |
    | `username`      | Email field name of the login account in the authentication service, required     |           `mail`            |
    | `email`      | Username field name of the login account in the authentication service, required, if the value does not exist, it takes `email`	|          `uid`  |
    | `mobile`      | Phone number field name of the login account in the authentication service, optional      |    `mobile`                   |
    | `exterId`      | Unique identifier field name of the login account in the authentication service, required	  |              `uid`         |


## Configuration Details

In the <<< custom_key.brand_name >>> Launcher namespace: forethought-core > core, add the following configuration, adjusting the configuration variable values as needed:


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
    # Control whether SSL should be enabled
    use_ssl: false
    # Specify whether to read server schema and specific server information (default SCHEMA). Optional values explained at https://ldap3.readthedocs.io/en/latest/server.html#server-object
    get_info: "SCHEMA"
    tls:
      # Default none; File path containing the client private key
      local_private_key_file:
      # Default none; File path containing the server certificate
      local_certificate_file:
      # Default none; File path containing the certificate authority certificates
      ca_certs_file:
      # Default none; String specifying which ciphers must be used. It applies to the latest Python interpreter, allowing changes to SSLContext or wrap_socket() methods, ignored in older versions. Default none
      ciphers:
      # Specifies whether server certificate validation is required, options: CERT_NONE (ignore certificate), CERT_OPTIONAL (not required but validated if provided), CERT_REQUIRED (required and validated)
      validate: "CERT_REQUIRED"
      # SSL or TLS version to use, one of: SSLv2, SSLv3, SSLv23, TLSv1 (varies by Python version), current default is TLS 1.2
      version: "PROTOCOL_TLSv1_2"
  connection:
    # Default none; Access Active Directory: Using ldap3, you can also connect to Active Directory servers using NTLM v2 protocol, set to NTLM here
    authentication:
    # authentication, sasl_mechanism, and sasl_credentials follow https://ldap3.readthedocs.io/en/latest/bind.html?highlight=Active%20Directory#digest-md5
    # Default none; When accessing Active Directory, sasl_mechanism can be DIGEST_MD5; default none
    sasl_mechanism:
    # When accessing Active Directory, 
    # To use the DIGEST-MD5 mechanism, you must pass a 4-tuple or 5-tuple as sasl_credentials: (realm, user, password, authz_id, enable_signing). If not used, you can pass None for 'realm', 'authz_id', and 'enable_signing':
    sasl_credentials:
  # Whether to enable TLS over standard connections; if true, after establishing a connection with LDAP, TLS is checked and enabled,
  startTls: false
  baseDN: "dc=demo1,dc=freeipa,dc=org"
  bindDN: "uid=admin,cn=users,cn=accounts,dc=demo1,dc=freeipa,dc=org"
  bindPassword: "Secret123"
  # Attribute used for searching accounts; Method one: `searchAttribute: uid` marks only the attribute field name; Method two: `searchAttribute: "(uid={username})"` custom filter statement, where parentheses and curly braces with username are mandatory.
  # Note, if AD user, generally set to sAMAccountName
  searchAttribute: "uid"
  # Class name corresponding to account information when searching for accounts. Note, if interfacing with Microsoft AD LDAP, this should be person;
  # Confirmation method, install `ldapsearch` (third-party LDAP link tool), execute command `ldapsearch -x -H ldap://xxx.cn:389 -D "bindDN information" -w "bindPassword information" -b "baseDN content" "(cn=target user)"` return results' objectClass is the selectable list
  personObjectClass: "inetOrgPerson"
  mapping:
    # Username field name of the login account in the authentication service, required, if value does not exist, take email
    username: uid
    # Email field name of the login account in the authentication service, required
    email: mail
    # Phone number field name of the login account in the authentication service, optional
    mobile: mobile
    # Unique identifier field name of the login account in the authentication service, required
    exterId: uid
```

Example configuration for internal network access to LDAP service without SSL:

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
    # Specify whether to read server schema and specific server information (default SCHEMA). Optional values explained at https://ldap3.readthedocs.io/en/latest/server.html#server-object
    get_info: "ALL"
  # Base DN information
  baseDN: "<base DN>"
  # DN used by the client to bind when establishing a connection
  bindDN: "<client bind DN>"
  # Password corresponding to bindDN
  bindPassword: "<password corresponding to bindDN>"
  # Attribute used for searching accounts
  searchAttribute: cn
  # Class name corresponding to account information when searching for accounts. Note, if interfacing with Microsoft AD LDAP, this should be person;
  # Confirmation method, install `ldapsearch` (third-party LDAP link tool), execute command `ldapsearch -x -H ldap://xxx.cn:389 -D "bindDN information" -w "bindPassword information" -b "baseDN content" "(cn=target user)"` return results' objectClass is the selectable list
  personObjectClass: "inetOrgPerson"
  # If account attributes do not match the table below, adjustments are needed
  mapping:
    # Username field name of the login account in the authentication service, required, if value does not exist, take email
    username: cn
    # Email field name of the login account in the authentication service, required
    email: mail
    # Phone number field name of the login account in the authentication service, optional
    mobile: mobile
    # Unique identifier field name of the login account in the authentication service, required
    exterId: cn
```


## Using LDAP Single Sign-On to <<< custom_key.brand_name >>>

![](img/ldap-1.png)

After adding the above configurations, you can use LDAP Single Sign-On to log into <<< custom_key.brand_name >>>.

1) Open the <<< custom_key.brand_name >>> Deployment Plan login URL, select **LDAP Login** on the login page;

2) Enter the username and password used on the LDAP server;

3) Log in to the corresponding workspace in <<< custom_key.brand_name >>>.


## Further Reading


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Using Microsoft Entra ID for LDAP Authentication**</font>](https://learn.microsoft.com/en-us/entra/architecture/auth-ldap)

</div>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **How to Assign Permissions After Successful SSO?**</font>](./setting.md#mapping)

</div>