# DataKit API Token

## What is a Token?

After a user successfully logs into the Guance system, the system generates a Token and returns this Token to the client. This Token contains the user's identity information and permissions. In subsequent requests, the client will carry this Token as an authentication credential and send it to the server.

Upon receiving the request, the server will verify the validity and legality of the Token. This typically includes checking the Token's signature, expiration time, and matching with user information. If the Token verification passes, the server will perform corresponding operations and authorizations based on the user identity and permissions contained in the Token.

By using Tokens for authentication, Guance can achieve stateless session management, thereby improving system scalability and performance. Additionally, Tokens can carry extra information such as roles and permissions, allowing the system to implement fine-grained access control over resources and functionalities based on different user roles and permissions.

In summary, in Guance, Tokens act as authentication credentials, playing a crucial role in ensuring that only authorized users can use and access system resources.

## How does Token ensure security?

Tokens enhance the security of both users and products when using Guance services, specifically in the following aspects:

- Authentication and Authorization: Tokens are used to verify user identity and permissions, ensuring that only authorized users can use and access system resources and functionalities. Through Tokens, the system can authenticate and authorize users, preventing unauthorized access and operation of sensitive data and features.

- Secure Transmission and Storage: In Guance, Tokens are usually transmitted via HTTPS protocol to ensure confidentiality and integrity during network transmission. Additionally, Tokens can be encrypted using encryption algorithms during transmission between the client and server, providing extra security protection.

- Renewal Mechanism: In Guance, after a Token is generated, users can define a security period as needed and promptly replace the Token to ensure system security.

- Access Control and Permission Management: Through the user identity and permission information carried by the Token, fine-grained access control and permission management can be performed. The system can restrict and control different resources and functionalities based on user roles and permissions, ensuring that users can only access and operate authorized resources, enhancing system security.

## How to obtain a Token in Guance?

Go to **Management > Settings > Token**, click to copy the chart. You can also replace the current workspace's Token as needed.

![Token](../img/token.png)