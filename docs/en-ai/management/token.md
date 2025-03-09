# DataKit API Token

## What is a Token?

When a user successfully logs into the <<< custom_key.brand_name >>> system, the system generates a Token and returns this Token to the client. This Token contains the user's identity information and permissions. In subsequent requests, the client sends this Token as an authentication credential to the server.

Upon receiving the request, the server verifies the validity and legality of the Token. This typically includes checking the Token's signature, expiration time, and matching it with user information. If the Token verification passes, the server performs corresponding operations and authorizations based on the user identity and permissions contained in the Token.

By using Tokens for authentication, <<< custom_key.brand_name >>> can achieve stateless session management, thereby improving the scalability and performance of the system. Additionally, Tokens can carry extra information such as roles and permissions, allowing the system to implement fine-grained access control over resources and features based on different user roles and permissions.

In summary, in <<< custom_key.brand_name >>>, Tokens serve as authentication credentials, playing a crucial role in ensuring that only authorized users can use and access system resources.

## How does a Token ensure security?

Using Tokens in <<< custom_key.brand_name >>> products enhances both user and product security in several ways:

- **Authentication and Authorization**: Tokens are used to verify user identity and permissions, ensuring that only authorized users can use and access system resources and features. Through Tokens, the system can authenticate and authorize users, preventing unauthorized access and operations on sensitive data and features.

- **Secure Transmission and Storage**: In <<< custom_key.brand_name >>>, Tokens are typically transmitted via HTTPS protocol, ensuring confidentiality and integrity during network transmission. Additionally, Tokens can be encrypted using encryption algorithms during transmission between the client and server, providing extra security protection.

- **Rotation Mechanism**: After a Token is generated in <<< custom_key.brand_name >>>, users can define a security period as needed and timely rotate the Token to ensure system security.

- **Access Control and Permission Management**: With the user identity and permission information carried by Tokens, fine-grained access control and permission management can be implemented. The system can restrict and control different resources and features based on user roles and permissions, ensuring users can only access and operate resources they are authorized to, thus enhancing system security.

## How to obtain a Token in <<< custom_key.brand_name >>>

Go to **Manage > Settings > Token**, click to copy the chart. You can also replace the current workspace's Token as needed.

![Token](../img/token.png)